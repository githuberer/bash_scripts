#!/usr/bin/env bash

. /home/wyy/bash_functions/script-variable.sh

logfile=/var/log/cron/${0##*/}.log

# need variable $pdir
func_clear_dir()
{
  for dir in $( ls $dir2cleared | egrep "[0-9]{4}-[0-9]{2}-[0-9]{2}" )
  do
    if (( $(( $(date +%Y%m%d) - ${dir//-/} )) > 100 ))
    then
      rm -rf $dir2cleared/$dir && echo "rm -rf $dir2cleared/$dir"
    fi
  done
}

main_func()
{
  func_tmstamp
  dir2cleared=/home/wyy/1cloud_data
  func_clear_dir
  unset dir2cleared
}


if [[ -n $TERM ]]
then
  main_func 2>&1 | tee -a $logfile
else
  main_func >> $logfile 2>&1
fi
