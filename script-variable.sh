#!/usr/bin/env bash
#This is the environment for bash script
#shopt -s expand_aliases


export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/wyy/Dropbox/script

LC_ALL="en_US.UTF-8"

curr_date=$(date +%Y-%m-%d)
curr_time=$(date +%H:%M)

curr_a=$(date +%c)

curr_d=$(date +%Y-%m-%d)
curr_t=$(date +%H:%M)
curr_dt=$(date +%Y-%m-%d_%H:%M)
curr_dts=$(date +%Y-%m-%d_%H:%M:%S)

curr_year=$(date +%Y)
curr_month=$(date +%m)
curr_day=$(date +%d)

func_tmstamp()
{
  echo -e "\n\n
==========================================
  $curr_dts
==========================================
"
}
