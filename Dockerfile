FROM ubuntu:20.04
MAINTAINER Marcus Hughes <hello@msh100.uk>

RUN apt-get update && \
    apt-get install -y qstat xmlstarlet wget

RUN wget https://github.com/transitorykris/hypnos/releases/download/1.0/hypnos-linux-amd64.tar.gz && \
    tar -xvf hypnos-linux-amd64.tar.gz && \
    mv hypnos /bin && \
    rm -rf hypnos-linux-amd64.tar.gz

RUN wget https://github.com/icedream/icecon/releases/download/v1.0.0/icecon_linux_amd64 && \
    mv icecon_linux_amd64 /bin/icecon && \
    chmod +x /bin/icecon

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT /run.sh
