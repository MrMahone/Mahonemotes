-- Aufruf aus dem Projektordner: lua5.1 tests/spiral_test.lua
local Spiral = dofile("Spiral.lua")

local failed = 0
local function eq(name, got, want)
	if got ~= want then
		failed = failed + 1
		print(("FAIL %s: erwartet %s, bekommen %s"):format(name, tostring(want), tostring(got)))
	end
end

local function vec(deg, r)
	r = r or 100
	local a = math.rad(deg)
	return math.sin(a) * r, math.cos(a) * r
end

-- Frischer Zustand, zeigt direkt auf einen Winkel
local function pointAt(deg, pages)
	local s = Spiral.New(pages or 3, 40)
	s.page = 1
	Spiral.Update(s, vec(deg))
	return s
end

-- Feldgrenzen auf Seite 1
eq("0°", pointAt(0).slot, 1)
eq("14.9°", pointAt(14.9).slot, 1)
eq("15°", pointAt(15).slot, 2)
eq("90°", pointAt(90).slot, 4)
eq("164.9°", pointAt(164.9).slot, 6)
eq("165°", pointAt(165).slot, 7)
eq("180°", pointAt(180).slot, 7)
eq("194.9°", pointAt(194.9).slot, 7)
eq("195°", pointAt(195).slot, 8)
eq("270°", pointAt(270).slot, 10)
eq("344.9°", pointAt(344.9).slot, 12)
eq("345°", pointAt(345).slot, 1)
eq("345° Seite", pointAt(345).page, 1)
eq("330° Seite", pointAt(330).page, 1)

-- Spirale: in 10°-Schritten drehen
local function rotate(s, from, to)
	local step = to > from and 10 or -10
	for d = from, to, step do
		Spiral.Update(s, vec(d))
	end
end

local s = pointAt(0)
rotate(s, 0, 340)
eq("vor Umdrehung Seite", s.page, 1)
eq("vor Umdrehung Feld", s.slot, 12)
rotate(s, 340, 370)
eq("nach Umdrehung Seite", s.page, 2)
eq("nach Umdrehung Feld", s.slot, 1)
rotate(s, 370, 340)
eq("zurück Seite", s.page, 1)
eq("zurück Feld", s.slot, 12)

-- Zyklisch: Seite 1 gegen den Uhrzeigersinn → letzte Seite, und zurück
s = pointAt(0)
rotate(s, 0, -30)
eq("zyklisch rückwärts Seite", s.page, 3)
eq("zyklisch rückwärts Feld", s.slot, 12)
rotate(s, -30, 0)
eq("zyklisch vorwärts Seite", s.page, 1)
eq("zyklisch vorwärts Feld", s.slot, 1)

-- Drei volle Umdrehungen bei drei Seiten → wieder Seite 1
s = pointAt(0)
rotate(s, 0, 3 * 360)
eq("3 Umdrehungen Seite", s.page, 1)

-- Totzone: kein Feld, Seite bleibt; Wiedereintritt zeigt direkt
s = pointAt(0)
rotate(s, 0, 370)
Spiral.Update(s, 5, 5)
eq("Totzone Feld", s.slot, nil)
eq("Totzone Seite", s.page, 2)
Spiral.Update(s, vec(180))
eq("Wiedereintritt Seite", s.page, 2)
eq("Wiedereintritt Feld", s.slot, 7)

-- Mausrad
s = pointAt(90)
Spiral.Turn(s, 1)
eq("Rad vor Seite", s.page, 2)
eq("Rad vor Feld", s.slot, 4)
Spiral.Turn(s, -2)
eq("Rad zurück zyklisch", s.page, 3)
Spiral.Update(s, 0, 0)
Spiral.Turn(s, 1)
eq("Rad in Totzone Seite", s.page, 1)
eq("Rad in Totzone Feld", s.slot, nil)

-- Eine Seite
s = pointAt(0, 1)
rotate(s, 0, 400)
eq("eine Seite", s.page, 1)
eq("eine Seite Feld", s.slot, 2)

if failed > 0 then
	print(failed .. " Test(s) fehlgeschlagen")
	os.exit(1)
end
print("Alle Spiral-Tests bestanden")
