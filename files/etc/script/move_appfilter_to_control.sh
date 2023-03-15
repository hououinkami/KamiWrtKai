#!/bin/sh
sed -i 's/services/control/g' /usr/lib/lua/luci/controller/appfilter.lua
sed -i 's/services/control/g' /usr/lib/lua/luci/model/cbi/appfilter/*.lua
sed -i 's/services/control/g' /usr/lib/lua/luci/view/admin_network/dev_status.htm
sed -i 's/services/control/g' /usr/lib/lua/luci/view/admin_network/user_status.htm
sed -i 's/services/control/g' /usr/lib/lua/luci/view/cbi/oaf_dvalue.htm
sed -i 's/services/control/g' /usr/lib/lua/luci/view/cbi/oaf_upload.htm
rm -rf /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/*