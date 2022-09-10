from users.models import Cart, CartItem
from users.serializers import CartSerializer
from orders.models import Order,Payment
from orders.checkout import get_cart_object, calculate_delivery_charge, calculate_tax
import logging
from rest_framework import exceptions as excp
from garden_drf.exception import ServiceUnavailable
import datetime
from datetime import timedelta 
from PyPDF2 import PdfFileMerger
from google.cloud import storage
import pytz
import math
import tempfile
import json



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
                x={
                   "name":obj.product.name,
                   "unit_price": obj.product.regular_price,
                   "unit_discount": obj.product.discount_price,
                   "qty":int(obj.quantity),
                   "total":obj.price,
                   "index":count}
                temp.append(x)
                count+=1
        return  temp

def get_all_details(instance,*args, **kwargs):
        note_address=instance.address.address1 + instance.address.address2 
        temp=get_cart_items_as_list(instance)
        user=instance.user.get_username()
        context={
            "cart_items":temp,
            "grand_total":instance.total_price,
            "sub_total":instance.cart_price,
            "tax":instance.tax,
            "delivery_fee":instance.delivery_fee,
            "address": {
                "name":instance.address.name,
                "add1":instance.address.address1,
                "add2": instance.address.address2,
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
        return context
'''
        logger.info(context)
        pdf = output_to_pdf('invoice.html', context)
        #file= File(BytesIO(pdf))

        file_name = default_storage.save(f'{instance.order_id}.pdf', File(BytesIO(pdf)))
#@receiver(post_save, sender=Order)
#def generate_pdf(sender, instance,created,*args, **kwargs):
'''