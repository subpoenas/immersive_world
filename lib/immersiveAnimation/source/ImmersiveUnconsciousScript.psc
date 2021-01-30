Scriptname ImmersiveUnconsciousScript extends Quest

import po3_SKSEFunctions
Import Utility

Actor Property Player  Auto

package approachPackage = none

Spell unconscionAlertSpell = none

ImmersiveSoundScript imsSndQuest = None
ImmersiveAnimationScript imsAniQuest = None

int Version
int Function VersionCheck()
	Version = 1
	Return Version
EndFunction

event OnInit()
	Debug.Notification("ImmersiveUnconscious Load..")
		
	init()
endEvent

function init()
	if imsSndQuest == none && imsAniQuest == none
		Debug.Notification("ImmersiveUnconscious init..")

		imsSndQuest =  					Game.GetFormFromFile(0x0603D374, "AltonImmersiveSound.esp") As ImmersiveSoundScript
		imsAniQuest =  					Game.GetFormFromFile(0x06005900, "AltonImmersiveAnimation.esp") As ImmersiveAnimationScript

		imsSndQuest.init()
		imsAniQuest.init()
		
		approachPackage = 				Game.GetFormFromFile(0x0603320A, "AltonImmersiveAnimation.esp") as Package

		unconscionAlertSpell =  		Game.GetFormFromFile(0x06056910, "AltonImmersiveAnimation.esp") as Spell

		RegisterForSingleUpdate(1.0)
	endif
endfunction

Spell function getUnconsiconAlertSpell ()
	return unconscionAlertSpell
endfunction

Package function getApproachPackage ()
	return approachPackage
endfunction

function undoOverridePackages (actor  _actor)	
	Debug.Notification("undoOverridePackages")	
	ActorUtil.ClearPackageOverride(_actor)
	_actor.EvaluatePackage()
	wait(1.0)
	
endfunction 

; bool isRunningUpdate = false
; function doArmorSearchRegister()
; 	ObjectReference[] nearActors = findNearActors(player)

; 	if isRunningUpdate == false 
; 		isRunningUpdate = true
; 		RegisterForSingleUpdate(30.0)
; 	endif 

; 	if nearActors != none
; 		int i = 0
; 		while i < nearActors.length
; 			actor _actor = nearActors[i] as actor
			
; 			if !_actor.IsUnconscious() && !_actor.IsBleedingOut() && imsAniQuest.isActorNaked(_actor)
; 				doSearchArmorPackage(_actor)
; 			endif
; 			i += 1
; 		endwhile
; 	endif
; endfunction

; event OnUpdate()
; 	ObjectReference[] nakedActors = findNearActors(player)

; 	if nakedActors != none

; 		int i = 0
; 		while i < nakedActors.length
; 			actor _actor = nakedActors[i] as actor
; 			if !_actor.IsUnconscious() && !_actor.IsBleedingOut() && imsAniQuest.isActorNaked(_actor)
; 				doSearchArmorPackage(_actor)				
; 			endif
; 			i += 1
; 		endwhile		

; 		RegisterForSingleUpdate(120.0)
; 	else 
; 		RegisterForSingleUpdate(180.0)
; 	endif
; EndEvent
