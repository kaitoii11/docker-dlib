From python:3-jessie
MAINTAINER kaitoii11

ENV DLIB=https://github.com/davisking/dlib/archive/v19.13.tar.gz

RUN apt-get -y update
RUN apt-get install -y \
      build-essential \
      cmake \
      libboost-all-dev \
      libopenblas-dev \
      liblapack-dev \
      x11-apps \
      wget \
      && apt-get clean && rm -rf /tmp/* /var/tmp/*
RUN wget -qO- $DLIB | tar xvz
RUN ln -s dlib* dlib
WORKDIR /dlib
RUN python setup.py install
WORKDIR /dlib/python_examples
RUN pip install -r requirements.txt
