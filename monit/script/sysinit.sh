#!/usr/bin/env bash

__FILE__=$(readlink -f $0)


ago=${__FILE__/.sh/.ago}
now=${__FILE__/.sh/.now}

ls /etc/init.d |sort > $now
news=$(comm -23 $now $ago)

if [[ -n $news ]]
then
    for n in $news
    do
        echo -e "\n\n New sys init script detected in \"/etc/init.d\" \n\n"
        ls -l /etc/init.d/$n
    done
    exit 1
fi
