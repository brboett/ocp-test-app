FROM quay.io/devfile/base-developer-image:ubi8-latest

USER root

RUN dnf -y update && \
    rpm --setcaps shadow-utils 2>/dev/null && \
    dnf -y install podman fuse-overlayfs openssh-clients \
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

COPY build.sh /tmp

WORKDIR /tmp

RUN cd /tmp && \
    chmod +x build.sh && \
    ./build.sh

# # Copy & modify the defaults to provide reference if runtime changes needed.
# # Changes here are required for running with fuse-overlay storage inside container.
# RUN sed -e 's|^#mount_program|mount_program|g' \
#            -e '/additionalimage.*/a "/var/lib/shared",' \
#            -e 's|^mountopt[[:space:]]*=.*$|mountopt = "nodev,fsync=0"|g' \
#            /usr/share/containers/storage.conf \
#            > /etc/containers/storage.conf 

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