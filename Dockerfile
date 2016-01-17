FROM java:8-jre

RUN apt-get -y update
RUN apt-get -y install libsodium13

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
