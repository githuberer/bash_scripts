#!/usr/bin/env bash

# need to set variable $logfile
# need function "main_func"
# logfile=/var/test.log
func_log22file()
{
  if [[ -n $TERM ]]
  then
    main_func 2>&1 | tee -a $logfile
  else
    main_func >> $logfile 2>&1
  fi
}
