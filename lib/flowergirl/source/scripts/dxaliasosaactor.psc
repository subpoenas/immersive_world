Scriptname dxAliasOsaActor extends dxAliasActorBase  

;-----------------------------------------------------------------
; SetUpActorForScene(): Main function to configure the
;	Actor alias for the scene. Called from Initialize phase
;	of the animator.
;-----------------------------------------------------------------
Function SetupActorForScene()

	; Size the equipment cache arrays
	ClearEquipmentCache()
		
	if (DebugMode)
		Debug.Trace (Self + " ~~~~~~~~~~~~~~~~ SetUpActorForScene: " + ActorRef + " ~~~~~~~~~~~~~~~~")
		Debug.Trace (Self + " OSA being used as the animator.")
		Debug.Trace (Self + " Var: UseStrapOn: " + UseStrapOn + " UseStrapOnCbbe: " + UseStrapOnCbbe + " IsDomRole: " + IsDomRole)
		Debug.Trace (Self + " Var: StripPlayer: " + StripPlayer + " StripNpc: " + StripNpc)
		Debug.Trace (Self + " Var: IsVRActor: " + IsVRActor)
		Debug.Trace (Self + " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	endIf
	
	if (IsVRActor)
		; ObjectReference akActor, float afOffsetX, float afOffsetY, float afOffsetZ, float afOffsetHeading
		;Game.PlayerAllowUpdateHmd(False)
		;Game.PlayerAttachToActor(VRPartnerRef, 20.0, 0, 0, 0)
		return	; No positioning or setup for the player in VR.
	endIf
	
	ActorRef.ClearKeepOffsetFromActor()
	ActorRef.SetHeadTracking(False)
	
	StartMonitoring()	; Start equipment monitoring for the actor.	
	UndressActor()
	
endFunction

;-----------------------------------------------------------------
; ReleaseActorFromScene(): Main function to configure the
;	Actor alias for completion. Called from Stop animation 
;	phase of the animator.
;-----------------------------------------------------------------
Function ReleaseActorFromScene()

	DebugThis("ReleaseActorFromScene()", "Releasing Actor...")
	if (IsVRActor)
		return
	endIf
	
	RedressActor()
	StopMonitoring()		; Stop monitoring equipment for this actor.	
	DebugThis("ReleaseActorFromScene()", "Redressed Actor.")
		
	ActorRef.EvaluatePackage()
		
	DebugThis("ReleaseActorFromScene()", "Actor released from scene successfully.")
	
endFunction
