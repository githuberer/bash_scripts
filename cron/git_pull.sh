#!/usr/bin/env bash

__FILE__=$(readlink -f $0)
param=init
logfile=/var/log/${__FILE__##*/}.log
user=$(whoami)

if [[ $1 == $param ]]
then
    sudo sh -c "echo \"# $__FILE__ init\" >> /var/spool/cron/crontabs/$user"
    sudo sh -c "echo \"30 09    *  *  *    $__FILE__\" >> /var/spool/cron/crontabs/$user"
    sudo sh -c "echo \"30 20    *  *  *    $__FILE__\" >> /var/spool/cron/crontabs/$user"
    exit 0
fi

if [[ -n $1 ]] && [[ $1 != $param ]]
then
    echo -e "\n  Valid param should be: $param \n"
    exit 0
fi

. /home/wyy/bash_scripts/script-variable.sh
. /home/wyy/bash_scripts/functions/func-gitall.sh


dir=(
      "$HOME/.vim"
      "$HOME/.emacs.d"
      "$HOME/conf_file"
      "$HOME/bash_scripts"
      "$HOME/ruby_scripts"
      "$HOME/wyying.github.io"
)

{
    func_tmstamp
    for i in "${dir[@]}"
    do
        cd $i && (
        echo -e "\n==$(pwd)==================="
        git pull
        )
    done
} &> $logfile


