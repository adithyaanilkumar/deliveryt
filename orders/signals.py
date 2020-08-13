from users.models import Cart, CartItem, User
from users.serializers import CartSerializer
from orders.models import Order,Payment,Coupon, UserCoupon, UserAppliedCouponList
from django.db.models.signals import post_save, post_delete, pre_delete, m2m_changed, pre_save
from django.dispatch import receiver
from orders.checkout import get_cart_object, calculate_delivery_charge, calculate_tax
import logging
from garden_drf.rzpay import place_order,verify_signature
from rest_framework import exceptions as excp
from garden_drf.exception import ServiceUnavailable
from garden_drf.pdf_render import output_to_pdf
from django.core.files.storage import default_storage
from io import BytesIO
from django.core.files import File
import datetime
from datetime import timedelta 
from PyPDF2 import PdfFileMerger
from google.cloud import storage
import pytz
import math
import tempfile
import json
utc=pytz.UTC


logger = logging.getLogger("mylogger")
#logger.info("Whatever to log")
def get_cart_items_as_json(instance):
        qset = Cart.objects.filter(user= instance.user)
        serializer = CartSerializer(qset, many=True)
        json_string=json.dumps(serializer.data[0])
        return json_string
def get_cart_items_as_string(instance, flag=0):
        temp= []
        notes={}
        count= 1
        for obj in instance.order_cart.cart_items.all():
                s_temp=' '.join(map(str, temp))
                x={"name":obj.product.name,
                   "qty":int(obj.quantity)}
                if flag==0:
                        if len(s_temp)>=200:
                                temp=[]
                                count+=1
                        if count>=11:
                                break
                temp.append(x)
                key=f"prod_list{count}"
                notes[key]=' '.join(map(str, temp))
        return  notes
def get_cart_items_as_list(instance):
        temp= []
        count=1
        for obj in instance.order_cart.cart_items.all():
                x={"name":obj.product.name,
                   "unit_price": obj.product.regular_price,
                   "unit_discount": obj.product.discount_price,
                   "qty":int(obj.quantity),
                   "total":obj.price,
                   "index":count}
                temp.append(x)
                count+=1
        return  temp

@receiver(pre_save, sender=Order)
def save_order(sender, instance,*args, **kwargs):
        instance.order_cart=get_cart_object(instance)
        instance.delivery_fee= int(math.ceil(calculate_delivery_charge(instance)))
        instance.tax = int(math.ceil(calculate_tax(instance)))
        instance.cart_price= int(math.ceil(instance.order_cart.total_price))
        today = datetime.datetime.now().replace(tzinfo=utc)
        instance.total_price=int(math.ceil(instance.tax + instance.delivery_fee + (instance.order_cart.total_price)))
        try:
                UserAppliedCouponList_obj = UserAppliedCouponList.objects.get(user = instance.user)
        except:
                UserAppliedCouponList_obj = UserAppliedCouponList.objects.create(user = instance.user)
        print(f"coupon list{UserAppliedCouponList_obj.coupons}")
        try:
                all_coupons = Coupon.objects.all()
                print(f"all coupons {all_coupons}")
                for coupon_item in all_coupons:
                        print("in for")
                        if instance.coupon == coupon_item.name:
                                print("in 1st name check")
                                if coupon_item.active==True:
                                        print("in 1st active check")
                                        print(f"coupon item exp {coupon_item.expiry}  today {today}")
                                        if  today<=coupon_item.expiry:
                                                print(f"in expiry")
                                                user_coupon_list = UserAppliedCouponList_obj.coupons.all()
                                                print(f"user_coupon_list {user_coupon_list}")
                                                coupon_flag = 0
                                                for user_coupon in user_coupon_list:
                                                        if len(user_coupon_list)!=0:
                                                                if user_coupon.coupon.name == instance.coupon:
                                                                        coupon_flag = 1
                                                                        print(f"coupon times {user_coupon.times}  max time {user_coupon.coupon.max_times}")
                                                                        if user_coupon.times < user_coupon.coupon.max_times :#and user_coupon.active==True
                                                                                print(f"in coupon times")
                                                                                user_coupon.times +=1
                                                                                instance.coupon_discount = (coupon_item.percentage*instance.order_cart.total_price/100)
                                                                        else:
                                                                                print("in else for max times")
                                                                                user_coupon.active = False
                                                                                instance.coupon_discount = 0
                                                                                
                                                if coupon_flag == 0:
                                                        print(f"in flag{UserAppliedCouponList_obj.coupons}")
                                                        obj=UserCoupon.objects.create(user=instance.user)
                                                        obj.coupon = coupon_item
                                                        obj.times+=1
                                                        obj.active = True
                                                        obj.save()
                                                        UserAppliedCouponList_obj.coupons.add(obj)
                                                        instance.coupon_discount = (coupon_item.percentage*instance.order_cart.total_price/100)
                                        else:
                                                coupon_item.active = False
                        
                                                
                user_coupon.save()
                UserAppliedCouponList_obj.save()         
                instance.total_price=int(math.ceil(instance.tax + instance.delivery_fee + (instance.order_cart.total_price - instance.coupon_discount )))
        except:
                instance.total_price=int(math.ceil(instance.tax + instance.delivery_fee + instance.order_cart.total_price))
        note_address=instance.address.address1 + instance.address.address2 
        rzpay_amt= instance.total_price * 100
        notes= {
                "username": instance.user.get_username(),
                "address": note_address,
                "tax": instance.tax,
                "delivery fee": instance.delivery_fee,
        }    
        recieved_notes= get_cart_items_as_string(instance)
        for k,v in recieved_notes.items():
                notes[k]=v

        data={
                "amount": rzpay_amt,
                "currency": "INR",
                "receipt": instance.id,
                "payment_capture": 1,
                "notes":notes
                }
        #instance.order_items=str(get_cart_items_as_string(instance,1))
        instance.order_items = get_cart_items_as_json(instance)
        if not instance.order_id:
                rzp_order_id=place_order(data)
                if rzp_order_id is None:
                        raise  ServiceUnavailable()
                instance.order_id=rzp_order_id
                instance.ordered= True
                instance.payment_status="ORDERED"
        
