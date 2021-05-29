Scriptname dxThreadManager extends Quest

dxSceneThread[] Property SceneThreads  Auto  
dxOsaSceneThread Property OsaSceneThread Auto

int _maxThreads = 5
int Property MaxThreads Hidden
	int Function Get()
		return _maxThreads
	endFunction
endProperty

bool Property ThreadAvailable Hidden
	bool Function Get()
		return (MaxThreads > ActiveThreadCount())
	endFunction
endProperty

dxSceneThread Function GetNextAvailableThread()
	dxSceneThread thread = NONE
	int i = 0
	while (i < MaxThreads && thread == NONE)
		if (SceneThreads[i].IsRunning() == False)
			thread = SceneThreads[i]
			thread.Start()
			Utility.Wait(0.2)
			Debug.Trace(Self + ": Returning thread at index " + i + ": " + thread) 
		endIf
		i += 1
	endWhile
	return thread
endFunction

int Function ActiveThreadCount()
	int iThreads = 0
	int i = 0
	while (i < MaxThreads)
		if (SceneThreads[i].IsRunning() == False)
			iThreads += 1
		endIf
		i += 1
	endWhile
	return iThreads
endFunction

dxOsaSceneThread Function GetOsaSceneThread()
	dxOsaSceneThread thread = None
	if (OsaSceneThread.IsRunning() == False)
		thread = OsaSceneThread
		thread.Start()
		Utility.Wait(0.2)
		Debug.Trace(Self + ": Returning OsaSceneThread.")
	endIf
	return thread
endFunction

;--------------------------------------------------------------------------------------------------
; GetActiveThreadForActor(): Locates the active thread containing the passed in 
; actor reference. Returns NONE if the reference is not located.
;--------------------------------------------------------------------------------------------------
dxSceneThread Function GetActiveThreadForActor(ObjectReference actorRef)
	dxSceneThread thread = NONE
	int i = 0
	while (i < MaxThreads && thread == NONE)
		if (SceneThreads[i].IsRunning())
			int c = 0
			while (c < SceneThreads[i].Participants.Length && thread == NONE)
				if (SceneThreads[i].Participants[c].GetReference() == actorRef)
					thread = SceneThreads[i]
				endIf
				c += 1
			endWhile			
		endIf
		i += 1
	endWhile
	return thread
endFunction

Function ClearThreads()
	int i = 0
	while (i < MaxThreads)
		if (SceneThreads[i].IsRunning() == True)
			SceneThreads[i].Stop()
			Utility.Wait(0.2)
			Debug.Trace(Self + ": Stopped thread at index: " + i) 
		endIf
		i += 1
	endWhile
	if (OsaSceneThread.IsRunning())
		OsaSceneThread.Stop()
		Utility.Wait(0.2)
		Debug.Trace(Self + ": Stopped OsaSceneThread")
	endIf
endFunction

Event OnReset()
	Self.ClearThreads()
endEvent
