#!/usr/bin/env bash

logfile=/u/logs/monitor/${0##*/}.log
vm=(
    "vm_test1"
    "vm_test2"
)


{
    echo -e "\n\n
    ==========================================
    $(date +%Y-%m-%d_%H:%M:%S)
    ==========================================
    "

    for m in  ${vm[*]}
    do
        if [[ $(virsh -c qemu:///system list --all| grep $m| awk '{print $3}') != "running" ]]
        then
            echo "$m is not running, start it, now......"
            virsh -c qemu:///system start $m
        else
            echo "$m is running"
        fi
    done

} &>> $logfile
