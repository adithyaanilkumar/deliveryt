# index.py
'''
from algoliasearch_django import AlgoliaIndex
from algoliasearch_django.decorators import register

from .models import Product

@register(Product)
class YourModelIndex(AlgoliaIndex):
    fields = ('name', 'category','description','image_url','regular_price','discount_price','active','id','popular')
'''