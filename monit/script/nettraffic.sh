#!/usr/bin/env bash

t=10         # seconds
limitn=5     # MiB/s

__FILE__=$(readlink -f $0)
log=${__FILE__/.sh/.log}

vnstat -tr $t -ru &> $log

n=$(grep 'tx' $log | awk '{print $2}' | awk -F. '{print $1}')
unit=$(grep 'tx' $log | awk '{print $3}')


if ( [[ $unit =~ "MiB/s" ]] && (( $n > $limitn )) ) || [[ $unit =~ "GiB/s" ]]
then
    echo -e "\n\n Net traffic average(tx|$t seconds) [current $n $unit] matches resource limit [$limitn $unit] \n\n Details:"
    grep -E "(rx|tx)"  $log
    echo -e "\n See More: vnstat -l -ru || iftop -PB || nethogs \n"
    exit 1
fi
