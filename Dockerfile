FROM centos:7

RUN yum update -y && yum clean all

RUN yum install -y \
        autoconf \
        automake \
        bzip2 \
        bzip2-libs \
        bzip2-devel \
        gcc \
        gcc-c++ \
        gcc-gfortran \
        java-1.8.0-openjdk \
        java-1.8.0-openjdk-devel \
        libcurl \
        libcurl-devel \
        libtool \
        m4 \
        make \
        pcre \
        pcre-devel \
        perl \
        pkgconfig \
        readline \
        readline-devel \
        tar \
        wget \
        xz \
        xz-libs \
        xz-devel \
        zlib \
        zlib-devel

RUN curl https://cran.r-project.org/src/base/R-3/R-3.3.1.tar.gz | tar -xz && \
    cd R-3.3.1 && \
    ./configure --with-x=no && \
    make && \
    make install

RUN useradd -m -U -s /bin/bash stm && \
    passwd -l stm

ADD . /tmp/
WORKDIR /tmp

RUN R --vanilla -f install.r && \
    rm -f Dockerfile install.r

USER stm
