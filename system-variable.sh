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

#curr_a=$(date +%c)
#curr_d=$(date +%Y-%m-%d)
#curr_t=$(date +%H:%M)
#curr_dt=$(date +%Y-%m-%d_%H:%M)
#curr_dts=$(date +%Y-%m-%d_%H:%M:%S)

alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias svim='sudo vim'

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


