#!/bin/bash

# this is for running to put the keys into the mappings file
# replace "USERNAME" in quotes with the username needing the login

# Use logname as $USER or who will be root. 
USERNAME="$(logname)"

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "Please execute script as root"
  exit 1
fi

while [ "$1" != "" ]; do
  case $1 in 
    --username)
      shift
      USERNAME=$1
      ;;
  esac
  shift
done

if [ -z "$USERNAME" ]; then
  echo "Username is not set, please use --username flag to set"
fi

read -p "u2f mapping will be generated for the user '$USERNAME'. Is this correct? (Y/N): "
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Please call script again and user --username flag to specify username."
  exit 1
fi

sudo -v
echo "Enter PIN if required then Press the button"
# Append new line
pamu2fcfg -u $USERNAME >> /etc/u2f_mappings
