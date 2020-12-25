Scriptname _BS_AccessHiddenPocket extends ActiveMagicEffect

_BS_MCM Property MCM Auto
Quest Property _BS_CheckIfPlayerDetectedQuest Auto
ObjectReference Property _BS_HiddenPocketChestREF Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if MCM.SelfConscious
		_BS_CheckIFPlayerDetectedQuest.Start()
	else
		_BS_HiddenPocketChestREF.Activate(akCaster)
	endif
EndEvent

