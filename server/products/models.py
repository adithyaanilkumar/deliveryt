from django.db import models

# Create your models here.


class Product(models.Model):
    name = models.TextField(
        max_length = 512,
        null=False,
        )
    category = models.TextField(
        max_length = 512,
        null=False,
        )
    description = models.TextField( 
        max_length = 4096,
        null=False,
    )
    image_url = models.URLField(
        max_length = 512,
    )
    regular_price = models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=0.00
    )
    discount_price = models.DecimalField(
        max_digits=50, 
        decimal_places=2, 
        default=0.00
    )
    active = models.BooleanField(
        default = True,
    )
    popular =  models.BooleanField(
        default = True,
    )
    stock = models.DecimalField(
        max_digits = 10,
        decimal_places = 2 
    )
    taxable = models.BooleanField(
        default = False,
    )
    created_at = models.DateTimeField(
        auto_now = True,
    )
    updated_at = models.DateTimeField(
        auto_now_add = True,
    )
    class Meta:
        verbose_name = "product"
        verbose_name_plural = "products"
    
    def __str__(self):
        return self.name
    
    def get_absolute_url(self):
        return reverse('company_details', kwargs={'pk': self.id})
    

