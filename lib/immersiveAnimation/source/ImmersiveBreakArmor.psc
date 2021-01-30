Scriptname ImmersiveBreakArmor extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto

SexLabFramework property SexLab auto

bool Function _isMeleeWeapon(Weapon _weapon)
	return _weapon.IsMace() || _weapon.IsGreatsword() || _weapon.IsWarhammer() || _weapon.IsWarAxe() || _weapon.IsBattleaxe()
EndFunction 

function handleArmorBreak (actor _victim, actor _aggressor, weapon _weapon, bool _abHitPower, bool _abHitBlocked)
	if _isMeleeWeapon(_weapon)
		; Explosion exp = akSource as Explosion
			; -1 - None
			; 0 - Male
			; 1 - Female
			int gender = _victim.GetActorBase().GetSex()
			int rndint = Utility.RandomInt()

			; male got more good change not to take off clothes
			if gender == 0
				rndint = (rndint * 1.3) as int
			endif

			if _abHitBlocked
				Armor[] actorArmorList = new Armor[3]

				actorArmorList[0]	= _victim.GetWornForm(0x00000200) As Armor	; actorShield
				actorArmorList[1]	= _victim.GetWornForm(0x00000008) As Armor	; actorHand
				actorArmorList[2]	= _victim.GetWornForm(0x00000010) As Armor	; actorArm				
				
				int idx = 0
				while idx < actorArmorList.length 

					if actorArmorList[idx]
						if rndint < 5
							_handleArmorDropped(_victim, actorArmorList[idx])	
							return	
						endif
					endif

					idx += 1
				endwhile
			else
				Armor[] actorArmorList = new Armor[10]

				actorArmorList[0]	= _victim.GetWornForm(0x00000001) As Armor 	; actorHelmet
				actorArmorList[1]	= _victim.GetWornForm(0x00000008) As Armor	; actorHand
				actorArmorList[2]	= _victim.GetWornForm(0x00000010) As Armor	; actorArm
				actorArmorList[3]	= _victim.GetWornForm(0x00000004) as Armor	; actorArmor
				actorArmorList[4] 	= _victim.GetWornForm(0x00100000) as Armor	; actorBackpack
				actorArmorList[5] 	= _victim.GetWornForm(0x00200000) as Armor	; actorChest
				actorArmorList[6] 	= _victim.GetWornForm(0x08000000) as Armor	; actorShoulder
				actorArmorList[7] 	= _victim.GetWornForm(0x10000000) as Armor	; actorPanty
				actorArmorList[8] 	= _victim.GetWornForm(0x00000002) as Armor	; actorHair
				actorArmorList[9] 	= _victim.GetWornForm(0x00004000) as Armor	; actorFace
	
				; only short distant weapon will be available to break victim's armor
				if actorArmorList[9]				;actorFace						
						__handleArmorBroken(_victim, actorArmorList[0], rndint, 10, 20, 40)
				elseif actorArmorList[0]				;actorHelmet						
						__handleArmorBroken(_victim, actorArmorList[0], rndint, 10, 20, 40)
				elseif actorArmorList[1]			;actorHand
						__handleArmorBroken(_victim, actorArmorList[1], rndint, 10, 15, 40)	
				elseif actorArmorList[2]			; actorArm
						__handleArmorBroken(_victim, actorArmorList[2], rndint, 10, 20, 40)
				elseif actorArmorList[6]			; actorShoulder
						__handleArmorBroken(_victim, actorArmorList[6], rndint, 10, 20, 40)																		
				elseif actorArmorList[5]			; actorChest
						__handleArmorBroken(_victim, actorArmorList[5], rndint, 10, 15, 20)													
				elseif actorArmorList[4]			; actorBackpack												
						_handleArmorDropped(_victim, actorArmorList[4])								
				elseif actorArmorList[3]			; actorArmor
						__handleArmorBroken(_victim, actorArmorList[3], rndint, 3, 8, 20)
				elseif actorArmorList[7] && _victim.GetRelationshipRank(_aggressor) < -1 ; panty, -1 means rival 							
						__handleArmorBroken(_victim, actorArmorList[7], rndint, 10, 20, 50)
				else
						; naked or creature
				endif
			endif
		endif

endfunction

function __handleArmorBroken (Actor _actor, Armor _armor, int rndint, int heavyTh, int lightTh, int clothTh)
	if  rndint < clothTh
		int _removeRndint = Utility.RandomInt(1,10)
		bool isRemove = false

		if heavyTh < rndint
			if _removeRndint <= 1
				isRemove = true			
			endif 
		elseif lightTh < rndint
			if _removeRndint <= 3
				isRemove = true			
			endif 
		else
			if _removeRndint <= 5
				isRemove = true			
			endif 
		endif

		if isRemove
			_doArmorAction (_actor, _armor, "remove")
		else 
			_doArmorAction (_actor, _armor, "drop") 
		endif 
	endif
endFunction

function _handleArmorDropped (Actor _actor, Armor _armor)
	_doArmorAction (_actor, _armor, "drop") 	
endFunction

function _doArmorAction (Actor _actor, Armor _armor, String _type)
	if _type == "drop"
		_actor.DropObject(_armor)
	else 
		_actor.RemoveItem(_armor)
	endif
endFunction

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
