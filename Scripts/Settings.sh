#!/bin/bash

#删除冲突插件
rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\|openclash\).*")
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd-alt,miniupnpd-iptables,wireless-regdb}
#删除旧版本插件
rm -rf feeds/packages/net/alist
#cp -rf feeds/smpackage/alist feeds/packages/net/

sed -i "s/1.32.3/1.58.2/g" feeds/packages/net/tailscale/Makefile
sed -i "s/4cf88a1d754240ce71b29d3a65ca480091ad9c614ac99c541cef6fdaf0585dd4/452f355408e4e2179872387a863387e06346fc8a6f9887821f9b8a072c6a5b0a/g" feeds/packages/net/tailscale/Makefile

sed -i "s/1.8.3/1.8.7/g" feeds/packages/net/xray-core/Makefile
sed -i "s/bdfa65c15cd25f931745d9c70c753503db5d119ff11960ca7b3a2e19c4b0a8d1/e8f46177d792b89700f164ca28fbf1a3c7d95a3ecf98871cb0dd5e474b46a859/g" feeds/packages/net/xray-core/Makefile

sed -i "s/2023.8.1/2024.1.5/g" feeds/packages/net/cloudflared/Makefile
sed -i "s/e2cbb89bf73220a7bc4491facb96ff16c1880ebfcac679b5b17f21abab039c72/0a0da188e162680927ebafcef32c3366aed26661273dc63c540bbebee435bd4e/g" feeds/packages/net/cloudflared/Makefile

#修改默认主题
#sed -i "s/luci-theme-bootstrap/luci-theme-$OWRT_THEME/g" $(find ./feeds/luci/collections/ -type f -name "Makefile")
#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/$OWRT_IP/g" ./package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='$OWRT_NAME'/g" ./package/base-files/files/bin/config_generate
#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

#根据源码来修改
if [[ $OWRT_URL == *"lede"* ]] ; then
  #修改默认时间格式
  sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
fi
