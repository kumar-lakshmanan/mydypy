import json
import random
from django.http import HttpResponse
from django.shortcuts import render
from django.views.generic import TemplateView

class HomeView(TemplateView):
    template_name = "home.html"


def PageTwo(request):    
    names = ("bob", "dan", "jack", "lizzy", "susan")

    items = []
    for i in range(100):
        items.append({
            "name": random.choice(names),
            "age": random.randint(20,80),
            "url": "https://example.com",
        })

    context = {}
    context["items_json"] = json.dumps(items)

    return render(request, 'page2.html', context)

def hello(request):
    return HttpResponse("Hello, World!")