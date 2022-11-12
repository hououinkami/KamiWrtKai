# 更改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# HelloWorld归类至VPN菜单
sed -i 's/services/vpn/g' package/feeds/helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/feeds/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm