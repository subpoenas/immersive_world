Scriptname BaboAllureGlobalTrigger extends Quest  
{This will trigger and adjust the value of globals}

GlobalVariable Property AllurePoints Auto
GlobalVariable Property AllureAddSmall Auto
GlobalVariable Property AllureAddBig Auto
GlobalVariable Property AllureTrigger01 Auto
BaboXmarkerMover Property BaboXmarkerMoverScript Auto

Function AfterbarteringScene(int i)
	BaboXmarkerMoverScript.SelfCommentaryEndofEvents(i)
EndFunction

Function AllureAddSmallValue()
	Actor Player = Game.GetPlayer()
		int AdjPoints = Utility.RandomInt(-10,10)
		AllurePoints.SetValue(AllurePoints.GetValue() + AllureAddSmall.GetValue() + AdjPoints)
		;debug.messagebox ("AllureAddSmallValue added")
EndFunction

Function AllureAddBigValue()
		int AdjPoints = Utility.RandomInt(-10,10)
		AllurePoints.SetValue(AllurePoints.GetValue() + AllureAddBig.GetValue() + AdjPoints)
		;debug.messagebox ("AllureAddBigValue added")
EndFunction

Function AllureSubtractValue()
		AllurePoints.SetValue(AllurePoints.GetValue() - AllureAddSmall.GetValue())
		;debug.messagebox ("AllureSubtractValue subtracted")
EndFunction

Function AllureReturntoBasicValue()
		AllurePoints.SetValue(AllurePoints.GetValue() - AllureTrigger01.GetValue())
EndFunction