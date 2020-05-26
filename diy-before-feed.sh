#
# 自定义插件
#
# 编译OpenClash
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
# 添加Clash内核
mkdir -p package/base-files/files/etc/openclash/core
cd package/base-files/files/etc/openclash/core
wget https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz
tar -zxvf clash-linux-amd64.tar.gz
chmod 0755 clash
cd -
# 编译OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# 编译ServerChan
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
#
# 自定义主题
#
# 更新argon主题
git clone https://github.com/Mrbai98/luci-theme-atmaterial.git package/luci-theme-atmaterial
cd package/lean
rm -rf luci-theme-argon
cd -
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
