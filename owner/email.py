from users.models import Cart, CartItem
from owner.models import Vieworder
from users.serializers import CartSerializer
from orders.models import Order
from owner.utils import get_all_details
from owner.signals import get_cart_items_as_list
from orders.checkout import get_cart_object, calculate_delivery_charge, calculate_tax
import logging
import operator
import sys
import os
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
from django.core.mail import EmailMessage
utc=pytz.UTC
logger = logging.getLogger("mylogger")

def email_orders():
    today = datetime.datetime.now().replace(tzinfo=utc)
    treshhold = today- timedelta(days=1)
    exp_date = timedelta(days=10)
    merger = PdfFileMerger()
    orders = Order.objects.all()
    detail_list = list()
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
            outer_order_id=order.order_id
            logger.info(f"detail list {detail_list}")
            logger.info(f"detail list {detail_list}")
    sorted_list = sorted(detail_list, key=lambda k: k['address']['pincode'])
    count = 1
    for data in sorted_list:
        data["count"]= count
        count+=1
    logger.info(f"sorted list {sorted_list}")
    pdf = output_to_pdf('orders.html', {"datas":sorted_list})
    print(f'email{outer_order_id}.pdf')
    file_name = default_storage.save(f'email{outer_order_id}.pdf', File(BytesIO(pdf)))
    #file_name = default_storage.save('email.pdf', File(BytesIO(pdf)))
    client = storage.Client()
    bucket = client.get_bucket("garden-orders")
    blob = bucket.blob(f'email{outer_order_id}.pdf')
    url=blob.generate_signed_url(expiration = exp_date)
    email = EmailMessage(
    f'Orders till {today} {outer_order_id}',
    f'Here are the orders till {today} upto order id {outer_order_id} : \n {url}',
    'gardenfreshtohome@garden.com',
    ['gardenfreshtohome@gmail.com']
    )
    #email.attach_file(f'email{outer_order_id}.pdf')
    #email.attach_file('email.pdf')
    email.send()
    
    