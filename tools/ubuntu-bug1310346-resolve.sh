#!/usr/bin/env bash
#
# Find and view it at link here:
# https://github.com/wyying/bash_scripts/blob/master/tools/ubuntu-bug1310346-resolve.sh
#
# Download and update it at link here:
# https://raw.githubusercontent.com/wyying/bash_scripts/master/tools/ubuntu-bug1310346-resolve.sh
#
#
#
# The MIT License (MIT)
#
# Copyright (c) 2014 WangYanying
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
#
#


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

( cd ~ && wget -O - "https://www.dropbox.com/s/4stxcgdxcfzgw7p/ubuntu-bug1310346.tar.gz" | tar xzf - )

( cd /usr/lib/x86_64-linux-gnu/sunpinyin/ && sudo tar -cvf data_bak.tar data )

cd ~/ubuntu-bug1310346 && {
sudo cp -f /usr/share/doc/sunpinyin/SLM-inst.mk Makefile
make
sudo cp -f lm_sc.t3g  /usr/lib/x86_64-linux-gnu/sunpinyin/data
sudo cp -f pydict_sc.bin /usr/lib/x86_64-linux-gnu/sunpinyin/data
}


kill -9 $(ps -C ibus-engine-sunpinyin -o pid=) || echo 'ibus-sunpinyin not running!!!'



echo -e "\n\n\n\n==========Messages:============"

echo -e "\nOld file backup at:
$(ls -l /usr/lib/x86_64-linux-gnu/sunpinyin/data_bak.tar)"

echo -e "\nAny problem use command below to roll back: \n
cd /usr/lib/x86_64-linux-gnu/sunpinyin/ && tar -xvf data_bak.tar"


