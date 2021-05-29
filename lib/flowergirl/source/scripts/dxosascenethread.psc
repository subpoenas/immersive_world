Scriptname dxOsaSceneThread extends Quest  

Actor Property PlayerRef Auto
{Added here for performance reasons. }

dxFlowerGirlsBase Property FlowerGirls Auto
{This provides access to the data model.}
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
{Stores common references and variables.}

dxAliasOsaActor Property Participant01 Auto
{This is the reference to the first actor to animate (usually the player).}
dxAliasOsaActor Property Participant02 Auto
{This is the reference to the second actor used to animate.}
dxAliasOsaActor[] Property Participants Auto Hidden
{Array of actors that can controlled by this script.}

ReferenceAlias Property VRPlayerParticipant Auto
{This is the reference to the player if he is being replaced with VR dummy.}


; VR Mode dummy actor
Actor VrDummyActor

; Scene Flags and counters. --------------------------------------------------
bool isPlayerInvolved = False			; Flag if player is involved in the scene.
bool isUsingVrDummy = False			; Flag if the player has been replaced with a VR dummy actor.
bool hasCleanedUp = False 			; Flag to prevent Event register from occurring.

; private variables
bool _debugMode = False

;-----------------------------------------------------------------------------------
; StartScene(): Places the script into Animating state and begins
;	polling the OnUpdate() event in that state.
;----------------------------------------------------------------------------------- 
bool Function StartScene()
	
	; Set the dom role flag on actor 1
	Participant01.IsDomRole = True
	
	Participants = new dxAliasOsaActor[2]	
	Participants[0] = Participant01
	Participants[1] = Participant02
	
	; Determine if any of the actors are currently forbidden.
	isPlayerInvolved = False
	int idx = Participants.Length
	while (idx > 0)
		idx -= 1
		if (Participants[idx].GetActorReference().IsInFaction(FlowerGirlsConfig.ForbiddenActorsFaction))
			FlowerGirlsConfig.MsgSexForbidden.Show()
			idx = 0
			RegisterForSingleUpdate(2.0)
			GoToState("Flush")
			return False
		endIf
		if (isPlayerInvolved == False)
			isPlayerInvolved = (PlayerRef == Participants[idx].GetActorReference())
		endIf
	endWhile
	
	; Fade out for a few seconds
	if (isPlayerInvolved)
		if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 2) )
			FlowerGirlsConfig.FadeToBlackImod.Apply()
		endIf
	endIf
	
	GotoState("InitiateScene")
	RegisterForUpdate(0.2)
		
	return True
	
EndFunction

;-----------------------------------------------------------------------------------
; #State InitiateScene: 
;----------------------------------------------------------------------------------- 
State InitiateScene
	Event OnUpdate()
		Debug.Trace(Self + " Initiating Flower Girls OSA Scene.")
		UnregisterForUpdate()
		
		int iVRMode = FlowerGirlsConfig.DX_VR_MODE.GetValueInt()
		; Check if VR Mode is being used. If so create a dummy actor.
		if (isPlayerInvolved)			
			if (iVRMode == 1)
				VrDummyActor = PlayerRef.PlaceActorAtMe(PlayerRef.GetActorBase())
				Utility.Wait(1.0)
				IsUsingVrDummy = True
				if (Participant01.GetActorReference() == PlayerRef)
					Participant01.ForceRefTo(VrDummyActor)				
				elseIf (Participant02.GetActorReference() == PlayerRef)
					Participant02.ForceRefTo(VrDummyActor)
				endIf
				VRPlayerParticipant.ForceRefTo(PlayerRef)
			elseIf (iVRMode == 2)
				if (Participant01.GetActorReference() == PlayerRef)
					Participant01.IsVRActor = True
					Participant01.VRPartnerRef = Participant02.GetActorReference()
				elseIf (Participant02.GetActorReference() == PlayerRef)
					Participant02.IsVRActor = True
					Participant02.VRPartnerRef = Participant01.GetActorReference()
				endIf
			endIf
		endIf
		
		bool stripPlayer = (FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 1 || FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 2)
		bool stripNpc = (FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 1 || FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 3)
		bool debugMode = _debugMode
		bool useStrapOn = (FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt() > 0)
		bool useStrapOnCbbe = (FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt() == 2)
		
		int cnt = 0
		while (cnt < Participants.Length)
			Participants[cnt].StripPlayer = stripPlayer
			Participants[cnt].StripNpc = stripNpc
			Participants[cnt].UseStrapOn = useStrapOn
			Participants[cnt].UseStrapOnCbbe = useStrapOnCbbe
			Participants[cnt].DebugMode = debugMode
			Participants[cnt].SetUpActorForScene()		
			cnt += 1
		endWhile		
		
		Utility.Wait(1.0)		
		
		if (isPlayerInvolved)
			; Remove Fade out screen
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 2))
				FlowerGirlsConfig.FadeToBlackImod.Remove()
			endIf
		endIf
		
		FlowerGirls.KeywordSexStarted.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
		
		RegisterForUpdate(0.1)
		GotoState("Animating")		

	endEvent
