;------------------------------------------------------------------------------------
; dxSceneThread by Xider
;------------------------------------------------------------------------------------
; This script controls animation sequences for either singular or multiple
; actors. It will send events to each actor placed in the controller to
; play idle animations and also to initialize them.
;
;------------------------------------------------------------------------------------

Scriptname dxSceneThread extends Quest Conditional

Actor Property PlayerRef Auto
{Added here for performance reasons. }

dxFlowerGirlsBase Property FlowerGirls Auto
{This provides access to the data model.}
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
{Stores common references and variables.}
dxAliasActor Property Participant01 Auto
{This is the reference to the first actor to animate (usually the player).}
dxAliasActor Property Participant02 Auto
{This is the reference to the second actor used to animate.}
dxAliasActor Property Participant03 Auto
{This is the reference to the actor used in threesomes.}
ReferenceAlias Property VRPlayerParticipant Auto
{This is the reference to the player if he is being replaced with VR dummy.}
dxAliasActor[] Property Participants Auto Hidden
{Array of actors that can controlled by this script.}
Scene Property SoundStageScene  Auto
{Provides access to the scene itself.}

; Static base to mark the spots for the anims, this is mandatory for the SetVehicle() to work properly.
ObjectReference SexPositionRef
; Static base to mark the spot for furniture animations
ObjectReference FurnitureStaticBaseRef

; Furniture References
ObjectReference TableStaticBaseRef
ObjectReference ChairStaticBaseRef
ObjectReference ThroneStaticBaseRef
ObjectReference BedStaticBaseRef
ObjectReference WorkbenchStaticBaseRef
ObjectReference AlchemyBenchStaticBaseRef
ObjectReference EnchantingBenchStaticBaseRef

; VR Mode dummy actor
Actor VrDummyActor

float[] Property animStageDurations Auto Hidden
{Array of float times for each stage during the sequence.}
int Property SceneType Auto Hidden
{Stores a short arbitary value representing the type of scene this thread has played.}

; Sound stage properties. ---------------------------------------------------
bool Property IsFemaleEnabledActor1 = False Auto Hidden Conditional
bool Property IsFemaleEnabledActor2 = False Auto Hidden Conditional
bool Property IsFemaleEnabledActor3 = False Auto Hidden Conditional

bool Property IsMaleEnabledActor1 = False Auto Hidden Conditional
bool Property IsMaleEnabledActor2 = False Auto Hidden Conditional
bool Property IsMaleEnabledActor3 = False Auto Hidden Conditional

bool Property IsFemaleVoice2Actor1 = False Auto Hidden Conditional
bool Property IsFemaleVoice2Actor2 = False Auto Hidden Conditional

; Scene Flags and counters. --------------------------------------------------
bool isPlayerInvolved = False			; Flag if player is involved in the scene.
bool isSoloScene = False 				; Flag if this is a solo scene.
bool isThreesome = False				; Flag if this is a threesome scene.
bool isUsingFurniture = False			; Flag if the scene is actively using furniture.
bool isUsingVrDummy = False			; Flag if the player has been replaced with a VR dummy actor.

int animStages = 0 
int animCurrentStage = 0
bool hasCleanedUp = False 			 ; Flag to prevent Event register from occurring.

; private variables
bool _debugMode = False
bool _skse64 = False
bool _papyrusUtils = False
int _vrMode = 0
bool _freecamEngaged = False

;-----------------------------------------------------------------------------------
; OnUpdate(): This is in the empty state, used to validate our data
;----------------------------------------------------------------------------------- 
Event OnUpdate()
	;Debug.Trace(Self + " OnUpdate() Event called for dxSceneThread in EMPTY State")
	UnregisterForUpdate()
EndEvent

