From python:3-jessie
MAINTAINER kaitoii11

RUN apt-get -y update
RUN apt-get install -y \
      build-essential \
      cmake \
      libav-tools\
      libboost-all-dev \
      libopenblas-dev \
      liblapack-dev \
      wget \
      && apt-get clean && rm -rf /tmp/* /var/tmp/*
RUN pip install dlib opencv-python numpy
