# Ubuntu 22.04

1. Install system dependencies
```shell
sudo sh -c "$(curl -fsSL https://raw.github.com/nick-nachos/pc-provisioning/master/ubuntu-22.04/provision-su.sh)"
```
2. Install oh-my-suv for user
```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
3.  Install user dependencies
```shell
zsh -c "$(curl -fsSL https://raw.github.com/nick-nachos/pc-provisioning/master/ubuntu-22.04/provision-user.sh)"
```
