from django.urls import path, include
from rest_framework.routers import DefaultRouter
from orders import views

router = DefaultRouter()

router.register(
    r'orders', 
    views.OrderViewSet
)


router.register(
    r'payments', 
    views.PaymentViewSet
)


router.register(
    r'coupons', 
    views.CouponViewSet
)
router.register(
    r'uc', 
    views.UserCouponViewSet
)
router.register(
    r'ucl', 
    views.UserAppliedCouponListViewSet
)
urlpatterns = [
    path('',include(router.urls))
]