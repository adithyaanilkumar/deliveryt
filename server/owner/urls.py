from django.urls import path, include
from rest_framework.routers import DefaultRouter
from owner import views

router = DefaultRouter()



router.register(
    r'delivery', 
    views.DeliveryViewSet
)

router.register(
    r'vieworders', 
    views.VieworderViewSet
)

urlpatterns = [
    path('',include(router.urls))
]