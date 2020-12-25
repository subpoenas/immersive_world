Scriptname _BS_FillAliasScript extends activemagiceffect

_BS_MCM Property MCM Auto
_BS_BodySearch Property _BS_BodySearchQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float r = Utility.RandomFloat(0.0, 100.0)
	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] FillAlias akTarget=" + akTarget + ": r=" + r + ": ForcegreetChance=" + MCM.ForcegreetChance)
	endif
	if r <= MCM.ForcegreetChance
		_BS_BodySearchQuest.FillAlias(akTarget)
	endif
EndEvent
