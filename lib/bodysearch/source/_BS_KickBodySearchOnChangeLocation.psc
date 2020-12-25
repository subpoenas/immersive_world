Scriptname _BS_KickBodySearchOnChangeLocation extends Quest

_BS_MCM Property MCM Auto
Quest Property _BS_BodySearchQuest Auto
Quest Property _BS_KickBodySearchQuest Auto
GlobalVariable Property _BS_NextAllowed Auto

Event OnStoryChangeLocation(ObjectReference akActor, Location akOldLocation, Location akNewLocation) 
	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] _BS_KickBodySearchOnChangeLocation start")
	endif

	_BS_BodySearchQuest.Stop()

	int i = 0
	while !_BS_BodySearchQuest.IsStopped() && i < 100
		Utility.Wait(0.1)
		i += 1
	endWhile

	float currentTime = Utility.GetCurrentGameTime()
	float nextAllowed = _BS_NextAllowed.GetValue()
	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] _BS_KickBodySearchOnChangeLocation: currentTime=" + currentTime + ": nextAllowed=" + nextAllowed)
	endif
	if currentTime > nextAllowed
		_BS_BodySearchQuest.Start()
		_BS_KickBodySearchQuest.RegisterForSingleUpdate(MCM.KickInterval)
	endif

	Stop()
EndEvent

