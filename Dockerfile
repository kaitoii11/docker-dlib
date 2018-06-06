From  python:3.6-alpine
MAINTAINER kaitoii11

RUN apk add --update --no-cache \
      build-base \
      boost-dev \
      clang-dev \
      cmake \
      coreutils \
      ffmpeg-dev \
      ffmpeg-libs \
      libjpeg \
      libjpeg-turbo-dev \
      wget
RUN pip install numpy

WORKDIR /tmp
RUN wget https://github.com/opencv/opencv/archive/3.4.0.zip && \
   unzip 3.4.0.zip && rm 3.4.0.zip && \
   wget https://github.com/opencv/opencv_contrib/archive/3.4.0.zip && \
   unzip 3.4.0.zip && rm 3.4.0.zip

WORKDIR /tmp/opencv-3.4.0/build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
   -D CMAKE_C_COMPILER=/usr/bin/clang \
   -D CMAKE_CXX_COMPILER=/usr/bin/clang++ \
   -D CMAKE_INSTALL_PREFIX=/usr/local \
   -D INSTALL_PYTHON_EXAMPLES=OFF \
   -D INSTALL_C_EXAMPLES=OFF \
   -D WITH_FFMPEG=ON \
   -D WITH_TBB=ON \
   -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-3.4.0/modules \
   -D PYTHON_EXECUTABLE=/usr/local/bin/python \
   ..
RUN make -j$(nproc) && make install && cd .. && rm -rf build
ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++
RUN pip install dlib
WORKDIR /
RUN rm -rf /tmp/*
