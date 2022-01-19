#!/bin/bash

cd /etc/pam.d
echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f
for f in gdm-password lightdm sudo login polkit-1 xscreensaver; do
mv $f $f~
awk '/@include common-auth/ {print "@include common-u2f"}; {print}' $f~ > $f
done
