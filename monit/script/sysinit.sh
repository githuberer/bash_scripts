#!/usr/bin/env bash

__FILE__=$(readlink -f $0)


ago=${__FILE__/.sh/.ago}
now=${__FILE__/.sh/.now}


if [[ $1 == "update" ]]
then
    ls -a /etc/init.d |sort > $ago
    exit 0
fi

if [[ -n $1 ]] && [[ $1 != "update" ]]
then
    echo -e "\n  Valid param should be: update \n"
    exit 0
fi


ls -a /etc/init.d |sort > $now

news=$(comm -23 $now $ago)

if [[ -n $news ]]
then
    echo -e "\n\n New sysinit script detected in \"/etc/init.d\". "
    echo -e "\n\n Details:"
    for n in $news
    do
        ls -l /etc/init.d/$n
    done
    echo -e "\n\n More: Validate the new sysinit with \"$__FILE__ update\". \n"
    exit 1
fi

