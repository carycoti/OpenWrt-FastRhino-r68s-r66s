#!/bin/bash

# uci set luci.main.lang=zh_cn
# uci commit luci

# uci -q batch <<-EOF
# 	set system.@system[0].timezone='CST-8'
# 	set system.@system[0].zonename='Asia/Shanghai'

# 	delete system.ntp.server
# 	add_list system.ntp.server='ntp1.aliyun.com'
# 	add_list system.ntp.server='ntp.tencent.com'
# 	add_list system.ntp.server='ntp.ntsc.ac.cn'
# 	add_list system.ntp.server='time.ustc.edu.cn'
# EOF
# uci commit system

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
sed -i "s/imm/official/" etc/opkg/distfeeds.conf

# 防火墙
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/firewall -o etc/config/firewall

# 时区
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/system -o etc/config/system
sed -i "s/ImmortalWrt/Haleima/" etc/config/system

# docker
curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/dockerd -o etc/config/dockerd

# 中文
# curl -sL https://github.com/carycoti/OpenWrt-FastRhino-r68s-r66s/raw/main/files/luci -o etc/config/luci

popd
