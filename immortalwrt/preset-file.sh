#!/bin/bash

# files大法
mkdir -p files/etc/config

# 进入工作目录 files
pushd files
# 配置 base 和 fish
git clone https://github.com/carycoti/dotfiles.git root/dotfiles

# echo "source ~/dotfiles/bash/colors
# source ~/dotfiles/bash/settings
# source ~/dotfiles/bash/alias
# source ~/dotfiles/bash/functions" > etc/bash.bashrc
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/bash.bashrc -o etc/bash.bashrc

# fish
mkdir -p root/.config
cp -r root/dotfiles/fish root/.config

# echo "root:\$1\$V4UetPzk\$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::
# daemon:*:0:0:99999:7:::
# ftp:*:0:0:99999:7:::
# network:*:0:0:99999:7:::
# nobody:*:0:0:99999:7:::
# ntp:x:0:0:99999:7:::
# dnsmasq:x:0:0:99999:7:::
# docker:x:0:0:99999:7:::
# logd:x:0:0:99999:7:::
# p910nd:x:0:0:99999:7:::
# ubus:x:0:0:99999:7:::" > etc/shadow
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/shadow -o etc/shadow

# 配置 opkg
# echo "dest root /
# dest ram /tmp
# lists_dir ext /var/opkg-lists
# option overlay_root /overlay" > etc/opkg.conf
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/opkg.conf -o etc/opkg.conf
# 替换opkg默认源，要用webdav自建 core 库 
mkdir -p etc/opkg
# echo "src/gz core http://192.168.1.21:6086/dav2/imm
# src/gz base https://dl.openwrt.ai/23.05/packages/aarch64_generic/base
# src/gz luci https://dl.openwrt.ai/23.05/packages/aarch64_generic/luci/
# src/gz packages https://dl.openwrt.ai/23.05/packages/aarch64_generic/packages
# src/gz routing https://dl.openwrt.ai/23.05/packages/aarch64_generic/routing
# src/gz kiddin9 https://dl.openwrt.ai/23.05/packages/aarch64_generic/kiddin9" > etc/opkg/distfeeds.conf
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/distfeeds.conf -o etc/opkg/distfeeds.conf

# 防火墙
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/firewall -o etc/config/firewall

popd