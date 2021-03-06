#!/usr/bin/env bash
# This script is used to initialize environment of centos6.*
# Take CMD between line "#-----------" as one CMD Block.
#
# Find and view it at link here:
# https://github.com/wyying/bash_scripts/blob/master/tools/environment_init_cent6.sh
#
# Download and update it at link here:
# https://raw.githubusercontent.com/wyying/bash_scripts/master/tools/environment_init_cent6.sh
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
set -x 

logfile=./$(basename $0).log


{

# ---------------
#[[ -z $(grep "biosdevname=0" /boot/grub/grub.conf) ]] && sed '/kernel/s/$/ biosdevname=0/g' /boot/grub/grub.conf

#----------------
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config

# ---------------
test -f /etc/init.d/NetworkManager && \
    {
        /etc/init.d/NetworkManager stop
        /etc/init.d/network restart
        chkconfig NetworkManager off
        chkconfig network on
    }

# ---------------
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
( cd /etc/yum.repos.d && wget http://mirrors.163.com/.help/CentOS6-Base-163.repo )
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm


# ---------------
yum makecache
yum -y groupinstall Development tools
yum -y install vim man wget elinks nmap pstree lsof tmux byobu postfix mailx lrzsz traceroute expect openssh openssh-clients openssh-server sshpass redhat-lsb dirname basename realpath iftop vnstat tcpdump


#---------------

[[ -f /etc/init.d/sendmail ]] && chkconfig sendmail off
[[ -f /etc/init.d/postfix ]] && chkconfig postfix on
[[ -f /etc/init.d/rpcidmapd ]] && chkconfig rpcidmapd off
[[ -f /etc/init.d/rpcbind ]] && chkconfig rpcbind off
[[ -f /etc/init.d/nfslock ]] && chkconfig nfslock off


# ---------------
cat >> ~/.vimrc <<EOF

"added by WYY below :

syntax on                   
syntax enable
filetype on
filetype indent on
filetype plugin on

"colorscheme jellybeans
colorscheme molokai
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
set showcmd

set nu              
set t_Co=256
set nocompatible              "be vim
set clipboard=unnamedplus     "murge vim clipboard to system clipboard
"set mouse=a		      "Enable mouse usage (all modes)


"-----"code indent
set autoindent              
set expandtab
set tabstop=8 shiftwidth=4 softtabstop=4
au FileType python set tabstop=8 shiftwidth=4 softtabstop=4
au FileType sh set tabstop=8 shiftwidth=4 softtabstop=4
au FileType ruby set tabstop=4 shiftwidth=2 softtabstop=2

"-----"vim tab switch mapping
map <C-l> :bn<CR> 
map <C-h> :bp<CR> 
map <C-k> :bd<CR> 

"-----"vim backslash search
"set ignorecase
set nowrapscan                "do not wrap around
set incsearch                 "interactive searching
set hlsearch                  "highlight searching
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>


EOF


# ---------------
[[ ! -d ~/.vim/colors/ ]] && mkdir -p ~/.vim/colors
( cd ~/.vim/colors/ && wget --no-check-certificate https://raw.github.com/githuberer/conf_vim/master/colors/jellybeans.vim )
( cd ~/.vim/colors/ && wget --no-check-certificate https://raw.github.com/githuberer/conf_vim/master/colors/molokai.vim )

# ---------------
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
#echo -e"Port 52222 \nPermitRootLogin no" >>/etc/ssh/sshd_config &&\
sed '/AcceptEnv LANG LC_/s/^/#/' /etc/ssh/sshd_config.bak > /etc/ssh/sshd_config
/etc/init.d/sshd restart
chkconfig sshd on


# ---------------
cp /etc/postfix/main.cf /etc/postfix/main.cf.bak

sed  -e '/inet_interfaces = localhost/s/^/#/' \
     -e '/#inet_interfaces = all/s/#//' \
         /etc/postfix/main.cf.bak > /etc/postfix/main.cf

/etc/init.d/postfix restart

# ---------------
iptables -F && /etc/init.d/iptables save


: <<'END'
# ---------------
# remote VM server through Serial Console
# desktop # virsh --connect qemu:///system
# virsh # console centos
# Use Ctrl + ] to exit the console
#echo “ttyS0″ >> /etc/securetty
#sed -i '/kernel.*quiet/s/$/ console=ttyS0/' /boot/grub/grub.conf
#echo 'S0:12345:respawn:/sbin/agetty ttyS0 115200' >> /etc/inittab

# ---------------
# rename eth1 to eth0
cp /etc/udev/rules.d/70-persistent-net.rules ~/70-persistent-net.rules
sed -i 's/NAME="eth1"/NAME="eth0/' /etc/udev/rules.d/70-persistent-net.rules
grep "eth1" /etc/udev/rules.d/70-persistent-net.rules | egrep -o '([[:xdigit:]]{2}[:]){5}[[:xdigit:]]{2}'


END

#---------------
/etc/init.d/ntpd start
chkconfig ntpd on
#---------------

yum -y update && reboot


} | tee -a $logfile 2>&1


