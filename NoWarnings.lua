local f = CreateFrame("Frame")

-- unregister LUA_WARNING from other addons (ie. UIParent and possibly !BugGrabber)
local frames = {GetFramesRegisteredForEvent("LUA_WARNING")}
for _, frame in ipairs(frames) do
	f.UnregisterEvent(frame, "LUA_WARNING")
end

f:SetScript("OnEvent",
function(f, ev, warnType, warnMessage)
	warnMessage = warnMessage:gsub("Interface\\FrameXML\\Bindings.xml:%d+ ", "")
	if warnMessage:match("^Couldn't open") or warnMessage:match("%.xml:%d+ Couldn't open Interface") or warnMessage:match("^Error loading") or warnMessage:match("%.xml:%d+ Error loading Interface") or warnMessage:match("^%(null%)") or warnMessage:match("%(null%)$") then
		return
	end
	geterrorhandler()(warnMessage, true)
end)
f:RegisterEvent("LUA_WARNING")

BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE = 10000
