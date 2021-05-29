Scriptname dxFlowerGirlsSoundFX extends Quest

Sound[] Property OralFemaleSFX  Auto
Sound[] Property OralMaleSFX Auto
Sound Property PenisIntoVaginaSFX Auto
Sound[] Property MasturbationFemaleSFX Auto
Sound[] Property MasturbationMaleSFX Auto
Sound[] Property SoundFX Auto

ObjectReference _sourceRef;
Sound _loopSound;

int _soundID = 0
float _interval = 1.0

Function PlaySoundFX(ObjectReference o, int stage = 0)
	int len = SoundFX.Length
	if (len > 0)		
		if (stage < len)
			if (SoundFX[stage] != NONE)
				if (_soundID > 0)
					Sound.StopInstance(_soundID)
				endIf
				_soundID = SoundFX[stage].Play(o)
			endIf
		endIf		
	endIf	
endFunction

Function PlayOralSFX(ObjectReference o, int gender, int stage = 0)
	if (gender > 0)
		PlayFlowerGirlsSFX(OralFemaleSFX, o, stage)
	else
	
	endIf
endFunction

Function PlayPenisIntoVaginaSFX(ObjectReference o, float speed)
	;StopSFX()
	if (speed > 0.1)
		_sourceRef = o
		_interval = speed
		RegisterForSingleUpdate(_interval)
		GotoState("PivState")
	endIf
endFunction

Function PlayVaginalSFX(ObjectReference o, int stage = 0)
	;PlayFlowerGirlsSFX(VaginalSFX, o, stage)
endFunction

Function PlayMasturbationSFX(ObjectReference o, int gender, int stage = 0)
	if (gender > 0)
		PlayFlowerGirlsSFX(MasturbationFemaleSFX, o, stage)
	else
		PlayFlowerGirlsSFX(MasturbationMaleSFX, o, stage)
	endIf
endFunction

Function PlayFlowerGirlsSFX(Sound[] sfx, ObjectReference o, int stage = 0)

	if (_soundID > 0)
		Sound.StopInstance(_soundID)
	endIf
	
	if (stage >= 1)
		_soundID = sfx[stage - 1].Play(o)		
	else
		_soundID = 0
		return
	endIf	
endFunction

Function StopSFX()
	if (_soundID > 0)
		Sound.StopInstance(_soundID)
	endIf
	_soundID = 0
	UnregisterForUpdate()
endFunction

;--------------------------------------------------------
; Plays repeating sound effects.
;--------------------------------------------------------
State PivState
	Event OnUpdate()
		if (PenisIntoVaginaSFX.PlayAndWait(_sourceRef))
			Debug.Trace(Self + " OnUpdate(): Playing")
		else
			Debug.Trace(Self + " OnUpdate(): Failed To Play!")
		endIf
		RegisterForSingleUpdate(_interval)
	endEvent
EndState

Event OnInit()
	UnregisterForUpdate()
endEvent