Scriptname _BS_KickBodySearch extends Quest

_BS_MCM Property MCM Auto
Quest Property _BS_BodySearchQuest Auto
GlobalVariable Property _BS_NextAllowed Auto

Event OnInit()
	if !MCM.Enabled
		Stop()
		return
	endif
	RegisterForSingleUpdate(MCM.KickInterval)
EndEvent

Event OnUpdate()
	float currentTime = Utility.GetCurrentGameTime()
	float nextAllowed = _BS_NextAllowed.GetValue()
	if currentTime > nextAllowed
		if _BS_BodySearchQuest.IsStopped()
			if MCM.DebugOutputEnabled
				Debug.Trace("[BS] _BS_KickBodySearch: currentTime=" + currentTime + ": nextAllowed=" + nextAllowed)
			endif
			_BS_BodySearchQuest.Start()
		endif
	endif
	RegisterForSingleUpdate(MCM.KickInterval)
EndEvent

