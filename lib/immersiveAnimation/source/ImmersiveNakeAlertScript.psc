Scriptname ImmersiveNakeAlertScript extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto
ReferenceAlias Property questAlias  Auto

package findArmorPackage = none
package fleeFromPackage = none

Spell nakedAlertSpell = none
Spell dropItemAlertSpell = none

Topic nakedCommentTopic = none
Topic nakedPlayerSelfTopic = none
Topic assualtCommentTopic = none

ImmersiveSoundScript imsSndQuest = None
ImmersiveAnimationScript imsAniQuest = None

int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction

event OnInit()
	Debug.Notification("ImmersiveNakeAlert Load..")
		
	init()
endEvent

function init()
	if imsSndQuest == none && imsAniQuest == none
		Debug.Notification("ImmersiveNakeAlert init..")

		imsSndQuest =  					Game.GetFormFromFile(0x0603D374, "AltonImmersiveSound.esp") As ImmersiveSoundScript
		imsAniQuest =  					Game.GetFormFromFile(0x06005900, "AltonImmersiveAnimation.esp") As ImmersiveAnimationScript

		imsSndQuest.init()
		imsAniQuest.init()
		
		findArmorPackage = 				Game.GetFormFromFile(0x0600AA07, "AltonImmersiveAnimation.esp") as Package
		fleeFromPackage = 				Game.GetFormFromFile(0x0607F119, "AltonImmersiveAnimation.esp") as Package

		nakedAlertSpell = 				Game.GetFormFromFile(0x0605690C, "AltonImmersiveAnimation.esp") as Spell
		dropItemAlertSpell = 			Game.GetFormFromFile(0x0607A015, "AltonImmersiveAnimation.esp") as Spell

		nakedCommentTopic =				Game.GetFormFromFile(0x0608E41E, "AltonImmersiveAnimation.esp") as Topic
		nakedPlayerSelfTopic = 			Game.GetFormFromFile(0x060B6C47, "AltonImmersiveAnimation.esp") as Topic
		RegisterForSingleUpdate(1.0)
	endif
endfunction

Spell function getNakedAlertSpell ()
	return nakedAlertSpell
endfunction

Spell function getDropItemAlertSpell ()
	return dropItemAlertSpell
endfunction

Package function getFindArmorPackage ()
	return findArmorPackage
endfunction

Package function getFleeFromPackage ()
	return fleeFromPackage
endfunction

function setFleeFromTarget(actor _actor) 	
	questAlias.forcerefto(_actor)
endfunction

Topic function getNakedTopic()
	return nakedCommentTopic
endfunction

Topic function getNakedPlayerSelfTopic()
	return nakedPlayerSelfTopic
endfunction

Topic function getAssualtTopic ()
	return assualtCommentTopic
endfunction

function registerForInteresingItem (actor _actor, Form _ref) 

	ObjectReference[] refs = imsAniQuest.findNearActors(_actor)

	Debug.Notification("register For Interesing " + refs.length)
	
	int i=0
	int j=0

	while i < refs.length
		actor __actor = refs[i] as actor
		if !__actor.IsDead() && player != __actor && __actor.HasKeyWordString("ActorTypeNPC")

			if j > 10
				return
			endif 
			UnregisterForLOS(__actor, _ref as objectReference)
			RegisterForSingleLOSGain(__actor, _ref as objectReference)			
			j += 1
		endif 
		i += 1
	endwhile
endfunction

function doSearchArmorPackage (actor _actor)	
	if _actor != player && !_actor.IsUnconscious() && !_actor.IsBleedingOut()

		ActorUtil.ClearPackageOverride(_actor)
		_actor.EvaluatePackage()
		wait(1.0)

		ActorUtil.AddPackageOverride(_actor, findArmorPackage, 1, 1)
		_actor.EvaluatePackage()
		wait(1.0)

		Debug.Notification("evaluateSearchArmorPackage")
	endif
endFunction

function doFleePackage (actor _actor)	
	if _actor != player && !_actor.IsUnconscious() && !_actor.IsBleedingOut()

		ActorUtil.ClearPackageOverride(_actor)
		_actor.EvaluatePackage()
		wait(1.0)

		ActorUtil.AddPackageOverride(_actor, fleeFromPackage, 1, 1)
		_actor.EvaluatePackage()
		wait(1.0)

		Debug.Notification("evaluateFleePackage")
	endif
endFunction

function undoOverridePackages (actor  _actor)	
	Debug.Notification("undoOverridePackages")	
	ActorUtil.ClearPackageOverride(_actor)
	_actor.EvaluatePackage()
	wait(1.0)
endfunction 

