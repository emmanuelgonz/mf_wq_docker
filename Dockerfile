FROM centos:centos7

WORKDIR /opt
COPY . /opt

USER root

RUN yum update -y
RUN apt-get install -y python3

RUN wget https://ccl.cse.nd.edu/software/files/cctools-7.1.12-x86_64-centos7.tar.gz
RUN tar -xzvf cctools-7.1.12-x86_64-centos7.tar.gz

RUN export CCTOOLS_HOME=/opt/cctools-7.1.12-x86_64-centos7
RUN PATH=${CCTOOLS_HOME}/bin:$PATH

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'