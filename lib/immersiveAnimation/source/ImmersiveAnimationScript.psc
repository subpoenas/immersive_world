Scriptname ImmersiveAnimationScript extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto

SexLabFramework property SexLab auto

package findArmorAndPick = none
package findDeadBodyAndPick = none
package findActorAndApproach = none

Keyword[] SLHHScriptEventKeywords = none

Sound _clothSound = None
int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction


event OnInit()
	Debug.Notification("ImmersiveAnimation Load..")
		
	; load package
	findArmorAndPick = Game.GetFormFromFile(0x0600AA07, "AltonImmersiveAnimation.esp") as Package
	findDeadBodyAndPick = Game.GetFormFromFile(0x0602E108, "AltonImmersiveAnimation.esp") as Package
	findActorAndApproach = Game.GetFormFromFile(0x0603320A, "AltonImmersiveAnimation.esp") as Package
	
	; load resource	

	if Game.GetModByName("Skyrim.esm") != 255
		_clothSound =  Game.GetFormFromFile(0x334A9, "Skyrim.esm") As Sound	
	endif

    If Game.GetModByName("SexLabHorribleHarassment.esp") != 255
		SLHHScriptEventKeywords =  new Keyword[3]
		SLHHScriptEventKeywords[0] = Game.GetFormFromFile(0x00C510, "SexLabHorribleHarassment.esp") as Keyword	; backhug
		SLHHScriptEventKeywords[1] = Game.GetFormFromFile(0x0233C6, "SexLabHorribleHarassment.esp") as Keyword	; choke
		SLHHScriptEventKeywords[2] = Game.GetFormFromFile(0x02495B, "SexLabHorribleHarassment.esp") as Keyword 	; drunk
	endif
	
    If Game.GetModByName("ZaZAnimationPack.esm") != 255
	endif	
endEvent

Actor function getPlayerActor()
	return Player
endfunction 

bool function isActorPlayer(actor _actor)
	return Player == _actor
endfunction 

function doApproachToObject(actor _actor, ObjectReference _targetObj, float _speed = 1.0)
	Debug.Notification("doApproachToObject")
	findActorAndApproach = Game.GetFormFromFile(0x0603320A, "AltonImmersiveAnimation.esp") as Package
	ActorUtil.AddPackageOverride(_actor, findActorAndApproach, 1, 1)
	_actor.EvaluatePackage()
endfunction

function doSearchClothes (actor _actor)
	Debug.Notification("doSearchClothes")
	
	 if _searchClothes(_actor)	
		findArmorAndPick = Game.GetFormFromFile(0x0600AA07, "AltonImmersiveAnimation.esp") as Package
		Debug.Notification("run findArmorAndPick")
		ActorUtil.AddPackageOverride(_actor, findArmorAndPick, 1, 1)	
		_actor.EvaluatePackage()
	 elseif _searchDeadBodies(_actor)			 
			findDeadBodyAndPick = Game.GetFormFromFile(0x0602E108, "AltonImmersiveAnimation.esp") as Package
			Debug.Notification("run findDeadBodyAndPick")
			ActorUtil.AddPackageOverride(_actor, findDeadBodyAndPick, 1, 1)
			_actor.EvaluatePackage()		
	 endif 
endFunction

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
		
	if SLHHScriptEventKeywords
		_aggressor.moveTo(_victim)
		_victim.KeepOffsetFromActor(_aggressor, 0.0, 0.0, 20.0)
		_aggressor.SetLookAt(_victim)

		Debug.SendAnimationEvent(_victim, "SLHH_Drunk_SBD_A01Start")
		Debug.SendAnimationEvent(_aggressor, "SLHH_Drunk_SBD_A02Start")
	endif
endfunction

function doTearItems (Actor _actor, Armor _armor, int rndint, int heavyTh, int lightTh, int clothTh, string type, float volumeUp, Sound[] _soundArray)
	if  rndint < clothTh
		int _rndint = Utility.RandomInt(1,10)		
		if _armor.IsHeavyArmor()
			if rndint < heavyTh								
				playSoundForDropItem(_actor, _armor, volumeUp, type, _soundArray)
			endif
		elseif _armor.IsLightArmor()
			if  rndint < lightTh
				if _rndint < 2
					playSoundRemoveItem(_actor, _armor, volumeUp, type, _soundArray)
				else 
					playSoundForDropItem(_actor, _armor, volumeUp, type, _soundArray)
				endif
			endif			
		else
			if _rndint < 5				
				playSoundRemoveItem(_actor, _armor, volumeUp, type, _soundArray)						
			Else
				playSoundForDropItem(_actor, _armor, volumeUp, type, _soundArray)
			endif
		endif 
	endif
endFunction

function doDropItems (Actor _actor, Armor _armor, string type, float volumeUp, Sound[] _soundArray) 
	playSoundForDropItem(_actor, _armor, volumeUp, type, _soundArray)
