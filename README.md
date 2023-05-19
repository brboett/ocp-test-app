# Overview
This repository contains packer code that will build the following AMIs in AWS: 

* Amazon linux 2


# Commands

```sh
# Initialize Directory
$ packer init
```

```sh
# Format all files
$ packer fmt .
```

```sh
# Format files individually
$ packer fmt linux.pkr.hcl
```

```sh
# Validate all files
$ packer validate .
```

```sh
# Validate files individually
$ packer validate linux.pkr.hcl
```

```sh
# Build Ubuntu
$ packer build .
```

# AWS AMI Timeouts
Add to /etc/environment on the packer build server

```sh
# As root (sudo su)
sudo echo 'AWS_POLL_DELAY_SECONDS=60' >> /etc/environment
sudo echo 'AWS_MAX_ATTEMPTS=800' >> /etc/environment
```