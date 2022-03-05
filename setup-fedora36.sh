#!/bin/bash
# Setup WSL Fedora36 Linux

if ! test -e /etc/fedora-release; then
  exit
fi

 echo "fastestmirror=True" >> /etc/dnf/dnf.conf
 echo >> /etc/dnf/dnf.conf

echo 'upgrade...'
dnf upgrade -y 1>/etc/null

# install
echo 'install...'

dnf groupinstall "Development Tools" -y 1>/etc/null
dnf groupinstall "C Development Tools and Libraries" -y 1>/etc/null
dnf install pcre-devel zlib-devel openssl-devel -y 1>/etc/null
dnf install clang g++ -y 1>/etc/null
dnf install bashmount util-linux-user net-tools iputils -y 1>/etc/null
dnf install nodejs golang python-pip python3-devel python-launcher mono-complete java-1.8.0-openjdk -y 1>/etc/null
dnf install wget vim tree -y 1>/etc/null

# config git
git config --global user.name "januwA"
git config --global user.email ajanuw1995@gmail.com
git config --global core.editor vim
git config --global core.autocrlf input
git config --global pull.rebase true

if ! test -e /c; then
	ln -s /mnt/c/ /c
fi

# set alias
echo "set alias..."
if ! grep -q "alias ll" /etc/bashrc; then
  echo "alias ll='ls -ahl'" >>/etc/bashrc
  echo >>/etc/bashrc
fi

# set  ~/.ssh/id_rsa.pub
if ! test -e ~/.ssh/id_rsa.pub; then
  ssh-keygen -t rsa -C "ajanuw1995@gmail.com"
fi
