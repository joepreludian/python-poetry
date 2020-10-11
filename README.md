# python-poetry

Docker image with latest python 3 + poetry installed. It will be used within Dockerized Jenkins pipelines in order to speedup package generation and deployment using Poetry.

https://hub.docker.com/repository/docker/joepreludian/python-poetry/general

Keeping efficiency in mind, I'm inheriting from python:alpine docker image. Take a look on `Dockerfile` for reference.

## Basic usage

    $ docker run -v $(pwd):/app -w /app docker.io/joepreludian/python-poetry:latest poetry build

This command will run under your current working directory and will build your poetry based project, for instance.
So you can automate through jenkins pipelines in order to build your project and publish on PyPI or your own private repo.

Thank you!
