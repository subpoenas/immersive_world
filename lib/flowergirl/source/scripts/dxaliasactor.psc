;------------------------------------------------------------------------------------
; dxAliasActor by Xider
;------------------------------------------------------------------------------------
; This script applies to each actor being animated and controls each aspect
; of the Actor whilst the scene is playing.
;------------------------------------------------------------------------------------
Scriptname dxAliasActor extends dxAliasActorBase

Static Property StaticBaseRef Auto
{Holds a dxAnimationMarker static object for the actor placement.}

bool Property UseScaling = False Auto Hidden
{Allows user setting whether to enable/disable NPC scaling.}

bool Property SuppressSound = False Auto Hidden
{Sets whether this actor has sound suppressed.}
ObjectReference Property SexPositionRef Auto Hidden
{Sets the position in the world the scene will take place.}
float Property ScaleTo = 1.0 Auto Hidden
{Sets the scale that non-player actors will use to scale too.}

float Property PosXOffset = 0.0 Auto Hidden					; Float value to offset the X position for this actor.
float Property PosYOffset = 0.0 Auto Hidden					; Float value to offset the Y position for this actor.
float Property PosZOffset = 0.0 Auto Hidden					; Float value to offset the Z position for this actor.

bool Property IsUsingKissing = False Auto Hidden			; Flag to hold whether kissing was initiated for the scene.
bool Property IsThreesome = False Auto Hidden 				; Flag if this is a threesome.
bool Property IsSoloScene = False Auto Hidden				; Flag if this is a solo scene.
bool Property IsUsingFurniture = False Auto Hidden		; Flag if this scene is using either bed or throne.

ObjectReference OriginalPositionRef
ObjectReference ActorPositionRef

float _sceneSFXInterval = 0.0
int _sceneSFXType = 0
int _soundID = 0

;------------------------------------------------------------------
; Options for the scene
;------------------------------------------------------------------
Ammo Property 	SexType Auto Hidden										; Holds the animation token to use for the scene.
string[] Property 	AnimationSequence	Auto Hidden				; Holds the animation sequence for this actor.
bool Property			UseOralExpression = False Auto Hidden	; Specifies whether the actor should use the oral expression.
bool[] Property		OralExpressionToggles Auto Hidden			; Holds the toggle for each stage in the sequence.
int[] Property 		SchlongBends Auto Hidden							; Holds the Schlong bends for each stage in this scene.
int[] Property			SoundTypes Auto Hidden							; Holds the SoundFX type for each stage of the animation sequence.
float[] Property		SoundTimings Auto Hidden							; Holds the timings for repeating sounds for each stage.
bool Property			SoundFXEnabled Auto Hidden					; User selected enable/disable for FG sound effects.
bool Property			UseSoundFX = False Auto Hidden				; Specifies whether the actor should use optional Sound FX.
bool[] Property		EjaculationStages Auto Hidden					; The actor will display the ejaculation effect for this scene.
int Property			CumTextureLocation = -1 Auto Hidden		; Will display a post sex cum texture at the location specified:
																									; 1 - Vaginal, 2 - Oral, 3 - Anal, 4 - Stomach, 5 - Back, 6 - Facial, 7 - Chest

																									
int _currentSchlongBend = 0
int Property CurrentSchlongBend Hidden 
	int Function Get()
		return _currentSchlongBend
	endFunction
endProperty

;-----------------------------------------------------------------
; Set-up, tear down and animation functions
;-----------------------------------------------------------------

