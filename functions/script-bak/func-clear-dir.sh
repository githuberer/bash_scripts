#!/usr/bin/env bash

# need to set variable $dir2cleared
# delete "$dir2cleared/..-..-.." which created one month ago
# dir2cleared=/test
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

