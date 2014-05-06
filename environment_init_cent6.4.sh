#!/usr/bin/env bash
# find me here below URL:
# wget https://raw.github.com/githuberer/bash_scripts/master/environment_init_cent6.4.sh && chmod 755 environment_init_cent6.4.sh

# Installation of centos6.4 (64)
# Take CMD between line "#-----------" as one CMD Block

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
[[ -f /etc/init.d/NetworkManager ]] && (
/etc/init.d/NetworkManager stop
/etc/init.d/network restart
chkconfig NetworkManager off
chkconfig network on
)

# ---------------
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
    ( cd /etc/yum.repos.d && wget http://mirrors.163.com/.help/CentOS6-Base-163.repo )
#rpm -ivh http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
#sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/remi.repo


# ---------------
yum makecache &&\
yum -y groupinstall Development tools &&\
yum -y install ruby #ruby-devel ruby-docs ruby-extlib ruby-irb ruby-libs
yum -y install vim man wget elinks nmap pstree lsof tmux screen byobu postfix mailx lrzsz traceroute expect openssh openssh-clients openssh-server sshpass redhat-lsb realpath iftop vnstat tcpdump vnstat


#---------------
[[ -f /etc/init.d/chkconfig ]] && chkconfig postfix on
[[ -f /etc/init.d/rpcidmapd ]] && chkconfig rpcidmapd off
[[ -f /etc/init.d/rpcbind ]] && chkconfig rpcbind off
[[ -f /etc/init.d/nfslock ]] && chkconfig nfslock off


# ---------------
cat >> /root/.vimrc <<EOF

"added by WYY below :


syntax enable
colorscheme jellybeans


syntax on                   
filetype on
filetype indent on
filetype plugin on

set nu                        "Auto line num
set hlsearch                  "Highlight Searching
set t_Co=256
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
set nocompatible              "vim is vim not vi
set clipboard=unnamedplus     "murge vim clipboard to system clipboard
"set mouse=a		              "Enable mouse usage (all modes)

set autoindent                "autoindent
set expandtab
set showcmd
au FileType python set tabstop=8 shiftwidth=4 softtabstop=4
au FileType sh set tabstop=8 shiftwidth=4 softtabstop=4
au FileType ruby set tabstop=4 shiftwidth=2 softtabstop=2
"set tabstop=8 shiftwidth=4 softtabstop=4


"-----------------------------"windows moving shortcut mapping
"map <c-j> <c-w>j             
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h


"-----------------------------"original <c-n> move to 'tab complete'
map <c-l> :bn<CR> 
map <c-h> :bp<CR> 
map <c-b>l :bn<CR> 
map <c-b>h :bp<CR> 

EOF


# ---------------
[[ ! -d /root/.vim/colors/ ]] && mkdir -p /root/.vim/colors
( cd /root/.vim/colors/ && wget --no-check-certificate https://raw.github.com/githuberer/conf_vim/master/colors/jellybeans.vim )
# wget https://raw.github.com/githuberer/my_vim_conf/master/colors/molokai.vim

# ---------------
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
#echo -e"Port 52222 \nPermitRootLogin no" >>/etc/ssh/sshd_config &&\
sed '/AcceptEnv LANG LC_/s/^/#/' /etc/ssh/sshd_config.bak > /etc/ssh/sshd_config
/etc/init.d/sshd restart
chkconfig sshd on


# ---------------
cp /etc/postfix/main.cf /etc/postfix/main.cf.bak &&\
sed  -e '/inet_interfaces = localhost/s/^/#/' \
     -e '/#inet_interfaces = all/s/#//' \
         /etc/postfix/main.cf.bak > /etc/postfix/main.cf &&\
/etc/init.d/postfix restart


# ---------------
iptables -F && /etc/init.d/iptables save


# ---------------
# remote VM server through Serial Console
# desktop # virsh --connect qemu:///system
# virsh # console centos
# Use Ctrl + ] to exit the console
#echo “ttyS0″ >> /etc/securetty
#sed -i '/kernel.*quiet/s/$/ console=ttyS0/' /boot/grub/grub.conf
#echo 'S0:12345:respawn:/sbin/agetty ttyS0 115200' >> /etc/inittab


: <<'END'
# ---------------
# rename eth1 to eth0

cp /etc/udev/rules.d/70-persistent-net.rules /root/70-persistent-net.rules
sed -i 's/NAME="eth1"/NAME="eth0/' /etc/udev/rules.d/70-persistent-net.rules
grep "eth1" /etc/udev/rules.d/70-persistent-net.rules | egrep -o '([[:xdigit:]]{2}[:]){5}[[:xdigit:]]{2}'


# ---------------
mkdir /data/shscript/ -p

cat > /data/shscript/env-bashrc.sh <<EOF
# This file is for bashrc environment added by WYY
# Make sure /root/.bashrc existing  line ". dir/curr_filename" to validate this file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
curr_date=$(date +%Y-%m-%d)
#export GREP_OPTIONS='--color=always'
#export PATH=$PATH:/u/shscript/tomcat_init:/u/shscript/auto_upgrade_maichang
EOF

echo '. /data/shscript/env-bashrc.sh' >> /root/.bashrc
END

#---------------
/etc/init.d/ntpd start
chkconfig ntpd on
#---------------
yum -y update && reboot


} | tee -a $logfile 2>&1


