cd package
#
# 自定义插件
#
# > 编译OpenClash
git clone -b master https://github.com/vernesong/OpenClash.git
# >> 添加Clash dev内核
mkdir -p base-files/files/etc/openclash/core
cd base-files/files/etc/openclash/core
wget https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz
tar -zxvf clash-linux-amd64.tar.gz && rm -rf clash-linux-amd64.tar.gz
chmod 0755 clash
# >> 添加Clash tun内核
find ../../../../../OpenClash/core-lateset/premium -name "clash-linux-amd64*"  | xargs -i mv -f {} ./
gzip -df *.gz
mv clash-linux-amd64* clash_tun
chmod 0755 clash_tun
cd -

# 编译OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git && mv -f OpenAppFilter/* ./

# 编译ServerChan
cd lean
rm -rf luci-app-serverchan
cd -

git clone https://github.com/tty228/luci-app-serverchan.git

sed -i 's/微信推送/设备状态推送/g' luci-app-serverchan/luasrc/controller/serverchan.lua

cd luci-app-serverchan/root/usr/bin/serverchan

sed -i 's/"IP 地址变化"/"🔗 IPアドレスがISPにより変更"/g' serverchan
sed -i 's/IP 地址变化/IPアドレス変更/g' serverchan
sed -i 's/当前 IP/現在のIP/g' serverchan
sed -i 's/当前IP/現在のIP/g' serverchan
sed -i 's/"路由器重新启动"/"🔄 ルーターが再起動しました"/g' serverchan
sed -i 's/路由器重新启动/ルーター再起動完了/g' serverchan

sed -i 's/\$ip_name 连接了你的路由器/✅ \$ip_name がルーターに接続/g' serverchan
sed -i 's/新设备连接/デバイス接続/g' serverchan
sed -i '700,800 s/\${ip_name} \${title}/✅ \${ip_name} \${title}/' serverchan
sed -i 's/客户端名/設備/g' serverchan
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
sed -i 's/设备温度/設備温度/g' serverchan
sed -i 's/WAN 口信息/WAN情報/g' serverchan
sed -i 's/接口ip/インターフェースIP/g' serverchan
sed -i 's/外网ip/外部ネットワークIP/g' serverchan
sed -i 's/外网 ip 与接口 ip 不一致，你的 ip 不是公网 ip/IPはパブリックネットワークIPではありません。/g' serverchan
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

# HelloWorld
cd ..
sed -i "/helloworld/d" "feeds.conf.default"
echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
cd package

#
# 自定义主题
#
# 更新argon主题
git clone https://github.com/Mrbai98/luci-theme-atmaterial.git
cd lean
rm -rf luci-theme-argon
cd -
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
# 更改默认主题
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/argon' lean/default-settings/files/zzz-default-settings
#
cd ./
