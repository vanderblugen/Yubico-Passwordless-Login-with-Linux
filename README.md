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
Run this for each user.  Update `USERNAME` with the username of the appropriate user
```shell
echo Press the button
sudo pamu2fcfg -u USERNAME >> /etc/u2f_mappings
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
An error message may appear during this portion.  But that is normal under certain circumstances.

````shell
wget https://raw.githubusercontent.com/vanderblugen/Yubico-Passwordless-Login-with-Linux/master/update-mapping.sh
chmod +x updadate-mapping.sh
sudo ./update-mapping.sh
````
Note if you don't use xscreensaver, take that out
# Enjoy

## If anyone wants to contribute please reach out.