;-----------------------------------------------------------------------------------
; StartScene(): Places the script into Animating state and begins
;	polling the OnUpdate() event in that state.
;----------------------------------------------------------------------------------- 
bool Function StartScene()

	; Determine if this is a solo scene based on token
	isSoloScene = FlowerGirls.TokenToIdle.IsSoloScene(Participant01)
		
	; Determine if this is a threesome based on tokens
	if (isSoloScene)
		isThreesome = False
	else
		isThreesome = FlowerGirls.TokenToIdle.IsThreesome(Participant01)
	endIf
	
	; Set the dom role flag on actor 1
	Participant01.IsDomRole = True
	
	if ( isThreesome )
		Participant01.IsThreesome = True
		Participant02.IsThreesome = True
		Participant03.IsThreesome = True
		
		Participants = new dxAliasActor[3]	
		Participants[0] = Participant01
		Participants[1] = Participant02
		Participants[2] = Participant03
	elseIf ( isSoloScene )
		Participant01.IsSoloScene = True
		Participants = new dxAliasActor[1]
		Participants[0] = Participant01
	else
		Participants = new dxAliasActor[2]	
		Participants[0] = Participant01
		Participants[1] = Participant02
	endIf

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
	
	; Animations are currently toggled off.. skip the rest of startup.
	if (FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.GetValueInt() == False)
		GotoState("NoAnimations")
		RegisterForUpdate(0.2)
		return True
	endIf
	
	; Determine if there is furniture nearby to use.
	if (FlowerGirls.TokenToIdle.CanUseBed(Participant01)) 
		FlowerGirls.TokenToIdle.HasAvailableBed = Self.HasAvailableBed()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseTable(Participant01))
		FlowerGirls.TokenToIdle.HasAvailableTable = Self.HasAvailableTable()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseChair(Participant01))
		FlowerGirls.TokenToIdle.HasAvailableChair = Self.HasAvailableChair()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseThrone(Participant01))
		FlowerGirls.TokenToIdle.HasAvailableThrone = Self.HasAvailableThrone()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseWorkbench(Participant01))
		FlowerGirls.TokenToIdle.HasAvailableWorkbench = Self.HasAvailableWorkbench()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseAlchemyBench(Participant01) && FlowerGirls.TokenToIdle.HasAvailableWorkbench == False)
		FlowerGirls.TokenToIdle.HasAvailableAlchemyBench = Self.HasAvailableAlchemyBench()
	endIf
	if (FlowerGirls.TokenToIdle.CanUseEnchantingBench(Participant01) && FlowerGirls.TokenToIdle.HasAvailableAlchemyBench == False)
		FlowerGirls.TokenToIdle.HasAvailableEnchantingBench = Self.HasAvailableEnchantingBench()
	endIf
	
	animCurrentStage = 0
	hasCleanedUp = False
	
	int _rnd = 0
	int lastSceneType = 0
	if (FlowerGirlsConfig.DX_LAST_SCENETYPE != NONE)
		lastSceneType = FlowerGirlsConfig.DX_LAST_SCENETYPE.GetValueInt()
	endIf
	_debugMode = FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt()
	if (_debugMode)
		if (FlowerGirlsConfig.DX_DEBUG_SEQUENCE.GetValueInt() > -1)
			_rnd = FlowerGirlsConfig.DX_DEBUG_SEQUENCE.GetValueInt()
		else
			int sequenceCount = FlowerGirls.TokenToIdle.ConvertTokenToSequences(Participants[0])
			int playSequence = 0
			if (lastSceneType == FlowerGirlsConfig.DX_PREVIOUS_SCENETYPE.GetValueInt())
				playSequence = FlowerGirlsConfig.DX_LAST_SEQUENCE.GetValueInt() + 1
				if (playSequence > sequenceCount)
					playSequence = 0
				endIf
				FlowerGirlsConfig.DX_LAST_SEQUENCE.SetValueInt(playSequence)
			endIf
			_rnd = playSequence
		endIf
	else
		_rnd = Utility.RandomInt(0, FlowerGirls.TokenToIdle.ConvertTokenToSequences(Participants[0]))
	endIf
	if (FlowerGirlsConfig.DX_PREVIOUS_SCENETYPE != NONE)
		FlowerGirlsConfig.DX_PREVIOUS_SCENETYPE.SetValueInt(lastSceneType)
	endIf

	; Convert our love tokens into Idles
	Participants[0].AnimationSequence = FlowerGirls.TokenToIdle.ConvertTokenToIdles(Participants[0], _rnd)
	if (!isSoloScene)
		Participants[1].AnimationSequence = FlowerGirls.TokenToIdle.ConvertTokenToIdles(Participants[1], _rnd)
	endIf
	if (isThreesome)
		Participants[2].AnimationSequence = FlowerGirls.TokenToIdle.ConvertTokenToIdles(Participants[2], _rnd)
	endIf
	
	; Retrieve our sequence durations based on love token
	animStageDurations = FlowerGirls.TokenToIdle.ConvertTokenToDurations(Participants[0], _rnd)
	
	; Resize our schlong bends if required (never needed on threesomes)
	if (!isSoloScene && !isThreesome)
		FlowerGirls.TokenToIdle.ResizeSchlongArray(Participants[0])
		FlowerGirls.TokenToIdle.ResizeSchlongArray(Participants[1])
	endIf
	
	if (FlowerGirls.TokenToIdle.IsUsingBed || FlowerGirls.TokenToIdle.IsUsingTable \
		|| FlowerGirls.TokenToIdle.IsUsingChair || FlowerGirls.TokenToIdle.IsUsingThrone \
		|| FlowerGirls.TokenToIdle.IsUsingWorkbench || FlowerGirls.TokenToIdle.IsUsingAlchemyBench \
		|| FlowerGirls.TokenToIdle.IsUsingEnchantingBench)
		if (FlowerGirls.TokenToIdle.IsUsingBed)
			FurnitureStaticBaseRef = BedStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingChair)
			FurnitureStaticBaseRef = ChairStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingTable)
			FurnitureStaticBaseRef = TableStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingThrone)
			FurnitureStaticBaseRef = ThroneStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingWorkbench)
			FurnitureStaticBaseRef = WorkbenchStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingAlchemyBench)
			FurnitureStaticBaseRef = AlchemyBenchStaticBaseRef
		elseIf (FlowerGirls.TokenToIdle.IsUsingEnchantingBench)
			FurnitureStaticBaseRef = EnchantingBenchStaticBaseRef
		endIf
		isUsingFurniture = True
		Participant01.IsUsingFurniture = True
		Participant02.IsUsingFurniture = True
		FurnitureStaticBaseRef.BlockActivation(True)
	endIf
	
	; Do not allow the scene to proceed with no Anims for actor 1.
	if (Participants[0].AnimationSequence != "")
	
		; Fade out for a few seconds
		if (isPlayerInvolved)
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 2) && !isSoloScene)
				FlowerGirlsConfig.FadeToBlackImod.Apply()
			endIf
		endIf
	
		animStages = Participants[0].AnimationSequence.Length
		animCurrentStage = 0
		hasCleanedUp = False

		;-----------------------------------------------------------------------------------
		; Conduct a singular pass when the animation scene begins to determine
		; which voices are available based on user settings. As well as which voice
		; version to use for each slot. This is done for performance rather than
		; performing these checks on each and every topic info.
		;-----------------------------------------------------------------------------------
		if (FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.GetValueInt())
			int actor1Sex = Participants[0].Gender
			int actor2Sex = -1
			int actor3Sex = -1
			
			bool bSuppressActor1 = Participants[0].SuppressSound
			bool bSuppressActor2 = False
			
			if (Participant02.GetActorReference() != NONE)
				actor2Sex = Participants[1].Gender
				bSuppressActor2 = Participants[1].SuppressSound
			endIf
			if (Participant03.GetActorReference() != NONE)
				actor3Sex = Participants[2].Gender
			endIf

			if (FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt() <= 1)
				if (actor1Sex == 1 && !bSuppressActor1)
					IsFemaleEnabledActor1 = True
				endIf
				if (actor2Sex == 1 && !bSuppressActor2)
					IsFemaleEnabledActor2 = True
				endIf
				if (actor3Sex == 1)
					IsFemaleEnabledActor3 = True
				endIf

				if (actor1Sex == 0 && actor2Sex == 1)
					IsFemaleVoice2Actor2 = True
				elseIf(actor1Sex == 1 && (actor2Sex == 0 || actor2Sex == -1))
					IsFemaleVoice2Actor1  = True
				elseIf(actor1Sex == 1 && actor2Sex == 1)
					IsFemaleVoice2Actor1 = False
					IsFemaleVoice2Actor2 = True
				endIf
				if (actor1Sex == 1 && actor2Sex == 1 && actor3Sex == 1)
					IsFemaleVoice2Actor1 = True
					IsFemaleVoice2Actor2 = True
				endIf
			endIf
			
			If (FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt() == 0 || FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt() == 2)
				if (actor1Sex == 0 && !bSuppressActor1)
					IsMaleEnabledActor1 = True
				endIf
				if (actor2Sex == 0 && !bSuppressActor2)
					IsMaleEnabledActor2 = True
				endIf
				if (actor3Sex == 0)
					IsMaleEnabledActor3 = True
				endIf
			endIf
		endIf
		
		_vrMode = FlowerGirlsConfig.DX_VR_MODE.GetValueInt()
		_skse64 = FlowerGirlsConfig.DX_SKSE_AVAILABLE.GetValueInt()
		if (_skse64)
			_papyrusUtils = FlowerGirls.FlowerGirlsMod.PapyrusUtilsInstalled
			if (isPlayerInvolved)
				if (_vrMode == 0)
					if (_papyrusUtils)
						RegisterForKey(FlowerGirlsConfig.KeycodeToggleFreecam)
					endIf
				endIf
				RegisterForKey(FlowerGirlsConfig.KeycodeAdvanceStage)
				RegisterForKey(FlowerGirlsConfig.KeycodeEndScene)
			endIf
		endIf
		
		GotoState("InitiateScene")
		RegisterForUpdate(0.2)
		
		return True
	else
			; This is our Try-Catch block. Prevent the scene proceeding further.
			Debug.Notification("Unable to play this scene. An error has occurred retrieving the animations.")
			Debug.Trace(Self + " Stopping Scene due to no animations for actor 1: " + Participants[0] )
			hasCleanedUp = True
			return False
	endIf	
	
