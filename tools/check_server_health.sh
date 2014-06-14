#!/usr/bin/env bash
#
# This script is used to collect linux system health messages.
#
#
# Find and view it at link here:
# https://github.com/wyying/bash_scripts/blob/master/tools/check_server_health.sh
#
# Download and update it at link here:
# https://raw.githubusercontent.com/wyying/bash_scripts/master/tools/check_server_health.sh
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
#


#set -e

TMOUT=15

time=$(date +%Y%m%d)
file1="messages_utf8_$time.csv"
file2="messages_gbk_$time.csv"
filetar="check_health_$(hostname)_$time.tar"



if [[ $(whoami) != "root" ]]
then
    echo -e "\n
    \e[31m
    Please run this shell script as root user, exit now!!!
    \e[0m
    \n"

    false
    exit 1
fi



echo -e "\e[32m\n\n\nStart to collect system health messages....\n\n\n\e[0m"
cat > $file1 <<EOF

项目,检查结果,备注

系统主机名,$(hostname)
IP地址,$(ifconfig |sed -n 2p|awk '{print $2}'|awk -F: '{print $2}')

服务器厂商型号,$(sudo dmidecode -s system-manufacturer) $(sudo dmidecode -s system-product-name)
服务器厂商编号,$(dmidecode -s system-serial-number)

CPU个数和核数,$(dmidecode -t 4 | grep -c 'Processor Information')个 $(dmidecode -t 4 |grep -m 1 'Core Count' | awk -F: '{print $2}')核
CPU详情,"$(dmidecode -t 4 | grep 'Version' | awk -F: '{print $2}' | tr -s ' ')"

内存条个数,$(dmidecode -t 17 | grep -cE '(Size:.*MB)')个
内存条详情,"$(dmidecode -t 17|grep -A 7 -E '(Size:.*MB)'|grep -vE '(Form Factor|Set|Locator|Bank Locator|Type Detail)' | tr -s ' ')"

Linux系统架构平台,$(uname -m)
Linux内核版本,$(uname -r)
Linux发布版本,"$(lsb_release -d)"

Swap使用情况,"总大小共计$(free -m|grep 'Swap:'|awk '{print $2}')M, 剩余$(free -m|grep 'Swap:'|awk '{print $2}')M可用"
系统5分钟10分钟15分钟平均负载各为,"$(uptime |awk -F: '{print $NF}' | tr -s ' ')"

当前系统的运行级别,runlevel=$(runlevel |awk '{print $2}')


网络配置详情,"$(ifconfig -a)"

文件系统状态,"$(df -h)"

磁盘分区状态,"$(fdisk -l)"

虚拟卷组状态,"$(vgs)"

虚拟逻辑卷状态,"$(lvs)"

/var/log/message最近1000行的错误信息(该文件不存在或者无错误则空),"$(test -f /var/log/message && tail -n 1000 /var/log/messages|grep -E 'error|warning|fail')"

EOF
echo -e "\e[32m\nCollection is over.\e[0m"




echo -en "\n\n\n\e[32mConvert encoding of result file from utf8 to gbk... \e[0m"
iconv -f utf8 -t gbk $file1 -o $file2
echo -e "\e[32mDone\e[0m"




echo -e "\n\n\n
\e[31m
Would you like to tar the result files \"$file1\" \"$file2\" and then remove them ?\n
--------------------------
To tar files please type in uppercase \"Y\" within \"$TMOUT\" seconds, otherwise skip the tar course and continue...
--------------------------
\e[0m
"
read con
if [[ $con == "Y" ]]
then
    tar -cvf $filetar $file1 $file2 && rm $file1 $file2
    echo -e "\e[32m\n\n\nCONGRATULATION!!! EVERYTHING IS DONE!\n\n\n\e[0m
        Please check the result files:\n 
        \"$(readlink -f $filetar)\"\n\n\n"
else
    echo -e "\e[32m\n\n\nCONGRATULATION!!! EVERYTHING IS DONE!\n\n\n\e[0m
        Please check the result files:\n 
        \"$(readlink -f $file1)\" 
        \"$(readlink -f $file2)\"\n\n\n"
fi



