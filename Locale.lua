local _, ns = ...

-- enUS ist Standard, andere Sprachen überschreiben einzelne Einträge
local L = {
	BINDING_WHEEL = "Emote wheel (hold)",
	PAGE = "Page %d/%d",
	EMOTE_FAILED = "Emote %s is not possible here.",
	SIZE_SET = "Radius set to %d.",
	SIZE_RANGE = "Radius must be between 80 and 300.",
	RESET = "Settings reset.",
	CHECK_NOLIST = "No emote list found in the client, cannot check.",
	CHECK_OK = "All emotes are known to the client.",
	CHECK_UNKNOWN = "Page %d, slot %d: %s unknown (may still work).",
	HELP = {
		"Bind a key under Key Bindings → Mahonemotes.",
		"Hold, pick a direction, release. Tap: wheel stays open, click to choose.",
		"Rotate clockwise past 12 o'clock or use the mouse wheel: next page.",
		"/memote size <80-300>  radius",
		"/memote check  verify emote tokens",
		"/memote reset  reset settings",
	},
	EMOTES = {
		HELLO = "Hello", THANK = "Thanks", CHEER = "Cheer", YES = "Yes",
		LAUGH = "Laugh", WAVE = "Wave", BYE = "Bye", APOLOGIZE = "Sorry",
		CRY = "Cry", NO = "No", SIGH = "Sigh", BOW = "Bow",
		DANCE = "Dance", FLEX = "Flex", ROAR = "Roar", APPLAUD = "Applaud",
		KISS = "Kiss", FLIRT = "Flirt", CHICKEN = "Chicken", JOKE = "Joke",
		ROFL = "ROFL", SHRUG = "Shrug", SILLY = "Silly", SALUTE = "Salute",
		CHARGE = "Charge!", FOLLOW = "Follow me", INCOMING = "Incoming", OPENFIRE = "Open fire",
		HEALME = "Heal me!", OOM = "Out of mana", WAIT = "Wait", HELPME = "Help!",
		FLEE = "Flee!", TRAIN = "Train", ATTACKMYTARGET = "My target", GOODLUCK = "Good luck",
	},
}

local locales = {
	deDE = {
		BINDING_WHEEL = "Emote-Rad (halten)",
		PAGE = "Seite %d/%d",
		EMOTE_FAILED = "Emote %s ist hier nicht möglich.",
		SIZE_SET = "Radius auf %d gesetzt.",
		SIZE_RANGE = "Radius muss zwischen 80 und 300 liegen.",
		RESET = "Einstellungen zurückgesetzt.",
		CHECK_NOLIST = "Keine Emote-Liste im Client gefunden, Prüfung nicht möglich.",
		CHECK_OK = "Alle Emotes sind im Client bekannt.",
		CHECK_UNKNOWN = "Seite %d, Feld %d: %s unbekannt (kann trotzdem funktionieren).",
		HELP = {
			"Taste unter Tastenbelegung → Mahonemotes belegen.",
			"Halten, Richtung wählen, loslassen. Kurz tippen: Rad bleibt offen, Klick wählt.",
			"Im Uhrzeigersinn über 12 Uhr drehen oder Mausrad: nächste Seite.",
			"/memote size <80-300>  Radius",
			"/memote check  Emote-Namen prüfen",
			"/memote reset  Einstellungen zurücksetzen",
		},
		EMOTES = {
			HELLO = "Hallo", THANK = "Danke", CHEER = "Jubeln", YES = "Ja",
			LAUGH = "Lachen", WAVE = "Winken", BYE = "Tschüss", APOLOGIZE = "Sorry",
			CRY = "Weinen", NO = "Nein", SIGH = "Seufzen", BOW = "Verbeugen",
			DANCE = "Tanzen", FLEX = "Muskeln", ROAR = "Brüllen", APPLAUD = "Applaus",
			KISS = "Kuss", FLIRT = "Flirten", CHICKEN = "Huhn", JOKE = "Witz",
			ROFL = "ROFL", SHRUG = "Schulterzucken", SILLY = "Albern", SALUTE = "Salutieren",
			CHARGE = "Angriff!", FOLLOW = "Folgt mir", INCOMING = "Achtung", OPENFIRE = "Feuer frei",
			HEALME = "Heilung!", OOM = "Kein Mana", WAIT = "Warten", HELPME = "Hilfe!",
			FLEE = "Rückzug", TRAIN = "Zug", ATTACKMYTARGET = "Mein Ziel", GOODLUCK = "Viel Glück",
		},
	},
}

local override = locales[GetLocale()]
if override then
	for k, v in pairs(override) do
		L[k] = v
	end
end

BINDING_HEADER_MAHONEMOTES = "Mahonemotes"
BINDING_NAME_MAHONEMOTES_WHEEL = L.BINDING_WHEEL

ns.L = L
