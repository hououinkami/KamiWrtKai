#集成关机功能到系统源码菜单中
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

cd package

#
# 自定义插件
#
# 编译OpenClash
git clone -b master https://github.com/vernesong/OpenClash.git

cd OpenClash
git clone -b core https://github.com/vernesong/OpenClash.git core
cd -

find OpenClash/core/dev/premium -name "clash-linux-amd64-20*"  | xargs -i mv -f {} ./
gzip -df clash-linux-amd64-20*.gz
mv clash-linux-amd64* clash_tun
rm -rf OpenClash/core

# >> 添加Clash Tun内核
mkdir -p base-files/files/etc/openclash/core
mv clash_tun base-files/files/etc/openclash/core
cd base-files/files/etc/openclash/core
chmod 0755 clash_tun

# >> 添加Clash Meta内核
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/meta/clash-linux-amd64.tar.gz
tar -zxvf clash-linux-amd64.tar.gz && rm -rf clash-linux-amd64.tar.gz
mv clash clash_meta
chmod 0755 clash_meta

# >> 添加Clash Dev内核
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/dev/clash-linux-amd64.tar.gz
tar -zxvf clash-linux-amd64.tar.gz && rm -rf clash-linux-amd64.tar.gz
chmod 0755 clash

cd -

# >> 更改中控台为meta版本
cd OpenClash/luci-app-openclash/root/usr/share/openclash/ui
wget -O yacd.zip https://codeload.github.com/MetaCubeX/Yacd-meta/zip/refs/heads/gh-pages
wget -O dash.zip https://codeload.github.com/MetaCubeX/Razord-meta/zip/refs/heads/gh-pages
rm -rf yacd
rm -rf dashboard
unzip yacd.zip
mv *meta* yacd
unzip dash.zip
mv *meta* dashboard
rm -rf *.zip

cd -

# >> 归类至VPN菜单
sed -i 's/services/vpn/g' OpenClash/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' OpenClash/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' OpenClash/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' OpenClash/luci-app-openclash/luasrc/view/openclash/*.htm

# >> 开机默认启动OpenClash
sed -i "s/uci -q set openclash.config.enable=0/uci -q set openclash.config.enable=1/g" OpenClash/luci-app-openclash/root/etc/uci-defaults/luci-openclash

# 编译OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git && mv -f OpenAppFilter/* ./

