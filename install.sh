#!/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "This Script need to be executed as root"
  exit
fi

clear
#change this to your host-name of choosing
CHOOSEN_HOSTNAME="SomeBoringCorp"

echo -n "Deploy on : \n"
echo -n "personal computer : 1\n"
echo -n "server : 2\n"
read deploy_type


# change hostname if not already set
hostnamectl set-hostname $CHOOSEN_HOSTNAME

# install specific packages for server or personal computer
if [ "$deploy_type" = "1" ] ; then
	pacman -Syu --noconfirm
	
	pacman -S neofetch fish git firefox xfce4-terminal steam filezilla nvidia nvidia-utils opencl-nvidia neovim noto-fonts-cjk obs-studio --noconfirm

	git clone https://aur.archlinux.org/yay.git

	cd yay

	makepkg -siC --noconfirm

	yay -S onlyoffice-bin unityhub rider ffmpeg-git qbittorrent-git 7-zip-full pridefetch aseprite --noconfirm

elif [ "$deploy_type" = "2" ] ; then
    # nginx
    apt install nginx fish neofetch build-essential file git git-core curl fonts-powerline docker docker-compose -y

    # allow some ports
    ufw allow 25565     # minecraft
    ufw allow 80        # web
    ufw allow 443       # ssl
    ufw allow 22        # sftp / ssh. Note that this allow connection through ftp (like filezilla and stuff)

    #*
    #   @todo : clone my web services here
    #*

    mv config-files/default /etc/nginx/sites-available
    systemctl restart nginx.service

else
    echo "please use a valid option"
    exit
fi

# set fish as default shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells

chsh -s /usr/local/bin/fish

# move config files

cp config-files/asound.conf /etc

mkdir /etc/fish
cp config-files/fish.config /etc/fish

echo "installation finished ! You should reboot to see all the changes"
