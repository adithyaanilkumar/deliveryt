from django.contrib import admin
from users.models import User, Address, Cart, CartItem
# Register your models here.

admin.site.register(User)
admin.site.register(Address)
admin.site.register(CartItem)
admin.site.register(Cart)