################################################################################

                temp=get_cart_items_as_list(instance)
                user=instance.user.get_username()
                context={
                        "cart_items":temp,
                        "grand_total":instance.total_price,
                        "sub_total":instance.order_cart.total_price,
                        "tax":instance.tax,
                        "delivery_fee":instance.delivery_fee,
                        "address": {
                                "name":instance.address.name,
                                "add1":instance.address.address1,
                                "add2": instance.address.address2,
                                "add3":instance.address.address3,
                                "add4":instance.address.address4,
                                "city": instance.address.city,
                                "state":instance.address.state,
                                "pincode":instance.address.pin_code,
                                "distance":instance.address.distance
                        },
                        "payment_status": instance.payment_status,
                        "ordered":instance.ordered,
                        "coupon_discount":instance.coupon_discount,
                        "updated_at":datetime.datetime.now(),
                        "order_id":instance.order_id,
                        "user":user,
                        "phone":instance.user.phone
                }
                logger.info(context)
                pdf = output_to_pdf('invoice.html', context)
                #file= File(BytesIO(pdf))

                file_name = default_storage.save(f'{instance.order_id}.pdf', File(BytesIO(pdf)))
#@receiver(post_save, sender=Order)
#def generate_pdf(sender, instance,created,*args, **kwargs):
        
@receiver(post_save, sender=Payment)
def save_payment(sender, instance,*args, **kwargs):
    order_obj= Order.objects.get(order_id=instance.razorpay_order_id)
    cart_obj= order_obj.order_cart
    instance.order_relation= order_obj
    instance.payment_status= "INITIATED"
    order_obj.payment_status="INITIATED"
    #instance.save()
    params_dict={
        'razorpay_order_id': str(instance.razorpay_payment_id),
        'razorpay_payment_id': str(instance.razorpay_order_id),
        'razorpay_signature':str(instance.razorpay_signature)
    }
    
    verification= verify_signature(params_dict)
    
    if verification== True:
        instance.payment_complete= True
        instance.payment_status= "SUCCEEDED"
        order_obj.payment_status="SUCCEEDED"
        order_obj.completed=True
        order_obj.cart_obj.completed = True
        order_obj.save()
        cart_obj.delete()
        
    else:
        instance.payment_complete= False
        instance.payment_status= "FAILED"
        order_obj.payment_status="FAILED"
        order_obj.save()
    


    

