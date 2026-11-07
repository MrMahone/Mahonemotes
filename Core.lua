local addonName, ns = ...
local L = ns.L

local defaults = {
	radius = 130,
	deadzone = 40,
	hold = 0.2,
}

local function Print(msg)
	print("|cffffd100Mahonemotes|r: " .. msg)
end

function ns.PerformEmote(token)
	if C_ChatInfo and C_ChatInfo.PerformEmote then
		if C_ChatInfo.PerformEmote(token) == false then
			Print(L.EMOTE_FAILED:format(token))
		end
	elseif DoEmote then
		DoEmote(token)
	end
end

-- Aufgerufen aus Bindings.xml, keystate ist "down" oder "up"
function Mahonemotes_OnKey(keystate)
	if not ns.db then
		return
	end
	if keystate == "down" then
		ns.Wheel:KeyDown()
	else
		ns.Wheel:KeyUp()
	end
end

local function ApplyDefaults(db)
	for k, v in pairs(defaults) do
		if db[k] == nil then
			db[k] = v
		end
	end
end

-- Vergleicht die Tokens mit den EMOTEn_TOKEN-Globals des Clients.
-- Reine DoEmote-Tokens (z.B. GOODLUCK) fehlen dort und erscheinen als unbekannt.
local function CheckTokens()
	local known, any = {}, false
	for i = 1, 1000 do
		local t = _G["EMOTE" .. i .. "_TOKEN"]
		if t then
			known[t], any = true, true
		end
	end
	if not any then
		Print(L.CHECK_NOLIST)
		return
	end
	local ok = true
	for p, page in ipairs(ns.Pages) do
		for s, e in ipairs(page) do
			if not known[e.token] then
				ok = false
				Print(L.CHECK_UNKNOWN:format(p, s, e.token))
			end
		end
	end
	if ok then
		Print(L.CHECK_OK)
	end
end

SLASH_MAHONEMOTES1 = "/memote"
SLASH_MAHONEMOTES2 = "/mahonemotes"
SlashCmdList.MAHONEMOTES = function(msg)
	local cmd, arg = msg:match("^(%S*)%s*(.-)$")
	cmd = cmd:lower()
	if cmd == "size" then
		local r = tonumber(arg)
		if r and r >= 80 and r <= 300 then
			ns.db.radius = math.floor(r)
			ns.Wheel:ApplyLayout()
			Print(L.SIZE_SET:format(ns.db.radius))
		else
			Print(L.SIZE_RANGE)
		end
	elseif cmd == "check" then
		CheckTokens()
	elseif cmd == "reset" then
		wipe(ns.db)
		ApplyDefaults(ns.db)
		ns.Wheel:ApplyLayout()
		Print(L.RESET)
	else
		for _, line in ipairs(L.HELP) do
			Print(line)
		end
	end
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", function(self, _, name)
	if name ~= addonName then
		return
	end
	MahonemotesDB = MahonemotesDB or {}
	ApplyDefaults(MahonemotesDB)
	ns.db = MahonemotesDB
	ns.Wheel:ApplyLayout()
	self:UnregisterEvent("ADDON_LOADED")
end)
