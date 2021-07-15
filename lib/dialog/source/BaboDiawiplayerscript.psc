Scriptname BaboDiawiplayerscript extends ReferenceAlias  
{Script to attach to Player alias in BaboWI quests}

Bool Property StopQuestOnLocationChange = false auto
{Default: false; If the player changes location, should this quest stop?}

Bool Property StopQuestOnLocationChangeInterior = false auto
{Default: false; If the player changes location and it was interior, should this quest stop?}


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if StopQuestOnLocationChange
		If (NewLocationRef.getlocation() == akNewLoc)
		Else
			GetOwningQuest().Stop()
		EndIf
	EndIf

	if StopQuestOnLocationChangeInterior
		If PlayerRef.isininterior()
			GetOwningQuest().Stop()
		EndIf
	EndIf
EndEvent

LocationAlias Property NewLocationRef  Auto  
Actor Property PlayerRef Auto