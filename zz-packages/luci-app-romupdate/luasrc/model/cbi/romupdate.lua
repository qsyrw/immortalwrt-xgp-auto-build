local fs = require "nixio.fs"
m = Map("romupdate", translate("ROM升级"), translate("固件在线升级工具"))
s = m:section(TypedSection, "main")
s.anonymous = true

e = s:option(Flag, "enable", translate("启用自动检查"))
e.default = 1

auto = s:option(Flag, "auto_update", translate("自动执行升级"))
auto.default = 0

local cur_ver = fs.readfile("/etc/lenyu_version") or "未知"
curr = s:option(DummyValue, "current_version", translate("当前版本"))
curr.value = cur_ver

-- 这里的逻辑会调用我们自定义的脚本显示云端版本
btn = s:option(Button, "check", translate("手动执行"))
btn.inputtitle = translate("立即检查并升级")
btn.write = function()
    luci.sys.call("/usr/bin/xgp-update &")
end

return m
