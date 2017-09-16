FROM java:8-jre

RUN \
    apt-get update && \
    apt-get -y install curl build-essential unzip

ENV LIBSODIUM_VERSION 1.0.13
ENV GLOWROOT_VERSION 0.9.24

# build libsodium
RUN \
    mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VERSION.tar.gz -o libsodium-$LIBSODIUM_VERSION.tar.gz && \
    tar xfvz libsodium-$LIBSODIUM_VERSION.tar.gz && \
    cd /tmpbuild/libsodium/libsodium-$LIBSODIUM_VERSION/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/

# grab glowroot and put it in a known place
RUN \
    mkdir -p /tmpbuild/glowroot && \
    cd /tmpbuild/glowroot && \
    curl -L https://github.com/glowroot/glowroot/releases/download/v$GLOWROOT_VERSION/glowroot-$GLOWROOT_VERSION-dist.zip -o glowroot-$GLOWROOT_VERSION-dist.zip && \
    unzip -j glowroot-$GLOWROOT_VERSION-dist.zip glowroot/glowroot.jar && \
    mkdir -p /opt/glowroot && \
    mv glowroot.jar /opt/glowroot/

# clean up
RUN \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -Rf /tmpbuild/
