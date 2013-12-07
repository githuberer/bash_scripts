#!/usr/bin/env bash

. /home/wyy/bash_functions/script-variable.sh
. /home/wyy/bash_functions/script/func-tmstamp.sh
. /home/wyy/bash_functions/system/func-gitall.sh
. /home/wyy/bash_functions/script/func-log22file.sh

logfile=/var/log/cron/${0##*/}.log

dir=(
      "/home/wyy/vim_conf"
      "/home/wyy/sync_sql_table"
      "/home/wyy/conf_file"
      "/home/wyy/bash_functions"
<<<<<<< HEAD
      "/home/wyy/emacs.d"
=======
>>>>>>> e3ec617bc31e588b2bd5127dede5cf62b82e914d
)
#      "/home/wyy/sync_sql_table"

main_func()
{
  func_tmstamp

  for i in "${dir[@]}"
  do
    if cd $i
    then
      echo -e "\n==$(pwd)==================="
      func_gitall 'crontab'
    fi
  done
}


func_log22file

