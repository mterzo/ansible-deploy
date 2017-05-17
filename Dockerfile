FROM python:2.7-alpine

MAINTAINER Mike Terzo <mike@terzo.org>

ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV LANG C.UTF-8

RUN apk add --no-cache openssh

RUN mkdir -p /src/
WORKDIR /src
COPY requirements.txt /src


RUN apk add --no-cache --virtual .fetch-deps  \
        gcc \
        libc-dev \
        libffi-dev \
        linux-headers \
        make \
        openssl-dev \
        && pip install --no-cache-dir -r requirements.txt \
        && apk del .fetch-deps


COPY root /root
