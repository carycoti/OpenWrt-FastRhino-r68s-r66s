#!/bin/bash

# files大法
mkdir -p files/etc/config

# 进入工作目录 files
pushd files
# 配置 base 和 fish
git clone https://github.com/carycoti/dotfiles.git root/dotfiles
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/bash.bashrc -o etc/bash.bashrc
# fish
mkdir -p root/.config
cp -r root/dotfiles/fish root/.config

# 用户名和密码
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/shadow -o etc/shadow

# 配置 opkg
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/opkg.conf -o etc/opkg.conf
# 替换opkg默认源，要用webdav自建 core 库 
mkdir -p etc/opkg
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/distfeeds.conf -o etc/opkg/distfeeds.conf

# 防火墙
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/firewall -o etc/config/firewall

# 时区
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/system -o etc/config/system

popd