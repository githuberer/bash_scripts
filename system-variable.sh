#!/usr/bin/env bash
#This is the environment for interactive bash
#shopt -s expand_aliases

export TERM="xterm-256color"
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/wyy/Dropbox/script:/home/wyy/ruby_scripts/bin
export MAIL=/home/wyy/mail/inbox
export EDITOR="vim"
export VISUAL="vim"
export CDPATH=$CDPATH:/home/wyy:/var/www

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
#LANG="en_us 8859 1"


Script=/home/wyy/Dropbox/script

curr_a=$(date +%c)
curr_d=$(date +%Y-%m-%d)
curr_t=$(date +%H:%M)
curr_dt=$(date +%Y-%m-%d_%H:%M)
curr_dts=$(date +%Y-%m-%d_%H:%M:%S)


alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


. /etc/profile.d/rvm.sh
