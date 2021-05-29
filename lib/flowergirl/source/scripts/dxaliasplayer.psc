Scriptname dxAliasPlayer extends ReferenceAlias  

Actor Property PlayerRef Auto
ReferenceAlias Property LoveInterestRef  Auto 
dxFlowerGirlsMod Property FlowerGirlsMod Auto
dxFlowerGirlsScript Property FlowerGirlsScript Auto
Quest Property RelationshipMarriageFIN Auto
GlobalVariable Property DX_USE_COMFORT  Auto

float Property PlayerLastHadSceneGameTime = 0.0 Auto Hidden
float Property PlayerLastHadSexGametime = 0.0 Auto Hidden

bool bSleepDurationInvalid = True

Event OnPlayerLoadGame()
	FlowerGirlsMod.CheckUpdate()
	RegisterForSleep()
endEvent

Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
	bSleepDurationInvalid = ((afDesiredSleepEndTime - afSleepStartTime) < 0.20) ; Approx less then 5 hours.
endEvent

Event OnSleepStop(Bool abInterrupted)
	Actor lover = LoveInterestRef.GetActorReference()
	if (abInterrupted || bSleepDurationInvalid || (DX_USE_COMFORT.GetValueInt() != 1) || (lover == NONE))
		return
	endIf
	
	if (RelationshipMarriageFIN.IsRunning() && RelationshipMarriageFIN.GetStage() >= 10)
		if(PlayerRef.GetCurrentLocation() == lover.GetCurrentLocation())
			Debug.Trace(Self + "OnSleepStop(): Lover's comfort sex scene initiated")
			FlowerGirlsScript.RandomScene(PlayerRef, lover)
		else
			Debug.Trace(Self + "OnSleepStop(): Eligible for Lover's Comfort but spouse is not nearby")
		endIf
	else
		Debug.Trace(Self + "OnSleepStop(): Not eligible for Lover's Comfort")
	endIf
endEvent

Actor Function GetLover()
	
	Actor lover = LoveInterestRef.GetActorReference()
	if (lover == NONE)
	
	else
		if (PlayerRef.GetCurrentLocation() == lover.GetCurrentLocation())
		
		else
		
		endIf
		
	endIf
	
endFunction