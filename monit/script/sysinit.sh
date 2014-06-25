#!/usr/bin/env bash

__FILE__=$(readlink -f $0)


ago=${__FILE__/.sh/.ago}
now=${__FILE__/.sh/.now}

ls /etc/init.d |sort > $now
news=$(comm -23 $now $ago)

if [[ -n $news ]]
then
    echo -e "\n\n New sysinit script detected in \"/etc/init.d\" \n\n"
    for n in $news
    do
        ls -l /etc/init.d/$n
    done
    exit 1
fi
