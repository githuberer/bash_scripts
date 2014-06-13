#!/usr/bin/env bash

# this file is used to collect linux system health messages.

set -e

file1="messages_utf8.csv"
file2="messages_gbk.csv"
filetar="check_health_$(hostname).tar"

echo -e "\e32m\n\n\nStart collect system health messages....\n\n\n\e[0m"

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

echo -e "\e[32m\n\n\n\n\n\n\nCollection is over.\e[0m"

echo -en "\n\nConvert utf8 file content to gbk..."

iconv -f utf8 -t gbk $file1 -o $file2
echo -e "\e[32mDone\e[0m"


echo -e "
\e[31m
Would you like to tar the $file1 and $file2 and then rm them ?
--------------------------
type in uppercase 'Y' to tar file, otherwise skip the tar course and continue...
--------------------------
\e[0m
"

read con


if [[ $con == "Y" ]]
then
    tar -cvf $filetar $file1 $file2 && rm $file1 $file2
    echo -e "\e[32m\n\n\nCongratulation!!! Everything is done! Please check file: $filetar\n\n\n\e[0m"
else

    echo -e "\e[32m\n\n\nCongratulation!!! Everything is done! Please check files: $file1 $file2\n\n\n\e[0m"
fi





