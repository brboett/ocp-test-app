#!/bin/bash

echo "Customizations - STARTING"

########################
### DIRECTORIES ########
########################

echo "Creating Directories..."

sudo mkdir /opt/build > /dev/null
sudo chown ec2-user:ec2-user /opt/build > /dev/null

sleep 3s


########################
### DOWNLOADS ##########
########################

echo "Downloading Agent Binaries"

cd /opt/build

# AWS CLI
echo "Downloading AWS CLI..."
sudo curl -k -O "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" &> /dev/null

sleep 3s

########################
### AWS CLI ############
########################

echo "Installing AWS CLI..."

cd /opt/build
sudo unzip -qq awscli-exe-linux-x86_64.zip > /dev/null
sudo ./aws/install > /dev/null

sleep 3s

echo "Customizations - COMPLETE"