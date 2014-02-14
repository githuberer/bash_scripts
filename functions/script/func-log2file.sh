#!/usr/bin/env bash

# need function "main_func"
# need to set variable $logfile
# logfile=/var/test.log
func_log2file()
{
  if [[ -n $TERM ]]
  then
    main_func 2>&1 | tee $logfile
  else
    main_func > $logfile 2>&1
  fi
}
