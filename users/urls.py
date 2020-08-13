from django.urls import  path,include
from rest_framework.routers import DefaultRouter
from users import views

router = DefaultRouter()


router.register(r'user',views.UserViewSet)
router.register(
    r'address', 
    views.AddressViewSet
)

router.register(
    r'cartitem', 
    views.CartItemViewSet
)
router.register(
    r'cart', 
    views.CartViewSet
)



urlpatterns =[
    path('',include(router.urls))
    ]