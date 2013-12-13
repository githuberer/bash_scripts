#!/usr/bin/env bash

scriptname=$(basename $0)
logfile=/u/logs/${scriptname/.sh/.log}
files="find /usr/local/nginx/logs -name '*.log' -size  +100M |paste -s -d ' '"

main_func()
{
  for fff in $files
  do
    if tail -v -c 100000K $fff > $fff.old
    then
      echo -e "\n\n
      ==========================================
      date +%Y-%m-%d_%H:%M:%S
      ==========================================
      Split file and zero it
      original:  $fff
      old backup: $fff.old
      \n\n\n" |tee $fff
    fi
  done
}  


if [[ -n $TERM ]]
then
  main_func 2>&1 | tee -a $logfile
else
  main_func >> $logfile 2>&1
fi


