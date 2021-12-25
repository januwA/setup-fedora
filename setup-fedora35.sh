#!/bin/bash
# Setup WSL Fedora35 Linux

if ! test -e /etc/fedora-release; then
  exit
fi

echo 'upgrade...'
dnf upgrade -y 1>/etc/null

# install
echo 'install wget git vim nodejs python-pip ...'
dnf install make cmake clang g++ -y 1>/etc/null
dnf install wget git vim nodejs python-pip python-launcher -y 1>/etc/null
dnf install tree -y 1>/etc/null

# install chsh
if ! command -v chsh &>/dev/null; then
  echo 'install util-linux-user ...'
  dnf install util-linux-user -y 1>/etc/null
fi

# install ifconfig

if ! command -v ifconfig &>/dev/null; then
  echo 'install net-tools ...'
  dnf install net-tools -y 1>/etc/null
fi

# config git
git config --global user.name "januwA"
git config --global user.email ajanuw1995@gmail.com
git config --global core.editor vim
git config --global core.autocrlf input
git config --global pull.rebase true

# Mount the windows drive to wsl
if test -e /mnt; then
  if ! command -v mount &>/dev/null; then
    dnf install bashmount -y 1>/etc/null
  fi

  mount -t drvfs C: /mnt/c &>/etc/null
  mount -t drvfs D: /mnt/d &>/etc/null

  if ! test -e /c; then
    ln -s /mnt/c/ /c
  fi

  if ! test -e /d; then
    ln -s /mnt/d/ /d
  fi
fi

# set alias
echo "set alias..."
if ! grep -q "alias ll" /etc/bashrc; then
  echo "alias ll='ls -ahl'" >>/etc/bashrc
fi

# set  ~/.ssh/id_rsa.pub
if ! test -e ~/.ssh/id_rsa.pub; then
  ssh-keygen -t rsa -C "ajanuw1995@gmail.com"
fi
