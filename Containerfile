FROM quay.io/devfile/base-developer-image:ubi8-latest

USER root

RUN dnf -y update && \
    rpm --setcaps shadow-utils 2>/dev/null && \
    dnf -y install podman slirp4netns fuse-overlayfs openssh-clients \
        --exclude container-selinux && \
    dnf clean all && \
    rm -rf /var/cache /var/log/dnf* /var/log/yum.*

RUN useradd podman; \
echo -e "podman:1:999\npodman:1001:64535" > /etc/subuid; \
echo -e "podman:1:999\npodman:1001:64535" > /etc/subgid; 

ADD containers.conf /etc/containers/containers.conf
ADD podman-containers.conf /home/podman/.config/containers/containers.conf 

RUN mkdir -p /home/podman/.local/share/containers && \
    chown podman:podman -R /home/podman && \
    chmod 644 /etc/containers/containers.conf

# RUN usermod --add-subuids 100000-165536 --add-subgids 100000-165536 user

COPY build.sh /tmp

WORKDIR /tmp

RUN cd /tmp && \
    chmod +x build.sh && \
    ./build.sh

# Note VOLUME options must always happen after the chown call above
# RUN commands can not modify existing volumes
VOLUME /var/lib/containers
VOLUME /home/podman/.local/share/containers 

RUN mkdir -p /var/lib/shared/overlay-images \
             /var/lib/shared/overlay-layers \
             /var/lib/shared/vfs-images \
             /var/lib/shared/vfs-layers && \
    touch /var/lib/shared/overlay-images/images.lock && \
    touch /var/lib/shared/overlay-layers/layers.lock && \
    touch /var/lib/shared/vfs-images/images.lock && \
    touch /var/lib/shared/vfs-layers/layers.lock 

ENV _CONTAINERS_USERNS_CONFIGURED=""