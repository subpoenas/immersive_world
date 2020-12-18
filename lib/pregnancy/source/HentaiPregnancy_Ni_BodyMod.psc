Scriptname HentaiPregnancy_BodyMod extends Quest

Function SetNodeScale(Actor akActor, string nodeName, float value)
	HentaiPregnancy HentaiP = Quest.GetQuest("HentaiPregnancyQuest") as HentaiPregnancy
	string modName = "SexLabHentaiPregnancy"
	;Debug.Notification(akActor.GetLeveledActorBase().GetName() + " HentaiPregnancy_BodyMod Scaling " + nodeName + " to " + value)
		
	If nodeName == "NPC L Breast"
		SetMorphScale(akActor, "Breasts", value)
		SetMorphScale(akActor, "BreastsSH", value)
		SetMorphScale(akActor, "BreastsSSH", value)
		SetMorphScale(akActor, "BreastGravity", value)
		SetMorphScale(akActor, "NippleAreola", value)
	ElseIf nodeName == "NPC Belly"
		SetMorphScale(akActor, "ChubbyArms", value)
		SetMorphScale(akActor, "ChubbyWaist", value)
		SetMorphScale(akActor, "ChubbyButt", value)
		SetMorphScale(akActor, "ChubbyLegs", value)
		SetMorphScale(akActor, "ButtShape2", value)
		SetMorphScale(akActor, "PregnancyBelly", value)
	EndIf
EndFunction

Function SetMorphScale(Actor akActor, string nodeName, float value)
	string modName = "SexLabHentaiPregnancy"
	HentaiPregnancy HentaiP = Quest.GetQuest("HentaiPregnancyQuest") as HentaiPregnancy
	
	;SE bodyslide notes:
	;BreastsSH changed to BreastsNewSH
	;BreastsSSH doesnt exist in SE
	;BreastGravity changed to BreastGravity2
	;NippleAreola changed to AreolaSize
	;try to scale all nodes for se converted/legacy armors
	
	;NetImmerse-Bodyslide converter
	float bodyslide_value = (value - 1)
	float bodyslide_divider_breast = (HentaiP.config.MaxScaleBreasts - 1)
	float bodyslide_divider_belly = (HentaiP.config.MaxScaleBelly - 1)
	
	if bodyslide_value < 0
		bodyslide_value = 0
	endif
	if bodyslide_divider_breast < 1
		bodyslide_divider_breast = 1
	endif
	if bodyslide_divider_belly < 1
		bodyslide_divider_belly = 1
	endif
	
	
	;breast scale
	If nodeName == "Breasts"
		NiOverride.SetBodyMorph(akActor, "Breasts", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.Breasts)
	ElseIf nodeName == "BreastsSH"
		NiOverride.SetBodyMorph(akActor, "BreastsSH", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.BreastsSH)
		NiOverride.SetBodyMorph(akActor, "BreastsNewSH", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.BreastsSH)
	ElseIf nodeName == "BreastsSSH"
		NiOverride.SetBodyMorph(akActor, "BreastsSSH", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.BreastsSSH)
	ElseIf nodeName == "BreastGravity"
		NiOverride.SetBodyMorph(akActor, "BreastGravity", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.BreastGravity)
		NiOverride.SetBodyMorph(akActor, "BreastGravity2", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.BreastGravity)
	ElseIf nodeName == "NippleAreola"
		NiOverride.SetBodyMorph(akActor, "NippleAreola", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.NippleAreola)
		NiOverride.SetBodyMorph(akActor, "AreolaSize", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_breast, 0, 1) * HentaiP.config.NippleAreola)

	;belly scale
	ElseIf nodeName == "ChubbyArms"
		NiOverride.SetBodyMorph(akActor, "ChubbyArms", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.ChubbyArms)
	ElseIf nodeName == "ChubbyWaist"
		NiOverride.SetBodyMorph(akActor, "ChubbyWaist", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.ChubbyWaist)
	ElseIf nodeName == "ChubbyButt"
		NiOverride.SetBodyMorph(akActor, "ChubbyButt", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.ChubbyButt)
	ElseIf nodeName == "ChubbyLegs"
		NiOverride.SetBodyMorph(akActor, "ChubbyLegs", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.ChubbyLegs)
	ElseIf nodeName == "ButtShape2"
		NiOverride.SetBodyMorph(akActor, "ButtShape2", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.ButtShape2)
	ElseIf nodeName == "PregnancyBelly"
		NiOverride.SetBodyMorph(akActor, "PregnancyBelly", modName, PapyrusUtil.ClampFloat(bodyslide_value / bodyslide_divider_belly, 0, 1) * HentaiP.config.PregnancyBelly)

	;breast(milk) scale
	ElseIf nodeName == "DoubleMelon"
		NiOverride.SetBodyMorph(akActor, "DoubleMelon", modName, PapyrusUtil.ClampFloat((value) / (HentaiP.config.MaxScaleBreasts), 0, 1) * HentaiP.config.DoubleMelon)
	ElseIf nodeName == "BreastsFantasy"
		NiOverride.SetBodyMorph(akActor, "BreastsFantasy", modName, PapyrusUtil.ClampFloat((value) / (HentaiP.config.MaxScaleBreasts), 0, 1) * HentaiP.config.BreastsFantasy)
	ElseIf nodeName == "NipplePerkiness"
		NiOverride.SetBodyMorph(akActor, "NipplePerkiness", modName, PapyrusUtil.ClampFloat((value) / (HentaiP.config.MaxScaleBreasts), 0, 1) * HentaiP.config.NipplePerkiness)
	ElseIf nodeName == "NippleLength"
		NiOverride.SetBodyMorph(akActor, "NippleLength", modName, PapyrusUtil.ClampFloat((value) / (HentaiP.config.MaxScaleBreasts), 0, 1) * HentaiP.config.NippleLength)
	EndIf
	NiOverride.UpdateModelWeight(akActor)
