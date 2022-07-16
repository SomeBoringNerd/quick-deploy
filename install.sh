#!/bin/sh

sudo apt update -y && sudo apt dist-upgrade -y
clear
#change this to your host-name of choosing
CHOOSEN_HOSTNAME="SomeBoringCorp"

echo -n "Deploy on : \n"
echo -n "personal computer : 1\n"
echo -n "server : 2\n"
read deploy_type

# install apt packages
apt install zsh neofetch htop build-essential curl file git git-core curl fonts-powerline -y

# install oh-my-zsh automatically
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# move my zsh config to home folder
cp .zshrc ~/

# change hostname if not already set
hostnamectl set-hostname $CHOOSEN_HOSTNAME

# install node

# install node, npm and stuff
wget https://nodejs.org/dist/v16.16.0/node-v16.16.0-linux-x64.tar.xz

sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-v16.16.0-linux-x64.tar.xz -C /usr/local/lib/nodejs 

echo export PATH=/usr/local/lib/nodejs/node-v16.16.0-linux-x64:$PATH > ~/.profile

# install specific packages for server or personal computer
if [ "$deploy_type" == "1"] ; then
    # polychromatic for my mouse
    add-apt-repository ppa:polychromatic/stable
    add-apt-repository ppa:openrazer/stable

    apt update 
    sudo apt install polychromatic openrazer-meta

    #amd driver
    wget https://repo.radeon.com/amdgpu-install/22.20/ubuntu/focal/amdgpu-install_22.20.50200-1_all.deb

    dpkg -i amdgpu-install_22.20.50200-1_all.deb

    amdgpu-install -y --vulkan=amdvlk,pro --accept-eula


elif ["$deploy_type" == "2"] ; then
    # nginx
    apt install nginx 

    # allow some ports
    ufw allow 25565     # minecraft
    ufw allow 80        # web
    ufw allow 443       # ssl
    ufw allow 22        # sftp / ssh. Note that this allow connection through ftp (like filezilla and stuff)

else
    echo "please use a valid option"
    exit
fi