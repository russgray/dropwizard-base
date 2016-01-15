FROM java:8-jre

RUN apt-get -y update
RUN apt-get -y install libsodium13 python-pip
RUN pip install envdir

RUN apt-get clean
