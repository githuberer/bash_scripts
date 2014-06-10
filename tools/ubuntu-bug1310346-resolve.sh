#!/usr/bin/env bash

set -e

echo -e "
This script is used to solve ubuntu 14.04 sunpinyin bug#1310346. 
bug reference link blow:
https://bugs.launchpad.net/ubuntu/+source/open-gram/+bug/1310346

You can solve it manual follow this link:
https://code.google.com/p/sunpinyin/wiki/BuildUnix

This script is valid on Ubuntu_14.04_X64

--------------------------
type in 'Y' to continue...
--------------------------
"
read con; [[ $con != "Y" ]] && exit 0

sudo apt-get -y install sunpinyin-utils

( cd ~ && wget -O - "https://www.dropbox.com/s/estzyyrwfk9d2qv/ubuntu-bug1310346.tar.gz" | tar xzf - )

( cd /usr/lib/x86_64-linux-gnu/sunpinyin/ && tar -cvf data_bak.tar data )

cd ~/ubuntu-bug1310346 && {
sudo cp -f /usr/share/doc/sunpinyin/SLM-inst.mk Makefile
make
cp -f lm_sc.t3g  /usr/lib/x86_64-linux-gnu/sunpinyin/data
cp -f pydict_sc.bin /usr/lib/x86_64-linux-gnu/sunpinyin/data
}




