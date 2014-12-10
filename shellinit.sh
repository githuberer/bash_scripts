#!/usr/bin/env bash

### zsh ########################################
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git rails colored-man aliases zsh-syntax-highlighting zsh-history-substring-search waga)
source $ZSH/oh-my-zsh.sh



### variables ###################################
export TERM="xterm-256color"
export PATH=$PATH:$HOME/Dropbox/script:/home/wyy/ruby_scripts/bin
export MAIL=$HOME/mail/inbox
export EDITOR="vim"
export VISUAL="vim"
export CDPATH=$CDPATH:$HOME:/data
export HISTTIMEFORMAT='%F %T  '
#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US:en"
#export LC_CTYPE=en_US.UTF-8
#export LANG=en_US.UTF-8
SCRIPT=$HOME/Dropbox/script



#zle -N predict-on
#zle -N predict-off
#bindkey '^X1' predict-on
#bindkey '^X2' predict-off

#predict-on

