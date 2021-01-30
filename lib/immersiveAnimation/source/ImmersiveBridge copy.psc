Scriptname ImmersiveBridgeScript extends Quest

Actor Property Player  Auto

int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction

ImmersiveSoundScript 		imsSndQuest =  none
ImmersiveAnimationScript 	imsAniQuest =  none
ImmersiveNakeAlertScript 	imsNakQuest =  none

event OnInit()
	Debug.Notification("ImmersiveBridge Load..")
		
	init()
endEvent

function init()
	if imsSndQuest == none
		imsSndQuest =  	Game.GetFormFromFile(0x0603D374, "AltonImmersiveSound.esp") As ImmersiveSoundScript
		imsAniQuest =  	Game.GetFormFromFile(0x06005900, "AltonImmersiveAnimation.esp") As ImmersiveAnimationScript
		imsNakQuest =  (Game.GetFormFromFile(0x0605180B, "AltonImmersiveAnimation.esp") As ImmersiveNakeAlertScript)
		
		imsSndQuest.init()
		imsAniQuest.init()
		imsNakQuest.init()
	endif
endfunction

Actor function getPlayerActor()
	return Player
endfunction

int function getVoiceTypeIdx(actor _actor) 
	return imsSndQuest.getVoiceTypeIdx(_actor)
endfunction 

Spell function getNakedAlertSpell ()
	return imsNakQuest.getNakedAlertSpell()
endfunction

Spell function getDropItemAlertSpell ()
	return imsNakQuest.getDropItemAlertSpell()
endfunction

Package function getFindArmorPackage ()
	return imsNakQuest.getFindArmorPackage()
endfunction

function setFleeFromTarget(actor _actor) 
	imsNakQuest.setFleeFromTarget(_actor)
endfunction

Package function getFleeFromPackage ()
	return imsNakQuest.getFleeFromPackage()
endfunction

Topic function getNakedTopic()
	return imsNakQuest.getNakedTopic()
endfunction

Topic function getNakedPlayerSelfTopic()
	return imsNakQuest.getNakedPlayerSelfTopic()
endfunction

Topic function getAssualtTopic()
	return imsNakQuest.getAssualtTopic()
endfunction

function registerForInteresingItem (actor _actor, Form _ref) 
	imsNakQuest.registerForInteresingItem(_actor, _ref)
endfunction

bool function checkWornItem(Actor _actor, Armor _armor)
	return imsNakQuest.checkWornItem(_actor, _armor)
endfunction

function doSearchArmorPackage (actor _actor)	
	imsNakQuest.doSearchArmorPackage(_actor)
endFunction

function doFleePackage (actor _actor)	
	imsNakQuest.doFleePackage(_actor)
endFunction

function undoOverridePackages (actor  _actor)	
	imsNakQuest.undoOverridePackages(_actor)
endfunction 

function handleArmorBreak (actor _victim, actor _aggressor, weapon _weapon, bool _abHitPower, bool _abHitBlocked, int _actorVoiceType)
	imsNakQuest.handleArmorBreak(_victim, _aggressor, _weapon, _abHitPower, _abHitBlocked, _actorVoiceType)
endfunction

function doUnconscious(actor _actor,float _sleep)
	_actor.SetUnconscious(true)
	_actor.dropObject(_actor.GetEquippedWeapon()) ; alton added
endFunction

function doBackhugEvent (String _mode, actor _victim, actor _aggressor, int _sex) ; Sex 1 = NoSex
	imsAniQuest.doBackhugEvent(_mode, _victim, _aggressor, _sex);
endfunction

function doChokeEvent (String _mode, actor _victim, actor _aggressor, int _sex) ; Sex 1 = NoSex		
	imsAniQuest.doChokeEvent(_mode, _victim, _aggressor, _sex);
endfunction

function playUnconsciousAnimation(ACtor _actor, int step)
	imsAniQuest.playUnconsciousAnimation(_actor, step)
endfunction

function playDefaultAnimation(Actor _actor)
	imsAniQuest.playDefaultAnimation(_actor)
endFunction

function playNakeCoverAnimation(Actor _actor)
	imsAniQuest.playNakeCoverAnimation(_actor)
endFunction

function playKnockbackAnimation(Actor _actor)
	imsAniQuest.playKnockbackAnimation(_actor)
endFunction

function playHideFaceAnimation(Actor _actor)
	imsAniQuest.playHideFaceAnimation(_actor)
endFunction

function playDressAnimation(Actor _actor, Armor _armor)
	imsAniQuest.playDressAnimation(_actor, _armor)
endFunction


bool Function isAllHumanAvailable(Actor _actor)
	return imsAniQuest.isAllHumanAvailable(_actor)
EndFunction 

bool Function isOnlyNpcHumanAvailable(Actor _actor)
	return imsAniQuest.isOnlyNpcHumanAvailable(_actor)
EndFunction 

bool Function isMeleeWeapon(Weapon _weapon)
	return imsAniQuest.isMeleeWeapon(_weapon)
EndFunction 

bool function isActorFemale(Actor _actor) 
	return imsAniQuest.isActorFemale(_actor)
endfunction

bool function isActorNaked(Actor _actor) 	
	return imsAniQuest.isActorNaked(_actor)
endfunction

bool function isWornArmorHalfNaked(Actor _actor)
	return imsAniQuest.isWornArmorHalfNaked(_actor)
endfunction

Actor function findNearestNpcHuman(actor _actor, float _distance, int _gender = 0)
	return imsAniQuest.findNearestNpcHuman(_actor, _distance, _gender = 0)
endfunction

