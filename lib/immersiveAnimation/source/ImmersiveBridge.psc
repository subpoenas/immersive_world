Scriptname ImmersiveBridge extends Quest

Actor Property Player  Auto

int Version
int Function VersionCheck()
	Version = 2
	Return Version
EndFunction

ImmersiveBreakArmor 		imsBreakArmorQuest =  none

event OnInit()
	Debug.Notification("ImmersiveBridge Load..")		
	init()
endEvent

function init()
	if imsBreakArmorQuest == none
		imsBreakArmorQuest =  	Game.GetFormFromFile(0x05005900, "AltonArmorBreak.esp") As ImmersiveBreakArmor
	endif
endfunction

bool function handleWeaponDrop (actor _victim, actor _aggressor, weapon _weapon)
	return imsBreakArmorQuest.handleWeaponDrop(_victim, _aggressor, _weapon)
endfunction

bool function handleClothWorn (actor _victim, actor _aggressor, weapon _weapon)
	return imsBreakArmorQuest.handleClothWorn(_victim, _aggressor, _weapon)
endfunction

float function handleArmorBroken (actor _victim, actor _aggressor, weapon _weapon, float _armordurability)
	return imsBreakArmorQuest.handleArmorBroken(_victim, _aggressor, _weapon, _armordurability)
endfunction

bool function isActorFemale(Actor _actor) 
	return imsBreakArmorQuest.isActorFemale(_actor)
endfunction

bool function isWornHalfNaked(Actor _actor) 	
	return imsBreakArmorQuest.isWornHalfNaked(_actor)
endfunction

bool function isWornHalfNakedArmor(Actor _actor)
	return imsBreakArmorQuest.isWornHalfNakedArmor(_actor)
endfunction

function nakedCoverAnimation(Actor _actor) 	
	return imsBreakArmorQuest.nakedCoverAnimation(_actor)
endfunction

function bleedoutStartAnimation(Actor _actor) 	
	return imsBreakArmorQuest.bleedoutStartAnimation(_actor)
endfunction

function bleedoutEndAnimation(Actor _actor) 	
	return imsBreakArmorQuest.bleedoutEndAnimation(_actor)
endfunction

function defaultAnimation(Actor _actor) 	
	return imsBreakArmorQuest.defaultAnimation(_actor)
endfunction