# >> 归类至管控菜单
sed -i 's/services/control/g' luci-app-oaf/luasrc/controller/*.lua
sed -i 's/services/control/g' luci-app-oaf/luasrc/*.lua
sed -i 's/services/control/g' luci-app-oaf/luasrc/model/cbi/appfilter/*.lua
sed -i 's/services/control/g' luci-app-oaf/luasrc/view/admin_network/*.htm
sed -i 's/services/control/g' luci-app-oaf/luasrc/view/cbi/*.htm

# 编译ServerChan
cd lean
rm -rf luci-app-serverchan
cd -

git clone https://github.com/tty228/luci-app-serverchan.git

sed -i 's/微信推送/设备状态推送/g' luci-app-serverchan/luasrc/controller/serverchan.lua

cd luci-app-serverchan/root/usr/bin/serverchan

sed -i 's/"IP 地址变化"/"🔗 IPアドレスがISPにより変更"/g' serverchan
sed -i 's/IP 地址变化/IPアドレス変更/g' serverchan
sed -i 's/"IPv6 地址变化"/"🔗 IPv6アドレスがISPにより変更"/g' serverchan
sed -i 's/IPv6 地址变化/IPv6アドレス変更/g' serverchan
sed -i 's/当前 IP/現在のIP/g' serverchan
sed -i 's/当前IP/現在のIP/g' serverchan
sed -i 's/"路由器重新启动"/"🔄 ルーターが再起動しました"/g' serverchan
sed -i 's/路由器重新启动/ルーター再起動完了/g' serverchan

sed -i 's/\$ip_name 连接了你的路由器/✅ \$ip_name がルーターに接続/g' serverchan
sed -i 's/新设备连接/デバイス接続/g' serverchan
sed -i '700,800 s/\${ip_name} \${title}/✅ \${ip_name} \${title}/' serverchan
sed -i 's/客户端名/設備/g' serverchan
sed -i 's/主机名/設備/g' serverchan
sed -i 's/客户端IP： /IP：     /g' serverchan
sed -i 's/客户端MAC/MAC/g' serverchan
sed -i 's/网络接口/インターフェース/g' serverchan
sed -i 's/连接了你的路由器/がルーターに接続/g' serverchan
sed -i 's/设备状态变化/📳 デバイスステータスの変更/g' serverchan

sed -i 's/总计流量：/トラフィック：    /g' serverchan

sed -i 's/\${ip_name} 断开连接/❌ \${ip_name} がルーターから切断/g' serverchan
sed -i 's/设备断开连接/デバイス切断/g' serverchan
sed -i '800,900 s/\${ip_name} \${title}/❌ \${ip_name} \${title}/' serverchan
sed -i 's/在线时间/オンライン時間/g' serverchan
sed -i 's/断开连接/がルーターから切断/g' serverchan

sed -i 's/台，詳細は以下の通り/つ、/g' serverchan
sed -i 's/IP 地址/IP：     /g' serverchan

sed -i 's/CPU 温度过高！/🌡 CPU温度異常！/g' serverchan
sed -i 's/CPU 温度过高/CPU温度上昇/g' serverchan
sed -i 's/CPU 温度已连续五分钟超过预设/CPU温度が5分間連続してプリセット値を超えました！/g' serverchan
sed -i 's/接下来一小 时不再提示/次の1時間は提示しない/g' serverchan
sed -i 's/当前温度/現在の温度/g' serverchan

sed -i 's/设备报警！/🚨 デバイスアラーム！/g' serverchan
sed -i 's/CPU 负载过高！/🚨 CPU負荷異常！/g' serverchan
sed -i 's/CPU 负载过高/CPU負荷上昇/g' serverchan
sed -i 's/CPU 负载已连续五分钟超过预设/CPU負荷が5分間連続してプリセット値を超えました！/g' serverchan
sed -i 's/接下来一小 时不再提示/次の1時間は提示しない/g' serverchan
sed -i 's/当前负载/現在の負荷/g' serverchan
sed -i 's/过高/異常/g' serverchan
sed -i 's/当前 CPU 占用前三的进程/現在CPUを著しく占めている上位3つプロセス/g' serverchan

sed -i 's/运行时间/稼働時間/g' serverchan
sed -i 's/系统运行状态/システム稼働状態/g' serverchan
sed -i 's/平均负载/平均負荷/g' serverchan
sed -i 's/CPU占用/CPU使用/g' serverchan
sed -i 's/内存占用/メモリ使用/g' serverchan
sed -i 's/全球互联/グローバル接続/g' serverchan
sed -i 's/设备温度/設備温度/g' serverchan
sed -i 's/WAN 口信息/WAN情報/g' serverchan
sed -i 's/接口 IPv4/LAN IP/g' serverchan
sed -i 's/外网 IPv4/WAN IP/g' serverchan
sed -i 's/接口 IPv6/LAN IPv6/g' serverchan
sed -i 's/外网 IPv6/WAN IPv6/g' serverchan
sed -i 's/外网 IP 与接口 IP 不一致，你的 IP 可能不是公网 IP/IPはパブリックネットワークIPではありません。/g' serverchan
sed -i 's/当前无在线设备/接続しているデバイスなし/g' serverchan
sed -i 's/在线设备/接続しているデバイス/g' serverchan
sed -i 's/总计流量/トラフィック/g' serverchan
sed -i 's/在线/オンライン/g' serverchan

sed -i 's/小时/時/g' serverchan
sed -i 's/天/日/g' serverchan

sed -i 's/ \&\& current_device//g' serverchan

sed -i 's/\${login_ip} 通过 web 登陆了路由器/🔑 \${login_ip} Web経由で/g' serverchan
sed -i 's/\${login_ip} 通过 ssh 登陆了路由器/🔑 \${login_ip} SSH経由でルーターにログイン/g' serverchan
sed -i 's/\${login_ip} 通过 web 频繁尝试登陆/🔑 \${login_ip} Web経由で頻繁にログイン試行/g' serverchan
sed -i 's/\${login_ip} 通过 ssh 频繁尝试登陆/🔑 \${login_ip} SSH経由で頻繁にログイン試行/g' serverchan
sed -i 's/登陆了路由器/ルーターにログイン/g' serverchan
sed -i 's/频繁尝试登陆/頻繁にログイン試行/g' serverchan
sed -i 's/登陆信息/ログイン情報/g' serverchan
sed -i 's/\${str_tab}时间/\${str_tab}時間/g' serverchan
sed -i 's/设备 IP： /IP：     /g' serverchan
sed -i 's/登录方式/方法/g' serverchan

cd -

# KamiWrtBot
git clone https://github.com/hououinkami/KamiWrtBot.git

# HelloWorld
rm -rf helloworld
git clone --depth=1 https://github.com/fw876/helloworld.git
sed -i 's/services/vpn/g' helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# Speedtest
# git clone https://github.com/sirpdboy/netspeedtest.git

# FileBroswer
rm -rf lean/luci-app-filebrowser
svn co https://github.com/immortalwrt/luci/branches/openwrt-18.06/applications/luci-app-filebrowser lean/luci-app-filebrowser
sed -i "s/..\/..\/luci.mk/\$(TOPDIR)\/feeds\/luci\/luci.mk/g" lean/luci-app-filebrowser/Makefile
rm -rf lean/filebrowser
svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/utils/filebrowser lean/filebrowser
sed -i "s/..\/..\/lang\/golang\/golang-package.mk/\$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g" lean/filebrowser/Makefile

# 定时插件
git clone https://github.com/sirpdboy/luci-app-autotimeset.git

# 家长控制
git clone https://github.com/sirpdboy/luci-app-parentcontrol.git

# Adguard Home
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git

# 编译Quickstart和iStore
# git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/{network/services/*,multimedia/*} ./; rm -rf nas-packages
# git clone --depth 1 https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/* ./; rm -rf nas-packages-luci
# git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
# git clone --depth 1 https://github.com/linkease/openwrt-app-actions
# git clone https://github.com/xiangfeidexiaohuo/op-ipkg.git

# 新增自定义脚本计划任务
sed -i '/exit 0/i\if [[ "$(cat /etc/crontabs/root | grep "/etc/script/check_openclash_connect.sh")" = "" ]]; then echo "#*/5 * * * * /etc/script/check_openclash_connect.sh" >> /etc/crontabs/root; fi' lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\if [[ "$(cat /etc/crontabs/root | grep "/etc/script/check_wan_connect.sh")" = "" ]]; then echo "#*/5 * * * * /etc/script/check_wan_connect.sh" >> /etc/crontabs/root; fi' lean/default-settings/files/zzz-default-settings

#
# 自定义主题
#
# 更新argon主题
git clone https://github.com/Mrbai98/luci-theme-atmaterial.git
cd lean
rm -rf luci-theme-argon
cd -
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone https://github.com/jerrykuku/luci-app-argon-config.git

# 更改默认主题
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon' lean/default-settings/files/zzz-default-settings

# 更改主机名
sed -i "s/hostname='.*'/hostname='Kami-Router'/g" base-files/files/bin/config_generate

# 加入自定义信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='KamiWrt-$(date +%Y%m%d)'/g" lean/default-settings/files/zzz-default-settings
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION='Compiled by Kami'/g" lean/default-settings/files/zzz-default-settings

#
cd ./
