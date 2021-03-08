# svn checkout https://github.com/openwrt/packages/trunk/utils/libnetwork packages/utils
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
# >> 添加Clash game内核
wget https://github.com/vernesong/OpenClash/releases/download/TUN/clash-linux-amd64.tar.gz
tar -zxvf clash-linux-amd64.tar.gz -O > clash_game && rm -rf clash-linux-amd64.tar.gz
chmod 0755 clash_game
# >> 添加Clash tun内核
find ../../../../../OpenClash/core-lateset/premium -maxdepth 0  -name "clash-linux-amd64*"  | xargs -i mv -f {} ./
gzip -df *.gz
mv clash-linux-amd64* clash_tun
chmod 0755 clash_tun
cd -
# 编译OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git && mv -f OpenAppFilter/* ./
# 编译ServerChan
git clone https://github.com/hououinkami/luci-app-serverchan.git
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