endState

;-----------------------------------------------------------------------------------
; #State Animating: 
;----------------------------------------------------------------------------------- 
State Animating
	Event OnUpdate()
		UnregisterForUpdate()
		
		Actor[] actro = New Actor[2]
		actro[0] = Participant01.GetActorReference()
		actro[1] = Participant02.GetActorReference()

		string[] newScene = osa.makeStage()
		osa.setActors(newScene, actro)
		osa.setModule(newScene, "0Sex", "AUTO", "")
		
		RegisterForModEvent("0SAA" + _oGlobal.GetFormID_s(actro[0].GetActorBase()) + "_ActraEnd", "OnOsaCompleted")
		osa.start(newScene)		
	endEvent
endState

Event OnOsaCompleted(string eventName, string strArg, float numArg, Form sender)
	UnregisterForModEvent(eventName)
	
	if (isPlayerInvolved)
		if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 3))
			FlowerGirlsConfig.FadeToBlackImod.Apply()
		endIf
	endIf
	
	; Update the time the player last had sex.
	if (isPlayerInvolved)
		FlowerGirls.PlayerLastHadSexGametime = Utility.GetCurrentGameTime()
	endIf
	
	FlowerGirls.KeywordSexClimax.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
		
	GotoState("StopAnimating")		
	RegisterForSingleUpdate(0.1)
	
endEvent

;-----------------------------------------------------------------------------------
; #StopAnimating:
;----------------------------------------------------------------------------------- 
State StopAnimating
	Event OnUpdate()
		UnregisterForUpdate()
		
		int cnt = 0
		while (cnt < Participants.Length)
			Participants[cnt].ReleaseActorFromScene()
			cnt += 1
		endWhile	
		
		; Clean-up VR model
		if (isUsingVrDummy)
		
			; Place the player back into the participants
			if (Participant01.GetActorReference() == VrDummyActor)
				Participant01.ForceRefTo(PlayerRef)
			elseIf (Participant02.GetActorReference() == VrDummyActor)
				Participant02.ForceRefTo(PlayerRef)
			endIf
			
			VrDummyActor.Disable()
			VrDummyActor.Delete() ; Credit to Min for finding issue here.
			isUsingVrDummy = False
		endIf
		
		hasCleanedUp = True
		
		; Remove Fade out screen
		if (isPlayerInvolved)
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 3))
				FlowerGirlsConfig.FadeToBlackImod.Remove()
			endIf
		endIf
		
		RegisterForSingleUpdate(2.0)
		GoToState("Flush")
		
	endEvent
endState

;-----------------------------------------------------------------------------------
; #Flush:
;----------------------------------------------------------------------------------- 
State Flush
	Event OnUpdate()
		UnregisterForUpdate()
		
		if (isPlayerInvolved)
			; Update the players last had a scene gametime
			FlowerGirls.PlayerLastHadSceneGametime = Utility.GetCurrentGameTime()
		endIf
		
		FlowerGirls.KeywordSexCompleted.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
		
		Debug.Trace(Self + " OnUpdate(): Flushing aliases")		
		; Clear aliases	
		if (Participant01.GetActorReference() != None)
			Participant01.Clear()
		endIf
		if (Participant02.GetActorReference() != None)
			Participant02.Clear()
		endIf
		if (VRPlayerParticipant.GetActorReference() != None)
			VRPlayerParticipant.Clear()
		endIf
		
		Self.Reset()
		Self.Stop()
	endEvent
endState
