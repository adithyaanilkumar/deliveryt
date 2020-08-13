import razorpay
import os
import json
import logging
logger = logging.getLogger("mylogger")

rzpay_id =os.getenv("RPID")
rzpay_key =os.getenv("RPKEY")
print(rzpay_id)
print(rzpay_key)
logger.info(rzpay_id)
logger.info(rzpay_key)
client = razorpay.Client(auth=(rzpay_id,rzpay_key))
client.set_app_details({"title" : "Django", "version" : "3.0.5"})
logger = logging.getLogger("mylogger")

def place_order(data):
  logger.info(data)
  ordered=client.order.create(data=data)
  return ordered["id"]
def verify_signature(params_dict):
  try:
    client = razorpay.Client(auth=(rzpay_id,rzpay_key))
    client.set_app_details({"title" : "Django", "version" : "3.0.5"})
    client.utility.verify_payment_signature(params_dict)
    return True
  except:
    return False
  
params_dict = { 
    'razorpay_order_id': 'order_EwZ0bLEaxjUpOw', 
    'razorpay_payment_id': 'pay_EwZ0wA7EQ8tBMz',
    'razorpay_signature': 'dbb38f5d9401f9b458ccd0e982845e9b1fcc0885367486549f4a454f14cbb6c4'
}

print(verify_signature(
  params_dict
))
print(client.utility.verify_payment_signature(params_dict))
