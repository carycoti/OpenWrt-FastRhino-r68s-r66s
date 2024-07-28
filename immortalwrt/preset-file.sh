#!/bin/bash

# 配置bash
mkdir -p files/etc
pushd files
# 配置 base 和 fish
git clone https://github.com/carycoti/dotfiles.git root/dotfiles

echo "source ~/dotfiles/bash/colors
source ~/dotfiles/bash/settings
source ~/dotfiles/bash/alias
source ~/dotfiles/bash/functions" > etc/bash.bashrc

mkdir -p root/.config
# sed -i "s/whoami/uname -n/" root/dotfiles/fish/functions/fish_prompt_get_left_prompt.fish
cp -r root/dotfiles/fish root/.config

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

# 配置 opkg
echo "dest root /
dest ram /tmp
lists_dir ext /var/opkg-lists
option overlay_root /overlay" > etc/opkg.conf
# 替换opkg默认源，要用webdav自建 core 库 
mkdir -p etc/opkg
echo "src/gz core http://192.168.1.21:6086/dav2/imm
src/gz base https://dl.openwrt.ai/23.05/packages/aarch64_generic/base
src/gz luci https://dl.openwrt.ai/23.05/packages/aarch64_generic/luci/
src/gz packages https://dl.openwrt.ai/23.05/packages/aarch64_generic/packages
src/gz routing https://dl.openwrt.ai/23.05/packages/aarch64_generic/routing
src/gz kiddin9 https://dl.openwrt.ai/23.05/packages/aarch64_generic/kiddin9" > etc/opkg/distfeeds.conf
popd