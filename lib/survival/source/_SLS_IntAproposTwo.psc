Scriptname _SLS_IntAproposTwo Hidden 

Function HealAllHoles(ReferenceAlias PlayerAlias, Actor akTarget, Int HealAmount) Global
	Apropos2ActorAlias AproposScript = PlayerAlias as Apropos2ActorAlias
	If AproposScript.ActorRef == akTarget
		Debug.Trace("_SLS_: Applying apropos W&T healing of " + HealAmount)
		AproposScript.ApplyReducedVaginalWearAndTearAmount(HealAmount)
		AproposScript.ApplyReducedAnalWearAndTearAmount(HealAmount)
		AproposScript.ApplyReducedOralWearAndTearAmount(HealAmount)

		AproposScript.ApplyReducedVaginalAbuseWearAndTearAmount(HealAmount)
		AproposScript.ApplyReducedAnalAbuseWearAndTearAmount(HealAmount)
		AproposScript.ApplyReducedOralAbuseWearAndTearAmount(HealAmount)
		AproposScript.ApplyEffectsAndTextures(increasingAbuse=False)
		
	Else
		Debug.Trace("_SLS_: _MA_Apropos - ActorRef != akTarget")
	EndIf
EndFunction

Bool Function ConsumablesIncreaseArousal(ReferenceAlias AproposTwoAlias) Global
	Return (AproposTwoAlias as Apropos2ActorAlias).Config.ConsumablesIncreaseArousal 
EndFunction

Int Function GetWearStateAnal(Actor akTarget, ReferenceAlias AproposAlias) Global
	Return (AproposAlias as Apropos2ActorAlias).AnalWearTearState
EndFunction

Int Function GetWearStateVaginal(Actor akTarget, ReferenceAlias AproposAlias) Global
	Return (AproposAlias as Apropos2ActorAlias).VaginalWearTearState
EndFunction

Int Function GetWearStateOral(Actor akTarget, ReferenceAlias AproposAlias) Global
	Return (AproposAlias as Apropos2ActorAlias).OralWearTearState
EndFunction