endFunction

; _soundArray [shock, shame, faint, tear ]
function playSoundForDropItem (Actor _actor, Armor _armor, float volumeUp, String type, Sound[] _soundArray) 
	if !_actor.IsDead() && isActorFemale(_actor)
		if type == "shock"
			Sound.SetInstanceVolume(_soundArray[0].Play(_actor), volumeUp)
		elseif type == "shame"		
			Sound.SetInstanceVolume(_soundArray[1].Play(_actor), volumeUp)		
		else	
			Sound.SetInstanceVolume(_soundArray[1].Play(_actor), volumeUp)			
		endif
	endif
	_actor.DropObject(_armor)
endFunction

; _soundArray [shock, shame, faint, tear ]
function playSoundRemoveItem (Actor _actor, Armor _armor, float volumeUp, String type, Sound[] _soundArray) 
	; play tear sound
	Sound.SetInstanceVolume(_soundArray[4].Play(_actor), volumeUp)

	if !_actor.IsDead() && isActorFemale(_actor)
		if type == "shame"
			Sound.SetInstanceVolume(_soundArray[0].Play(_actor), volumeUp)
		elseif type == "shock"		
			Sound.SetInstanceVolume(_soundArray[1].Play(_actor), volumeUp)		
		else	
			Sound.SetInstanceVolume(_soundArray[2].Play(_actor), volumeUp)			
		endif	
	endif
	_actor.RemoveItem(_armor)
endFunction

bool Function checkAvailableHardWeapon(Weapon _weapon)
	return _weapon.IsMace() || _weapon.IsGreatsword() || _weapon.IsWarhammer() || _weapon.IsWarAxe() || _weapon.IsBattleaxe()
EndFunction 

bool function _searchClothes (Actor _actor)
	Debug.Notification("Searching for ... clothes")

		int [] _formType = new int[2]

		_formType[0] = 26  ; armor
		_formType[1] = 124 ; cloth

		int i = 0

		While (i < _formType.length)
			ObjectReference targetRef = _findNearestItem(_actor, _formType[i], 1000.0)

			if _actor.isDead()
				return false
			elseif targetRef
				Debug.Notification("Found dead cloth")
				return true
			endif
			i += 1
		EndWhile
	return false
endFunction

bool function _searchDeadBodies(Actor _actor)
	Debug.Notification("Searching for ... dead body")

	Form [] actorArmor = _findNearestDeadNpcHumanBody(_actor, 1000.0)

	if _actor.isDead()
		return false
	elseif actorArmor[0]
		Debug.Notification("Found dead body")
		return true	
	endif

	return false
endFunction

bool function _searchWeapons (Actor _actor)
	Debug.Notification("Searching for ... weapon")

		int [] _formType = new int[2]

		_formType[0] = 41  ; weapon		

		int i = 0

		While (i < _formType.length)
			; find nearest armor
			float shortDistance = 1000.0

			ObjectReference targetRef = _findNearestItem(_actor, _formType[i], 700.0)

			if _actor.isDead()
				return false
			elseif targetRef
				Debug.Notification("Found weapon")
				return true
			endif

			i += 1
		EndWhile
	return false
endFunction

function rollbackPackages (actor  _actor)
	ActorUtil.RemovePackageOverride(_actor, findArmorAndPick)
	ActorUtil.RemovePackageOverride(_actor, findDeadBodyAndPick)
	ActorUtil.RemovePackageOverride(_actor, findActorAndApproach)
	_actor.EvaluatePackage()
endfunction 

; function doPlayerSceneStart()
; 	Game.ForceThirdPerson()
; 	Game.DisablePlayerControls(0, 0, 1, 1, 0, 1, 0, 0)
; endfunction

; function doPlayerSceneEnd()
; 	Game.EnablePlayerControls()
; endfunction

Actor function _findNearestNpcHuman(actor _actor, float _distance, int _gender = 0) ; 0 is male, 1 is female

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
		if !_nearActor.IsDead()	&& !isActorPlayer(_nearActor) && _nearActor.HasKeyWordString("ActorTypeNPC") && _nearActor.GetActorBase().GetSex() == _gender
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
		if _nearActor.IsDead()	&& !isActorPlayer(_nearActor) && _nearArmor
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

ObjectReference function _findNearestItem(actor _actor,  int _formType = 0, float _distance = 100.0)
	ObjectReference[] _refs = FindAllReferencesOfFormType(_actor, _formType, _distance)  ; 43 npc

	; find nearest Item
	float shortDistance = 10000.0
	ObjectReference targetItem = None
	int _i = 0

	while (_i < _refs.length)
		if _actor.isDead()
			return None
		endif	

		float refDistance = _actor.getDistance(_refs[_i])

		if refDistance < shortDistance
			targetItem = _refs[_i]
			shortDistance = refDistance
		endif

		 _i += 1
	EndWhile 
	return targetItem
