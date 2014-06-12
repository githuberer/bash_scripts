#!/usr/bin/env bash
#This is the environment of interactive shell
#shopt -s expand_aliases

export TERM="xterm-256color"
export PATH=$PATH:$HOME/Dropbox/script:/home/wyy/ruby_scripts/bin
export MAIL=$HOME/mail/inbox
export EDITOR="vim"
export VISUAL="vim"
export CDPATH=$CDPATH:$HOME

#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US:en"
#export LC_CTYPE=en_US.UTF-8
#export LANG=en_US.UTF-8
#LANG="en_us 8859 1"

Script=$HOME/Dropbox/script

# inactive rm cp mv
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#sudo vim
alias svim='sudo vim'

#debian aptitude
alias asearch='sudo aptitude search'
alias ashow='sudo aptitude show'
alias aversions='sudo aptitude versions'

alias ainstall='sudo aptitude install'
alias ainstall='sudo aptitude remove'
alias apurge='sudo aptitude purge'
alias aremove='sudo aptitude remove'

alias aupdate='sudo aptitude update'
alias aupgrade='sudo aptitude upgrade'

#debian dpkg
alias dpkgl='sudo dpkg -l'
alias dpkgi='sudo dpkg -i'
alias dpkgr='sudo dpkg -r'

#git
alias gits='git status'

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

# colorized ri
alias ri='ri -f ansi'

# for emacs prompt
if [[ -n ${INSIDE_EMACS} ]]; then
    # This shell runs inside an Emacs *shell*/*term* buffer.
    prompt walters
    unsetopt zle
fi


