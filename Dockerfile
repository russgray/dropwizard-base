FROM java:8-jre

RUN \
    apt-get update \
    && apt-get -y install curl build-essential unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LIBSODIUM_VERSION 1.0.10

RUN \
    mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VERSION.tar.gz -o libsodium-$LIBSODIUM_VERSION.tar.gz && \
    tar xfvz libsodium-$LIBSODIUM_VERSION.tar.gz && \
    cd /tmpbuild/libsodium/libsodium-$LIBSODIUM_VERSION/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/ && \
    rm -Rf /tmpbuild/

RUN apt-get clean
