# Pop!_OS 22.04

1. Install system dependencies
```bash
sudo sh -c "$(curl -fsSL https://raw.github.com/nick-nachos/pc-provisioning/master/popos-22.04/provision-su.sh)"
```
2. Install oh-my-suv for user
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
3.  Install user dependencies
```bash
zsh -c "$(curl -fsSL https://raw.github.com/nick-nachos/pc-provisioning/master/popos-22.04/provision-user.sh)"
```
