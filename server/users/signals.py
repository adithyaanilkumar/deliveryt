from users.models import Cart, CartItem
from django.db.models.signals import post_save, post_delete, pre_delete, m2m_changed 
from django.dispatch import receiver
from django.db.models import Sum
import logging
logger = logging.getLogger("mylogger")
#logger.info("Whatever to log")
def cal_total(instance):
  queryset = instance.cart_items.all().aggregate(
           total_price = Sum('price')
        )
  return queryset["total_price"]
  #return instance.cart_items.all().aggregate(Sum('price'))

@receiver(post_save, sender=CartItem)
def save_profile(sender, instance,created,*args, **kwargs):
    if created:
      try:
        logger.info(f"loggin user {instance.user}")
        obj=Cart.objects.get(user=instance.user)
        logger.info(f"loggin user {obj.user}")
        logger.info(f"loggin user {obj.cart_items}")
        obj.cart_items.add(instance)
        total=cal_total(obj)
        logger.info(f"loggin user tot {total}")
        obj.total_price=total
        obj.save()
        instance.product.stock = instance.product.stock - instance.quantity
      except:
        obj=Cart.objects.create(user=instance.user)
        obj.cart_items.add(instance)
        logger.info(f"creAted user {obj.user}")
        total=cal_total(obj)
        logger.info(f"created user tot {total}")
        obj.total_price=total
        obj.save()
'''       
@receiver(m2m_changed,sender=Cart.cart_items.through)
def cart_item_changed(sender, instance, action, reverse, model, pk_set, **kwargs):
  if action=='post_remove' or action=='post_clear':
    instance.total=cal_total(instance)
    instance.save()
'''



@receiver(post_delete, sender=CartItem)
def del_from_cart(sender, instance,*args, **kwargs):
  obj=Cart.objects.get(user=instance.user)
  #obj.cart_items.remove(instance)
  total=cal_total(obj)
  logger.info(f"delete user tot {total}")
  obj.total_price=total
  #admin
  obj.save()
@receiver(pre_delete, sender=Cart)
def del_cart_item(sender, instance,*args, **kwargs):
  obj=Cart.objects.get(user=instance.user)
  queryset = obj.cart_items.all()
  for data in queryset:
    data.delete()
  



