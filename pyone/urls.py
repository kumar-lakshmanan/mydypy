from django.urls import path
from . import views

urlpatterns = [
    path('', views.HomeView.as_view(), name='home'),
    path('page2/', views.PageTwo, name='page2'),
    path('pyone/', views.hello, name='hello'),
]