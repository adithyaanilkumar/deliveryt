from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from owner.models import Delivery
from geopy import distance
from products.models import Product


class Address(models.Model):
    user_name = models.CharField(max_length=500,null=True)
    name = models.TextField(max_length=200)
    address1 = models.TextField(max_length=20)
    address2 = models.TextField(max_length=20, null=True , blank = True)
    address3 = models.TextField(max_length=20,null=True , blank = True)
    address4 = models.TextField(max_length=20,null=True , blank = True)
    city = models.TextField(max_length=30)
    state = models.TextField(max_length=30)
    pin_code = models.CharField(max_length=6)
    deflt = models.BooleanField(default = False, null = True)
    lat = models.DecimalField(
        blank = False,
        max_digits = 30,
        decimal_places = 15,
        verbose_name="lattitude"
    )
    longt = models.DecimalField(
        blank = False,
        max_digits = 30,
        decimal_places = 15,
        verbose_name="longtitude"
    )
    distance = models.DecimalField(
        blank = True,
        max_digits = 30,
        decimal_places = 15,
        verbose_name="distance",
        null=True
    )


    def __str__(self):
        return f"{self.id}"

    def save(self, *args, **kwargs):
        #super(Address, self).save(*args, **kwargs)  
        delivery_obj= Delivery.objects.get(id=1)
        address_loc = (self.lat,self.longt)
        delivery_loc= (delivery_obj.lattitude,delivery_obj.longtitude)
        self.distance= distance.distance(delivery_loc, address_loc).km
        super(Address, self).save(*args, **kwargs) 
class User(AbstractUser):
    phone = models.CharField(max_length=15, blank=True)
    address = models.ManyToManyField( Address, blank=True)
    


class CartItem(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE
    )
    ordered = models.BooleanField(
        default=False
    )
    product = models.ForeignKey(
        Product, 
        on_delete = models.CASCADE,
    )
    quantity = models.DecimalField(
        blank = False,
        max_digits = 10,
        decimal_places = 2,
    )
    created_at = models.DateTimeField(
        auto_now = True
    )
    updated_at = models.DateTimeField(
        auto_now_add = True
    )
    amount_saved = models.DecimalField(
        blank = True, 
        max_digits = 50, 
        decimal_places = 2,
    )
    price =  models.DecimalField(
        blank = True, 
        max_digits = 50, 
        decimal_places = 2,
    )
    active = models.BooleanField(default=True)
    

    def __str__(self):
        return f"{self.quantity}gm of {self.product}"

    
    @property
    def get_total_product_price(self):
        return self.quantity * self.product.regular_price

    @property
    def get_total_discount_product_price(self):
        return self.quantity * self.product.discount_price

    @property
    def get_amount_save(self):
        return self.get_total_product_price - self.get_total_discount_product_price

    @property
    def get_final_price(self):
        if self.product.discount_price > 0:
            return self.get_total_discount_product_price
        return self.get_total_product_price

    def save(self, *args, **kwargs):
        self.amount_saved = self.get_amount_save
        self.price = self.get_final_price
        super(CartItem, self).save( *args, **kwargs)

class Cart(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        unique=True
    )
    ordered = models.BooleanField(
        default = False
    )
    cart_items = models.ManyToManyField(
        CartItem,
    ) 
    total_price = models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
    )
    active = models.BooleanField(default=True)
    #delivery_fee
    #@property
    #def get_total_price(self):
    #    queryset = self.objects.all().aggregate(
    #        total_price = models.Sum('price')
    #    )
    #    return queryset["total_price"]
    @classmethod
    def create(cls, user):
        cart = cls(user=user)
        # do something with the book
        
        return cart
    '''def save(self, *args, **kwargs):
        #super(Cart, self).save(*args, **kwargs)
        #self.total_price = self.get_total_price
        super(Cart, self).save(*args, **kwargs)'''
        
    def __str__(self):
        return self.user.get_username()

    




