from django.shortcuts import render
from rest_framework import viewsets
from owner.models import Vieworder, Delivery
from owner.serializers import DeliverySerializer, VieworderSerializer
# Create your views here.



class DeliveryViewSet(viewsets.ModelViewSet):
    queryset = Delivery.objects.all()
    serializer_class = DeliverySerializer

class VieworderViewSet(viewsets.ModelViewSet):
    queryset = Vieworder.objects.all()
    serializer_class = VieworderSerializer
    