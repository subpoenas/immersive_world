Scriptname ImmersiveAnimationScript extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto

SexLabFramework property SexLab auto

Keyword[] SLHHScriptEventKeywords = none

ImmersiveSoundScript imsSndQuest = None

int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction

event OnInit()
	Debug.Notification("ImmersiveAnimation Load..")
		
	init()
endEvent

function init()
	if imsSndQuest == none		
		If Game.GetModByName("SexLabHorribleHarassment.esp") != 255
			SLHHScriptEventKeywords =  new Keyword[3]
			SLHHScriptEventKeywords[0] = Game.GetFormFromFile(0x00C510, "SexLabHorribleHarassment.esp") as Keyword	; backhug
			SLHHScriptEventKeywords[1] = Game.GetFormFromFile(0x0233C6, "SexLabHorribleHarassment.esp") as Keyword	; choke
			SLHHScriptEventKeywords[2] = Game.GetFormFromFile(0x02495B, "SexLabHorribleHarassment.esp") as Keyword 	; drunk
		endif
		
		If Game.GetModByName("ZaZAnimationPack.esm") != 255
		endif	

		imsSndQuest =  (Game.GetFormFromFile(0x0603D374, "AltonImmersiveSound.esp") As ImmersiveSoundScript)
	endif
endfunction

function doBackhugEvent (String _mode, actor _victim, actor _aggressor, int _sex) ; Sex 1 = NoSex
	Debug.Notification("doBackhugEvent")
		
	if SLHHScriptEventKeywords
		if _mode == "backchoke"
			SLHHScriptEventKeywords[1].SendStoryEvent(None, _victim, _aggressor)
		elseif _mode == "drunk"
			SLHHScriptEventKeywords[2].SendStoryEvent(None, _victim, _aggressor, _sex, 0)
		else  ; backhug
			SLHHScriptEventKeywords[0].SendStoryEvent(None, _victim, _aggressor)	
		endif
	endif
endfunction

function doChokeEvent (String _mode, actor _victim, actor _aggressor, int _sex) ; Sex 1 = NoSex
	Debug.Notification("doChokeEvent")	
	if SLHHScriptEventKeywords && _victim != player
		_aggressor.moveTo(_victim)
		_victim.KeepOffsetFromActor(_aggressor, 0.0, 0.0, 20.0)
		_aggressor.SetLookAt(_victim)

		Debug.SendAnimationEvent(_victim, "SLHH_Drunk_SBD_A01Start")
		Debug.SendAnimationEvent(_aggressor, "SLHH_Drunk_SBD_A02Start")
	endif
endfunction

Actor function getPlayerActor()
	return Player
endfunction 

function playUnconsciousAnimation(ACtor _actor, int step)
	if _actor.IsUnconscious() && !_actor.isDead() && !_actor.IsBleedingOut()
		if step == 0
			Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_Start")
		elseif step == 1
			Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_End")
		else
			Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_Exit")
			wait(1.0)
			Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
		endif
	endif
endfunction

function playDefaultAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
endFunction

function playNakeCoverAnimation(Actor _actor)

	if !_actor.isDead() && !_actor.IsUnconscious() && !_actor.IsBleedingOut()

		int voiceTypeIdx =imsSndQuest.getVoiceTypeIdx(_actor)
		
		if isActorFemale(_actor)

			if voiceTypeIdx == 0
				Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfAll_01")
			elseif voiceTypeIdx < 2
				Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfAll_02")
			elseif voiceTypeIdx < 5
				Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfBra")
			else
				Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfVag")				
			endif
		else 
			Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfVag")	
		endif

		wait(2.0)
		playDefaultAnimation(_actor)
	endif
endFunction

function playKnockbackAnimation(Actor _actor)

	if !_actor.isDead() && !_actor.IsUnconscious() && !_actor.IsBleedingOut()
		Debug.SendAnimationEvent(_actor, "BleedOutStart")
		wait(0.5)
		Debug.SendAnimationEvent(_actor, "BleedOutStop")
	endif
endFunction

