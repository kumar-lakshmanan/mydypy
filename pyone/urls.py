from django.urls import path
from . import views

urlpatterns = [
    path('pyone/', views.hello, name='hello'),
]