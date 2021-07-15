Scriptname BaboAliasWIChangeLocationScript extends ReferenceAlias  


LocationAlias Property NewLocationRef  Auto  
Bool Property StopQuestOnLocationChange = false auto
{Default: false; If the player changes location, should this quest stop?}
Bool Property StageChangeOnLocationChange = false auto
Bool Property StopQuestOnLocationTimeChange = false auto
Bool Property StopQuestOnInterior = false auto
int property NextStage Auto
Actor Property PlayerRef Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if StageChangeOnLocationChange
		If !(NewLocationRef.getlocation() == akNewLoc)
			GetOwningQuest().setstage(NextStage)
		EndIf
	EndIf
	if StopQuestOnLocationChange
		If !(NewLocationRef.getlocation() == akNewLoc)
			GetOwningQuest().Stop()
			return
		EndIf
	EndIf
	if StopQuestOnLocationTimeChange
		If !(NewLocationRef.getlocation() == akNewLoc)
			if GetCurrentHourOfDay() > 6 && GetCurrentHourOfDay() < 20
				GetOwningQuest().Stop()
				return
			endif
		EndIf
	EndIf
	if StopQuestOnInterior
		If PlayerRef.isininterior()
			GetOwningQuest().Stop()
			return
		EndIf
	EndIf
EndEvent


float Function GetCurrentHourOfDay() 
 
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
	Return Time
 
EndFunction