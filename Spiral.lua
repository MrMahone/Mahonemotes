-- Reine Rad-Logik ohne WoW-API, damit sie außerhalb des Spiels testbar ist.
-- Winkel: 0° = oben, im Uhrzeigersinn steigend. Feld 1 liegt bei 345°–15°.
-- Der kumulierte Winkel "total" läuft zyklisch über alle Seiten: über 12 Uhr
-- im Uhrzeigersinn geht es von Feld 12 auf Feld 1 der nächsten Seite.
local _, ns = ...
ns = ns or {}

local Spiral = {}
Spiral.SEGMENTS = 12
Spiral.STEP = 360 / Spiral.SEGMENTS

local STEP = Spiral.STEP
local HALF = STEP / 2

function Spiral.Angle(dx, dy)
	local a = math.deg(math.atan2(dx, dy))
	if a < 0 then
		a = a + 360
	end
	return a
end

function Spiral.New(pages, deadzone)
	return { pages = math.max(pages, 1), deadzone = deadzone or 40, page = 1 }
end

function Spiral.Reset(s)
	s.page, s.slot, s.total, s.lastAngle = 1, nil, nil, nil
end

local function normalize(s)
	s.total = (s.total + HALF) % (s.pages * 360) - HALF
	local g = math.floor((s.total + HALF) / STEP)
	s.page = math.floor(g / Spiral.SEGMENTS) + 1
	s.slot = g % Spiral.SEGMENTS + 1
end

function Spiral.Update(s, dx, dy)
	if dx * dx + dy * dy < s.deadzone * s.deadzone then
		s.slot, s.lastAngle = nil, nil
		return
	end
	local a = Spiral.Angle(dx, dy)
	if s.lastAngle then
		local d = a - s.lastAngle
		if d > 180 then
			d = d - 360
		elseif d < -180 then
			d = d + 360
		end
		s.total = s.total + d
	else
		-- (Wieder-)Eintritt aus der Totzone: direkt zeigen, Seite beibehalten
		s.total = (s.page - 1) * 360 + (a >= 360 - HALF and a - 360 or a)
	end
	s.lastAngle = a
	normalize(s)
end

function Spiral.Turn(s, dir)
	s.page = (s.page - 1 + dir) % s.pages + 1
	if s.lastAngle then
		s.total = s.total + dir * 360
		normalize(s)
	end
end

ns.Spiral = Spiral
return Spiral
