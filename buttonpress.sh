#!/bin/bash

# this is for running to put the keys into the mappings file
# replace "USERNAME" in quotes with the username needing the login

USERNAME="USERNAME"

sudo -v
echo "Enter PIN if required then Press the button"
sudo sh -c "pamu2fcfg -u $USERNAME >> /etc/u2f_mappings"
