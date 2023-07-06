############################################################
# A dockerfile used to construct a container for RRBSsim, making it easy to use. 
# Based on Ubuntu:14.04 
############################################################


# base image for python2.7
FROM ubuntu:14.04

# Author
MAINTAINER xwsun@zju.edu.cn version: 0.1.0

RUN apt-get update

# Compiler Installation
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils

# python2.7 Installation
RUN apt-get install --yes python2.7

# Numpy and Scipy Installation
RUN apt-get install --yes python-scipy \
    python-numpy

# pip Installation
RUN apt-get install --yes python-pip


# pyfasta Installation
RUN apt-get install -y wget
RUN wget "https://files.pythonhosted.org/packages/be/3f/794fbcdaaa2113f0a1d16a962463896c1a6bdab77bd63f33a8f16aae6cdc/pyfasta-0.5.2.tar.gz"
RUN tar -zxvf pyfasta-0.5.2.tar.gz && cd pyfasta-0.5.2 && python setup.py install && cd ..

# pirs Downloading
RUN apt-get install -y \
    git \
    libboost-dev \
    zlib1g-dev
RUN git clone https://github.com/galaxy001/pirs.git /opt/pirs --branch v1.11 --single-branch && \
    cd /opt/pirs && \
    make && \
    cd -

RUN git clone https://github.com/ryancey1/RRBSsim.git /opt/RRBSsim && \
    cd /opt/RRBSsim && \
    git pull && \
    cd -
RUN chmod -R a+x /opt/RRBSsim

WORKDIR /home


ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/pirs:/opt/RRBSsim 
