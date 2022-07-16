# Path to your oh-my-zsh installation.
export PATH=$PATH:$HOME/.dotnet
export DOTNET_ROOT=$HOME/.dotnet
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="duellj"

plugins=(git node npm sudo)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8


alias zshconfig="mate ~/.zshrc
alias ohmyzsh="mate ~/.oh-my-zsh"