function playHideFaceAnimation(Actor _actor)

	if !_actor.isDead() && !_actor.IsUnconscious() && !_actor.IsBleedingOut()
		Debug.SendAnimationEvent(_actor, "Erotic_CowardResponse")
		wait(2.0)
		Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
	endif
endFunction

function playDressAnimation(Actor _actor, Armor _armor)

	if !_actor.isDead() && !_actor.IsUnconscious() && !_actor.IsBleedingOut()
		String gender = "M"
		if _actor.GetActorBase().GetSex() == 1
			gender = "F"
		endif 
		
		bool shouldEquip = false

		if _armor.IsClothingBody() || _armor.IsHeavyArmor() || _armor.IsLightArmor()
			shouldEquip = true	
			if _actor.IsInCombat()
				Debug.SendAnimationEvent(_actor, "Erotic_Dress_Quick")
				wait(1.5)
			else 
				Debug.Notification("dress ClothBody")	

				if  _armor.HasKeyWordString("SLA_ArmorPanty")
					string aniName = "Erotic_DressPants" + gender
					Debug.SendAnimationEvent(_actor, aniName)
					wait(7.0)
				elseif  _armor.HasKeyWordString("SLA_ArmorBra")
					string aniName = "Erotic_DressBra" + gender
					Debug.SendAnimationEvent(_actor, aniName)
					wait(7.0)		
				else
					if _armor.IsCuirass()
						Debug.SendAnimationEvent(_actor, "Erotic_DressCuirass" + gender)
						wait(5.0)
					else
						Debug.SendAnimationEvent(_actor, "Erotic_Dress_Quick")
						wait(1.5)
					endif			
				endif
			endif		
		elseif _armor.IsHelmet() || _armor.IsClothingHead()
			Debug.Notification("dress Helmet")
			Debug.SendAnimationEvent(_actor, "Erotic_DressHelmet" + gender)
			wait(2.5)
			shouldEquip = true
		elseif _armor.IsGauntlets()
			Debug.Notification("dress Gauntlets")
			Debug.SendAnimationEvent(_actor, "Erotic_DressGloves" + gender)
			wait(2.5)
			shouldEquip = true					
		elseif _armor.IsBoots() || _armor.IsClothingFeet()
			Debug.Notification("dress Boot")
			Debug.SendAnimationEvent(_actor, "Erotic_DressBoots" + gender)
			wait(4.5)
			shouldEquip = true					
		endif

		if shouldEquip		
			_actor.EquipItem(_armor)
			Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
		endif 
	endif
endFunction

bool Function isAllHumanAvailable(Actor _actor)
	return _actor.HasKeyWordString("ActorTypeNPC") && !_actor.isDead()
EndFunction 

bool Function isOnlyNpcHumanAvailable(Actor _actor)
	return _actor.HasKeyWordString("ActorTypeNPC") && !_actor.isDead() && _actor != Player
EndFunction 

bool Function isMeleeWeapon(Weapon _weapon)
	return _weapon.IsMace() || _weapon.IsGreatsword() || _weapon.IsWarhammer() || _weapon.IsWarAxe() || _weapon.IsBattleaxe()
EndFunction 

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

bool function isWornArmorHalfNaked(Actor _actor)

	Armor _armor =_actor.GetWornForm(0x00000004) as Armor 

	if _armor != none && (_armor.HasKeyWordString("SLA_ArmorTransparent") || _armor.HasKeyWordString("SLA_ArmorCurtain") || _armor.HasKeyWordString("SLA_ArmorHalfNaked") || _armor.HasKeyWordString("SLA_ArmorHalfNakedBikini") ||  _armor.HasKeyWordString("SLA_PastiesNipple"))
		return true
	else 
		return false
	endif 
endfunction


ObjectReference[] function findNearActors (Actor _actor, float distance = 1000.0)
	; Debug.Notification("Searching for ... actors")

	ObjectReference[] targetRefs = _findAllFormType(_actor, 43, distance) ; NPC

	if _actor.isDead()
		return none
	else
		return targetRefs
	endif

endFunction

ObjectReference function findArmor (Actor _actor, float distance = 1000.0)
	; Debug.Notification("Searching for ... armors")

		ObjectReference targetRef= _findNearestFormType(_actor, 26, distance)

		if _actor.isDead()
			return none
		else
			return targetRef
		endif
