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

# 添加软件源
shopt -s extglob
# 添加软件源
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default

# 添加 kenzok8源
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git smpackage https://github.com/kenzok8/small-package' feeds.conf.default

# 删除 telephony feeds,并优化feeds命令
sed -i "/telephony/d" feeds.conf.default
sed -i "s?targets/%S/packages?targets/%S/\$(LINUX_VERSION)?" include/feeds.mk
sed -i '/	refresh_config();/d' scripts/feeds

# 更新 feeds
./scripts/feeds update -a

# 更新 kiddin9
# ./scripts/feeds install -a -p kiddin9 -f

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

# 取消对 samba4 的菜单调整
sed -i '/samba4/s/^/#/' package/lean/default-settings/files/zzz-default-settings

# Themes
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-bootstrap-mmdvm
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 为 kenzok8 源整理相关目录
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}

# 替换 golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 替换编译出错的包
rm -rf feeds/packages/lang/ruby
git clone https://github.com/coolsnowwolf/packages tmp/lede-packages
mv tmp/lede-packages/lang/ruby feeds/packages/lang/ruby
mv tmp/lede-packages/net/gowebdav feeds/packages/net/gowebdav
mv tmp/lede-packages/utils/bandwidthd feeds/packages/utils/bandwidthd
mv tmp/lede-packages/net/shadowsocks-libev feeds/packages/net/shadowsocks-libev
mv tmp/lede-packages/libs/pcre2 feeds/packages/libs/pcre2
rm -rf tmp/lede-packages

# 添加第三方软件包
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages

# 安装 feeds
./scripts/feeds install -a
