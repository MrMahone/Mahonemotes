local _, ns = ...

BINDING_HEADER_MAHONEMOTES = "Mahonemotes"
BINDING_NAME_MAHONEMOTES_WHEEL = "Emote-Rad (halten)"

ns.L = {
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
}
