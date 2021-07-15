scriptname sslBaseVoice extends sslBaseObject

; import MfgConsoleFunc ; OLDRIM
; TODO: switch back to mfgconsolefunc: https://www.nexusmods.com/skyrimspecialedition/mods/11669?tab=description
;  - NVM, not updated for current SKSE64, and buggy accoring to comments.
;  - Maybe https://www.nexusmods.com/skyrimspecialedition/mods/12919

Sound property Lead auto
Sound property Mild auto
Sound property Medium auto
Sound property Wild auto
Sound property Hot auto
Sound property Orgasm auto

Topic property LipSync auto hidden

string[] property RaceKeys auto hidden

int property Gender auto hidden
bool property Male hidden
	bool function get()
		return (Gender == 0 || Gender == -1)
	endFunction
endProperty
bool property Female hidden
	bool function get()
		return (Gender == 1 || Gender == -1)
	endFunction
endProperty
bool property Creature hidden
	bool function get()
		return RaceKeys && RaceKeys.Length > 0
	endFunction
endProperty

function PlayMoan(Actor ActorRef, int Strength = 30, bool UseLipSync = false, float volume = 1.0)
	Sound SoundRef = GetSound(Strength)	
	
	if SoundRef
		if SoundRef == Hot || SoundRef == Orgasm
			volume += 0.1
		endif

		if !UseLipSync
			Sound.SetInstanceVolume(SoundRef.Play(ActorRef), volume)	; modified by alton
			; Utility.WaitMenuMode(0.4)
		else
			float SavedP = sslBaseExpression.GetPhoneme(ActorRef, 1)			
			ActorRef.SetExpressionPhoneme(1, 0.2)
			; Utility.WaitMenuMode(0.1)			

			Sound.SetInstanceVolume(SoundRef.Play(ActorRef), volume)	; modified by alton
			ActorRef.SetExpressionPhoneme(1, Saved as float) ; SKYRIM SE
		endIf
	endIf
endFunction

function Moan(Actor ActorRef, int Strength = 30, bool IsVictim = false, float volume = 0.5)
	PlayMoan(ActorRef, Strength, Config.UseLipSync, volume)
endFunction

Sound function GetSound(int Strength)
	if Strength <= 15
		return Lead
	elseif Strength <= 30
		return Mild
	elseIf Strength <= 60
		return Medium
	elseIf Strength <= 80
		return Wild
	elseIf Strength <= 100
		return Hot
	else
		return Mild
	endIf
endFunction

Sound function GetOrgasmSound()
	return Orgasm
endFunction

bool function CheckGender(int CheckGender)
	return Gender == CheckGender || (Gender == -1 && (CheckGender == 1 || CheckGender == 0)) || (CheckGender >= 2 && Gender >= 2)
endFunction

function SetRaceKeys(string RaceList)
	string[] KeyList = PapyrusUtil.StringSplit(RaceList)
	int i = KeyList.Length
	while i
		i -= 1
		if KeyList[i]
			AddRaceKey(KeyList[i])
		endIf
	endWhile
endFunction
function AddRaceKey(string RaceKey)
	if !RaceKey
		; Do nothing
	elseIf !RaceKeys || !RaceKeys.Length
		RaceKeys = new string[1]
		RaceKeys[0] = RaceKey
	elseIf RaceKeys.Find(RaceKey) == -1
		RaceKeys = PapyrusUtil.PushString(RaceKeys, RaceKey)
	endIf
endFunction
bool function HasRaceKey(string RaceKey)
	return RaceKey && RaceKeys && RaceKeys.Find(RaceKey) != -1
endFunction
bool function HasRaceKeyMatch(string[] RaceList)
	if RaceList && RaceKeys
		int i = RaceList.Length
		while i
			i -= 1
			if RaceKeys.Find(RaceList[i]) != -1
				return true
			endIf
		endWhile
	endIf
	return false
endFunction

function Save(int id = -1)
	AddTagConditional("Male",   (Gender == 0 || Gender == -1))
	AddTagConditional("Female", (Gender == 1 || Gender == -1))
	AddTagConditional("Creature", (Gender == 2 || Gender == 3))
	Log(Name, "Voices["+id+"]")
	parent.Save(id)
endFunction

function Initialize()
	Gender  = -1
	Mild    = none
	Medium  = none
	Hot     = none
	Orgasm  = none
	RaceKeys = Utility.CreateStringArray(0)
	parent.Initialize()
	LipSync = Config.LipSync
endFunction

