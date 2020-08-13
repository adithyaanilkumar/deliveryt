from django.shortcuts import render
from users.models import User, Address, CartItem, Cart
from users.serializers import UserSerializer, AddressSerializer, CartItemSerializer, CartSerializer
from rest_framework import viewsets
from rest_framework import permissions
from rest_framework import generics
from users.signals import cal_total
from rest_framework.response import Response
from decimal import Decimal
from users.authenticate import get_uid
import logging
from rest_framework import status   
from users.authenticate import get_uid
from django.conf import settings
from rest_framework.response import Response
logger = logging.getLogger("mylogger")
# Create your views here.

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    #permission_classes = [permissions.IsAuthenticated]
    def create(self, request, *args, **kwargs):
        id_token=request.query_params.get('id_token')
        req_data= request.data.copy()
        req_data["username"]= get_uid(id_token)
        serializer = self.get_serializer(data=req_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
                try:
                    qset = User.objects.filter(username=uid)
                    serializer = UserSerializer(qset, many=True)
                    return Response(serializer.data)
                except:
                    serializer = UserSerializer(self.queryset, many=True)
                    return Response(serializer.data)

        serializer = UserSerializer(self.queryset, many=True)
        return Response(serializer.data)
    
    

class AddressViewSet(viewsets.ModelViewSet):
    queryset = Address.objects.all()
    serializer_class = AddressSerializer
    def create(self, request, *args, **kwargs):
        id_token=request.query_params.get('id_token')
        req_data= request.data.copy()
        username = get_uid(id_token)
        try:
            #user = User.objects.get(username=username)
            req_data["user_name"]= username
        except:
            pass
        serializer = self.get_serializer(data=req_data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
            try:
                qset = Address.objects.filter(user_name = uid)
                serializer = AddressSerializer(qset, many=True)
                return Response(serializer.data)
            except:
                serializer = AddressSerializer(self.queryset, many=True)
                return Response(serializer.data)
        serializer = AddressSerializer(self.queryset, many=True)
        return Response(serializer.data)

class CartItemViewSet(viewsets.ModelViewSet):
    queryset = CartItem.objects.all()
    serializer_class = CartItemSerializer
    #permission_classes = [permissions.IsAuthenticated]
    def on(self, parameter_list):
        pass


    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
            try:
                user = User.objects.get(username=uid)
                qset = CartItem.objects.filter(user= user)
                serializer = CartItemSerializer(qset, many=True)
                return Response(serializer.data)
            except:
                serializer = CartItemSerializer(self.queryset, many=True)
                return Response(serializer.data)
        serializer = CartItemSerializer(self.queryset, many=True)
        return Response(serializer.data)
    def update(self, request, pk=None, *args, **kwargs):
            queryset = CartItem.objects.all()
            #instance = CartItem.objects.get(id=request.data.get("id"))
            #instance.update(quantity=request.data.get("quantity"))
            instance = self.get_object()
            qty=Decimal(request.data.get("quantity"))
            logger.info(f"in update {qty}")
            instance.quantity = qty
            instance.save()
            #instance.save()
            
            #serializer = self.get_serializer(instance)
            #serializer.is_valid(raise_exception=False)
            #self.perform_update(serializer)
            logger.info("in update")
            obj=Cart.objects.get(user=instance.user)
            obj.total_price=cal_total(obj)
            logger.info(f"in update tot price {obj.total_price}")
            obj.save()
            serializer = CartItemSerializer(queryset, many=True)
            return Response(serializer.data)
class CartViewSet(viewsets.ModelViewSet):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
            try:
                user = User.objects.get(username=uid)
                qset = Cart.objects.filter(user= user)
                serializer = CartSerializer(qset, many=True)
                return Response(serializer.data)
            except:
                serializer = CartSerializer(self.queryset, many=True)
                return Response(serializer.data)
        serializer = CartSerializer(self.queryset, many=True)
        return Response(serializer.data)
    #permission_classes = [permissions.IsAuthenticated]
    