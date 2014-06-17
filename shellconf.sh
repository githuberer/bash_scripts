#!/usr/bin/env bash
#
# This file is my own Ubuntu system interactive shell environment.
#
#
# Find and view it at link here:
# https://github.com/wyying/bash_scripts/blob/master/system-variable.sh
#
# Download and update it at link here:
# https://raw.githubusercontent.com/wyying/bash_scripts/master/system-variable.sh
#
#
#
# The MIT License (MIT)
#
# Copyright (c) 2014 WangYanying
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
#
#
#

### zsh ###################################
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git rails)
source $ZSH/oh-my-zsh.sh

### variables ###################################

export TERM="xterm-256color"
export PATH=$PATH:$HOME/Dropbox/script:/home/wyy/ruby_scripts/bin
export MAIL=$HOME/mail/inbox
export EDITOR="vim"
export VISUAL="vim"
export CDPATH=$CDPATH:$HOME
export HISTTIMEFORMAT='%F %T  '

#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US:en"
#export LC_CTYPE=en_US.UTF-8
#export LANG=en_US.UTF-8

SCRIPT=$HOME/Dropbox/script


### alias #######################################

# rails
alias rgc='rails generate controller'
alias rgm='rails generate model'
alias rs='rails server'
alias rsh='rails server -h'
alias vimroute='reroute'
reroute () # rails edit config/routes.rb
{
    if [[ -x bin/rails ]]
    then
        $EDITOR config/routes.rb
    elif [[ -x ../bin/rails ]]
    then
        $EDITOR ../config/routes.rb
    else
        echo -e "\e[31m Get into a Rails app first, please.\e[0m"
    fi
}
devlog () #
{
    if [[ -x bin/rails ]]
    then
        tail -f log/development.log
    elif [[ -x ../bin/rails ]]
    then
        tail -f ../log/development.log
    else
        echo -e "\e[31m Get into Rails app first, please.\e[0m"
    fi
}

# git
alias gall='func_gitall'
alias gal='func_gitall'

alias gstatus='git status'
alias gstt='git status'

alias gpull='git pull'
alias gpl='git pull'

alias gpush='git push'
alias gph='git push'

alias gaddA='git add -A .'
alias gaa='git add -A .'

alias gcommitM='git commit -m'
alias gcm='git commit -m'

alias gcommitMA='git commit -m -a'
alias gcma='git commit -m -a'

alias gcheckout='git checkout'
alias gckt='git checkout'

# process manage
alias ps='sudo ps'
alias netstat='sudo netstat'
alias lsof='sudo lsof'
alias kill='sudo kill'

# lvm
alias lvs='sudo lvs'
alias vgs='sudo vgs'
alias lvcreate='sudo lvcreate'
alias lvremove='sudo lvremove'
alias lvresize='sudo lvresize'

# inactive rm cp mv
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#debian aptitude
alias asearch='sudo aptitude search'
alias asch='sudo aptitude search'

alias ashow='sudo aptitude show'
alias ashw='sudo aptitude show'

alias aversions='sudo aptitude versions'
alias avsn='sudo aptitude versions'

alias ainstall='sudo aptitude install'
alias ain='sudo aptitude install'

alias aremove='sudo aptitude remove'
alias apurge='sudo aptitude purge'

alias aupdate='sudo aptitude update'
alias aup='sudo aptitude update'

alias aupgrade='sudo aptitude upgrade'
alias aupgd='sudo aptitude upgrade'

#debian dpkg
alias dplist='sudo dpkg -l'
alias dls='sudo dpkg -l'

alias dpinstall='sudo dpkg -i'
alias din='sudo dpkg -i'

alias dpremove='sudo dpkg -r'
alias drm='sudo dpkg -r'

# colorized ri
alias ri='ri -f ansi'

#sudo vim
alias v='vim'
alias svim='sudo vim'
alias sv='sudo vim'

#sudo last command
alias slcmd='sudo ${history[${#history}]}'


### others ####################################
# colorized man pages with less Command
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


# for emacs prompt
if [[ -n ${INSIDE_EMACS} ]]; then
    # This shell runs inside an Emacs *shell*/*term* buffer.
    prompt walters
    unsetopt zle
fi


__FILE__=$(readlink -f $0)
VIRHOME=$(dirname $__FILE__)
. $HOME/.rvm/scripts/rvm
. $VIRHOME/functions/func-gitall.sh
. $VIRHOME/functions/func-ssh-mysql.sh
unset __FILE__
unset VIRHOME


# auto switch to root
#sudo -S echo -e "\n
echo -e "\n>> Welcome aboard, $(whoami) !!!\n"
#>> Automatically type in password for using Terminal conveniently ......
#" <<< 'ubuntu'
#>> Automatically switch to 'root' user for using Terminal conveniently ......
#sudo su
#exit


