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

INSTALL_DO_ONCE=/vagrant/installed

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 
  exit 1
fi

if [[ -f $INSTALL_DO_ONCE ]]; then
  echo "Already installed, remove $INSTALL_DO_ONCE and rerun if you want to reinstall"
else
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

  #Install nodejs and npm
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

  # Setup firewall ports
  firewall-cmd --zone=public --add-port=3000/tcp --permanent
  firewall-cmd --zone=public --add-port=3001/tcp --permanent
  firewall-cmd --zone=public --add-port=5858/tcp --permanent
  firewall-cmd --zone=public --add-port=8888/tcp --permanent
  firewall-cmd --zone=public --add-port=35729/tcp --permanent
  firewall-cmd --reload

  # Touch file to keep install to once.
  touch $INSTALL_DO_ONCE

fi

