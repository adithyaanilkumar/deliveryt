from users.models import Cart, CartItem
from owner.models import Vieworder
from users.serializers import CartSerializer
from orders.models import Order
from owner.utils import get_all_details
from orders.checkout import get_cart_object, calculate_delivery_charge, calculate_tax
from django.db.models.signals import post_save, post_delete, pre_delete, m2m_changed, pre_save
from django.dispatch import receiver
import logging
import operator
import sys
import os
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
utc=pytz.UTC
logger = logging.getLogger("mylogger")
@receiver(pre_save, sender=Vieworder)
def view_order(sender, instance,*args, **kwargs):
    logger.info("hellloooooooooooooooooooooooooooooooooooooooooooooooo")
    today = datetime.datetime.now().replace(tzinfo=utc)
    treshhold = today- timedelta(days=instance.day_count,minutes=today.minute,hours=today.hour,seconds=today.second)
    exp_date = timedelta(days=10)
    #instance.date_request_from = treshhold
    merger = PdfFileMerger()
    orders = Order.objects.all()
    detail_list = list()
    #temp_file = tempfile.NamedTemporaryFile()
    for order in orders:
        order_date= order.created_at.replace(tzinfo=utc)
        outer_order_id=""
        if order_date >= treshhold:
            temp = get_cart_items_as_list(order)
            user=order.user.get_username()
            order_id_p1 = order.order_id[:17]
            order_id_p2 = order.order_id[17:]
            user_id_p1 = user[:17]
            user_id_p2 = user[17:]
            detail_list.append({
            "cart_items":temp,
            "grand_total":order.total_price,
            "sub_total":order.cart_price,
            "tax":order.tax,
            "delivery_fee":order.delivery_fee,
            "address": {
                "name":order.address.name,
                "add1":order.address.address1,
                "add2": order.address.address2,
                "add3": order.address.address3,
                "add4": order.address.address4,
                "city": order.address.city,
                "state":order.address.state,
                "pincode":order.address.pin_code,
                "distance":order.address.distance
            },
            "payment_status": order.payment_status,
            "ordered":order.ordered,
            "coupon_discount":order.coupon_discount,
            "updated_at":datetime.datetime.now(),
            "order_id_p1" : order_id_p1,
            "order_id_p2" : order_id_p2,
            "user_id_p1" : user_id_p1,
            "user_id_p2" : user_id_p2,
            "phone":order.user.phone
        })
            logger.info(f"detail list {detail_list}")
            logger.info(f"detail list {detail_list}")
            order_id= order.order_id
            opener = default_storage.open(f'{order_id}.pdf','r')
            merger.append(opener)
            outer_order_id=order_id
    sorted_list = sorted(detail_list, key=lambda k: k['address']['pincode'])
    count = 1
    for data in sorted_list:
        data["count"]= count
        count+=1
    logger.info(f"sorted list {sorted_list}")
    pdf = output_to_pdf('orders.html', {"datas":sorted_list})
    file_name = default_storage.save(f'ol{outer_order_id}.pdf', File(BytesIO(pdf)))
    logger.info(merger)
    with tempfile.TemporaryFile() as tmp: 
        merger.write(tmp)
        tmp.seek(0)
        merger.close()
    #tempfile= open("hello.pdf")
        #default_storage.save(f"upto{outer_order_id}.pdf",File(tmp))
        default_storage.save(f"upto{outer_order_id}.pdf",File(tmp))
        client = storage.Client()
        bucket = client.get_bucket("garden-orders")
        blob = bucket.blob(f"upto{outer_order_id}.pdf")
        url=blob.generate_signed_url(expiration = exp_date)
        #expiration=exp_date
        #url = f'https://storage.googleapis.com/garden-orders/upto{outer_order_id}.pdf'
        instance.invoice_list = url
        blob2 = bucket.blob(f"ol{outer_order_id}.pdf")
        #url_order=blob2.generate_signed_url(expiration=1596182634)
        url_order=blob2.generate_signed_url(expiration=exp_date)
        instance.order_list = url_order
        #instance.order_list = f'https://storage.googleapis.com/garden-orders/ol{outer_order_id}.pdf'
    #merger.close()
    #tempfile.close()
'''


{
            "cart_items":"temp",
            "grand_total":"order.total_price",
            "sub_total":"order.cart_price",
            "tax":"order.tax",
            "delivery_fee":"order.delivery_fee",
            "address": {
                "name":"order.address.name",
                "add1":"order.address.address1",
                "add2":" order.address.address2",
                "city":" order.address.city",
                "state":"order.address.state",
                "pincode":"order.address.pin_code",
                "distance":"order.address.distance"
            },
            "payment_status":"order.payment_status",
            "ordered":"order.ordered",
            "coupon_discount":"order.coupon_discount",
            "updated_at":"datetime.datetime.now()",
            "order_id":"order.order_id",
            "user":"user",
            "phone":"order.user.phone"
        }
'''