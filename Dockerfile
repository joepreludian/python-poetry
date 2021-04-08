FROM docker.io/python:alpine

RUN apk update && \
    apk add --virtual .build-deps build-base gcc cmake linux-headers gcc libffi-dev libressl-dev gettext rust cargo

RUN pip install --upgrade pip && pip install poetry && \
    apk del .build-deps && \
    poetry -V

CMD ['poetry']
