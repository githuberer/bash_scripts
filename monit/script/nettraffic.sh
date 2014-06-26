#!/usr/bin/env bash

t=5           # seconds
limitn=50     # Mbit/s

__FILE__=$(readlink -f $0)
log=${__FILE__/.sh/.log}
netstat=${__FILE__/.sh/.netstat}


if [[ $1 == "netstat" ]]
then
    netstat -anp --inet > $netstat
    exit 0
fi

if [[ -n $1 ]] && [[ $1 != "update" ]]
then
    echo -e "\n  Valid param should be: netstat \n"
    exit 0
fi



vnstat -tr $t &> $log

n=$(grep 'tx' $log | awk '{print $2}' | awk -F. '{print $1}')
unit=$(grep 'tx' $log | awk '{print $3}')


if ( [[ $unit =~ "Mbit/s" ]] && (( $n > $limitn )) ) || [[ $unit =~ "Gbit/s" ]]
then
    echo -e "\n Net traffic average(tx|$t seconds) current [$n $unit] matches resource limit [$limitn $unit] \n\n Details:"
    grep -E "(rx|tx)"  $log
    echo -e "\n Check Connections: $netstat \n"
    echo -e "\n See More: vnstat -l || iftop -PB || nethogs \n"
    exit 1
fi
