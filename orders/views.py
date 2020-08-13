from django.shortcuts import render
from rest_framework import viewsets
from orders.models import Order, Payment, Coupon, UserAppliedCouponList, UserCoupon
from users.models import User
from django.conf import settings
from rest_framework.response import Response
from orders.serializers import OrderSerializer, PaymentSerializer, CouponSerializer, UserCouponSerializer, UserAppliedCouponListSerializer
from users.authenticate import get_uid
from django.conf import settings
from rest_framework.response import Response
# Create your views here.


class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
            try: 
                user = User.objects.get(username=uid)
                qset = Order.objects.filter(user= user)
                serializer = OrderSerializer(qset, many=True)
                return Response(serializer.data)
            except:
                serializer = OrderSerializer({}, many=True)
                return Response(serializer.data)
        serializer = OrderSerializer(self.queryset, many=True)
        return Response(serializer.data)


class PaymentViewSet(viewsets.ModelViewSet):
    queryset = Payment.objects.all()
    serializer_class = PaymentSerializer
 
    def list(self, request):
        id_token=request.query_params.get('id_token')
        uid = get_uid(id_token)
        if uid!= None:
            try:
                user = User.objects.get(username=uid)
                qset = Payment.objects.filter(user= user)
                serializer = PaymentSerializer(qset, many=True)
                return Response(serializer.data)
            except:
                serializer = PaymentSerializer(self.queryset, many=True)
                return Response(serializer.data)
        serializer = PaymentSerializer(self.queryset, many=True)
        return Response(serializer.data)

class CouponViewSet(viewsets.ModelViewSet):
    queryset = Coupon.objects.all()
    serializer_class = CouponSerializer
class UserCouponViewSet(viewsets.ModelViewSet):
    queryset = UserCoupon.objects.all()
    serializer_class = UserCouponSerializer
class UserAppliedCouponListViewSet(viewsets.ModelViewSet):
    queryset = UserAppliedCouponList.objects.all()
    serializer_class = UserAppliedCouponListSerializer
    