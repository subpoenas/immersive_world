Scriptname ImmersiveBreakArmor extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto

; durability - 기반 대상 공격에 노출 시 durability 가 0일 때 방어구 제거
float function handleArmorBroken (actor _victim, actor _aggressor, weapon _weapon, float _armorDurability)
	float _durability = _armorDurability
	if _isMeleeWeapon(_weapon)
			Armor[] actorArmorList = new Armor[5]

			actorArmorList[0] 	= _victim.GetWornForm(0x00004000) as Armor	; actorFace
			actorArmorList[1]	= _victim.GetWornForm(0x00000001) As Armor 	; actorHelmet
			actorArmorList[2] 	= _victim.GetWornForm(0x00200000) as Armor	; actorChest
			actorArmorList[3] 	= _victim.GetWornForm(0x08000000) as Armor	; actorShoulder
			actorArmorList[4]	= _victim.GetWornForm(0x00000004) as Armor	; actorArmor
				
			int idx = 0
			while idx < actorArmorList.length 
							
				if actorArmorList[idx]
					_durability = _calArmorDurability(_victim, _aggressor, actorArmorList[idx], _armorDurability)

					if _durability <= 0.0
						_handleArmorBroken(_victim, actorArmorList[idx])		
						return 100.0
					endif 	
				endif
	
				idx += 1
			endwhile
	endif
	return _durability
endfunction

; 확률 기반 - 짐승들 공격 노출 시 일정 확률로 clothes 제거
bool function handleClothWorn (actor _victim, actor _aggressor, weapon _weapon)
	if _victim.GetActorBase().GetSex() == -1 || _isMeleeWeapon(_weapon)

			; 1/5 확률
			if Utility.RandomInt(0, 100) > 80
				Armor[] actorArmorList = new Armor[6]

				actorArmorList[0]	= _victim.GetWornForm(0x00000008) As Armor	; actorHand
				actorArmorList[1]	= _victim.GetWornForm(0x00000010) As Armor	; actorArm
				actorArmorList[2]	= _victim.GetWornForm(0x00000004) as Armor	; actorArmor
				actorArmorList[3]	= _victim.GetWornForm(0x00000001) As Armor 	; actorHelmet
				actorArmorList[4] 	= _victim.GetWornForm(0x00200000) as Armor	; actorChest
				actorArmorList[5] 	= _victim.GetWornForm(0x10000000) as Armor	; actorPanty

				int idx = 0
				while idx < actorArmorList.length 

					if actorArmorList[idx]
						return _handleClothWorn(_victim, actorArmorList[idx])		
					endif

					idx += 1
				endwhile				
			endif
	endif
	return false
endfunction

; 스테미너/확률 기반 - 대상 공격에 대한 방어시 방패나 무기에 대해 대해 일정 확률로 바닥에 drop
bool function handleWeaponDrop (actor _victim, actor _aggressor, weapon _weapon)
	if _isMeleeWeapon(_weapon)		
			; -1 - None
			; 0 - Male
			; 1 - Female
			float dropPercentage = _getDropPercentage(_victim, _aggressor)
					
			if Utility.RandomInt(0, 100) > 50 && dropPercentage > 50.0
				if _victim.GetEquippedShield()
					return _handleArmorDropped(_victim, _victim.GetEquippedShield())
				elseif _victim.GetEquippedWeapon(true) ; left weapon				
					return _handleWeaponDropped(_victim, _victim.GetEquippedWeapon(true))				
				elseif _victim.GetEquippedWeapon(false) ; right weapon
					return _handleWeaponDropped(_victim, _victim.GetEquippedWeapon(false))
				else 
					; fist
					Armor[] actorArmorList = new Armor[2]

					actorArmorList[0]	= _victim.GetWornForm(0x00000008) As Armor	; actorHand
					actorArmorList[1]	= _victim.GetWornForm(0x00000010) As Armor	; actorArm	
						
					int idx = 0
						
					; armor
					while idx < actorArmorList.length 
	
						if actorArmorList[idx]
							return _handleArmorDropped(_victim, actorArmorList[idx])						
						endif
	
						idx += 1
					endwhile
				endif 				
			endif
		endif

	return false
endfunction

bool function _handleClothWorn (Actor _actor, Armor _armor)
	if _armor.IsClothing() && !_armor.IsHeavyArmor() && !_armor.IsLightArmor()
		return _handleArmorRemoved(_actor, _armor)
	endif 

	return false
