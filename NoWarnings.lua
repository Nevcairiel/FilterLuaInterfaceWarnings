local f = CreateFrame("Frame")

-- unregister LUA_WARNING from other addons (ie. UIParent and possibly !BugGrabber)
local frames = {GetFramesRegisteredForEvent("LUA_WARNING")}
for _, frame in ipairs(frames) do
	f.UnregisterEvent(frame, "LUA_WARNING")
end

f:SetScript("OnEvent",
function(f, ev, warnMessage)
	-- scrube nonsense from the message
	warnMessage = warnMessage:gsub("Interface\\FrameXML\\Bindings.xml:%d+ ", ""):trim()

	-- filter out missing file warnings or broken "(null)" warnings
	if warnMessage:find("^Couldn't open")
	or warnMessage:find("%.xml:%d+ Couldn't open ")
	or warnMessage:find("%.toc:%d+ Couldn't open ")
	or warnMessage:find("^Error loading")
	or warnMessage:find("%.xml:%d+ Error loading ")
	or warnMessage:find("%.lua:%d+ Error loading ")
	or warnMessage:find("%.toc:%d+ Error loading ")
	or warnMessage:find("^%(null%)")
	or warnMessage:find("%(null%)$") then
		return
	end
	geterrorhandler()(warnMessage, true)
end)
f:RegisterEvent("LUA_WARNING")

BUGGRABBER_ERRORS_PER_SEC_BEFORE_THROTTLE = 10000