;-----------------------------------------------------------------
; SetUpActorForScene(): Main function to configure the
;	Actor alias for the scene. Called from Initialize phase
;	of the animator.
;-----------------------------------------------------------------
Function SetUpActorForScene()
	
	; Size the equipment cache arrays
	ClearEquipmentCache()
		
	if (DebugMode)
		Debug.Trace (Self + " ~~~~~~~~~~~~~~~~ SetUpActorForScene: " + ActorRef + " ~~~~~~~~~~~~~~~~")
		Debug.Trace (Self + " Var: IsThreesome: " + IsThreesome + " IsSoloScene: " + IsSoloScene + " IsUsingFurniture: " + IsUsingFurniture)
		Debug.Trace (Self + " Var: UseStrapOn: " + UseStrapOn + " UseStrapOnCbbe: " + UseStrapOnCbbe + " IsDomRole: " + IsDomRole)
		Debug.Trace (Self + " Var: StripPlayer: " + StripPlayer + " StripNpc: " + StripNpc)
		Debug.Trace (Self + " Var: UseScaling: " + UseScaling + " ScaleTo: " + ScaleTo)
		Debug.Trace (Self + " Var: IsRestrained: " + IsRestrained + " UseOralExpression: " + UseOralExpression)
		Debug.Trace (Self + " Var: IsVRActor: " + IsVRActor)
		Debug.Trace (Self + " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	endIf
	
	if (IsVRActor)
		; ObjectReference akActor, float afOffsetX, float afOffsetY, float afOffsetZ, float afOffsetHeading
		;Game.PlayerAllowUpdateHmd(False)
		;Game.PlayerAttachToActor(VRPartnerRef, 20.0, 0, 0, 0)
		return	; No positioning or setup for the player in VR.
	endIf
	
	if (IsPlayer)
		Game.ForceThirdPerson()
		Game.DisablePlayerControls(true, true, true, false, true, true, true, false, 0)
	else
		ActorRef.SetRestrained(True)
		ActorRef.SetDontMove(True)		; Prevent any NPC's from being pushed. Do not use on Player.
		ActorRef.SetAlert(False)			; Clears any alerts from the npc.
	endIf
	
	ActorRef.EvaluatePackage()
	ActorRef.ClearKeepOffsetFromActor()
	ActorRef.SetHeadTracking(False)
	
	StartMonitoring()	; Start equipment monitoring for the actor.
	UndressActor()
	
	Debug.SendAnimationEvent(ActorRef, "SOSSlowErect")
	PositionActor()
	ScaleActor()
	
	if (FlowerGirlsConfig.DX_SCENE_LIGHTING.GetValueInt() == 1)
		; Apply scene lighting
		FlowerGirlsConfig.SceneLightSpell.Cast(ActorRef)
	endIf
endFunction

;-----------------------------------------------------------------
; ReleaseActorFromScene(): Main function to configure the
;	Actor alias for completion. Called from Stop animation 
;	phase of the animator.
;-----------------------------------------------------------------
Function ReleaseActorFromScene()

	DebugThis("ReleaseActorFromScene()", "Releasing Actor...")
	
	if (IsVRActor)
		;Game.PlayerAllowUpdateHmd(True)
		if (isThreesome)
			if (ActorRef.IsInFaction(FlowerGirlsScript.FlowerGirlsMod.ThreewayFaction))
				ActorRef.RemoveFromFaction(FlowerGirlsScript.FlowerGirlsMod.ThreewayFaction)
				DebugThis("ReleaseActorFromScene()", "Removed Actor from Threesome Faction.")
			endIf
		endIf
		DebugThis("ReleaseActorFromScene()", "VR Player Actor released from scene successfully.")
		return
	endIf
	
	if (_soundID != 0)
		Sound.StopInstance(_soundID)
	endIf
	
	Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	
	ActorRef.StopTranslation()
	ActorRef.SetVehicle(NONE)
	Utility.Wait(1.0)		; Delay to allow SetVehicle to rescale the actor.
	DebugThis("ReleaseActorFromScene()", "SetVehicle NONE called.")
	
	RedressActor()
	StopMonitoring()		; Stop monitoring equipment for this actor.
	DebugThis("ReleaseActorFromScene()", "Redressed Actor.")
		
	Debug.SendAnimationEvent(ActorRef, "SOSFlaccid")
	RestoreActorPosition()
	DebugThis("ReleaseActorFromScene()", "Restored Actor to original position.")
	
	; Adding a temporary expression override here to reset face manually to neutral.
	ActorRef.SetExpressionOverride(7, 100)
		
	;if (UseOralExpression)
	;	ActorRef.ClearExpressionOverride()
	;endIf
	
	if (IsPlayer)
		Game.EnablePlayerControls()
	else	
		ActorRef.SetRestrained(False)
		ActorRef.SetDontMove(False)	
		ActorRef.SetHeadTracking(True)
		if (isThreesome)
			if (ActorRef.IsInFaction(FlowerGirlsScript.FlowerGirlsMod.ThreewayFaction))
				ActorRef.RemoveFromFaction(FlowerGirlsScript.FlowerGirlsMod.ThreewayFaction)
				DebugThis("ReleaseActorFromScene()", "Removed Actor from Threesome Faction.")
			endIf
		endIf
	endIf
	DebugThis("ReleaseActorFromScene()", "Restored actor control.")

	ReverseActorScale()
	DebugThis("ReleaseActorFromScene()", "Reversed any Actor scaling.")
	
	if (FlowerGirlsConfig.DX_SCENE_LIGHTING.GetValueInt() == 1)
		ActorRef.DispelSpell(FlowerGirlsConfig.SceneLightSpell)
	endIf
	
	ActorRef.EvaluatePackage()
	
	; Now clear the expression override applied earlier.
	if !(MfgConsoleFunc.ResetPhonemeModifier(ActorRef))
		ActorRef.ClearExpressionOverride()
	endIf
	
	DebugThis("ReleaseActorFromScene()", "Actor released from scene successfully.")
	
endFunction

;---------------------------------------------------------------------------
; PlayIdleStage(): Sends the animation event.
;	int stage: Corresponds to the index of the array.
;---------------------------------------------------------------------------
bool Function PlayIdleStage(int stage)
	if (AnimationSequence[stage] != "")
		if (IsVRActor)
			return True
		endIf
	
		if (stage >= SchlongBends.Length)
			DebugThis("PlayIdleStage()", "SchlongBends array length is: " + SchlongBends.Length + " and requested stage is: " + stage)
		else
			_currentSchlongBend = SchlongBends[stage]
			Debug.SendAnimationEvent(ActorRef, "SOSBend" + SchlongBends[stage])
		endIf
		
		Debug.SendAnimationEvent(ActorRef, AnimationSequence[stage])
		
		if (SoundFXEnabled)
			int idx = stage
			if (IsUsingKissing)
				idx -= 3
			endIf
			if (idx >= 0)
				_sceneSFXType = SoundTypes[idx]
				if (_sceneSFXType > 0)
					_sceneSFXInterval = SoundTimings[idx]
					if (_sceneSFXInterval > 0.0)
						RegisterForSingleUpdate((_sceneSFXInterval / 2))
					endIf
				else
					UnregisterForUpdate()
				endIf
			endIf
			
			if (UseSoundFX)
				FlowerGirlsScript.FlowerGirlsSFX.PlaySoundFX(ActorRef, stage)
			endIf
		endIf
		
		if (UseOralExpression)
			if (OralExpressionToggles[stage])
				ActorRef.SetExpressionOverride(16, 100)
				;if !(MfgConsoleFunc.SetPhoneme(ActorRef, 11, 80))
				;	ActorRef.SetExpressionOverride(16, 100)
				;endIf
				DebugThis("PlayIdleStage()", "Setting Expression Over-ride for actor: " + ActorRef + " Stage: " + stage)
			else
				ActorRef.ClearExpressionOverride()
			endIf
		endIf
		
		if (EjaculationStages[stage] == True)
			Ejaculate()
		else
			if (IsEjaculating)
				StopEjaculating()
			endIf
		endIf
		
	else
		Debug.Trace(Self + " PlayIdleStage(): Animating State: Elements of Anim idle arrays are NONE. Stopping animation.")
		return False
	endIf
	return True
endFunction

;------------------------------------------------------------------
; Clear(): Function override from base. Clears local instance
;	variables and markers. Calls Parent.
;------------------------------------------------------------------
Function Clear()
	
	IsUsingKissing = False
	IsSoloScene = False
	IsThreesome = False
	IsUsingFurniture = False
	SuppressSound = False
	IsVRActor = False
	
	if (FlowerGirlsScript.FlowerGirlsSFX != NONE)
		FlowerGirlsScript.FlowerGirlsSFX.StopSFX()
	endIf
	
	SexType = NONE
	
	UseOralExpression = False
	UseSoundFX = False
	
	SchlongBends = new int[9]
	_currentSchlongBend = 0
	
	PosXOffset = 0.0
	PosYOffset = 0.0
	PosZOffset = 0.0
	
	ScaleTo = 1.0
	
	if (OriginalPositionRef != NONE)
		OriginalPositionRef.Disable()
		OriginalPositionRef.Delete()
	endIf
	if (ActorPositionRef != NONE)
		ActorPositionRef.Disable()
		ActorPositionRef.Delete()
	endIf
	
	Parent.Clear()
endFunction

;------------------------------------------------------
; Positioning Functions
;------------------------------------------------------

Function PositionActor()
	; Store the original starting point for the Actor
	OriginalPositionRef = ActorRef.PlaceAtMe(StaticBaseRef, 1, false, false)
	; Create new marker for this actor
	ActorPositionRef = SexPositionRef.PlaceAtMe(StaticBaseRef, 1, false, false)
	
	; Re-assign angles
	ActorPositionRef.SetAngle(SexPositionRef.GetAngleX(), SexPositionRef.GetAngleY(), SexPositionRef.GetAngleZ())
	
	if (PosXOffset != 0.0 || PosYOffset != 0.0 || PosZOffset != 0.0)
		ActorPositionRef.SetPosition(ActorPositionRef.GetPositionX() + PosXOffset, ActorPositionRef.GetPositionY() + PosYOffset, ActorPositionRef.GetPositionZ() + PosZOffset)
	endIf
	
	if (!IsPlayer || IsUsingFurniture)
		ActorRef.MoveTo(ActorPositionRef, 0.0, 0.0, 0.0, True)
	endIf
	if (FlowerGirlsConfig.DX_VR_MODE.GetValueInt() == 1)
		if (!IsPlayer)
			ActorRef.SetVehicle(ActorPositionRef)
		endIf
	else
		ActorRef.SetVehicle(ActorPositionRef)
	endIf
	ActorRef.TranslateTo(ActorPositionRef.GetPositionX(), ActorPositionRef.GetPositionY(), ActorPositionRef.GetPositionZ(), \
								ActorPositionRef.GetAngleX(), ActorPositionRef.GetAngleY(), ActorPositionRef.GetAngleZ()+0.01, 500.0, 0.0001)
endFunction

Function RestoreActorPosition()
	Utility.Wait((0.1 + FlowerGirlsConfig.DX_SCRIPT_WAIT_TIME.GetValue()))
	ActorRef.MoveTo(OriginalPositionRef, 0.0, 0.0, 2.0, True)
	Utility.Wait((0.1 + FlowerGirlsConfig.DX_SCRIPT_WAIT_TIME.GetValue()))
endFunction

;------------------------------------------------------
; Scaling Functions
;------------------------------------------------------

Function ScaleActor()
	if (UseScaling == False || isSoloScene || IsPlayer)
		DebugThis("ScaleActor()", "Scaling is off, or is a solo scene or the actor is the player. No scaling applied.")
		return
	endIf
	ActorRef.SetScale(1.0) ; SetScale(1.0) on both actors
	Utility.Wait(1.0) ; just to give time for the game to acknowledge SetScale(1.0)
	ActorRef.SetScale(ScaleTo / ActorRef.GetScale())
endFunction

Function ReverseActorScale()
	if (UseScaling == False || isSoloScene || IsPlayer)
		DebugThis("ReverseActorScale()", "Scaling is off, or is a solo scene or the actor is the player. No scaling applied.")
		return
	endIf
	ActorRef.SetScale(1.0)
EndFunction

;------------------------------------------------------
; Cum Effect Functions
;------------------------------------------------------

Function Ejaculate()
	if (IsEjaculating || FlowerGirlsConfig.DX_USE_EJACULATION.GetValueInt() != 1 || CheckUseStrapOn())
		return
	endIf

	;ActorRef.EquipItem(FlowerGirlsConfig.EjaculationEffect, False, True)
	IsEjaculating = True
endFunction

Function DisplayCumTexture()
	if (CumTextureLocation < 1)
		return
	endIf
	
endFunction

;--------------------------------------------------------
; Sound FX during scene
;--------------------------------------------------------

Event OnUpdate()
	if (_sceneSFXType == 0x000003)
		if (_sceneSFXInterval < 0.6)
			_soundID = FlowerGirlsConfig.SexSoundsPiv.Play(ActorRef)
		elseIf (_sceneSFXInterval < 0.8)
			_soundID = FlowerGirlsConfig.SexSoundsPivMed.Play(ActorRef)
		else
			_soundID = FlowerGirlsConfig.SexSoundsPivSlow.Play(ActorRef)
		endIf
	elseIf (_sceneSFXType == 0x000001)
		_soundID = FlowerGirlsConfig.SexSoundsVa.Play(ActorRef)
	elseIf (_sceneSFXType == 0x000006)
		_soundID = FlowerGirlsConfig.SexSoundsOralFemaleLight.Play(ActorRef)
	elseIf (_sceneSFXType == 0x000007)
		_soundID = FlowerGirlsConfig.SexSoundsOralFemaleMedium.Play(ActorRef)
	elseIf (_sceneSFXType == 0x000008)
		_soundID = FlowerGirlsConfig.SexSoundsOralFemaleHeavy.Play(ActorRef)
	endIf
	if (_sceneSFXInterval > 0.0)
		RegisterForSingleUpdate(_sceneSFXInterval)
	endIf
endEvent


Event OnDeath(Actor akKiller)
	Debug.Trace(Self + " Actor: " + Self.GetActorReference() + " has died. Clean-up.")
	if (PlayerRef.GetFactionRank(FlowerGirlsScript.FlowerGirlsMod.ThreewayFaction) > 0)
		FlowerGirlsScript.RemoveThreesomeParticipant(Self.GetActorReference())
	else
		Self.Clear()
	endIf
endEvent
