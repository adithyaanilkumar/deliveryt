from django.contrib import admin
from orders.models import Order,Payment, Coupon
# Register your models here.
admin.site.register(Order)
admin.site.register(Payment)
admin.site.register(Coupon)
