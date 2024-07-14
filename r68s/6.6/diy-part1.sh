#!/bin/bash
# =================================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# 执行命令来切换内核
#sed -i 's/PATCHVER:=6.1/PATCHVER:=6.6/g' target/linux/rockchip/Makefile

# 增减包: luci-app-smartdns换为需要操作的包名，增=y， 减=n
sed -i "s/\(luci-app-smartdns\)=y/\1=n/" .config
sed -i "s/\(luci-app-bypass\)=y/\1=n/" .config
sed -i "s/\(luci-app-passwall\)=y/\1=n/" .config
sed -i "s/\(luci-app-ssr-plus\)=y/\1=n/" .config

# 添加软件源
shopt -s extglob
# 添加软件源
sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default

sed -i "/telephony/d" feeds.conf.default

sed -i "s?targets/%S/packages?targets/%S/\$(LINUX_VERSION)?" include/feeds.mk

sed -i '/	refresh_config();/d' scripts/feeds

./scripts/feeds update -a
./scripts/feeds install -a -p kiddin9 -f
./scripts/feeds install -a

#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default

#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main' >>feeds.conf.default
#echo 'src-git helloworld https://github.com/Jason6111/helloworld' >>feeds.conf.default

# 添加第三方软件包
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