endFunction

;-----------------------------------------------------------------------------------
; OnKeyUp(): Key events fired if user has SKSE64 and PapyrusUtils.
;-----------------------------------------------------------------------------------
Event OnKeyUp(Int KeyCode, Float HoldTime)
	if (isPlayerInvolved)
		if (KeyCode == FlowerGirlsConfig.KeycodeToggleFreecam)
			if (_freecamEngaged)
				MiscUtil.SetFreeCameraState(False)
				_freecamEngaged = False
			else
				MiscUtil.SetFreeCameraState(True, FlowerGirlsConfig.FreecamSpeed)
				_freecamEngaged = True
			endIf
		elseIf (KeyCode == FlowerGirlsConfig.KeycodeAdvanceStage)
			RegisterForSingleUpdate(0.1)
			GotoState("Animating")
		elseIf (KeyCode == FlowerGirlsConfig.KeycodeEndScene)
			UnregisterForAllKeys()
			RegisterForSingleUpdate(0.1)
			GotoState("CleanStopAnimating")
		endIf
	endIf
EndEvent

;-----------------------------------------------------------------------------------
; #State InitiateScene: 
;----------------------------------------------------------------------------------- 
State InitiateScene
	Event OnUpdate()
		Debug.Trace(Self + " Initiating Flower Girls Scene. Stages: " + animStages)
		UnregisterForUpdate()
		
		; Check if VR Mode is being used. If so create a dummy actor.
		if (isPlayerInvolved)
			if (_vrMode == 1)
				VrDummyActor = PlayerRef.PlaceActorAtMe(PlayerRef.GetBaseObject() as ActorBase, 1, none)
				VrDummyActor.SetOutfit(FlowerGirlsConfig.NakedOutfit, False)
				VrDummyActor.RemoveAllItems()
				Utility.Wait(1.0)
				IsUsingVrDummy = True
				if (Participant01.GetActorReference() == PlayerRef)
					Participant01.ForceRefTo(VrDummyActor)
				elseIf (Participant02.GetActorReference() == PlayerRef)
					Participant02.ForceRefTo(VrDummyActor)
				elseIf (Participant03.GetActorReference() == PlayerRef)
					Participant03.ForceRefTo(VrDummyActor)
				endIf
				VRPlayerParticipant.ForceRefTo(PlayerRef)
			elseIf (_vrMode == 2)
				if (Participant01.GetActorReference() == PlayerRef)
					Participant01.IsVRActor = True
					Participant01.VRPartnerRef = Participant02.GetActorReference()
				elseIf (Participant02.GetActorReference() == PlayerRef)
					Participant02.IsVRActor = True
					Participant02.VRPartnerRef = Participant01.GetActorReference()
				elseIf (Participant03.GetActorReference() == PlayerRef)
					Participant03.IsVRActor = True
					Participant03.VRPartnerRef = Participant01.GetActorReference()
				endIf
			endIf
		endIf
		
		Utility.Wait(0.2) ; Adds a little time to ensure markers are placed correctly.
		
		; Find the Position of the scene.
		if (isUsingFurniture)
			SexPositionRef = FurnitureStaticBaseRef.PlaceAtMe(FlowerGirlsConfig.StaticBaseRef, 1, false, false)
		else
			Actor _actor
			if (isPlayerInvolved && _vrMode == 0)
				_actor = PlayerRef
			else
				_actor = Participant01.GetActorReference()
			endIf
			SexPositionRef = _actor.PlaceAtMe(FlowerGirlsConfig.StaticBaseRef, 1, false, false)
			SexPositionRef.SetAngle(_actor.GetAngleX(), _actor.GetAngleY(), _actor.GetAngleZ())
		endIf
		
		; Get our scale to set the actors to.
		float scale = 1.0
		if (isPlayerInvolved)
			scale = PlayerRef.GetScale()
		else
			scale = Participant01.GetActorReference().GetScale()
		endIf
		
		bool stripPlayer = (FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 1 || FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 2)
		bool stripNpc = (FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 1 || FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt() == 3)
		bool debugMode = _debugMode
		bool useStrapOn = (FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt() > 0)
		bool useStrapOnCbbe = (FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt() == 2)
		bool useScaling = FlowerGirlsConfig.DX_USE_SCALING.GetValueInt()
		bool useSoundFx = FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.GetValueInt()
		
		int cnt = 0
		while (cnt < Participants.Length)
			Participants[cnt].UseScaling = useScaling
			Participants[cnt].StripPlayer = stripPlayer
			Participants[cnt].StripNpc = stripNpc
			Participants[cnt].UseStrapOn = useStrapOn
			Participants[cnt].UseStrapOnCbbe = useStrapOnCbbe
			Participants[cnt].DebugMode = debugMode
			Participants[cnt].SexPositionRef = SexPositionRef
			Participants[cnt].ScaleTo = scale
			Participants[cnt].SoundFXEnabled = useSoundFx
			Participants[cnt].SetUpActorForScene()
			cnt += 1
		endWhile
		
		Utility.Wait(2.0)
		
		if (isPlayerInvolved)
			; Remove Fade out screen
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 2) && !isSoloScene)
				FlowerGirlsConfig.FadeToBlackImod.Remove()
			endIf
		endIf
		
		if (isSoloScene)
			FlowerGirls.KeywordSexStarted.SendStoryEvent(None, Participant01.GetActorReference())
		elseIf (isThreesome)
			FlowerGirls.KeywordSexStarted.SendStoryEvent(None, Participant02.GetActorReference(), Participant03.GetActorReference())
		else
			FlowerGirls.KeywordSexStarted.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
		endIf
		
		RegisterForSingleUpdate(0.1)
		GotoState("Animating")

	EndEvent
