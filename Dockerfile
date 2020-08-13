FROM python:3.8.3-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apt update \
    && apt-get -y install libpq-dev postgresql python-psycopg2 gcc python3-dev musl-dev libffi-dev 
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install grpcio==1.29.0
RUN pip install Pillow
RUN pip install uvloop
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
EXPOSE 8080
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "garden_drf.wsgi"]
