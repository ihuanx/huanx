#!/bin/bash
#=================================================
# DIY script
# jsjson@163.com 
#=================================================             

# Docker v20.10.17
rm -rf feeds/packages/utils/docker
rm -rf feeds/packages/utils/dockerd
rm -rf feeds/packages/utils/containerd
rm -rf feeds/packages/utils/runc
rm -rf feeds/packages/utils/libnetwork
rm -rf feeds/packages/utils/tini
svn export https://github.com/coolsnowwolf/packages/trunk/utils/docker feeds/packages/utils/docker
svn export https://github.com/coolsnowwolf/packages/trunk/utils/dockerd feeds/packages/utils/dockerd
svn export https://github.com/coolsnowwolf/packages/trunk/utils/containerd feeds/packages/utils/containerd
svn export https://github.com/coolsnowwolf/packages/trunk/utils/runc feeds/packages/utils/runc
svn export https://github.com/coolsnowwolf/packages/trunk/utils/libnetwork feeds/packages/utils/libnetwork
svn export https://github.com/coolsnowwolf/packages/trunk/utils/tini feeds/packages/utils/tini

##
svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-fs ./package/add/luci-lib-fs
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-filetransfer ./package/add/luci-app-filetransfer
sed -i "s/\.\.\/\.\./\$\(TOPDIR\)\/feeds\/luci/g" ./package/add/luci-app-filetransfer/Makefile
cp -af ./package/add/luci-app-filetransfer/po/zh-cn  ./package/add/luci-app-filetransfer/po/zh_Hans

rm -rf package/feeds/xiangfeidexiaohuo/luci-app-turboacc

##配置IP
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##更改主机名
sed -i "s/hostname='.*'/hostname='HUANX'/g" package/base-files/files/bin/config_generate

##
sed -i "53iLUCI_LANG.zh-cn=\$(LUCI_LANG.zh_Hans)" feeds/luci/luci.mk