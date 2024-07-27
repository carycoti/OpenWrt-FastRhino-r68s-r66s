#!/bin/bash
# ==============================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# ===============================================================

#修改默认IP
sed -i 's/192.168.1.1/192.168.1.21/g' package/base-files/files/bin/config_generate   # 定制默认IP
sed -i 's/192.168.1.1/192.168.1.21/g' package/feeds/kiddin9/base-files/files/bin/config_generate
# 默认网关和dns
sed -i 's/\(\([ \t]\+\)set network.$1.netmask=.*\)/\1\n \2set network.$1.dns='192.168.1.1'/' package/base-files/files/bin/config_generate
sed -i 's/\(\([ \t]\+\)set network.$1.netmask=.*\)/\1\n \2set network.$1.gateway='192.168.1.1'/' package/base-files/files/bin/config_generate
sed -i 's/\(\([ \t]\+\)set network.$1.netmask=.*\)/\1\n \2set network.$1.dns='192.168.1.1'/' package/feeds/kiddin9/base-files/files/bin/config_generate
sed -i 's/\(\([ \t]\+\)set network.$1.netmask=.*\)/\1\n \2set network.$1.gateway='192.168.1.1'/' package/feeds/kiddin9/base-files/files/bin/config_generate

# 更改默认 Shell 为 bash
# sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
# 改为 fish
sed -i "s/\/bin\/ash/\/usr\/bin\/fish/" package/base-files/files/etc/passwd

# 更改firewall设置：常规设置第3行和第5行的入站和转发设为接受
# sed -i "3s/REJECT/ACCEPT/" package/network/config/firewall/files/firewall.config
# sed -i "5s/REJECT/ACCEPT/" package/network/config/firewall/files/firewall.config

# Configure pppoe connection
#uci set network.wan.proto=pppoe
#uci set network.wan.username='yougotthisfromyour@isp.su'
#uci set network.wan.password='yourpassword'

# 修改软件包
#chmod -R 755 files
#rm -rf feeds/luci/applications/luci-app-mosdns && rm -rf feeds/packages/net/{alist,adguardhome,smartdns}
#rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# 停用冲突的软件包: luci-app-smartdns换为需要操作的包名，启用=y， 停用=n
# sed -i "s/\(luci-app-smartdns\)=y/\1=n/" .config
sed -i 's/\(luci-app-bypass\)=y/\1=n/' .config
# sed -i 's/\(luci-app-passwall\)=y/\1=n/' .config
sed -i 's/\(luci-app-ssr-plus\)=y/\1=n/' .config
# sed -i 's/\(chinadns-ng\)=y/\1=n/' .config
sed -i 's/\(zerotier\)=y/\1=m/' .config


# 添加额外软件包
echo 'CONFIG_PACKAGE_luci-app-diskman=y' >>.config
echo 'CONFIG_PACKAGE_luci-app-samba4=y' >>.config
echo 'CONFIG_PACKAGE_docker-compose=y' >>.config
echo 'CONFIG_PACKAGE_luci-app-dockerman=y' >>.config
echo 'CONFIG_PACKAGE_luci-app-istorex=y' >>.config
echo 'CONFIG_PACKAGE_luci-app-linkease=y' >>.config
# echo 'CONFIG_PACKAGE_luci-app-gowebdav=y' >>.config

# 科学上网插件


# 科学上网插件依赖
