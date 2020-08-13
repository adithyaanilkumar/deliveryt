from users.models import User,Address, CartItem, Cart
from products.serializers import ProductSerializer
from rest_framework import serializers

class AddressSerializer(serializers.ModelSerializer):

    class Meta:
        model = Address
        fields = "__all__"
class UserSerializer(serializers.ModelSerializer):
    #address = AddressSerializer(many = True)
    #date_joined = serializers.DateTimeField(required=False)
  
    class Meta:
        model = User
        fields = [
                    'id',
                    'last_login',
                    'username',
                    'first_name',
                    'last_name',
                    'email',
                    'phone',
                    'address',
                    ]

    

class CartItemSerializer(serializers.ModelSerializer):

    class Meta:
        model = CartItem
        fields = "__all__"

class CartItemListSerializer(serializers.ModelSerializer):
    product = ProductSerializer()
    class Meta:
        model = CartItem
        fields = ("id","user","ordered","product","quantity","created_at","updated_at","amount_saved","price")
class CartSerializer(serializers.ModelSerializer):
    #cart_items = serializers.PrimaryKeyRelatedField(queryset=CartItem.objects.all(), many=True)
    cart_items = CartItemListSerializer(many=True)
    class Meta:
        model = Cart
        fields =('id','user','ordered','cart_items','total_price')














'''
    def create(self, validated_data):
        address_data = validated_data.pop('address')
        user = User.objects.create(**validated_data)
        user.save()
        for data in address_data:
            Address.objects.create(**data)
        return user
    def update(self, instance, validated_data):
        address_datas = validated_data.pop('address')
        add_list = instance.address.all()
        add_list = list(add_list)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)
        instance.email = validated_data.get('email', instance.email)
        instance.phone = validated_data.get('phone', instance.phone)
        instance.username = validated_data.get('username', instance.username)
        instance.date_joined = validated_data.get('date_joined', instance.date_joined)
        instance.save()
        add = {}
        for address_data in address_datas:
            try:
                add = add_list.pop(0)
            except:
                add = {
        "id": "Null",
        "name": "Null",
        "address1": "Null",
        "address2": "Null",
        "city": "Null",
        "state": "Null",
        "pin_code": "Null",
        "lat": "Null",
        "longt": "Null"
    }
            #add.name = address_data.get('name', add.name)
            add.uid = instance.username
            add.address1  = address_data.get('address1', add.address1 )
            add.address2  = address_data.get('address2', add.address2 )
            add.city   = address_data.get('city', add.city)
            add.state    = address_data.get('state', add.state )
            add.pin_code   = address_data.get('pin_code', add.pin_code)
            add.lat   = address_data.get('lat', add.lat)
            add.longt   = address_data.get('longt', add.longt)
            add.save()
        return instance
    '''