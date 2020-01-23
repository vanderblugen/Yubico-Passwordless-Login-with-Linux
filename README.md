# Yubico Passwordless Ubuntu Login
This is for setting up a Yubico Passwordless Ubuntu Login or Logins.

This potentially can be used with any device that supports FIDO U2F.

This is a really straight forward.  

After this installation the key isn't required but the software will be a `sufficient` attempt and if the key isn't available then the password is required.  It even gives the key option during sudo access.

Please keep in mind that I did not come up with all of the information from this but did copy a large portion of it from [AskUbuntu](https://askubuntu.com/questions/1167691/passwordless-login-with-yubikey-5-nfc?newreg=d3833870cc924fedb49ce95d064f3a09)

### Install needed software to interface with the Yubico Key
```shell
sudo apt install libpam-u2f -y
```

### Create a mappings file
Run this for each user.  Update `USERNAME` with the username of the appropriate user
```shell
echo Press the button
sudo pamu2fcfg -u USERNAME >> /etc/u2f_mappings
```

#### Modify the file
The `/etc/u2f_mappings` file is going to need to be edited

```shell
sudo nano /etcu2f_mappings
```

Note these things when editing the file
- Each user should have it's own line in the file
- Single user with multiple keys is layed out
    - `USERNAME:KEY:KEY:KEY`

### This finalizes the installation
An error message may appear during this portion.  But that is normal under certain circumstances.

```shell
sudo su
cd /etc/pam.d
echo 'auth sufficient pam_u2f.so authfile=/etc/u2f_mappings cue' > common-u2f
for f in gdm-password lightdm sudo login; do
mv $f $f~
awk '/@include common-auth/ {print "@include common-u2f"}; {print}' $f~ > $f
done
exit
```

# Enjoy

## If anyone wants to contribue please reach out.