EndState

;-----------------------------------------------------------------------------------
; #State Animating: 
;----------------------------------------------------------------------------------- 
State Animating
	Event OnUpdate()
		UnregisterForUpdate()
		
		bool brk = false
		int cnt = 0
		while (cnt < Participants.Length && !brk)
			brk = !(Participants[cnt].PlayIdleStage(animCurrentStage))
			cnt += 1
		endWhile
		
		if (brk)
			RegisterForSingleUpdate(0.1)
			GotoState("StopAnimating")
			return
		endIf
		
		if (_debugMode)
			Debug.Trace(Self + " Animating: SEQ: " + Participants[0].AnimationSequence[animCurrentStage] + " SchlongBend: " + Participants[0].CurrentSchlongBend)
		endIf
		
		; Progress stages on the Animation Controller Scene.
		int controlStage = 10
		if ((Participants[0].IsUsingKissing == False) && animStages > 3)
			; First 3 stages are reserved for kissing animations and sounds.
			controlStage += 3
		endIf
		controlStage += animCurrentStage
	
		if (animStages == 3)
			; Is kissing scene.
			if (controlStage < 12)
				Self.SetStage(controlStage)
			endIf
		else
			string sPhase = ""
			If ((animStages - 5) == animCurrentStage)
				sPhase = "4"
				Self.SetStage(15) ; Light Sounds
			elseIf ((animStages - 4) == animCurrentStage)
				sPhase = "5"
				Self.SetStage(16) ; Medium Sounds
			elseIf ((animStages - 3) == animCurrentStage)
				sPhase = "6"
				Self.SetStage(17) ; Heavy Sounds
			elseIf ((animStages - 2) == animCurrentStage)
				sPhase = "7"
				Self.SetStage(18) ; End Sounds
				
				; Update the time the player last had sex.
				if (SceneType > 1 && isPlayerInvolved)
					FlowerGirls.PlayerLastHadSexGametime = Utility.GetCurrentGameTime()
				endIf
				
				; Send climax story event
				if (isSoloScene)
					FlowerGirls.KeywordSexClimax.SendStoryEvent(None, Participant01.GetActorReference())
				else
					FlowerGirls.KeywordSexClimax.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
				endIf
			else
				Self.SetStage(controlStage)
			endIf
			
			if (_debugMode)
				Debug.Notification("Phase " + sPhase + " - Playing: " + Participants[0].AnimationSequence[animCurrentStage] + " Schlong Bend: " + Participants[0].CurrentSchlongBend)
			endIf
			
		endIf
		
		if ((animStages - 1) == animCurrentStage)
		
			; Finish Animation Controller Scene
			if (animStages > 3) ; Don't send if kissing scene.
				Self.SetStage(19)
			endIf
		
			RegisterForSingleUpdate(animStageDurations[animCurrentStage])
			
			if (isPlayerInvolved)
				if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 3) && !isSoloScene)
					FlowerGirlsConfig.FadeToBlackImod.Apply()
				endIf
			endIf
			
			GotoState("StopAnimating")
		else
			;;Added by skip to alert listeners to a scene change
			if (isSoloScene)
				FlowerGirls.KeywordStageAdvanced.SendStoryEvent(None, Participant01.GetActorReference(), None, animCurrentStage, animStages)
			elseIf (isThreesome)
				FlowerGirls.KeywordStageAdvanced.SendStoryEvent(None, Participant02.GetActorReference(), Participant03.GetActorReference(), animCurrentStage, animStages)
			else
				FlowerGirls.KeywordStageAdvanced.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference(), animCurrentStage, animStages)
			endIf
		
			RegisterForUpdate(animStageDurations[animCurrentStage])
			animCurrentStage += 1
		endIf
	EndEvent