function handleArmorBreak (actor _victim, actor _aggressor, weapon _weapon, bool _abHitPower, bool _abHitBlocked, int _actorVoiceType)

	if imsAniQuest.isMeleeWeapon(_weapon)

		; Explosion exp = akSource as Explosion
			; -1 - None
			; 0 - Male
			; 1 - Female
			int gender = _victim.GetActorBase().GetSex()
			int rndint = Utility.RandomInt()
			float volumeUp = 0.4

			; male got more good change not to take off clothes
			if gender == 0
				int rndint2 = Utility.RandomInt()
				if rndint < rndint2
					rndint = rndint2
				endif
			endif

			Armor[] actorArmorList = new Armor[15]
			if _abHitBlocked
				actorArmorList[4]	= _victim.GetWornForm(0x00000200) As Armor	; actorShield

				; if shield will be dropped
				if actorArmorList[4]
					if rndint < 3
						; imsAniQuest._handleDropArmors(self, actorArmorList[4], "shock", volumeUp, _actorVoiceType)		
					endif 					
				endif
			else 								
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
					if rndint < 50
						_handleTearArmors(_victim, actorArmorList[0], rndint, 10, 20, 40, "shock", volumeUp, _actorVoiceType)
					endif
				elseif actorArmorList[0]				;actorHelmet						
						if rndint < 40
							_handleTearArmors(_victim, actorArmorList[0], rndint, 10, 20, 40, "shock", volumeUp, _actorVoiceType)
						endif
				elseif actorArmorList[1]			;actorHand
						if rndint < 30
							_handleTearArmors(_victim, actorArmorList[1], rndint, 10, 15, 30, "shock", volumeUp, _actorVoiceType)	
						endif
				elseif actorArmorList[2]			; actorArm
						if rndint < 30
							_handleTearArmors(_victim, actorArmorList[2], rndint, 10, 20, 30, "shock", volumeUp, _actorVoiceType)
						endif
				elseif actorArmorList[6]			; actorShoulder
						if rndint < 30
							_handleTearArmors(_victim, actorArmorList[6], rndint, 10, 20, 30, "shock", volumeUp, _actorVoiceType)	
						endif																	
				elseif actorArmorList[5]			; actorChest
						if rndint < 20
							_handleTearArmors(_victim, actorArmorList[5], rndint, 10, 15, 20, "shock", volumeUp, _actorVoiceType)
						endif													
				elseif actorArmorList[4]			; actorBackpack						
						if rndint < 18							
							_handleDropArmors(_victim, actorArmorList[4], "shock", volumeUp, _actorVoiceType)		
						endif 						
				elseif actorArmorList[3]			; actorArmor
						if rndint < 15
							_handleTearArmors(_victim, actorArmorList[3], rndint, 3, 8, 15, "shame", volumeUp, _actorVoiceType)
						endif
				elseif actorArmorList[7] && _victim.GetRelationshipRank(_aggressor) < -1 ; panty, -1 means rival
						if rndint < 50 							
							_handleTearArmors(_victim, actorArmorList[7], rndint, 10, 20, 50, "faint", volumeUp, _actorVoiceType)						
						endif
				else
						; naked or creature
				endif
			endif
		endif

endfunction

function _handleTearArmors (Actor _actor, Armor _armor, int rndint, int heavyTh, int lightTh, int clothTh, string _voicetype, float _volume, int _actorVoiceType)
	if  rndint < clothTh
		int _rndint = Utility.RandomInt(1,10)

		if _armor.IsHeavyArmor()
			if rndint < heavyTh								
				playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "drop") 				
			endif
		elseif _armor.IsLightArmor()
			if  rndint < lightTh
				if _rndint < 2
					playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "remove") 						
				else 
					playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "drop") 	
				endif
			endif			
		else
			if _rndint < 5
				playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "remove") 				
			else
				playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "drop") 	
			endif
		endif 
	endif
endFunction

function _handleDropArmors (Actor _actor, Armor _armor, string _voicetype, float _volume, int _actorVoiceType)
	playArmorAction (_actor, _armor, _volume, _voicetype,  _actorVoiceType, "drop") 	
endFunction

bool function checkWornItem(Actor _actor, Armor _armor)
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

; _soundArray [shock, shame, faint, tear ]
function playArmorAction (Actor _actor, Armor _armor, float _volume, String _voicetype,  int _actorVoiceType, String _type) 

	; play tear sound
	imsSndQuest.playTearSound(_actor, 0.5)

	if !_actor.IsDead() && imsAniQuest.isActorFemale(_actor)
		if _voicetype == "shock"
			imsSndQuest.playShockSound(_actor, _actorVoiceType, _volume)			
		elseif _voicetype == "shame"		
			imsSndQuest.playShameSound(_actor, _actorVoiceType, _volume)		
		else	
			imsSndQuest.playCrySound(_actor, _actorVoiceType, _volume)	
		endif
	endif
	if _type == "drop"
		_actor.DropObject(_armor)
	else 
		_actor.RemoveItem(_armor)
	endif
endFunction

event OnUpdate()
	ObjectReference[] nearActors = imsAniQuest.findNearActors(player)

	float curTime = Utility.GetCurrentRealTime() ; second

	if nearActors != none
		int i = 0
		while i < nearActors.length
			actor _actor = nearActors[i] as actor
			if _actor.Is3DLoaded() && _actor != player && _actor.HasKeyWordString("ActorTypeNPC") && imsAniQuest.isActorNaked(_actor) && !_actor.IsUnconscious() && !_actor.IsBleedingOut()
			
				float timeDiff = curTime - _actor.getNakedStartTime()

				Debug.Notification("found naked human ..." + _actor.GetActorBase().getName() + " elaps " + timeDiff)
			
				if timeDiff > 20
					if  _actor.GetCurrentPackage() == findArmorPackage ||  _actor.GetCurrentPackage() == fleeFromPackage 
						undoOverridePackages(_actor)
					else 
						doSearchArmorPackage(_actor)
					endif
				endif
			
			endif
			i += 1
		endwhile	
		RegisterForSingleUpdate(30.0)
	else 			
		RegisterForSingleUpdate(60.0)
	endif
EndEvent