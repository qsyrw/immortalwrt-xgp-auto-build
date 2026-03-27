module("luci.controller.romupdate", package.seeall)
function index()
    if not nixio.fs.access("/etc/config/romupdate") then return end
    entry({"admin", "system", "romupdate"}, cbi("romupdate"), _("ROM升级"), 90).dependent = true
end
