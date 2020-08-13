from django.db import models
from django.conf import settings
from users.models import Cart,Address
from garden_drf.models import Base


# Create your models here.
class Coupon(models.Model):
    name = models.TextField(max_length=10)
    percentage = models.DecimalField(max_digits=50, decimal_places=2)
    active= models.BooleanField(
        default =True
    )
    expiry = models.DateTimeField(null = True)
    created = models.DateTimeField(auto_now_add=True)
    max_times = models.IntegerField(default=1)
class UserCoupon(models.Model):
    user = user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE
    )
    coupon = models.ForeignKey(
        Coupon,
        on_delete=models.CASCADE,
        null= True
    )
    times =models.IntegerField(default=0)
    active= models.BooleanField(
        default = True
    )
    @classmethod
    def create(cls, user):
        user_coupon = cls(user=user)
        # do something with the book
        
        return user_coupon

class UserAppliedCouponList(models.Model):
    user =models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE, 
    )
    coupons = models.ManyToManyField(
        UserCoupon
    )
    @classmethod
    def create(cls, user):
        user_applied_coupon_list = cls(user=user)
        # do something with the book
        
        return user_applied_coupon_list





class Order(models.Model):
    order_id = models.CharField(max_length=100,
    blank = True,
    null=True,
    default= None
    )

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE
    )
    payment_status= models.CharField(
        max_length=20,
        blank=True,
        null=True)
    ordered = models.BooleanField(
        default = False
    )
    completed= models.BooleanField(
        default = False
    )
    order_cart = models.OneToOneField(
        Cart,
        on_delete=models.SET_NULL,
        blank=True,
        null=True
    )
    address = models.ForeignKey(
        to=Address,
        on_delete=models.DO_NOTHING,
        blank = False,
    )    
    tax=models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
    )
    delivery_fee = models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
    )
    coupon = models.CharField(
        max_length=20,
        blank=True,
        null=True)
    coupon_discount=  models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
        default=0
    )
    cart_price= models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
    )
    total_price = models.DecimalField(
        null = True,
        blank = True,
        max_digits = 50,
        decimal_places = 2,
    )
    order_items = models.TextField(null=True,blank=True)
    created_at = models.DateTimeField(
        auto_now = True
    )
    updated_at = models.DateTimeField(
        auto_now_add = True
    )
    '''
    @property
    def get_total_price(self):
        queryset = self.order_items.all().aggregate(
            total_price = models.Sum('price')
        )
        return queryset["total_price"]

    def save(self, *args, **kwargs):
        super(Order, self).save(*args, **kwargs)
        self.total_price = self.get_total_price
        super(Order, self).save(*args, **kwargs)
    '''
    def __str__(self):
        return f"{self.id}"

class Payment(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE
    )
    razorpay_payment_id = models.CharField(max_length=255)
    razorpay_order_id  = models.CharField(max_length=255)
    razorpay_signature = models.CharField(max_length=255)
    order_relation = models.ForeignKey(Order,
    on_delete=models.SET_NULL,
    null=True

    )


    payment_complete = models.BooleanField(
        default=False,
        null=True,
        blank=True
    )
    payment_status= models.CharField(max_length=255,
    null=True,
    blank=True)
    
    updated_at  = models.DateTimeField(
        auto_now = True
    )
    created_at = models.DateTimeField(
        auto_now_add = True
    )




    