EndState

;-----------------------------------------------------------------------------------
; #StopAnimating:
;----------------------------------------------------------------------------------- 
State StopAnimating
	Event OnUpdate()
		UnregisterForUpdate()

		if (_skse64)
			if (isPlayerInvolved)
				UnregisterForAllKeys()
				if (_papyrusUtils && !_vrMode)
					MiscUtil.SetFreeCameraState(False)	; Send this regardless.. so if user has used TFC at console, it will end it.
					_freecamEngaged = False
				endIf
			endIf
		endIf
		
		if (SoundStageScene.IsPlaying())
			SoundStageScene.Stop()
			Utility.Wait(0.1)
		endIf
		
		; Allow delay if script wait time is used.
		float delay = FlowerGirlsConfig.DX_SCRIPT_WAIT_TIME.GetValue()
		
		int cnt = 0
		while (cnt < Participants.Length)
			Participants[cnt].ReleaseActorFromScene()
			if (delay > 0.0)
				Utility.Wait(delay)
			endIf
			cnt += 1
		endWhile
		
		; Clean-up VR model
		if (isUsingVrDummy)
		
			; Place the player back into the participants
			if (Participant01.GetActorReference() == VrDummyActor)
				Participant01.ForceRefTo(PlayerRef)
			elseIf (Participant02.GetActorReference() == VrDummyActor)
				Participant02.ForceRefTo(PlayerRef)
			elseIf (Participant03.GetActorReference() == VrDummyActor)
				Participant03.ForceRefTo(PlayerRef)
			endIf
			
			; Remove threeway faction from player if applicable.
			if (isThreesome)
				if (VRPlayerParticipant.GetActorReference().IsInFaction(FlowerGirls.FlowerGirlsMod.ThreewayFaction))
					VRPlayerParticipant.GetActorReference().RemoveFromFaction(FlowerGirls.FlowerGirlsMod.ThreewayFaction)
				endIf
			endIf
		
			VrDummyActor.Disable()
			VrDummyActor.Delete() ; Credit to Min for finding issue here.
			isUsingVrDummy = False
		endIf
		
		; Reset the global flags.
		FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.SetValueInt(0)
		
		animStages = 0
		animCurrentStage = 0
		
		if (isUsingFurniture)
			FurnitureStaticBaseRef.BlockActivation(False)
		endIf
		
		isUsingFurniture = False
		
		; Clean up markers
		FurnitureStaticBaseRef = NONE
		TableStaticBaseRef = NONE
		ChairStaticBaseRef = NONE
		ThroneStaticBaseRef = NONE
		BedStaticBaseRef = NONE
		WorkbenchStaticBaseRef = NONE
		AlchemyBenchStaticBaseRef = NONE
		EnchantingBenchStaticBaseRef = NONE
		
		if (SexPositionRef != NONE)
			SexPositionRef.Disable()
			SexPositionRef.Delete()
		endIf
	
		hasCleanedUp = True

		; Remove Fade out screen
		if (isPlayerInvolved)
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 3) && !isSoloScene)
				FlowerGirlsConfig.FadeToBlackImod.Remove()
			endIf
		endIf
		
		RegisterForSingleUpdate(2.0)
		GoToState("Flush")

	EndEvent
