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

#
# ssh-pass is nice to have for manual testing
# Adding git for use with galaxy
RUN apk add --no-cache sshpass git

# Make life easy for running ansible when delegated to
# localhost
RUN ln -s /usr/local/bin/python /usr/bin/python

COPY root /root
