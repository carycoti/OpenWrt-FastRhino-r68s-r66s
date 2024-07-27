#!/bin/bash

# 配置bash
mkdir -p files/etc
pushd files

# git clone --depth=1 https://github.com/jaivardhankapoor/bestbash root/.bash
# sed -i "s/alias grep='grep --color=tty -d skip'/alias grep='grep --color=tty'/" root/.bash/alias 
# # ln -s root/.bash/init root/.bashrc
# # ln -s root/.bash/init etc/bash.bashrc
# echo "# GIT {{{
# alias gs='git status -sb'
# alias ga='git add .'
# alias gb='git branch'
# alias gc='git commit -am'
# alias gd='git diff'
# alias go='git checkout'
# alias gl=\"git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit\"
# alias gr='git remote'
# alias gn='git clone -o'
# alias gp='git pull'
# alias gps='git push'
# #}}}" >> root/.bash/alias 

# echo "source ~/.bash/colors
# source ~/.bash/settings
# source ~/.bash/alias
# source ~/.bash/functions" > etc/bash.bashrc

git clone https://github.com/carycoti/dotfiles.git root/dotfiles

echo "source ~/dotfiles/bash/colors
source ~/dotfiles/bash/settings
source ~/dotfiles/bash/alias
source ~/dotfiles/bash/functions" > etc/bash.bashrc

# mkdir -p root/.config
# cp -r root/dotfiles/fish root/.config
ln -s root/dotfiles/fish root/.config/fish

echo "root:\$1\$V4UetPzk\$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::
daemon:*:0:0:99999:7:::
ftp:*:0:0:99999:7:::
network:*:0:0:99999:7:::
nobody:*:0:0:99999:7:::
ntp:x:0:0:99999:7:::
dnsmasq:x:0:0:99999:7:::
docker:x:0:0:99999:7:::
logd:x:0:0:99999:7:::
p910nd:x:0:0:99999:7:::
ubus:x:0:0:99999:7:::" > etc/shadow

echo "dest root /
dest ram /tmp
lists_dir ext /var/opkg-lists
option overlay_root /overlay" > etc/opkg.conf

mkdir -p etc/opkg
echo "src/gz immortalwrt_core http://192.168.1.21:6086/dav2/immortalwrt
src/gz immortalwrt_base https://dl.openwrt.ai/23.05/packages/aarch64_generic/base
src/gz immortalwrt_luci https://dl.openwrt.ai/23.05/packages/aarch64_generic/luci/
src/gz immortalwrt_packages https://dl.openwrt.ai/23.05/packages/aarch64_generic/packages
src/gz immortalwrt_routing https://dl.openwrt.ai/23.05/packages/aarch64_generic/routing
src/gz openwrt_kiddin9 https://dl.openwrt.ai/23.05/packages/aarch64_generic/kiddin9" > etc/opkg/distfeeds.conf
popd