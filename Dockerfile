FROM ubuntu:18.04

WORKDIR /opt
COPY . /opt

USER root

RUN apt-get -y update
RUN apt-get install -y python3.6-dev \
                       python3-pip \
                       wget \
                       gdal-bin \
                       libgdal-dev \
                       libspatialindex-dev \
                       build-essential \
                       software-properties-common \
                       apt-utils \
                       ffmpeg \
                       libsm6 \
                       libxext6 \
                       zlib1g-dev \
                       libpcre3-dev \
                       libpython-dev \
                       libpython3-dev \
                       2to3 \
                       python3-distutils

RUN wget http://ccl.cse.nd.edu/software/files/cctools-7.1.12-source.tar.gz
RUN tar -xzvf cctools-7.1.12-source.tar.gz
RUN cd cctools-release-7.1.12
RUN ./configure --prefix /usr && make && make install
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get install -y libgdal-dev
RUN pip3 install --upgrade pip

RUN wget http://download.osgeo.org/libspatialindex/spatialindex-src-1.7.1.tar.gz
RUN tar -xvf spatialindex-src-1.7.1.tar.gz
RUN cd spatialindex-src-1.7.1/ && ./configure && make && make install
RUN ldconfig
RUN add-apt-repository ppa:ubuntugis/ppa
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal
RUN export C_INCLUDE_PATH=/usr/include/gdal
RUN apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'