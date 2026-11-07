-- Feld 1 = 12 Uhr, dann im Uhrzeigersinn (Feld 4 = 3 Uhr, Feld 7 = 6 Uhr, Feld 10 = 9 Uhr).
-- Gegenüberliegende Felder sind Gegensätze, wo es sich anbietet.
-- Beschriftungen kommen aus Locale.lua (L.EMOTES[token]).
local _, ns = ...

ns.Pages = {
	{ -- Seite 1: Alltag
		"HELLO", "THANK", "CHEER", "YES", "LAUGH", "WAVE",
		"BYE", "APOLOGIZE", "CRY", "NO", "SIGH", "BOW",
	},
	{ -- Seite 2: Spaß
		"DANCE", "FLEX", "ROAR", "APPLAUD", "KISS", "FLIRT",
		"CHICKEN", "JOKE", "ROFL", "SHRUG", "SILLY", "SALUTE",
	},
	{ -- Seite 3: Gruppe
		"CHARGE", "FOLLOW", "INCOMING", "OPENFIRE", "HEALME", "OOM",
		"WAIT", "HELPME", "FLEE", "TRAIN", "ATTACKMYTARGET", "GOODLUCK",
	},
}

for _, page in ipairs(ns.Pages) do
	for i, token in ipairs(page) do
		page[i] = { token = token, label = ns.L.EMOTES[token] or token }
	end
end
