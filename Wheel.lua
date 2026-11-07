local _, ns = ...
local Spiral = ns.Spiral
local L = ns.L

local Wheel = {}
ns.Wheel = Wheel

local MASK = "Interface\\CHARACTERFRAME\\TempPortraitAlphaMask"
local SLOT_SIZE = 64

local state = Spiral.New(#ns.Pages)
local cx, cy = 0, 0
local openedAt = 0
local sticky = false
local slots = {}

-- Vollbild-Fangframe: nimmt Klicks und Mausrad, solange das Rad offen ist
local catcher = CreateFrame("Frame", "MahonemotesCatcher", UIParent)
catcher:SetAllPoints(UIParent)
catcher:SetFrameStrata("FULLSCREEN_DIALOG")
catcher:EnableMouse(true)
catcher:EnableMouseWheel(true)
catcher:Hide()
tinsert(UISpecialFrames, "MahonemotesCatcher") -- Escape schließt

local wheel = CreateFrame("Frame", nil, catcher)

local disk = wheel:CreateTexture(nil, "BACKGROUND")
disk:SetAllPoints()
disk:SetTexture(MASK)
disk:SetVertexColor(0, 0, 0, 0.55)

local hub = wheel:CreateTexture(nil, "BORDER")
hub:SetPoint("CENTER")
hub:SetTexture(MASK)
hub:SetVertexColor(0.12, 0.12, 0.12, 0.9)

local pointer = wheel:CreateTexture(nil, "OVERLAY")
pointer:SetSize(10, 10)
pointer:SetTexture(MASK)
pointer:SetVertexColor(1, 0.82, 0)

local title = wheel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("CENTER", 0, 6)

local pageText = wheel:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
pageText:SetPoint("TOP", title, "BOTTOM", 0, -2)

for i = 1, Spiral.SEGMENTS do
	local f = CreateFrame("Frame", nil, wheel)
	f:SetSize(SLOT_SIZE, SLOT_SIZE)
	f.bg = f:CreateTexture(nil, "ARTWORK")
	f.bg:SetAllPoints()
	f.bg:SetTexture(MASK)
	f.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	f.text:SetPoint("CENTER")
	f.text:SetWidth(SLOT_SIZE + 16)
	slots[i] = f
end

local function Current()
	return state.slot and ns.Pages[state.page][state.slot]
end

local function Refresh()
	local page = ns.Pages[state.page]
	for i, f in ipairs(slots) do
		local e = page[i]
		f:SetShown(e ~= nil)
		if e then
			f.text:SetText(e.label)
			if i == state.slot then
				f.bg:SetVertexColor(1, 0.82, 0, 0.95)
				f.text:SetTextColor(0, 0, 0)
			else
				f.bg:SetVertexColor(0.1, 0.1, 0.1, 0.85)
				f.text:SetTextColor(1, 1, 1)
			end
		end
	end
	local cur = Current()
	title:SetText(cur and cur.label or "")
	pageText:SetText(L.PAGE:format(state.page, state.pages))
end

function Wheel:ApplyLayout()
	local r, dz = ns.db.radius, ns.db.deadzone
	wheel:SetSize(2 * r + SLOT_SIZE + 16, 2 * r + SLOT_SIZE + 16)
	hub:SetSize(2 * dz, 2 * dz)
	for i, f in ipairs(slots) do
		local a = math.rad((i - 1) * Spiral.STEP)
		f:ClearAllPoints()
		f:SetPoint("CENTER", wheel, "CENTER", math.sin(a) * r, math.cos(a) * r)
	end
	state.deadzone = dz
end

function Wheel:IsOpen()
	return catcher:IsShown()
end

function Wheel:Open()
	local scale = UIParent:GetEffectiveScale()
	local x, y = GetCursorPosition()
	-- Rad am Cursor, aber vollständig auf dem Bildschirm halten
	local hw, hh = wheel:GetWidth() / 2, wheel:GetHeight() / 2
	cx = math.min(math.max(x / scale, hw), UIParent:GetWidth() - hw)
	cy = math.min(math.max(y / scale, hh), UIParent:GetHeight() - hh)
	wheel:ClearAllPoints()
	wheel:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx, cy)
	Spiral.Reset(state)
	sticky = false
	openedAt = GetTime()
	Refresh()
	catcher:Show()
end

function Wheel:Close()
	catcher:Hide()
end

function Wheel:Confirm()
	local e = Current()
	self:Close()
	if e then
		ns.PerformEmote(e.token)
	end
end

function Wheel:KeyDown()
	if catcher:IsShown() then
		-- Sticky-Modus: erneuter Tastendruck wählt
		if sticky then
			self:Confirm()
		end
		return
	end
	self:Open()
end

function Wheel:KeyUp()
	if not catcher:IsShown() or sticky then
		return
	end
	if Current() then
		self:Confirm()
	elseif GetTime() - openedAt < ns.db.hold then
		sticky = true
	else
		self:Close()
	end
end

catcher:SetScript("OnUpdate", function()
	local scale = UIParent:GetEffectiveScale()
	local x, y = GetCursorPosition()
	local dx, dy = x / scale - cx, y / scale - cy
	local page, slot = state.page, state.slot
	Spiral.Update(state, dx, dy)
	if state.page ~= page or state.slot ~= slot then
		Refresh()
	end
	local len = math.sqrt(dx * dx + dy * dy)
	if len < state.deadzone then
		pointer:Hide()
	else
		pointer:ClearAllPoints()
		pointer:SetPoint("CENTER", wheel, "CENTER", dx / len * state.deadzone, dy / len * state.deadzone)
		pointer:Show()
	end
end)

catcher:SetScript("OnMouseDown", function(_, button)
	if button == "LeftButton" then
		Wheel:Confirm()
	else
		Wheel:Close()
	end
end)

catcher:SetScript("OnMouseWheel", function(_, delta)
	Spiral.Turn(state, -delta)
	Refresh()
end)

catcher:SetScript("OnHide", function()
	sticky = false
end)
