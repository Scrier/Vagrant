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
touch /etc/yum.repos.d/mongodb.repo
sh -c 'echo "[mongodb]" > /etc/yum.repos.d/mongodb.repo'
sh -c 'echo "name=MongoDB Repository" >> /etc/yum.repos.d/mongodb.repo'
sh -c 'echo "baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/" >> /etc/yum.repos.d/mongodb.repo'
sh -c 'echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb.repo'
sh -c 'echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo'
sh -c 'echo "" >> /etc/yum.repos.d/mongodb.repo'

# Install epel repo
yum -y install epel-release

# Update repos
yum -y update

#install nodejs and npm
yum -y install nodejs npm

# Install mongodb
yum -y install mongodb-org mongodb-org-server

# Start mongodb as a service
systemctl start mongod

# Install mean-cli
npm install -g gulp
npm install -g bower
npm install -g mean-cli

if [ -d "/root/.npm" ]; then
	echo "Moving /root/.npm to /home/vagrant/.npm"
	mv /root/.npm /home/vagrant
	chown -R vagrant:vagrant /home/vagrant/.npm
fi

