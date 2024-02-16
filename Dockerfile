# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG PYTHON_VERSION=3.11
FROM python:${PYTHON_VERSION}-slim as base

RUN set -xe;

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Switch to the non-privileged user to run the application.
USER appuser

# Copy the source code into the container.
COPY . .

# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD python3 manage.py runserver 0.0.0.0:8000


#-----------old setup---------------
# FROM python:3.11

# # The enviroment variable ensures that the python output is set straight
# # to the terminal with out buffering it first
# ENV PYTHONUNBUFFERED 1

# RUN set -xe;

# # Allows docker to cache installed dependencies between builds
# COPY requirements.txt requirements.txt

# RUN pip install --no-cache-dir -r requirements.txt

# RUN mkdir /pyone

# WORKDIR /pyone

# COPY . .
# # ADD . /pyone

# RUN pip install -r requirements.txt

# # RUN apk add --no-cache python3 py3-pip tini; \
# #     pip install --upgrade pip setuptools-scm; \
# #     python3 setup.py install; \
# #     python3 martor_demo/manage.py makemigrations; \
# #     python3 martor_demo/manage.py migrate; \
# #     addgroup -g 1000 appuser; \
# #     adduser -u 1000 -G appuser -D -h /app appuser; \
# #     chown -R appuser:appuser /app

# # USER appuser
# EXPOSE 8000/tcp
# # ENTRYPOINT [ "tini", "--" ]
# # ENTRYPOINT ["python3", "pyone/manage.py"]
# CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]