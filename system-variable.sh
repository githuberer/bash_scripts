#!/usr/bin/env bash

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

# colorized ri
alias ri='ri -f ansi'

#sudo vim
alias svim='sudo vim'

#sudo last command
alias slcmd='sudo ${history[${#history}]}'

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
alias ashow='sudo aptitude show'
alias aversions='sudo aptitude versions'
alias ainstall='sudo aptitude install'
alias aremove='sudo aptitude remove'
alias apurge='sudo aptitude purge'
alias aremove='sudo aptitude remove'
alias aupdate='sudo aptitude update'
alias aupgrade='sudo aptitude upgrade'

#debian dpkg
alias dplist='sudo dpkg -l'
alias dpinstall='sudo dpkg -i'
alias dpremove='sudo dpkg -r'



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


