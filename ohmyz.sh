# install oh-my-zsh automatically
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# move my zsh config to home folder
rm ~/.zshrc
cp .zshrc /home/$USER