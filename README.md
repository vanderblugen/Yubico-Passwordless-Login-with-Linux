# Yubico Passwordless Ubuntu Login
This is for setting up a Yubico Passwordless with Linux Ubuntu Login or Logins.

This has also been tested and works on Raspberry Pi OS as well.

This setup is not for the Yubico key's alone and can be used with other FIDO keys.

This is a fairly straight forward implementation.

After this installation the key isn't required but the software will be a `sufficient` attempt and if the key isn't available then the password is required.  It even gives the key option during sudo access.

Please keep in mind that I did not come up with all of the information from this but did copy a large portion of it from [AskUbuntu](https://askubuntu.com/questions/1167691/passwordless-login-with-yubikey-5-nfc?newreg=d3833870cc924fedb49ce95d064f3a09)

This is a modification on the original Yubico instructions found [here](https://support.yubico.com/support/solutions/articles/15000011356-ubuntu-linux-login-guide-u2f).

### Install needed software to interface with the Yubico Key
```shell
sudo apt install libpam-u2f -y
```

### Create a mappings file
Run this for each user.  Update `USERNAME` with the username of the appropriate user.
This script is contained in `buttonpress.sh`.
```shell
sudo -v
echo Enter the PIN if required then Press the button
sudo sh -c "pamu2fcfg -u USERNAME >> /etc/u2f_mappings"
```



#### Modify the file
The `/etc/u2f_mappings` file is going to need to be edited

```shell
sudo nano /etc/u2f_mappings
```

Note these things when editing the file
- Each user should have it's own line in the file
- Single user with multiple keys is layed out
    - `USERNAME:KEY:KEY:KEY`

### This finalizes the installation
Run 'update-mapping.sh` only once.
It does modify key authentication files for your system, run only once.

# Enjoy

## If anyone wants to contribute please reach out.
