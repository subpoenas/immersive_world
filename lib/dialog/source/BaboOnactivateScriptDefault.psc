Scriptname BaboOnactivateScriptDefault extends referencealias

Event OnActivate(ObjectReference Victim)
	If Victim == Game.getplayer()
	If MQuest.getstage() == CurrentStage
		Debug.Notification(Victim + "retrieved her belongings")
		MQuest.setstage(NextStage)
	EndIf
	EndIf
EndEvent

Quest Property MQuest Auto
Int Property CurrentStage Auto
Int Property NextStage Auto