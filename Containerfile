FROM quay.io/devfile/base-developer-image:ubi8-latest

USER root

COPY build.sh /tmp

WORKDIR /tmp

RUN cd /tmp && \
    chmod +x build.sh && \
    ./build.sh

RUN dnf -y clean all --enablerepo='*'