This read me is rough notes for developers.

#Commands for DJango Project Creation & RUN

1. pip install django
2. django-admin startproject mydypy
3. cd mydypy
4. python manage.py migrate
5. python manage.py runserver
6. python manage.py startapp pyone
    
#Edit 

1. mydypy\settings.py
    INSTALLED_APPS = [
    'pyone',
    ....
    ]

2. pyone\views.py
```
from django.http import HttpResponse

def hello(request):
    return HttpResponse("Hello, World!")
```


3. New file : pyone\urls.py
```
    from django.urls import path
    from . import views

    urlpatterns = [
        path('pyone/', views.hello, name='hello'),
    ]
```

4. Edit: mydypy\urls.py
```
from django.contrib import admin
from django.urls import path, include # <-- 1. add this 

urlpatterns = [
 
    path('admin/', admin.site.urls),

    # 2. add this line too
    path('', include('pyone.urls')),

]
```

4. Run command:
    python manage.py runserver

5. Check site:
    http://127.0.0.1:8000/
    http://127.0.0.1:8000/pyone/


-------------------------

Unit Test

Edit pyone\test.py
```
from django.test import TestCase

class HelloWorldCase(TestCase):
    def testHello(self):
        mdummy = 'one'
        self.assertEqual(mdummy, "one")
```

Test Run COMMAND:
python manage.py test


-----------------------

DEPLOYMENT ISSUE CHECKER

python manage.py check --deploy


--------------------------

STATIC FILE CACHE

python manage.py collectstatic
(wont work if no static set)

--------------------------

STYLE CHECK 
pip install flake8
flake8 . --max-line-length=127

--------------------------
update changes
python manage.py makemigrations


---------------------------------
containerize


- CREATE DOCKERFILE 
- BUILD USING CMD:
    docker build -t mydypy .

- RUN USING CMD:
    docker run -it -p 8000:8000 mydypy



-------


docker login -u kaymatrix
ACCESS TOKEN

docker build -t mydypy .
docker run -it -p 8000:8000 mydypy
docker tag mydypy kaymatrix/mydypy
docker push kaymatrix/mydypy

docker run -it -p 8080:8080 --user=root -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp kestra/kestra:latest-full server local
docker run --hostname=79a3adb99c2a --env=PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin --env=LANG=C.UTF-8 --env=GPG_KEY=A035C8C19219BA821ECEA86B64E628F8D684696D --env=PYTHON_VERSION=3.11.8 --env=PYTHON_PIP_VERSION=24.0 --env=PYTHON_SETUPTOOLS_VERSION=65.5.1 --env=PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/dbf0c85f76fb6e1ab42aa672ffca6f0a675d9ee4/public/get-pip.py --env=PYTHON_GET_PIP_SHA256=dfe9fd5c28dc98b5ac17979a953ea550cec37ae1b47a5116007395bfacff2ab9 --env=PYTHONUNBUFFERED=1 --workdir=/pyone -p 8000:8000 --restart=no --runtime=runc -t -d mydypy

docker save mydypy:latest -o mydypyt_latest.tar
docker load -i mydypyt_latest.tar


https://hub.docker.com/r/kaymatrix/mydypy

-------