EndState

;------------------------------------------------------------------------------------
; #CleanStopAnimating: Used when user exits the scene with hotkey.
;------------------------------------------------------------------------------------
State CleanStopAnimating
	Event OnUpdate()
		if (isPlayerInvolved)
			if ((FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 1 || FlowerGirlsConfig.DX_CINEMATIC.GetValueInt() == 3) && !isSoloScene)
				FlowerGirlsConfig.FadeToBlackImod.Apply()
			endIf
		endIf
		
		GotoState("StopAnimating")
		RegisterForSingleUpdate(0.5)
	EndEvent
EndState

;-----------------------------------------------------------------------------------
; #No Animations:
;----------------------------------------------------------------------------------- 
State NoAnimations
	Event OnUpdate()
		UnregisterForUpdate()
		
		; Fade out for a few seconds
		FlowerGirlsConfig.FadeToBlackImod.Apply()
		
		Utility.Wait(2.0)
		; Display MessageBox
		if (Self.SceneType == 1)	; Kissing scene
			FlowerGirlsConfig.MsgSexHappenedKiss.Show()
		elseIf (isSoloScene)
			FlowerGirlsConfig.MsgSexHappenedSolo.Show()
		else
			FlowerGirlsConfig.MsgSexHappened.Show()
		endIf
		
		; Fade to normal.
		FlowerGirlsConfig.FadeToBlackBackImod.Apply()
		FlowerGirlsConfig.FadeToBlackImod.Remove()
		Utility.Wait(2.0)
		
		; Send Climax Event
		if (isSoloScene)
			FlowerGirls.KeywordSexClimax.SendStoryEvent(None, Participant01.GetActorReference())
		else
			FlowerGirls.KeywordSexClimax.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
		endIf
		
		if (SoundStageScene.IsPlaying())
			SoundStageScene.Stop()
			Utility.Wait(0.1)
		endIf
		
		; Reset the global flags.
		FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.SetValueInt(0)
		
		animStages = 0
		animCurrentStage = 0
			
		isUsingFurniture = False
		
		; Clean up markers
		FurnitureStaticBaseRef = NONE
		TableStaticBaseRef = NONE
		ChairStaticBaseRef = NONE
		ThroneStaticBaseRef = NONE
		BedStaticBaseRef = NONE
		WorkbenchStaticBaseRef = NONE
		AlchemyBenchStaticBaseRef = NONE
		EnchantingBenchStaticBaseRef = NONE
		
		hasCleanedUp = True
		
		RegisterForSingleUpdate(2.0)
		GoToState("Flush")
		
	EndEvent
