#!/usr/bin/env bash

### zsh ########################################
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
alias vroute='reroute'
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
rdevlog () #
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
alias gal='func_gitall'
alias gstt='git status'
alias gpl='git pull'
alias gph='git push'
alias gaa='git add -A .'
alias gcm='git commit -m'
alias gcma='git commit -m -a'
alias gckt='git checkout'

# system admin
alias find='sudo find'
alias sysv-rc-conf='sudo sysv-rc-conf'
alias update-rc.d='sudo update-rc.d'
alias reboot='sudo reboot'
alias kill='sudo kill'
alias ps='sudo ps'
alias pscmd='ps -eo command --sort command'
alias iftop='sudo iftop'
alias iptraf='sudo iptraf'
alias nethogs='sudo nethogs'
alias top='sudo top'
alias atop='sudo atop'
alias monit='sudo monit'
alias netstat='sudo netstat'
alias netstatainet='sudo netstat -anp --inet'
alias lsof='sudo lsof'

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
alias asch='sudo aptitude search'
alias ashw='sudo aptitude show'
alias avsn='sudo aptitude versions'
alias ain='sudo aptitude install'
alias arin='sudo aptitude reinstall'
alias arm='sudo aptitude remove'
alias apg='sudo aptitude purge'
alias aup='sudo aptitude update'
alias aupgd='sudo apt-get upgrade'

#debian dpkg
alias dpl='sudo dpkg -l'
alias dpi='sudo dpkg -i'
alias dpr='sudo dpkg -r'

# colorized ri
alias ri='ri -f ansi'

#sudo vim
alias v='vim'
alias sv='sudo vim'
alias svim='sudo vim'

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


#auto switch to root
#sudo -S echo -e "\n
#echo -e "\n >> Welcome aboard & Happy hacking, $(whoami) !!! \n"
#echo -e "\n \e[32m>> Welcome aboard & Happy hacking, $(whoami) !!!\e[0m \n"
#echo -e "\n \e[2m>> Welcome aboard & Happy hacking, $(whoami) !!!\e[0m \n"
echo -e "\n \e[31m>> \e[32mWelcome \e[33maboard \e[34m& \e[35mHappy \e[36mhacking\e[35m, \e[95m$(whoami) \e[31m!!! \e[0m \n"

#>> Automatically type in password for using Terminal conveniently ......
#" <<< 'ubuntu'
#>> Automatically switch to 'root' user for using Terminal conveniently ......
#sudo su
#exit


