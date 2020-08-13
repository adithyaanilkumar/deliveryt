from users.models import Address,Cart, CartItem 
from owner.models import Delivery
from django.http import HttpResponse


def get_cart_object(instance):
    user_obj = instance.user
    cart_obj= Cart.objects.get(user=user_obj)
    return cart_obj
    
def calculate_delivery_charge(instance):
    distance = instance.address.distance
    delivery_obj= Delivery.objects.get(id=1)
    if distance>delivery_obj.max_radius:
        return None
    if distance<=delivery_obj.a1:
        return delivery_obj.c1
    if distance<=delivery_obj.a2:
        return delivery_obj.c2
    if distance<=delivery_obj.a3:
        return delivery_obj.c3
    return distance

def calculate_tax(instance):
    user_obj = instance.user
    cart_obj= Cart.objects.get(user=user_obj)
    delivery_obj= Delivery.objects.get(id=1)
    tax_percentage=delivery_obj.tax
    tot_cart_amt=cart_obj.total_price
    tax=(tax_percentage/100)*tot_cart_amt
    return tax

