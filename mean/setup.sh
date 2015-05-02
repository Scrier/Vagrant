#!/bin/sh
#title        :setups.sh
#description  :This script will setup the local user for working towards mean.io 
#author       :Andreas Joelsson
#date         :20141112
#version      :0.1.1
#usage        :setup.sh
#notes        :Add environment variable DEBUG to execute with information on
#             :the steps that needs to be done. DEBUG=true ./setup.sh
#===============================================================================

function add_if_no_exist() {
  local line="$1"
  local file="$2"
  if grep -Fxq "$line" "$file"; then
    echo "\"$line\" already exist in $file"
  else
    echo "$line" >> $file
  fi
}

# Add lang to .bashrc
if [ ! -f $HOME/.bashrc ]; then
debug "No $HOME/.bashrc exist, creating new"
echo "#!/bin/sh" > $HOME/.bashrc
echo "" >> $HOME/.bashrc
fi
add_if_no_exist "export LANGUAGE=en_US.UTF-8" "$HOME/.bashrc"
add_if_no_exist "export LANG=en_US.UTF-8" "$HOME/.bashrc"
add_if_no_exist "export LC_ALL=en_US.UTF-8" "$HOME/.bashrc"

