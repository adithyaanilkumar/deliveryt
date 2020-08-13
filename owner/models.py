from django.db import models
from django.conf import settings

    
class Delivery(models.Model):
    name = models.TextField(max_length=200)
    address1 = models.TextField(max_length=700)
    address2 = models.TextField(max_length=700)
    city = models.TextField(max_length=30)
    state = models.TextField(max_length=30)
    pin_code = models.CharField(max_length=6)
    lattitude = models.DecimalField(
        blank = False,
        max_digits = 30,
        decimal_places = 15,
    )
    longtitude = models.DecimalField(
        blank = False,
        max_digits = 30,
        decimal_places = 15,
    )
    a1 = models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=10,
        verbose_name = "distance limit area 1"
    )
    a2= models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=3,
        verbose_name = "distance limit area 2"
    )
    a3= models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=3,
        verbose_name = "distance limit area 3"
    )
    c1 = models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=10,
        verbose_name = "charge for area 1"
    )
    c2= models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=3,
        verbose_name = "charge for area 2"
    )
    c3= models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=3,
        verbose_name = "charge for area 3"
    )
    max_radius= models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=15,
        verbose_name = "Maximum_Radius"
    )
    tax=models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=15,
        verbose_name = "tax"
    )
    def __str__(self):
        return f"{self.id}"



class Vieworder(models.Model):
    day_count = models.IntegerField(default=1)
    date_request_was_made= models.DateField(auto_now=True)
    date_request_from = models.DateField(null=True, blank=True)
    order_list = models.URLField(blank=True, null=True)
    invoice_list = models.URLField(blank=True, null=True)
    output = models.FileField(null=True,blank=True)

    def __str__(self):
        return f"{self.date_request_was_made}"