EndState

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
		
		; Send story event
        if (isSoloScene)
			FlowerGirls.KeywordSexCompleted.SendStoryEvent(None, Participant01.GetActorReference())
        elseif (isThreesome)
            FlowerGirls.KeywordSexCompleted.SendStoryEvent(None, Participant02.GetActorReference(), Participant03.GetActorReference())
        else
            FlowerGirls.KeywordSexCompleted.SendStoryEvent(None, Participant01.GetActorReference(), Participant02.GetActorReference())
        endIf
		
		Debug.Trace(Self + " OnUpdate(): Flushing aliases")
		; Clear aliases
		if (Participant01.GetActorReference() != None)
			Participant01.Clear()
		endIf
		if (Participant02.GetActorReference() != None)
			Participant02.Clear()
		endIf
		if (Participant03.GetActorReference() != None)
			Participant03.Clear()
		endIf
		if (VRPlayerParticipant.GetActorReference() != None)
			VRPlayerParticipant.Clear()
		endIf
		
		Self.Reset()
		Self.Stop()
		
	EndEvent
EndState

bool Function HasAvailableBed()
	BedStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureBeds, Participant01.GetActorReference(), 256.0)
	if (BedStaticBaseRef != NONE)
		if (BedStaticBaseRef.Is3DLoaded() && !BedStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableBed(): Located suitable furniture: " + BedStaticBaseRef)
			return True
		else
			BedStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction

bool Function HasAvailableChair()
	ChairStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureChairs, Participant01.GetActorReference(), 198.0)
	if (ChairStaticBaseRef != NONE)
		if (ChairStaticBaseRef.Is3DLoaded() && !ChairStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableChair(): Located suitable furniture: " + ChairStaticBaseRef)
			return True
		else
			ChairStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction

bool Function HasAvailableThrone()
	ThroneStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureThrones, Participant01.GetActorReference(), 256.0)
	if (ThroneStaticBaseRef != NONE)
		if (ThroneStaticBaseRef.Is3DLoaded() && !ThroneStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableThrone(): Located suitable furniture: " + ThroneStaticBaseRef)
			return True
		else
			ThroneStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction

bool Function HasAvailableWorkbench()
	WorkbenchStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureWorkbenches, Participant01.GetActorReference(), 256.0)
	if (WorkbenchStaticBaseRef != NONE)
		if (WorkbenchStaticBaseRef.Is3DLoaded() && !WorkbenchStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableWorkbench(): Located suitable furniture: " + WorkbenchStaticBaseRef)
			return True
		else
			WorkbenchStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction

bool Function HasAvailableTable()
	
	;TableStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureTables, Participant01.GetActorReference(), 256.0)
	;if (TableStaticBaseRef != NONE)
	;	if (TableStaticBaseRef.Is3DLoaded())
	;		Debug.Trace(Self + " HasAvailableTable(): Located suitable furniture: " + TableStaticBaseRef)
	;		return True
	;	else
	;		TableStaticBaseRef = NONE
	;	endIf
	;endIf
	
	return False
endFunction

bool Function HasAvailableAlchemyBench()
	AlchemyBenchStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureWorkbenchesAlch, Participant01.GetActorReference(), 198.0)
	if (AlchemyBenchStaticBaseRef != NONE)
		if (AlchemyBenchStaticBaseRef.Is3DLoaded() && !AlchemyBenchStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableAlchemyBench(): Located suitable furniture: " + AlchemyBenchStaticBaseRef)
			return True
		else
			AlchemyBenchStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction

bool Function HasAvailableEnchantingBench()
	EnchantingBenchStaticBaseRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureWorkbenchesEnch, Participant01.GetActorReference(), 198.0)
	if (EnchantingBenchStaticBaseRef != NONE)
		if (EnchantingBenchStaticBaseRef.Is3DLoaded() && !EnchantingBenchStaticBaseRef.IsActivationBlocked())
			Debug.Trace(Self + " HasAvailableEnchantingBench(): Located suitable furniture: " + EnchantingBenchStaticBaseRef)
			return True
		else
			EnchantingBenchStaticBaseRef = NONE
		endIf
	endIf
	return False
endFunction
