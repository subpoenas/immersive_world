Scriptname BaboCharmFactionScript extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
Race TargetRace = akTarget.getrace() 
	BDMScript.CreatureRegister(akTarget, TargetRace)
EndEvent

BaboDiaMonitorScript Property BDMScript Auto