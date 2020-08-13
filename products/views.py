from django.shortcuts import render
from products.models import Product
from products.serializers import ProductSerializer
from rest_framework import viewsets
from rest_framework import permissions
# Create your views here.

class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    #permission_classes = [permissions.IsAuthenticated]
    

