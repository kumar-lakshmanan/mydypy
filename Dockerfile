FROM python:3.11

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

RUN set -xe;

# Allows docker to cache installed dependencies between builds
COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /pyone

WORKDIR /pyone

COPY . .
# ADD . /pyone

RUN pip install -r requirements.txt

# RUN apk add --no-cache python3 py3-pip tini; \
#     pip install --upgrade pip setuptools-scm; \
#     python3 setup.py install; \
#     python3 martor_demo/manage.py makemigrations; \
#     python3 martor_demo/manage.py migrate; \
#     addgroup -g 1000 appuser; \
#     adduser -u 1000 -G appuser -D -h /app appuser; \
#     chown -R appuser:appuser /app

# USER appuser
EXPOSE 8000/tcp
# ENTRYPOINT [ "tini", "--" ]
# ENTRYPOINT ["python3", "pyone/manage.py"]
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]