endFunction

ObjectReference function findCloth (Actor _actor, float distance = 1000.0)
	; Debug.Notification("Searching for ... clothes")

		ObjectReference targetRef = _findNearestFormType(_actor, 124, distance)

		if _actor.isDead()
			return none
		else
			return targetRef
		endif
endFunction


Form[] function findDeadBodies(Actor _actor)
	; Debug.Notification("Searching for ... dead body")

	Form [] actorArmor = _findNearestDeadNpcHumanBody(_actor, 1000.0)

	if _actor.isDead()
		return none
	elseif actorArmor[0]		
		return actorArmor	
	endif

	return none
endFunction

Actor function findNearestNpcHuman(actor _actor, float _distance, int _gender = 0) ; 0 is male, 1 is female

	ObjectReference[] _refs = FindAllReferencesOfFormType(_actor, 43, _distance)  ; 43 npc

	; find nearest dead body
	float shortDistance = 10000.0
	Actor targetActor = None
	int _i = 0

	while (_i < _refs.length)
		if _actor.isDead()
			return None
		endif	

		Actor _nearActor = _refs[_i] as Actor		 
		if !_nearActor.IsDead()	&& player != _nearActor && _nearActor.HasKeyWordString("ActorTypeNPC") && _nearActor.GetActorBase().GetSex() == _gender
			float refDistance = _actor.getDistance(_nearActor)
			if refDistance < shortDistance
				targetActor = _nearActor
				shortDistance = refDistance
			endif
		endif
		 _i += 1
	EndWhile 
	return targetActor
endfunction

Form[] function _findNearestDeadNpcHumanBody(actor _actor, float _distance) 

	ObjectReference[] _refs = FindAllReferencesOfFormType(_actor, 43, _distance)  ; 43 npc

	; find nearest dead body
	float shortDistance = 10000.0
	Form [] actorArmor = new Form[2]
	int _i = 0
	
	while (_i < _refs.length)

		if _actor.isDead()
			return actorArmor
		endif

		Actor _nearActor = _refs[_i] as Actor		 
		Armor _nearArmor = _nearActor.GetWornForm(0x00000004) as Armor
		if _nearActor.IsDead()	&& player != _nearActor && _nearArmor
			float refDistance = _actor.getDistance(_nearActor)
			if refDistance < shortDistance
				actorArmor[0] = _nearActor as form
				actorArmor[1] = _nearArmor as form
				shortDistance = refDistance
			endif
		endif
		 _i += 1
	EndWhile 
	return actorArmor
endfunction

; Apparatus = 33
; Armor = 26
; Water = 84
; Weapon = 41
; Weather = 54
; Tree = 38
; Outfit = 124
; Furniture = 40
; Potion = 46
; Material = 126

ObjectReference function _findNearestFormType(actor _actor,  int _formType = 0, float _distance = 100.0, bool isNaked = false)
	ObjectReference[] _refs = FindAllReferencesOfFormType(_actor, _formType, _distance)  ; 43 npc

	; find nearest Item
	float shortDistance = 10000.0
	ObjectReference targetItem = None
	int _i = 0

	while (_i < _refs.length)
		if _actor.isDead()
			return None
		endif	

		actor _nearActor = _refs[_i] as actor

		if isNaked 
			if isActorNaked(_nearActor) && _nearActor != player && !_nearActor.IsDead()
				float refDistance = _actor.getDistance(_refs[_i])

				if refDistance < shortDistance
					targetItem = _refs[_i]
					shortDistance = refDistance
				endif
			endif
		else 
			if _nearActor != player && !_nearActor.IsDead()
				float refDistance = _actor.getDistance(_refs[_i])

				if refDistance < shortDistance
					targetItem = _refs[_i]
					shortDistance = refDistance
				endif
			endif
		endif 

		 _i += 1
	EndWhile 
	
	return targetItem
endfunction

ObjectReference[] function _findAllFormType(actor _actor,  int _formType = 0, float _distance = 100.0)
	return FindAllReferencesOfFormType(_actor, _formType, _distance)  ; 43 npc
endfunction