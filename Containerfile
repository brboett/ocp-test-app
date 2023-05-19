FROM quay.io/devfile/base-developer-image:ubi8-latest

USER root

RUN dnf -y update && \
    rpm --setcaps shadow-utils 2>/dev/null && \
    dnf -y install podman fuse-overlayfs openssh-clients \
        --exclude container-selinux && \
    dnf clean all && \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

RUN useradd user; \
echo -e "user:1:999\nuser:1001:64535" > /etc/subuid; \
echo -e "user:1:999\nuser:1001:64535" > /etc/subgid; 

ADD containers.conf /etc/containers/containers.conf
ADD podman-containers.conf /home/user/.config/containers/containers.conf 

RUN mkdir -p /home/user/.local/share/containers && \
    chown user:user -R /home/user && \
    chmod 644 /etc/containers/containers.conf

COPY build.sh /tmp

WORKDIR /tmp

RUN cd /tmp && \
    chmod +x build.sh && \
    ./build.sh

# Note VOLUME options must always happen after the chown call above
# RUN commands can not modify existing volumes
VOLUME /var/lib/containers
VOLUME /home/user/.local/share/containers 

RUN mkdir -p /var/lib/shared/overlay-images \
             /var/lib/shared/overlay-layers \
             /var/lib/shared/vfs-images \
             /var/lib/shared/vfs-layers && \
    touch /var/lib/shared/overlay-images/images.lock && \
    touch /var/lib/shared/overlay-layers/layers.lock && \
    touch /var/lib/shared/vfs-images/images.lock && \
    touch /var/lib/shared/vfs-layers/layers.lock 

ENV _CONTAINERS_USERNS_CONFIGURED=""