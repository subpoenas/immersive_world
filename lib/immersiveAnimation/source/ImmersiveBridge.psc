Scriptname ImmersiveBridge extends Quest

Actor Property Player  Auto

int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction

ImmersiveBreakArmor 		imsBreakArmorQuest =  none

event OnInit()
	Debug.Notification("ImmersiveBridge Load..")		
	init()
endEvent

function init()
	if imsBreakArmorQuest == none
		imsBreakArmorQuest =  	Game.GetFormFromFile(0x06005900, "AlstonImmersiveArmorBreak.esp") As ImmersiveBreakArmor
	endif
endfunction

function handleArmorBreak (actor _victim, actor _aggressor, weapon _weapon, bool _abHitPower, bool _abHitBlocked)
	imsBreakArmorQuest.handleArmorBreak(_victim, _aggressor, _weapon, _abHitPower, _abHitBlocked)
endfunction

bool function isActorFemale(Actor _actor) 
	if _actor.GetActorBase().GetSex() == 1
		return true
	else 
		return false
	endif
endfunction

bool function isActorNaked(Actor _actor) 	
	if !_actor.GetWornForm(0x00000004)
		return true
	else 
		return false
	endif 
endfunction

bool function isWornHalfNakedArmor(Actor _actor)
	Armor _armor =_actor.GetWornForm(0x00000004) as Armor 

	if _armor != none && (_armor.HasKeyWordString("SLA_ArmorTransparent") || _armor.HasKeyWordString("SLA_ArmorCurtain") || _armor.HasKeyWordString("SLA_ArmorHalfNaked") || _armor.HasKeyWordString("SLA_ArmorHalfNakedBikini") ||  _armor.HasKeyWordString("SLA_PastiesNipple"))
		return true
	else 
		return false
	endif 
endfunction