endFunction

bool function _handleArmorBroken (Actor _actor, Armor _armor)
	return _handleArmorRemoved(_actor, _armor)
endFunction

bool function _handleArmorRemoved (Actor _actor, Armor _armor)
	_actor.RemoveItem(_armor)
	return true	
endFunction

bool function _handleArmorDropped (Actor _actor, Armor _armor)
	_actor.DropObject(_armor)
	return true	
endFunction

bool function _handleWeaponDropped (Actor _actor, Weapon _weapon)
	_actor.DropObject(_weapon)
	return true	
endFunction

bool Function _isMeleeWeapon(Weapon _weapon)
	return _weapon.IsMace() || _weapon.IsGreatsword() || _weapon.IsWarhammer() || _weapon.IsWarAxe() || _weapon.IsBattleaxe()
EndFunction 

float function _getDropPercentage(actor _victim, actor _aggressor)
	; -1 - None
	; 0 - Male
	; 1 - Female
	float dropPercentage = 0.0
	float victimStamina = _victim.GetAv("Stamina")

	if victimStamina <= 0.0
		dropPercentage += Utility.RandomFloat(10.0, 50.0)
	elseif victimStamina < 0.10
		dropPercentage += Utility.RandomFloat(10.0, 35.0)
	elseif victimStamina < 0.20
		dropPercentage += Utility.RandomFloat(10.0, 20.0)
	endif
			
	int aggressorLevel = _aggressor.GetLevel()
	int victimLevel = _victim.GetLevel()
			
	if (aggressorLevel - victimLevel > 5) 
		dropPercentage += (aggressorLevel - victimLevel) * 2
	endif 

	int aggressorGender = _victim.GetActorBase().GetSex()
	int victimGender = _victim.GetActorBase().GetSex()

	if victimGender == 1 && aggressorGender == 0		
		dropPercentage = dropPercentage * 1.2
	endif	

	return dropPercentage

endfunction

float function _calArmorDurability(actor _victim, actor _aggressor, armor _armor, float _durability)
	; -1 - None
	; 0 - Male
	; 1 - Female

	float penaltyPercentage = 0.0

	if _armor.IsHeavyArmor()
		penaltyPercentage += 3.0
	elseif  _armor.IsLightArmor()
		penaltyPercentage += 8.0
	elseif _armor.IsClothing()
		penaltyPercentage += 15.0
	endif		

	if _aggressor.GetActorBase().GetSex() == 0	; male
		penaltyPercentage = penaltyPercentage * 1.3
	else ; female
		penaltyPercentage = penaltyPercentage * 0.9
	endif
	
	_durability -= penaltyPercentage

	return _durability

endfunction

bool function _checkWornItem(Actor _actor, Armor _armor)
	bool returnValue = false
	if _armor.IsClothingBody() || _armor.IsHeavyArmor() || _armor.IsLightArmor() || _armor.IsCuirass()
		if _actor.GetWornForm(0x00000004)				
			returnValue = true
		endif
	elseif _armor.IsHelmet() || _armor.IsClothingHead()
		if _actor.GetWornForm(0x00000001)	
			returnValue = true
		endif 
	elseif _armor.IsBoots() || _armor.IsClothingFeet()
		if _actor.GetWornForm(0x00000080)			
			returnValue = true
		endif
	elseif _armor.IsGauntlets()
		if _actor.GetWornForm(0x00000010)		
			returnValue = true
		endif
	else 
		if _actor.GetWornForm(0x00004000)	
			returnValue = true
		endif
	endif

	return returnValue
endfunction

bool function isActorFemale(Actor _actor) 
	if _actor.GetActorBase().GetSex() == 1
		return true
	else 
		return false
	endif
endfunction

bool function isWornHalfNaked(Actor _actor) 	
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

function nakedCoverAnimation(Actor _actor)

	if isActorFemale(_actor) && !_actor.isDead() && !_actor.IsUnconscious() && !_actor.IsBleedingOut()

		if _actor.IsInCombat()
			int type = Utility.RandomInt(1,4)
			Debug.SendAnimationEvent(_actor, "Break_CoverSelf_0" + type)
		endif 
	endif
endFunction

function bleedoutStartAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "Alton_Bleedout_Start")
endFunction

function bleedoutEndAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "Alton_Bleedout_Exit")
endFunction

function defaultAnimation(Actor _actor)
	Debug.SendAnimationEvent(_actor, "IdleForceDefaultState")
endFunction