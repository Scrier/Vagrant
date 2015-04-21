#!/bin/sh
#title        :install.sh
#description  :This script will install mean on a centos machine.
#author       :Andreas Joelsson
#date         :20141112
#version      :0.1.1
#usage        :install.sh
#notes        :Add environment variable DEBUG to execute with information on
#             :the steps that needs to be done. DEBUG=true ./setup.sh
#===============================================================================

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 
  exit 1
fi

# Add mongo db
sudo touch /etc/yum.repos.d/mongodb.repo
sudo sh -c 'echo "[mongodb]" > /etc/yum.repos.d/mongodb.repo'
sudo sh -c 'echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb.repo'
sudo sh -c 'echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" >> /etc/yum.repos.d/mongodb.repo'
sudo sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb.repo'
sudo sh -c 'echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo'
sudo sh -c 'echo "" >> /etc/yum.repos.d/mongodb.repo'

# Install epel repo
sudo yum -y install epel-release

# Update repos
sudo yum -y update

#install nodejs and npm
sudo yum -y install nodejs npm

# Install mongodb
sudo yum -y install mongodb-org mongodb-org-server

# Start mongodb as a service
sudo systemctl start mongod

# Install mean-cli
sudo npm install -g gulp
sudo npm install -g bower
sudo npm install -g mean-cli