endfunction

; bool function tryEquipArmor (actor _actor, ObjectReference _item)

; 	_actor.AddItem(_item)

; 	int _check = 0
; 	while _check < 5
; 		wait(1.0)
; 		if isActorNaked(_actor)	
; 			return true
; 		endif 
; 		_check += 1
; 	endwhile 

; 	return false
; endFunction

bool function isAliveHuman(Actor _actor)
	return _actor.HasKeyWordString("ActorTypeNPC") && !_actor.isDead()
endFunction

bool function isHuman(Actor _actor)
	return _actor.HasKeyWordString("ActorTypeNPC") || _actor.HasKeyWordString("ActorTypeNPCUndead")
endFunction

bool function isActorFemale(Actor _actor) 
	if _actor.GetActorBase().GetSex() == 1
		return true
	endif
	return false
endfunction

bool function isActorNaked(Actor _actor) 

	if _actor.GetWornForm(0x00000004) || _actor.GetWornForm(0x00400000)
		return false
	else 
		return true
	endif 
endfunction

bool function isWornNakedArmor(Actor _actor)

	Armor _armor =_actor.GetWornForm(0x00000004) as Armor 

	if _armor != none && (_armor.HasKeyWordString("SLA_ArmorTransparent") || _armor.HasKeyWordString("SLA_ArmorCurtain") || _armor.HasKeyWordString("SLA_ArmorHalfNaked") || _armor.HasKeyWordString("SLA_ArmorHalfNakedBikini") ||  _armor.HasKeyWordString("SLA_PastiesNipple"))
		return true
	else 
		return false
	endif 
endfunction

function playUnconsciousAnimation(ACtor _actor, int step)
	if step == 1
		Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_Start")
	elseif step == 2
		Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_End")
	else
		Debug.SendAnimationEvent(_actor, "Erotic_KnockOut_Exit")
		wait(1.0)
		Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
	endif 
endfunction

function playNakeCoverAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfAll_02")
	wait(1.0)
	Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
endFunction

function playKnockbackAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "BleedOutStart")
	wait(0.5)
	Debug.SendAnimationEvent(_actor, "BleedOutStop")
endFunction

function playNakeCoverOnCombatAnimation(Actor _actor)
	if isActorFemale(_actor)
		int _rndint = Utility.RandomInt(1,5)

		if _rndint == 1
			Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfBra")
		elseif _rndint == 2
			Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfVag")
		else 
			Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfAll_01")
		endif
	else 
		Debug.SendAnimationEvent(_actor, "Erotic_CoverSelfVag")
	endif
endFunction

function playDressAnimation(Actor _actor, Armor _armor)
	int _gender = _actor.GetActorBase().GetSex()
	String gender = "F"
	bool shouldEquip = false

	if _gender == 0; male
		gender = "M"
	endif
	
	if _armor.IsClothingBody() || _armor.IsHeavyArmor() || _armor.IsLightArmor()
		Armor _wornArmor = _actor.GetWornForm(0x00000004) as Armor
		if _wornArmor == None					
			if _armor.IsCuirass()
				Debug.SendAnimationEvent(_actor, "Erotic_DressCuirass" + gender)
				wait(4.0)
			elseif _armor.HasKeyWordString("SLA_ArmorTransparent")
				Debug.SendAnimationEvent(_actor, "Erotic_DressPants" + gender)
				wait(4.0)
			else 
				Debug.SendAnimationEvent(_actor, "Erotic_Dress_Quick")
				wait(3.0)
			endif			
			shouldEquip = true
		endif
	elseif _armor.IsHelmet() || _armor.IsClothingHead()
		Armor _wornArmor = _actor.GetWornForm(0x00000001) as Armor
		if _wornArmor == None	
			Debug.SendAnimationEvent(_actor, "Erotic_DressHelmet" + gender)
			wait(3.0)
			shouldEquip = true
		endif 
	elseif _armor.IsBoots() || _armor.IsClothingFeet()
		Armor _wornArmor = _actor.GetWornForm(0x00000080) as Armor
		if _wornArmor == None			
			Debug.SendAnimationEvent(_actor, "Erotic_DressBoots" + gender)
			wait(5.0)
			shouldEquip = true
		endif
	elseif _armor.IsGauntlets()
		Armor _wornArmor = _actor.GetWornForm(0x00000010) as Armor
		if _wornArmor == None			
			Debug.SendAnimationEvent(_actor, "Erotic_DressGloves" + gender)
			wait(3.0)
			shouldEquip = true
		endif
	endif

	if shouldEquip		
		Sound.SetInstanceVolume(_clothSound.Play(_actor), 0.4)
		_actor.EquipItem(_armor)
		wait(0.5)
		Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
	endif 

endFunction
