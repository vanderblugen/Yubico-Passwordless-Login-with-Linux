# yubico_password_less_ubuntu

# WORK IN PROGRESS

Yubico Passwordless Ubuntu Login

First off I did not come up with all of the information from this but did copy a large portion of it from [AskUbuntu] (https://askubuntu.com/questions/1167691/passwordless-login-with-yubikey-5-nfc?newreg=d3833870cc924fedb49ce95d064f3a09)

### Install needed software to interface with the Yubico Key
`sudo apt install libpam-u2f`

### Create a mappings file
Run this for each user
`echo Press the button`
`pamu2fcfg -u USERNAME >> /etc/u2f_mappings`

### 

`sudo su
cd /etc/pam.d
echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f
for f in gdm-password lightdm sudo login; do
mv $f $f~
awk '/@include common-auth/ {print "@include common-u2f"}; {print}' $f~ > $f
done
exit`
