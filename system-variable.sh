#!/usr/bin/env bash
#This is the environment of interactive shell
#shopt -s expand_aliases

export TERM="xterm-256color"
export PATH=$PATH:/home/wyy/Dropbox/script:/home/wyy/ruby_scripts/bin
export MAIL=/home/wyy/mail/inbox
export EDITOR="vim"
export VISUAL="vim"
export CDPATH=$CDPATH:/home/wyy

#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"
#export LANGUAGE="en_US:en"
#export LC_CTYPE=en_US.UTF-8
#export LANG=en_US.UTF-8
#LANG="en_us 8859 1"

Script=/home/wyy/Dropbox/script

# inactive rm cp mv
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#sudo vim
alias svim='sudo vim'

#debian aptitude
alias aptsearch='sudo aptitude search'
alias aptshow='sudo aptitude show'
alias aptversions='sudo aptitude versions'

alias aptinstall='sudo aptitude install'
alias aptreinstall='sudo aptitude remove'
alias aptpurge='sudo aptitude purge'
alias aptremove='sudo aptitude remove'

alias aptupdate='sudo aptitude update'
alias aptupgrade='sudo aptitude upgrade'

#debian dpkg
alias dpkgl='dpkg -l'
alias dpkgi='dpkg -i'
alias dpkgr='dpkg -r'

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


