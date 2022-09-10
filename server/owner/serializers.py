from rest_framework import  serializers
from  owner.models import Vieworder, Delivery
class VieworderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vieworder
        fields = '__all__'
class DeliverySerializer(serializers.ModelSerializer):

    class Meta:
        model = Delivery
        fields = "__all__"