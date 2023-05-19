#!/bin/bash

# Install Packer
echo "Installing Packer..."
cd /tmp
curl -k -O https://releases.hashicorp.com/packer/1.8.6/packer_1.8.6_linux_amd64.zip
unzip packer_1.8.6_linux_amd64.zip
mv packer /usr/local/bin
rm -rf packer_1.8.6_linux_amd64.zip

# Install Terraform
echo "Installing Terraform..."
cd /tmp
curl -k -O https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
mv terraform /usr/local/bin
rm -rf terraform_1.4.6_linux_amd64.zip
 
# Install Container Tools
echo "Installing Container Tools..."
yum module install container-tools:rhel8 -y