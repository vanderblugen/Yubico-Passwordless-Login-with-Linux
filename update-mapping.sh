#!/bin/bash

# List of services to update policy for
SERVICES=(
  gdm-password
  lightdm
  sudo
  login
  polkit-1
  xscreensaver
)

cd /etc/pam.d
echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f
for f in ${SERVICES[@]}; do
  if [ ! -f $f ]; then
    echo "[SKIP] $f does not exist"
    continue
  fi

  if grep -Fxq "@include common-u2f" $f; then
    echo "[SKIP] Updated policy exists in $f"
  else
    mv $f $f~
    awk '/@include common-auth/ {print "@include common-u2f"}; {print}' $f~ > $f
  fi
done
