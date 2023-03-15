#!/bin/sh
sed -i 's/services/vpn/g' /usr/lib/lua/luci/controller/openclash.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/openclash.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' /usr/lib/lua/luci/view/openclash/*.htm
rm -rf /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/*