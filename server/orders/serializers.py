from rest_framework import  serializers
from  orders.models import Order,Payment,Coupon, UserCoupon, UserAppliedCouponList

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = '__all__'
class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = '__all__'
class UserCouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserCoupon
        fields = '__all__'
class UserAppliedCouponListSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserAppliedCouponList
        fields = '__all__'