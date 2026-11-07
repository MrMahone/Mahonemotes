-- Feld 1 = 12 Uhr, dann im Uhrzeigersinn (Feld 4 = 3 Uhr, Feld 7 = 6 Uhr, Feld 10 = 9 Uhr).
-- Gegenüberliegende Felder sind Gegensätze, wo es sich anbietet.
local _, ns = ...

ns.Pages = {
	{ -- Seite 1: Alltag
		{ token = "HELLO", label = "Hallo" },
		{ token = "THANK", label = "Danke" },
		{ token = "CHEER", label = "Jubeln" },
		{ token = "YES", label = "Ja" },
		{ token = "LAUGH", label = "Lachen" },
		{ token = "WAVE", label = "Winken" },
		{ token = "BYE", label = "Tschüss" },
		{ token = "APOLOGIZE", label = "Sorry" },
		{ token = "CRY", label = "Weinen" },
		{ token = "NO", label = "Nein" },
		{ token = "SIGH", label = "Seufzen" },
		{ token = "BOW", label = "Verbeugen" },
	},
	{ -- Seite 2: Spaß
		{ token = "DANCE", label = "Tanzen" },
		{ token = "FLEX", label = "Muskeln" },
		{ token = "ROAR", label = "Brüllen" },
		{ token = "APPLAUD", label = "Applaus" },
		{ token = "KISS", label = "Kuss" },
		{ token = "FLIRT", label = "Flirten" },
		{ token = "CHICKEN", label = "Huhn" },
		{ token = "JOKE", label = "Witz" },
		{ token = "ROFL", label = "ROFL" },
		{ token = "SHRUG", label = "Schulterzucken" },
		{ token = "SILLY", label = "Albern" },
		{ token = "SALUTE", label = "Salutieren" },
	},
	{ -- Seite 3: Gruppe
		{ token = "CHARGE", label = "Angriff!" },
		{ token = "FOLLOW", label = "Folgt mir" },
		{ token = "INCOMING", label = "Achtung" },
		{ token = "OPENFIRE", label = "Feuer frei" },
		{ token = "HEALME", label = "Heilung!" },
		{ token = "OOM", label = "Kein Mana" },
		{ token = "WAIT", label = "Warten" },
		{ token = "HELPME", label = "Hilfe!" },
		{ token = "FLEE", label = "Rückzug" },
		{ token = "TRAIN", label = "Zug" },
		{ token = "ATTACKMYTARGET", label = "Mein Ziel" },
		{ token = "GOODLUCK", label = "Viel Glück" },
	},
}
