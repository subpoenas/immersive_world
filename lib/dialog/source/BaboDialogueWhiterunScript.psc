Scriptname BaboDialogueWhiterunScript extends Quest  


Int Function DeathCount()
	DeathCountNum = DeathCountNum + 1
	Debug.Trace(DeathCountNum + " + 1")
		If DeathCountNum >= DeathCountGoalNum
			BaboDialogueWhiterun.setstage(52)
		EndIf
	Return DeathCountNum
EndFunction

Int Function FaintCount()
	FaintCountNum = FaintCountNum + 1
	Debug.Trace(FaintCountNum + " + 1")
		If FaintCountNum >= FaintCountGoalNum
			BaboDialogueWhiterun.setstage(52)
		EndIf
	Return FaintCountNum
EndFunction

Function WVAS01()
	BaboDialogueWhiterunSceneVC01.forcestart()
EndFunction

Function Message(int num)
	(BaboSexController as BaboSexControllerManager).WhiterunViceCaptainMessagebox(num)
EndFunction

Function RapeStart(Referencealias Alias01, Referencealias Alias02)
	(BaboSexController as BaboSexControllerManager).SexCustom(Alias01, Alias02, None, None, None, "MF", "Aggressive", "rape", True, "WVAS01", "WhiterunViceCaptainAfterSex01", true)
EndFunction


Quest Property BaboSexController Auto
Quest Property BaboDialogueWhiterun Auto
Int property DeathCountNum = 0 auto hidden conditional
Int Property DeathCountGoalNum Auto

Int property FaintCountNum = 0 auto hidden conditional
Int Property FaintCountGoalNum Auto
Scene Property BaboDialogueWhiterunSceneVC01 Auto
Scene Property BaboDialogueWhiterunSceneVC03 Auto