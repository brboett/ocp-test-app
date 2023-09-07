# syntax=docker/dockerfile:1.3-labs

# updateBaseImages.sh can't operate on SHA-based tags as they're not date-based or semver-sequential, and therefore cannot be ordered
FROM quay.io/devfile/base-developer-image:ubi8-latest
LABEL maintainer="Red Hat, Inc."

LABEL com.redhat.component="devfile-universal-container"
LABEL name="devfile/universal-developer-image"
LABEL version="ubi8"

#label for EULA
LABEL com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI"

#labels for container catalog
LABEL summary="devfile universal developer image"
LABEL description="Image with developers tools. Languages SDK and runtimes included."
LABEL io.k8s.display-name="devfile-developer-universal"
LABEL io.openshift.expose-services=""

USER root

RUN \ 
curl -k -O https://releases.hashicorp.com/terraform/1.3.4/terraform_1.3.4_linux_amd64.zip; \
unzip terraform_1.3.4_linux_amd64.zip; \
mv terraform /usr/bin/; \
rm -rf terraform_1.3.4_linux_amd64.zip

RUN \ 
curl -k -O https://releases.hashicorp.com/packer/1.8.5/packer_1.8.5_linux_amd64.zip; \
unzip packer_1.8.5_linux_amd64.zip; \
mv packer /usr/bin; \
rm -rf packer_1.8.5_linux_amd64.zip

RUN \ 
curl -k -O https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip; \
unzip -qq awscli-exe-linux-x86_64.zip; \
./aws/install --bin-dir /usr/bin; \
rm -rf awscli-exe-linux-x86_64.zip

# cleanup dnf cache
RUN dnf -y clean all --enablerepo='*'