EndFunction

Function ClearMorphScale(Actor akActor, string nodeName)
	string modName = "SexLabHentaiPregnancy"

	If nodeName == "Breasts"
		NiOverride.ClearBodyMorph(akActor, "Breasts", modName)
	ElseIf nodeName == "BreastsSH"
		NiOverride.ClearBodyMorph(akActor, "BreastsNewSH", modName)
		NiOverride.ClearBodyMorph(akActor, "BreastsSH", modName)
	ElseIf nodeName == "BreastsSSH"
		NiOverride.ClearBodyMorph(akActor, "BreastsSSH", modName)
	ElseIf nodeName == "BreastGravity"
		NiOverride.ClearBodyMorph(akActor, "BreastGravity", modName)
		NiOverride.ClearBodyMorph(akActor, "BreastGravity2", modName)
	ElseIf nodeName == "NippleAreola"
		NiOverride.ClearBodyMorph(akActor, "NippleAreola", modName)
		NiOverride.ClearBodyMorph(akActor, "AreolaSize", modName)
		
	ElseIf nodeName == "ChubbyArms"
		NiOverride.ClearBodyMorph(akActor, "ChubbyArms", modName)
	ElseIf nodeName == "ChubbyWaist"
		NiOverride.ClearBodyMorph(akActor, "ChubbyWaist", modName)
	ElseIf nodeName == "ChubbyWaist"
		NiOverride.ClearBodyMorph(akActor, "ChubbyWaist", modName)
	ElseIf nodeName == "ButtShape2"
		NiOverride.ClearBodyMorph(akActor, "ButtShape2", modName)
	ElseIf nodeName == "ChubbyButt"
		NiOverride.ClearBodyMorph(akActor, "ChubbyButt", modName)
	ElseIf nodeName == "ChubbyLegs"
		NiOverride.ClearBodyMorph(akActor, "ChubbyLegs", modName)
	ElseIf nodeName == "PregnancyBelly"
		NiOverride.ClearBodyMorph(akActor, "PregnancyBelly", modName)

	ElseIf nodeName == "DoubleMelon"
		NiOverride.ClearBodyMorph(akActor, "DoubleMelon", modName)
	ElseIf nodeName == "BreastsFantasy"
		NiOverride.ClearBodyMorph(akActor, "BreastsFantasy", modName)
	ElseIf nodeName == "NipplePerkiness"
		NiOverride.ClearBodyMorph(akActor, "NipplePerkiness", modName)
	ElseIf nodeName == "NippleLength"
		NiOverride.ClearBodyMorph(akActor, "NippleLength", modName)
	EndIf
	NiOverride.UpdateModelWeight(akActor)
EndFunction