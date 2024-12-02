#!/bin/bash

# Verify running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "Please execute script as root"
  exit 1
fi


# List of services to update policy for
SERVICES=(
  lightdm
  sudo
  sudo-i
  su
  chsh
  login
  polkit-1
  xscreensaver
  gdm-password
  gdm-smartcard-sssd-or-password
  ppp
  unity
  cinnamon-screensaver
)

cd /etc/pam.d || exit 1
echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f

for f in "${SERVICES[@]}"; do
  # Starting with Ubuntu 24.04, polkit-1 is no longer in /etc/pam.d and has to be copied over first.
  if [[ ! -f "polkit-1" && -f "/usr/lib/pam.d/polkit-1" ]]; then
    cp /usr/lib/pam.d/polkit-1 .
  fi

  if [ ! -f "$f" ]; then
    echo "[SKIP] $f does not exist"
    continue
  fi

  if grep -Fxq "@include common-u2f" "$f"; then
    echo "[SKIP] Updated policy exists in $f"
  else
    mv "$f" "$f~"
    awk '/@include common-auth/ {print "@include common-u2f"}; {print}' "$f~" > "$f"
  fi
done
