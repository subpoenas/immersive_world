scriptname sslVoiceDefaults extends sslVoiceFactory

function LoadVoices()
	Debug.Notification("sexlab plus voice loading..")
	; Prepare factory resources
	PrepareFactory()
	; Female voices
	RegisterVoice("FemalePlayer")
	RegisterVoice("FemaleYoung")		
	RegisterVoice("MaleYoung")	
endFunction

; player
function FemalePlayer(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Female_Player"
	Base.Gender = Female
	
	Base.Lead   	= Game.GetFormFromFile(0x02000D6A, "Sexlab plus.esp") as Sound
	Base.Mild   	= Game.GetFormFromFile(0x02000D6E, "Sexlab plus.esp") as Sound
	Base.Medium 	= Game.GetFormFromFile(0x02000D6F, "Sexlab plus.esp") as Sound
	Base.Wild   	= Game.GetFormFromFile(0x02001DA2, "Sexlab plus.esp") as Sound
	Base.Hot    	= Game.GetFormFromFile(0x02000D70, "Sexlab plus.esp") as Sound
	Base.Orgasm 	= Game.GetFormFromFile(0x02000D71, "Sexlab plus.esp") as Sound

	Base.SetTags("Female,Player")

	Base.Save(id)
endFunction

; young
function FemaleYoung(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Female_Young"
	Base.Gender = Female

	Base.Lead   	= Game.GetFormFromFile(0x02002315, "Sexlab plus.esp") as Sound
	Base.Mild   	= Game.GetFormFromFile(0x0200231A, "Sexlab plus.esp") as Sound
	Base.Medium 	= Game.GetFormFromFile(0x0200231B, "Sexlab plus.esp") as Sound
	Base.Wild   	= Game.GetFormFromFile(0x02002319, "Sexlab plus.esp") as Sound
	Base.Hot    	= Game.GetFormFromFile(0x0200231C, "Sexlab plus.esp") as Sound
	Base.Orgasm 	= Game.GetFormFromFile(0x0200231D, "Sexlab plus.esp") as Sound

	Base.SetTags("Female,Young")

	Base.Save(id)
endFunction

; young
function MaleYoung(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Male_Young"
	Base.Gender = Male
	
	Base.Lead   	= Game.GetFormFromFile(0x020063D4, "Sexlab plus.esp") as Sound	
	Base.Mild   	= Game.GetFormFromFile(0x020063D4, "Sexlab plus.esp") as Sound
	Base.Medium 	= Game.GetFormFromFile(0x020063D5, "Sexlab plus.esp") as Sound
	Base.Wild   	= Game.GetFormFromFile(0x020063D6, "Sexlab plus.esp") as Sound
	Base.Hot    	= Game.GetFormFromFile(0x020063D7, "Sexlab plus.esp") as Sound
	Base.Orgasm 	= Game.GetFormFromFile(0x020063D8, "Sexlab plus.esp") as Sound

	Base.SetTags("Male,Young")

	Base.Save(id)
endFunction


function LoadCreatureVoices()	
endFunction