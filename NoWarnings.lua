-- unregister LUA_WARNING from other addons (ie. UIParent and possibly !BugGrabber)
local frames = {GetFramesRegisteredForEvent("LUA_WARNING")}
for _, frame in ipairs(frames) do
	frame:UnregisterEvent("LUA_WARNING")
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent",
function(f, ev, warnType, warnMessage)
	if warnMessage:match("^Couldn't open") or warnMessage:match("^Error loading") or warnMessage:match("^%(null%)") then
		return
	end
	geterrorhandler()(warnMessage)
end)
f:RegisterEvent("LUA_WARNING")
