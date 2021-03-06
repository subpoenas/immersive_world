scriptname sslActorAlias extends ReferenceAlias

import po3_SKSEFunctions

;TODO: clean up some stat lookup stuff in sslActorAlias.
	; [10:49 PM] ak86: hi, there is an error in sslActorAlias, script calls 
	; float OwnLewd = Stats.GetSkillLevel(ActorRef, Stats.kLewd)
	; that always return 0, should be
	; float OwnLewd = Stats.GetSkillLevel(ActorRef, "Lewd")
	; [10:54 PM] Jeffl: should be float OwnLewd = Stats._GetSkill(ActorRef, Stats.kLewd) actually, I think(edited)
	; [10:55 PM] Jeffl: would have to double check, but yeah, it should be one or the other for sure. Thanks
	; [10:57 PM] Jeffl: no nvm, you're right
	; [10:58 PM] Jeffl: fixed in dev build now
	; [10:59 PM] Jeffl: what lead you to finding that out of curiosity? Seems like an obscure bug to have come across by normal means
	; [11:01 PM] ak86: was reported in my SexLab Separate Orgasm thread that Stats.GetSkillLevel﻿(ActorRef, Stats﻿.kLewd) is broken
	; [11:02 PM] ak86: probably would never be found otherwise
	; [11:03 PM] ak86: as its effects can only be seen in my mod
	; [11:03 PM] Jeffl: bleh, you've made me look at the stat code for the first time in awhile
	; [11:04 PM] Jeffl: seems like a mess, might be one of the major causes of start slowness happening right now. Going to add cleaning it up to the todo list x.x

; Framework access
sslSystemConfig Config
sslActorLibrary ActorLib
sslActorStats Stats
Actor PlayerRef

; Actor Info
Actor property ActorRef auto hidden
ActorBase BaseRef
string ActorName
int BaseSex
int Gender
bool IsMale
bool IsFemale
bool IsCreature
bool IsVictim
bool IsAggressor
bool IsPlayer
bool IsTracked
bool IsSkilled
Faction AnimatingFaction

; Current Thread state
sslThreadController Thread
int Position
bool LeadIn

float StartWait
string StartAnimEvent
string EndAnimEvent
string ActorKey
bool NoOrgasm

; Voice
sslBaseVoice Voice
VoiceType ActorVoice
float BaseDelay
float VoiceDelay
bool IsForcedSilent
bool UseLipSync

; Expression
sslBaseExpression Expression

; Positioning
ObjectReference MarkerRef
float[] Offsets
float[] Center
float[] Loc

; Storage
int[] Flags
Form[] Equipment
bool[] StripOverride
float[] Skills

bool UseScale
float StartedAt
float ActorScale
float AnimScale
float LastOrgasm
int BestRelation
int BaseEnjoyment
int Enjoyment
int Orgasms
int NthTranslation

Form Strapon
Form HadStrapon

Sound OrgasmFX

Spell HDTHeelSpell
Form HadBoots

; Animation Position/Stage flags
bool property OpenMouth hidden
	bool function get()
		return Flags[1] == 1
	endFunction
endProperty
bool property IsSilent hidden
	bool function get()
		return !Voice || IsForcedSilent || Flags[0] == 1 || Flags[1] == 1
	endFunction
endProperty
bool property UseStrapon hidden
	bool function get()
		return Flags[2] == 1 && Flags[4] == 0
	endFunction
endProperty
int property Schlong hidden
	int function get()
		return Flags[3]
	endFunction
endProperty
bool property MalePosition hidden
	bool function get()
		return Flags[4] == 0
	endFunction
endProperty

; ------------------------------------------------------- ;
; --- Load/Clear Alias For Use                        --- ;
; ------------------------------------------------------- ;

bool function SetActor(Actor ProspectRef)
	if !ProspectRef || ProspectRef != GetReference()
		return false ; Failed to set prospective actor into alias
	endIf
	; Init actor alias information
	ActorRef   = ProspectRef
	BaseRef    = ActorRef.GetLeveledActorBase()
	ActorName  = BaseRef.GetName()
	; ActorVoice = BaseRef.GetVoiceType()
	BaseSex    = BaseRef.GetSex()
	Gender     = ActorLib.GetGender(ActorRef)
	IsMale     = Gender == 0
	IsFemale   = Gender == 1
	IsCreature = Gender >= 2
	IsTracked  = Config.ThreadLib.IsActorTracked(ActorRef)
	IsPlayer   = ActorRef == PlayerRef
	; Player and creature specific
	if IsPlayer
		Thread.HasPlayer = true
	endIf
	if IsCreature
		Thread.CreatureRef = BaseRef.GetRace()
	elseIf !IsPlayer
		Stats.SeedActor(ActorRef)
	endIf
	; Actor's Adjustment Key
	ActorKey = MiscUtil.GetRaceEditorID(BaseRef.GetRace())
	if IsCreature
		ActorKey += "C"
	elseIf BaseSex == 1
		ActorKey += "F"
	else
		ActorKey += "M"
	endIf
	; Set base voice/loop delay
	if IsCreature
		BaseDelay  = 3.0
	elseIf IsFemale
		BaseDelay  = Config.FemaleVoiceDelay
	else
		BaseDelay  = Config.MaleVoiceDelay
	endIf
	VoiceDelay = BaseDelay
	; Init some needed arrays
	Flags   = new int[5]
	Offsets = new float[4]
	Loc     = new float[6]
	; Ready
	RegisterEvents()
	TrackedEvent("Added")
	GoToState("Ready")
	Log(self, "SetActor("+ActorRef+")")
	return true
endFunction

function ClearAlias()
	; Maybe got here prematurely, give it 10 seconds before forcing the clear
	if GetState() == "Resetting"
		float Failsafe = Utility.GetCurrentRealTime() + 10.0
		while GetState() == "Resetting" && Utility.GetCurrentRealTime() < Failsafe
			Utility.WaitMenuMode(0.2)
		endWhile
	endIf
	; Make sure actor is reset
	if GetReference()
		; Init variables needed for reset
		ActorRef   = GetReference() as Actor
		BaseRef    = ActorRef.GetLeveledActorBase()
		ActorName  = BaseRef.GetName()
		BaseSex    = BaseRef.GetSex()
		Gender     = ActorLib.GetGender(ActorRef)
		IsMale     = Gender == 0
		IsFemale   = Gender == 1
		IsCreature = Gender >= 2
		IsPlayer   = ActorRef == PlayerRef
		Log("Actor present during alias clear! This is usually harmless as the alias and actor will correct itself, but is usually a sign that a thread did not close cleanly.", "ClearAlias("+ActorRef+" / "+self+")")
		; Reset actor back to default
		ClearEffects()
		RestoreActorDefaults()
		StopAnimating(true)
		UnlockActor()
		Unstrip()
	endIf
	Initialize()
	GoToState("")
endFunction

; Thread/alias shares
bool DebugMode
bool SeparateOrgasms
int[] BedStatus
float[] RealTime
float[] SkillBonus
string AdjustKey
bool[] IsType

int Stage
int StageCount
string[] AnimEvents
sslBaseAnimation Animation

function LoadShares()
	DebugMode  = Config.DebugMode
	UseLipSync = Config.UseLipSync && !IsCreature
	UseScale   = !Config.DisableScale

	Center     = Thread.CenterLocation
	BedStatus  = Thread.BedStatus
	RealTime   = Thread.RealTime
	SkillBonus = Thread.SkillBonus
	AdjustKey  = Thread.AdjustKey
	IsType     = Thread.IsType
	LeadIn     = Thread.LeadIn
	AnimEvents = Thread.AnimEvents

	SeparateOrgasms = Config.SeparateOrgasms
	AnimatingFaction = Config.AnimatingFaction ; TEMP
endFunction

; ------------------------------------------------------- ;
; --- Actor Prepartion                                --- ;
; ------------------------------------------------------- ;
; alton start
String[] actorAnimationArray
String[] actorActionArray
String[] actorSosArray
String[] actorExpressArray
float[]	 actorRotateArray
float[]	 actorForwardArray
int   actorArrayIdx = 0

state Ready

	bool function SetActor(Actor ProspectRef)
		return false
	endFunction

	function PrepareActor()
		; Remove any unwanted combat effects
		ClearEffects()
		if IsPlayer
			Game.SetPlayerAIDriven()
		endIf
		ActorRef.SetFactionRank(AnimatingFaction, 1)
		ActorRef.EvaluatePackage()
		; Starting Information
		LoadShares()
		GetPositionInfo()
		IsAggressor = Thread.VictimRef && Thread.Victims.Find(ActorRef) == -1
		string LogInfo
		; Calculate scales
		if UseScale
			float display = ActorRef.GetScale()
			ActorRef.SetScale(1.0)
			float base = ActorRef.GetScale()
			ActorScale = ( display / base )
			AnimScale  = ActorScale
			ActorRef.SetScale(ActorScale)
			if Thread.ActorCount > 1 && Config.ScaleActors ; FIXME: || IsCreature?
				AnimScale = (1.0 / base)
			endIf
			LogInfo = "Scales["+display+"/"+base+"/"+AnimScale+"] "
		else
			AnimScale = 1.0
			LogInfo = "Scales["+ActorRef.GetScale()+"/ DISABLED] "
		endIf
		; Stop other movements
		if DoPathToCenter
			PathToCenter()
		endIf
		LockActor()

		; Utility.Wait(1.0) ; DEV TMP
		; Pick a voice if needed
		if !Voice && !IsForcedSilent
			if IsCreature
				SetVoice(Config.VoiceSlots.PickByRaceKey(sslCreatureAnimationSlots.GetRaceKey(BaseRef.GetRace())), IsForcedSilent)
			else
				SetVoice(Config.VoiceSlots.PickVoice(ActorRef), IsForcedSilent)
			endIf
		endIf
		if Voice
			LogInfo += "Voice["+Voice.Name+"] "
		endIf
		; Player specific actions
		if IsPlayer
			FormList FrostExceptions = Config.FrostExceptions
			if FrostExceptions
				FrostExceptions.AddForm(Config.BaseMarker)
			endIf
		endIf
		; Extras for non creatures
		if !IsCreature
			; Decide on strapon for female, default to worn, otherwise pick random.
			if IsFemale && Config.UseStrapons
				HadStrapon = Config.WornStrapon(ActorRef)
				Strapon    = HadStrapon
				if !HadStrapon
					Strapon = Config.GetStrapon()
				endIf
			endIf
			
			ResolveStrapon()
			; Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
			; Suppress High Heels
			if IsFemale && Config.RemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
				; Remove NiOverride High Heels
				if Config.HasNiOverride && NiOverride.HasNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "internal")
					float[] pos = NiOverride.GetNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "internal")
					Log(pos, "RemoveHeelEffect (NiOverride)")
					pos[0] = -pos[0]
					pos[1] = -pos[1]
					pos[2] = -pos[2]
					NiOverride.AddNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLab.esm", pos)
					NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
				endIf
				; Remove HDT High Heels
				HDTHeelSpell = Config.GetHDTSpell(ActorRef)
				if HDTHeelSpell
					Log(HDTHeelSpell, "RemoveHeelEffect (HDTHeelSpell)")
					ActorRef.RemoveSpell(HDTHeelSpell)
				endIf
			endIf
			; Pick an expression if needed
			if !Expression && Config.UseExpressions
				Expression = Config.ExpressionSlots.PickByStatus(ActorRef, IsVictim, IsType[0] && !IsVictim)
			endIf
			if Expression
				LogInfo += "Expression["+Expression.Name+"] "
			endIf
		endIf
		IsSkilled = !IsCreature || sslActorStats.IsSkilled(ActorRef)
		if IsSkilled
			; Always use players stats for NPCS if present, so players stats mean something more
			Actor SkilledActor = ActorRef
			if !IsPlayer && Thread.HasPlayer 
				SkilledActor = PlayerRef
			; If a non-creature couple, base skills off partner
			elseIf Thread.ActorCount > 1 && !Thread.HasCreature
				SkilledActor = Thread.Positions[sslUtility.IndexTravel(Position, Thread.ActorCount)]
			endIf
			; Get sex skills of partner/player
			Skills       = Stats.GetSkillLevels(SkilledActor)
			BestRelation = Thread.GetHighestPresentRelationshipRank(ActorRef)
			if IsVictim
				BaseEnjoyment = Utility.RandomFloat(BestRelation, ((Skills[Stats.kLewd]*1.1) as int)) as int
			elseIf IsAggressor
				float OwnLewd = Stats.GetSkillLevel(ActorRef, "Lewd", 0.3)
				BaseEnjoyment = Utility.RandomFloat(OwnLewd, ((Skills[Stats.kLewd]*1.3) as int) + (OwnLewd*1.7)) as int
			else
				BaseEnjoyment = Utility.RandomFloat(BestRelation, ((Skills[Stats.kLewd]*1.5) as int) + (BestRelation*1.5)) as int
			endIf
			if BaseEnjoyment < 0
				BaseEnjoyment = 0
			elseIf BaseEnjoyment > 25
				BaseEnjoyment = 25
			endIf
		else
			BaseEnjoyment = Utility.RandomInt(0, 10)
		endIf

		; Play custom starting animation event
		if StartAnimEvent != ""
			Debug.SendAnimationEvent(ActorRef, StartAnimEvent)
		endIf

		actorAnimationArray = new String[90]
		actorActionArray = new String[90]
		actorSosArray = new String[90]
		actorExpressArray = new String[90]
		actorRotateArray = new Float[90]
		actorForwardArray = new Float[90]
	
		actorArrayIdx = 0
		while actorArrayIdx < 90
			actorRotateArray[actorArrayIdx] = 1000.0
			actorForwardArray[actorArrayIdx] = 1000.0
			actorArrayIdx += 1
		endWhile		
		actorArrayIdx = 0

		HumanLeadInScene(thread.ActorCount)
		RegisterForSingleUpdate(0.1)	; read onUpdate
	endFunction

	function waitForOther(float Distance, ObjectReference WaitRef, ObjectReference actorRef, bool isFirstActor) 
		; Start wait loop for actor pathing.
		int StuckCheck  = 0
		float Failsafe  = Utility.GetCurrentRealTime() + 30.0

		if (isFirstActor)
			if IsVictim
				Debug.SendAnimationEvent(actorRef, "00_Embarassed")
			else
				Debug.SendAnimationEvent(actorRef, "00_Lure" + Utility.RandomInt(1,2) + "_Dance")
			endif
		endif 

		ActorRef.SetLookAt(WaitRef, true)
		while Distance > 80.0 && Utility.GetCurrentRealTime() < Failsafe

			if isFirstActor
				float zOffset = actorRef.GetHeadingAngle(Thread.Positions[1])
				actorRef.SetAngle(actorRef.GetAngleX(), actorRef.GetAngleY(), actorRef.GetAngleZ() + zOffset)

				Center[0] = actorRef.GetPositionX()
				Center[1] = actorRef.GetPositionY()
				Center[2] = actorRef.GetPositionZ()
			endif 

			Utility.Wait(1.0)
			float Previous = Distance
			Distance = ActorRef.GetDistance(WaitRef)
			; Check if same distance as last time.
			if Math.Abs(Previous - Distance) < 1.0
				if StuckCheck > 2 ; Stuck for 2nd time, end loop.
					Distance = 0.0
				endIf
				StuckCheck += 1 ; End loop on next iteration if still stuck.
			else
				StuckCheck -= 1 ; Reset stuckcheck if progress was made.
			endIf
		endWhile
		ActorRef.ClearLookAt()
	endfunction 

	function PathToCenter()
		ObjectReference CenterRef = Thread.CenterAlias.GetReference()
		if CenterRef && ActorRef && (Thread.ActorCount > 1 || CenterRef != ActorRef)		
			ObjectReference WaitRef = CenterRef
		
			if WaitRef == ActorRef
				WaitRef = Thread.Positions[IntIfElse(Position != 0, 0, 1)]

				float Distance = ActorRef.GetDistance(WaitRef)
			
				if Distance > 135.0 && Distance < 8000.0
					waitForOther(Distance, WaitRef, ActorRef, true)
				endif				
			else 
				float Distance = ActorRef.GetDistance(WaitRef)

				if Distance > 135.0 && Distance < 8000.0
					ActorRef.SetFactionRank(AnimatingFaction, 2)
					ActorRef.EvaluatePackage()

					waitForOther(Distance, WaitRef, ActorRef, false)

					ActorRef.SetFactionRank(AnimatingFaction, 1)
					ActorRef.EvaluatePackage()					
				endif				
			endIf
		endIf
	endFunction

	; prepare modifed by alton
	event OnUpdate()
		if actorAnimationArray[actorArrayIdx] == "end"
			GoToState("Prepare")
			PrepareFinished()
		elseif actorAnimationArray[actorArrayIdx] == "undress"
			Strip()
		elseif actorAnimationArray[actorArrayIdx] == "redress"
			UnStrip()
		else

			if actorSosArray[actorArrayIdx] != ""
				Debug.SendAnimationEvent(actorRef, actorSosArray[actorArrayIdx])
			endif

			if actorExpressArray[actorArrayIdx] != ""
				if actorExpressArray[actorArrayIdx]  == "open"
					sslBaseExpression.OpenMouth(ActorRef)
				elseif actorExpressArray[actorArrayIdx]  == "close"
					sslBaseExpression.CloseMouth(ActorRef)
				endif 
			endif
				
			if actorAnimationArray[actorArrayIdx] != ""
				Debug.SendAnimationEvent(actorRef, actorAnimationArray[actorArrayIdx])		
			endif 

			; position
			bool isMoveChanged = false

			if actorForwardArray[actorArrayIdx] < 1000.0
				Offsets[0] = actorForwardArray[actorArrayIdx]
				isMoveChanged = true
			endif
		
			if actorRotateArray[actorArrayIdx] < 1000.0

				if Offsets[3] == 180 && actorRotateArray[actorArrayIdx] == 180
					Offsets[3] = 0
				else 
					Offsets[3] = actorRotateArray[actorArrayIdx]
				endif 				
				isMoveChanged = true			
			endif		

			if isMoveChanged
				OffsetCoords(Loc, Center, Offsets)
				MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
				MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
				ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
				ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
				AttachMarker()
			endif
				
			actorArrayIdx += 1					
			RegisterForSingleUpdate(1.0)
		endif
	endEvent
endState

state Prepare

	event onUpdate() 	
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Debug.SendAnimationEvent(ActorRef, "SOSFastErect")
		StartAnimating()
	endEvent 

	function PrepareFinished() 
		Game.FadeOutGame(true, true, 0.0, 3.0)
		RegisterForSingleUpdate(2.0)
	endfunction

	function StartAnimating()		
		TrackedEvent("Start")
		; Remove from bard audience if in one
		Config.CheckBardAudience(ActorRef, true)
		; Prepare for loop
		; StopAnimating(true)	
		StartedAt  = Utility.GetCurrentRealTime()
		LastOrgasm = StartedAt
		GoToState("Animating")
		SyncAll(true)
		PlayingSA = Animation.Registry
		CurrentSA = Animation.Registry
		; If enabled, start Auto TFC for player
		if IsPlayer && Config.AutoTFC
			MiscUtil.SetFreeCameraState(true)
			MiscUtil.SetFreeCameraSpeed(Config.AutoSUCSM)
		endIf
		SendAnimation()
		RegisterForSingleUpdate(Utility.RandomFloat(1.0, 3.0))
	endFunction
endState

; ------------------------------------------------------- ;
; --- Animation Loop                                  --- ;
; ------------------------------------------------------- ;


function SendAnimation()
endFunction

function GetPositionInfo()
	if ActorRef
		if !AdjustKey
			SetAdjustKey(Thread.AdjustKey)
		endIf
		LeadIn     = Thread.LeadIn
		Stage      = Thread.Stage
		Animation  = Thread.Animation
		StageCount = Animation.StageCount
		Flags      = Animation.PositionFlags(Flags, AdjustKey, Position, Stage)
		Offsets    = Animation.PositionOffsets(Offsets, AdjustKey, Position, Stage, BedStatus[1])
		CurrentSA  = Animation.Registry
		; AnimEvents[Position] = Animation.FetchPositionStage(Position, Stage)
	endIf
endFunction

string PlayingSA
string CurrentSA
float LoopDelay
state Animating

	function SendAnimation()
		; Reenter SA - On stage 1 while animation hasn't changed since last call
		if Stage == 1 && PlayingSA == CurrentSA
			; Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
			Utility.WaitMenuMode(0.2)
			Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
			; Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1)+"_REENTER")
		else
			; Enter a new SA - Not necessary on stage 1 since both events would be the same
			if Stage != 1 && PlayingSA != CurrentSA
				Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
				Utility.WaitMenuMode(0.2)
				; Log("NEW SA - "+Animation.FetchPositionStage(Position, 1))
			endIf
			; Play the primary animation
		 	Debug.SendAnimationEvent(ActorRef, AnimEvents[Position])
		 	; Log(AnimEvents[Position])
		endIf
		; Save id of last SA played
		PlayingSA = Animation.Registry
	endFunction

	event OnUpdate()
		; Pause further updates if in menu
		while Utility.IsInMenuMode()
			Utility.WaitMenuMode(1.5)
			StartedAt += 1.2
		endWhile
		; Check if still among the living and able.
		if !ActorRef.Is3DLoaded() || ActorRef.IsDisabled() || (ActorRef.IsDead() && ActorRef.GetActorValue("Health") < 1.0)
			Log("Actor is out of cell, disabled, or has no health - Unable to continue animating")
			Thread.EndAnimation(true)
			return
		endIf
		; Trigger orgasm
		GetEnjoyment()
		if !NoOrgasm && Enjoyment >= 100 && Stage < StageCount && SeparateOrgasms && (RealTime[0] - LastOrgasm) > 10.0
			OrgasmEffect()
		endIf
		; Lip sync and refresh expression
		if LoopDelay >= VoiceDelay
			LoopDelay = 0.0
			if !IsSilent
				float volume = 0.4
				Voice.PlayMoan(ActorRef, Enjoyment, IsVictim, UseLipSync, volume)
			endIf
			; RefreshExpression()
		endIf
		; Loop
		LoopDelay += (VoiceDelay * 0.35)
		RegisterForSingleUpdate(VoiceDelay * 0.35)

		findPeekHuman(actorRef, 43, 300)	; alton modified
	endEvent

	function SyncThread()
		; Sync with thread info
		GetPositionInfo()
		VoiceDelay = BaseDelay
		if !IsSilent && Stage > 1
			VoiceDelay -= (Stage * 0.8) + Utility.RandomFloat(-0.2, 0.4)
		endIf
		if VoiceDelay < 0.8
			VoiceDelay = Utility.RandomFloat(0.8, 1.4) ; Can't have delay shorter than animation update loop
		endIf
		; Update alias info
		GetEnjoyment()
		; Sync status
		if !IsCreature
			ResolveStrapon()
			RefreshExpression()
		endIf
		Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
		; SyncLocation(false)
	endFunction

	function SyncActor()
		SyncThread()
		SyncLocation(false)
		Thread.SyncEventDone(kSyncActor)
	endFunction

	function SyncAll(bool Force = false)
		SyncThread()
		SyncLocation(Force)
	endFunction

	function RefreshActor()
		UnregisterForUpdate()
		SyncThread()
		StopAnimating(true)
		SyncLocation(true)
		Debug.SendAnimationEvent(ActorRef, "SexLabSequenceExit1")
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Utility.WaitMenuMode(0.1)
		Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
		PlayingSA = "SexLabSequenceExit1"
		Debug.SendAnimationEvent(ActorRef, "SexLabSequenceExit1")
		Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
		PlayingSA = Animation.Registry
		CurrentSA = Animation.Registry
		SyncLocation(true)
		SendAnimation()
		RegisterForSingleUpdate(1.0)
		Thread.SyncEventDone(kRefreshActor)
	endFunction

	function RefreshLoc()
		Offsets = Animation.PositionOffsets(Offsets, AdjustKey, Position, Stage, BedStatus[1])
		SyncLocation(true)
	endFunction

	function SyncLocation(bool Force = false)
		OffsetCoords(Loc, Center, Offsets)
		MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		; Avoid forcibly setting on player coords if avoidable - causes annoying graphical flickering
		if Force && IsPlayer && IsInPosition(ActorRef, MarkerRef, 40.0)
			AttachMarker()
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0)
			return ; OnTranslationComplete() will take over when in place
		elseIf Force
			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
		endIf
		AttachMarker()
		Snap()
	endFunction

	function Snap()
		; Quickly move into place and angle if actor is off by a lot
		float distance = ActorRef.GetDistance(MarkerRef)
		if distance > 125.0 || !IsInPosition(ActorRef, MarkerRef, 75.0)
			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
			AttachMarker()
		elseIf distance > 2.0
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
			return ; OnTranslationComplete() will take over when in place
		endIf
		; Begin very slowly rotating a small amount to hold position
		ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+0.01, 500.0, 0.0001)
	endFunction

	event OnTranslationComplete()
		; Log("OnTranslationComplete")
		Snap()
	endEvent

	;/ event OnTranslationFailed()
		Log("OnTranslationFailed")
		; SyncLocation(false)
	endEvent /;

	function OrgasmEffect()
		DoOrgasm()
	endFunction

	function DoOrgasm(bool Forced = false)
		Debug.Notification("DoOrgasm ..")

		if !Forced && (NoOrgasm || Thread.DisableOrgasms)
			; Orgasm Disabled for actor or whole thread
			return 
		elseIf Math.Abs(Utility.GetCurrentRealTime() - LastOrgasm) < 5.0
			Log("Excessive OrgasmEffect Triggered")
			return
		endIf
		UnregisterForUpdate()
		LastOrgasm = StartedAt
		Orgasms   += 1
		; Reset enjoyment build up, if using multiple orgasms
		int FullEnjoyment = Enjoyment
		if Config.SeparateOrgasms
			BaseEnjoyment -= Enjoyment
			BaseEnjoyment += Utility.RandomInt((BestRelation + 10), PapyrusUtil.ClampInt(((Skills[Stats.kLewd]*1.5) as int) + (BestRelation + 10), 10, 35))
			FullEnjoyment  = GetEnjoyment()
		endIf
		; Send an orgasm event hook with actor and orgasm count
		int eid = ModEvent.Create("SexLabOrgasm")
		ModEvent.PushForm(eid, ActorRef)
		ModEvent.PushInt(eid, FullEnjoyment)
		ModEvent.PushInt(eid, Orgasms)
		ModEvent.Send(eid)
		TrackedEvent("Orgasm")
		Log("Orgasms["+Orgasms+"] Enjoyment ["+Enjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] FullEnjoyment["+FullEnjoyment+"]")
		if Config.OrgasmEffects
			; Shake camera for player
			if IsPlayer && Game.GetCameraState() >= 8
				Game.ShakeCamera(none, 1.00, 2.0)
			endIf
			; Play SFX/Voice
			if !IsSilent
				PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
			endIf
			PlayLouder(OrgasmFX, MarkerRef, Config.SFXVolume)
			; Apply cum to female positions from male position orgasm
			int i = Thread.ActorCount
			if i > 1 && Config.UseCum && (MalePosition || IsCreature) && (IsMale || IsCreature || (Config.AllowFFCum && IsFemale))
				if i == 2
					Thread.PositionAlias(IntIfElse(Position == 1, 0, 1)).ApplyCum()
				else
					while i > 0
						i -= 1
						if Position != i && Animation.IsCumSource(Position, i, Stage)
							Thread.PositionAlias(i).ApplyCum()
						endIf
					endWhile
				endIf
			endIf
		endIf
		Utility.WaitMenuMode(0.2)
		; VoiceDelay = 0.8
		RegisterForSingleUpdate(0.8)
	endFunction

	event ResetActor()
		Debug.Notification("ResetActor ..")
		ClearEvents()
		GoToState("Resetting")
		Log("Resetting!")
		; Clear TFC
		if IsPlayer
			MiscUtil.SetFreeCameraState(false)
		endIf
		; Update stats
		if IsSkilled
			Actor VictimRef = Thread.VictimRef
			if IsVictim
				VictimRef = ActorRef
			endIf
			sslActorStats.RecordThread(ActorRef, Gender, BestRelation, StartedAt, Utility.GetCurrentRealTime(), Utility.GetCurrentGameTime(), Thread.HasPlayer, VictimRef, Thread.Genders, Thread.SkillXP)
			Stats.AddPartners(ActorRef, Thread.Positions, Thread.Victims)
		endIf
		; Apply cum
		;/ int CumID = Animation.GetCum(Position)
		if CumID > 0 && !Thread.FastEnd && Config.UseCum && (Thread.Males > 0 || Config.AllowFFCum || Thread.HasCreature)
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf /;
		; Tracked events
		TrackedEvent("End")
		StopAnimating(Thread.FastEnd, EndAnimEvent)
		RestoreActorDefaults()
		UnlockActor()
		; Unstrip items in storage, if any
		if !IsCreature && !ActorRef.IsDead()
			Unstrip()
			; Add back high heel effects
			if Config.RemoveHeelEffect
				; HDT High Heel
				if HDTHeelSpell && ActorRef.GetWornForm(0x00000080) && !ActorRef.HasSpell(HDTHeelSpell)
					ActorRef.AddSpell(HDTHeelSpell)
				endIf
				; NiOverride High Heels
				if Config.HasNiOverride && NiOverride.RemoveNodeTransformPosition(ActorRef, false, IsFemale, "NPC", "SexLab.esm")
					NiOverride.UpdateNodeTransform(ActorRef, false, IsFemale, "NPC")
				endIf
			endIf
		endIf
		; Free alias slot
		Clear()
		GoToState("")
		Thread.SyncEventDone(kResetActor)
	endEvent
endState

state Resetting
	function ClearAlias()
	endFunction
	event OnUpdate()
	endEvent
	function Initialize()
	endFunction
endState

function SyncAll(bool Force = false)
endFunction

; ------------------------------------------------------- ;
; --- Actor Manipulation                              --- ;
; ------------------------------------------------------- ;

function StopAnimating(bool Quick = false, string ResetAnim = "IdleForceDefaultState")
	if !ActorRef
		return
	endIf
	; Disable free camera, if in it
	; if IsPlayer
	; 	MiscUtil.SetFreeCameraState(false)
	; endIf
	; Clear possibly troublesome effects
	ActorRef.StopTranslation()
	ActorRef.SetVehicle(none)
	; Stop animevent
	if IsCreature
		; Reset creature idle
		Debug.SendAnimationEvent(ActorRef, "Reset")
		Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
		Debug.SendAnimationEvent(ActorRef, "ReturnDefaultState")
		Debug.SendAnimationEvent(ActorRef, "FNISDefault")
		Debug.SendAnimationEvent(ActorRef, "IdleReturnToDefault")
		Debug.SendAnimationEvent(ActorRef, "ForceFurnExit")
		if ResetAnim != "IdleForceDefaultState" && ResetAnim != ""
			ActorRef.Moveto(ActorRef)
			ActorRef.PushActorAway(ActorRef, 0.75)
		endIf
	else
		; Reset NPC/PC Idle Quickly
		Debug.SendAnimationEvent(ActorRef, ResetAnim)
		Utility.Wait(0.1)
		; Ragdoll NPC/PC if enabled and not in TFC
		if !Quick && ResetAnim != "" && DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
			ActorRef.Moveto(ActorRef)
			ActorRef.PushActorAway(ActorRef, 0.1)
		endIf
	endIf
	PlayingSA = "SexLabSequenceExit1"	
endFunction

function AttachMarker()
	ActorRef.SetVehicle(MarkerRef)
	if UseScale
		ActorRef.SetScale(AnimScale)
	endIf
endFunction

function LockActor()
	if !ActorRef
		return
	endIf
	; Remove any unwanted combat effects
	ClearEffects()
	; Stop whatever they are doing
	; Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	; Start DoNothing package
	ActorUtil.AddPackageOverride(ActorRef, Config.DoNothing, 100, 1)
	ActorRef.SetFactionRank(AnimatingFaction, 1)
	ActorRef.EvaluatePackage()
	; Disable movement
	if IsPlayer
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endIf
		; abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = true, abJournalTabs = false, aiDisablePOVType = 0
		Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven()
		; Enable hotkeys if needed, and disable autoadvance if not needed
		if IsVictim && Config.DisablePlayer
			Thread.AutoAdvance = true
		else
			Thread.AutoAdvance = Config.AutoAdvance
			Thread.EnableHotkeys()
		endIf
	else
		ActorRef.SetRestrained(true)
		ActorRef.SetDontMove(true)
	endIf
	; Attach positioning marker
	if !MarkerRef
		MarkerRef = ActorRef.PlaceAtMe(Config.BaseMarker)
		int cycle
		while !MarkerRef.Is3DLoaded() && cycle < 50
			Utility.Wait(0.1)
			cycle += 1
		endWhile
		if cycle
			Log("Waited ["+cycle+"] cycles for MarkerRef["+MarkerRef+"]")
		endIf
	endIf
	MarkerRef.Enable()
	ActorRef.StopTranslation()
	MarkerRef.MoveTo(ActorRef)
	AttachMarker()
endFunction

function UnlockActor()
	if !ActorRef
		return
	endIf
	
	; Detach positioning marker
	ActorRef.StopTranslation()
	ActorRef.SetVehicle(none)
	; Remove from animation faction
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	ActorRef.SetFactionRank(AnimatingFaction, 0)
	ActorRef.EvaluatePackage()
	; Enable movement
	if IsPlayer
		Thread.DisableHotkeys()
		MiscUtil.SetFreeCameraState(false)
		Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven(false)
	else
		ActorRef.SetRestrained(false)
		ActorRef.SetDontMove(false)
	endIf
endFunction

function RestoreActorDefaults()
	; Make sure  have actor, can't afford to miss this block
	if !ActorRef
		ActorRef = GetReference() as Actor
		if !ActorRef
			return ; No actor, reset prematurely or bad call to alias
		endIf
	endIf	
	; Reset to starting scale
	if UseScale && ActorScale > 0.0
		ActorRef.SetScale(ActorScale)
	endIf
	if !IsCreature
		; Reset voicetype
		; if ActorVoice && ActorVoice != BaseRef.GetVoiceType()
		; 	BaseRef.SetVoiceType(ActorVoice)
		; endIf
		; Remove strapon
		if Strapon && !HadStrapon; && Strapon != HadStrapon
			ActorRef.RemoveItem(Strapon, 1, true)
		endIf
		; Reset expression
		ActorRef.ClearExpressionOverride()
		sslBaseExpression.ClearMFG(ActorRef)
	endIf
	; Player specific actions
	if IsPlayer
		; Remove player from frostfall exposure exception
		FormList FrostExceptions = Config.FrostExceptions
		if FrostExceptions
			FrostExceptions.RemoveAddedForm(Config.BaseMarker)
		endIf
	endIf
	; Clear from animating faction
	ActorRef.SetFactionRank(AnimatingFaction, -1)
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	ActorRef.EvaluatePackage()
	; Remove SOS erection
	Debug.SendAnimationEvent(ActorRef, "SOSFlaccid")
endFunction

function RefreshActor()
endFunction

; ------------------------------------------------------- ;
; --- Data Accessors                                  --- ;
; ------------------------------------------------------- ;

int function GetGender()
	return Gender
endFunction

function SetVictim(bool Victimize)
	Actor[] Victims = Thread.Victims
	; Make victim
	if Victimize && (!Victims || Victims.Find(ActorRef) == -1)
		Victims = PapyrusUtil.PushActor(Victims, ActorRef)
		Thread.Victims = Victims
		Thread.IsAggressive = true
	; Was victim but now isn't, update thread
	elseIf IsVictim && !Victimize
		Victims = PapyrusUtil.RemoveActor(Victims, ActorRef)
		Thread.Victims = Victims
		if !Victims || Victims.Length < 1
			Thread.IsAggressive = false
		endIf
	endIf
	IsVictim = Victimize
endFunction

bool function IsVictim()
	return IsVictim
endFunction

string function GetActorKey()
	return ActorKey
endFunction

function SetAdjustKey(string KeyVar)
	if ActorRef
		AdjustKey = KeyVar
		Position  = Thread.Positions.Find(ActorRef)
	endIf
endfunction

int function GetEnjoyment()
	if !ActorRef
		Enjoyment = 0
	elseif !IsSkilled
		Enjoyment = (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0) + ((Stage as float / StageCount as float) * 60.0)) as int
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf
		Enjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), Stage, StageCount)
		if Enjoyment < 0
			Enjoyment = 0
		elseIf Enjoyment > 100
			Enjoyment = 100
		endIf
		; Log("Enjoyment["+Enjoyment+"] / BaseEnjoyment["+BaseEnjoyment+"] / FullEnjoyment["+(Enjoyment - BaseEnjoyment)+"]")
	endIf
	return Enjoyment - BaseEnjoyment
endFunction

function ApplyCum()
	if ActorRef
		int CumID = Animation.GetCumID(Position, Stage)
		if CumID > 0
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf
	endIf
endFunction

function DisableOrgasm(bool bNoOrgasm)
	if ActorRef
		NoOrgasm = bNoOrgasm
	endIf
endFunction

bool function IsOrgasmAllowed()
	return !NoOrgasm && !Thread.DisableOrgasms
endFunction

bool function NeedsOrgasm()
	return GetEnjoyment() >= 100 && Enjoyment >= 100
endFunction

int function GetPain()
	if !ActorRef
		return 0
	endIf
	float Pain = Math.Abs(100.0 - PapyrusUtil.ClampFloat(GetEnjoyment() as float, 1.0, 99.0))
	if IsVictim
		Pain *= 1.5
	elseIf Animation.HasTag("Aggressive") || Animation.HasTag("Rough")
		Pain *= 0.8
	else
		Pain *= 0.3
	endIf
	return PapyrusUtil.ClampInt(Pain as int, 0, 100)
endFunction

function SetVoice(sslBaseVoice ToVoice = none, bool ForceSilence = false)
	IsForcedSilent = ForceSilence
	if ToVoice && IsCreature == ToVoice.Creature
		Voice = ToVoice
	endIf
endFunction

sslBaseVoice function GetVoice()
	return Voice
endFunction

function SetExpression(sslBaseExpression ToExpression)
	if ToExpression
		Expression = ToExpression
	endIf
endFunction

sslBaseExpression function GetExpression()
	return Expression
endFunction

function SetStartAnimationEvent(string EventName, float PlayTime)
	StartAnimEvent = EventName
	StartWait = PapyrusUtil.ClampFloat(PlayTime, 0.1, 10.0)
endFunction

function SetEndAnimationEvent(string EventName)
	EndAnimEvent = EventName
endFunction

bool function IsUsingStrapon()
	return Strapon && ActorRef.IsEquipped(Strapon)
endFunction

function ResolveStrapon(bool force = false)
	if Strapon
		if UseStrapon && !ActorRef.IsEquipped(Strapon)
			ActorRef.EquipItem(Strapon, true, true)
		elseIf !UseStrapon && ActorRef.IsEquipped(Strapon)
			ActorRef.UnequipItem(Strapon, true, true)
		endIf
	endIf
endFunction

function EquipStrapon()
	if Strapon && !ActorRef.IsEquipped(Strapon)
		ActorRef.EquipItem(Strapon, true, true)
	endIf
endFunction

function UnequipStrapon()
	if Strapon && ActorRef.IsEquipped(Strapon)
		ActorRef.UnequipItem(Strapon, true, true)
	endIf
endFunction

function SetStrapon(Form ToStrapon)
	if Strapon && !HadStrapon
		ActorRef.RemoveItem(Strapon, 1, true)
	endIf
	Strapon = ToStrapon
	if GetState() == "Animating"
		SyncThread()
	endIf
endFunction

Form function GetStrapon()
	return Strapon
endFunction

bool function PregnancyRisk()
	int cumID = Animation.GetCumID(Position, Stage)
	return cumID > 0 && (cumID == 1 || cumID == 4 || cumID == 5 || cumID == 7) && IsFemale && !MalePosition && Thread.IsVaginal
endFunction

function OverrideStrip(bool[] SetStrip)
	if SetStrip.Length != 33
		Thread.Log("Invalid strip override bool[] - Must be length 33 - was "+SetStrip.Length, "OverrideStrip()")
	else
		StripOverride = SetStrip
	endIf
endFunction

bool function ContinueStrip(Form ItemRef, bool DoStrip = true)
	return ItemRef && ((StorageUtil.FormListHas(none, "AlwaysStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "AlwaysStrip")) \
		|| (DoStrip && !(StorageUtil.FormListHas(none, "NoStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "NoStrip")))) 
endFunction

; alton modified
bool function findPeekHuman(actor _actor,  int _formType = 0, float _distance = 50.0)
	ObjectReference[] actorList =  FindAllReferencesOfFormType(_actor, _formType, _distance)  ; 43 npc

	int i=0
	while i < 20
		actor _actRef = actorList[i] as actor
		if !_actRef.isDead()
			bool isInvolvedActor = false
			int j=0
			while j < thread.positions.length

				if _actRef == thread.positions[j]
					isInvolvedActor = true
				endif 
				j += 1
			endwhile

			if !isInvolvedActor
				Debug.Notification("found someone to peek")
			endif 
		endif 

		i += 1
	endWhile

	return false
endfunction

; function HumanLeadInSceneSkip() 
; 	Debug.Notification("HumanLeadInSceneSkip" + ", " + Animation.Name)
; 	Strip()	
; endfunction 

function HumanLeadInScene(int partyCount)
		Debug.Notification("HumanLeadInScene" + ", " + Animation.Name)

		bool isSolo = false 
		bool isRape = false 
		bool isWorn= false

		string genderStr = "M"
		string sceneMode = "MM"

		if isFemale 
			genderStr = "F"
		endif		
				
		if IsVictim || IsAggressor
			isRape = true
		endif 

		if actorRef.GetWornForm(0x00000004) 
			isWorn = true
		endif 

		if partyCount == 1
			isSolo = true
			sceneMode = "Solo"
		endif 

		if partyCount > 1
			int firstActorGender = thread.positions[0].GetActorBase().GetSex()
			int secondActorGender = thread.positions[1].GetActorBase().GetSex()

			if firstActorGender == 1 && secondActorGender == 1
				sceneMode = "FF"
			elseif firstActorGender == 0 && secondActorGender == 1
				sceneMode = "MF"
			elseif firstActorGender == 1 && secondActorGender == 0
				sceneMode = "FM"
			endif
		endif 

		Debug.Notification("sceneMode " + ", " + sceneMode)

		if isSolo
			soloScene(isWorn, genderStr)
		else
			if sceneMode == "MM"				
				Strip()								
				setKeyFrame(1, _aniName = "end")
			else 
				if sceneMode == "FF" 
					if position == 0
						genderStr = "F"
					elseif position == 1
						genderStr = "M"
					endif
				endif

				int relationRank = thread.positions[0].GetRelationshipRank(thread.positions[1])			

				; prostitueScene(isWorn, genderStr, "Dance")
				; loverScene(isWorn, genderStr, "Long_Kiss")

				rapeBackHugScene(isWorn, genderStr, "")
			
				; if relationRank == 4
				; 	loverScene(isWorn, genderStr, "Long_Kiss")
				; elseif relationRank == 3 || relationRank == 2
				; 	loverScene(isWorn, genderStr, "Kiss")
				; elseif relationRank == 1
				; 	enjoyScene(isWorn, genderStr, "Shake")
				; elseif relationRank == 0
				; 	enjoyScene(isWorn, genderStr, "Dance")
				; else 
				; 	rapeScene()
							
			endif 			
		endif
endFunction

function Strip()
	; Select stripping array
	bool[] Strip
	if StripOverride.Length == 33
		Strip = StripOverride
	else
		Strip = Config.GetStrip(IsFemale, Thread.UseLimitedStrip(), IsType[0], IsVictim)
	endIf
	; Log("Strip: "+Strip)
	; Stripped storage
	Form ItemRef
	Form[] Stripped = new Form[34]
	; Right hand
	ItemRef = ActorRef.GetEquippedObject(1)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[33] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 1, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 1)
	endIf
	; Left hand
	ItemRef = ActorRef.GetEquippedObject(0)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[32] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 2, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 2) 
	endIf
	; Strip armor slots
	int i = 31
	while i >= 0
		; Grab item in slot
		ItemRef = ActorRef.GetWornForm(Armor.GetMaskForSlot(i + 30))
		if ContinueStrip(ItemRef, Strip[i])
			ActorRef.UnequipItemEX(ItemRef, 0, false)
			Stripped[i] = ItemRef
		endIf
		; Move to next slot
		i -= 1
	endWhile
	; Equip the nudesuit
	if Strip[2] && ((Gender == 0 && Config.UseMaleNudeSuit) || (Gender == 1 && Config.UseFemaleNudeSuit))
		ActorRef.EquipItem(Config.NudeSuit, true, true)
	endIf
	; Store stripped items
	Equipment = PapyrusUtil.MergeFormArray(Equipment, PapyrusUtil.ClearNone(Stripped), true)
	Log("Equipment: "+Equipment)
endfunction

function UnStrip()
	Debug.Notification("unstrip " + Equipment.Length)
 	if !ActorRef || IsCreature || Equipment.Length == 0
 		return
 	endIf
	; Remove nudesuit if present
	if ActorRef.GetItemCount(Config.NudeSuit) > 0
		ActorRef.RemoveItem(Config.NudeSuit, ActorRef.GetItemCount(Config.NudeSuit), true)
	endIf
	; Continue with undress, or am I disabled?
 	if !DoRedress
 		return ; Fuck clothes, bitch.
 	endIf
 	; Equip Stripped
 	int i = Equipment.Length
 	while i
 		i -= 1
 		if Equipment[i]
 			int hand = StorageUtil.GetIntValue(Equipment[i], "Hand", 0)
 			if hand != 0
	 			StorageUtil.UnsetIntValue(Equipment[i], "Hand")
	 		endIf
	 		ActorRef.EquipItemEx(Equipment[i], hand, false)
  		endIf
 	endWhile
endFunction

bool NoRagdoll
bool property DoRagdoll hidden
	bool function get()
		if NoRagdoll
			return false
		endIf
		return !NoRagdoll && Config.RagdollEnd
	endFunction
	function set(bool value)
		NoRagdoll = !value
	endFunction
endProperty

bool NoUndress
bool property DoUndress hidden
	bool function get()
		if NoUndress
			return false
		endIf
		return Config.UndressAnimation
	endFunction
	function set(bool value)
		NoUndress = !value
	endFunction
endProperty

bool NoRedress
bool property DoRedress hidden
	bool function get()
		if NoRedress || (IsVictim && !Config.RedressVictim)
			return false
		endIf
		return !IsVictim || (IsVictim && Config.RedressVictim)
	endFunction
	function set(bool value)
		NoRedress = !value
	endFunction
endProperty

int PathingFlag
function ForcePathToCenter(bool forced)
	PathingFlag = (forced as int)
endFunction
function DisablePathToCenter(bool disabling)
	PathingFlag = IntIfElse(disabling, -1, (PathingFlag == 1) as int)
endFunction
bool property DoPathToCenter
	bool function get()
		return (PathingFlag == 0 && Config.DisableTeleport) || PathingFlag == 1
	endFunction
endProperty

function RefreshExpression()
	if !ActorRef || IsCreature
		; Do nothing
	elseIf OpenMouth
		sslBaseExpression.OpenMouth(ActorRef)
	else
		if Expression
			sslBaseExpression.CloseMouth(ActorRef)
			Expression.Apply(ActorRef, Enjoyment, BaseSex)
		elseIf sslBaseExpression.IsMouthOpen(ActorRef)
			sslBaseExpression.CloseMouth(ActorRef)			
		endIf
	endIf
endFunction


; ------------------------------------------------------- ;
; --- System Use                                      --- ;
; ------------------------------------------------------- ;

function TrackedEvent(string EventName)
	if IsTracked
		Thread.SendTrackedEvent(ActorRef, EventName)
	endif
endFunction

function ClearEffects()
	if IsPlayer && GetState() != "Animating"
		; MiscUtil.SetFreeCameraState(false)
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endIf
	endIf
	if ActorRef.IsInCombat()
		ActorRef.StopCombat()
	endIf
	if ActorRef.IsWeaponDrawn()
		ActorRef.SheatheWeapon()
	endIf
	if ActorRef.IsSneaking()
		ActorRef.StartSneaking()
	endIf
	ActorRef.ClearKeepOffsetFromActor()
endFunction

int property kPrepareActor = 0 autoreadonly hidden
int property kSyncActor    = 1 autoreadonly hidden
int property kResetActor   = 2 autoreadonly hidden
int property kRefreshActor = 3 autoreadonly hidden
int property kStartup      = 4 autoreadonly hidden

function RegisterEvents()
	string e = Thread.Key("")
	; Quick Events
	RegisterForModEvent(e+"Animate", "SendAnimation")
	RegisterForModEvent(e+"Orgasm", "OrgasmEffect")
	RegisterForModEvent(e+"Strip", "Strip")
	; Sync Events
	RegisterForModEvent(e+"Prepare", "PrepareActor")
	RegisterForModEvent(e+"Sync", "SyncActor")
	RegisterForModEvent(e+"Reset", "ResetActor")
	RegisterForModEvent(e+"Refresh", "RefreshActor")
	RegisterForModEvent(e+"Startup", "StartAnimating")
endFunction

function ClearEvents()
	UnregisterForUpdate()
	string e = Thread.Key("")
	; Quick Events
	UnregisterForModEvent(e+"Animate")
	UnregisterForModEvent(e+"Orgasm")
	UnregisterForModEvent(e+"Strip")
	; Sync Events
	UnregisterForModEvent(e+"Prepare")
	UnregisterForModEvent(e+"Sync")
	UnregisterForModEvent(e+"Reset")
	UnregisterForModEvent(e+"Refresh")
	UnregisterForModEvent(e+"Startup")
endFunction

function Initialize()
	; Clear actor
	if ActorRef
		; Stop events
		ClearEvents()
		; RestoreActorDefaults()
		; Remove nudesuit if present
		if ActorRef.GetItemCount(Config.NudeSuit) > 0
			ActorRef.RemoveItem(Config.NudeSuit, ActorRef.GetItemCount(Config.NudeSuit), true)
		endIf
	endIf
	; Delete positioning marker
	if MarkerRef
		MarkerRef.Disable()
		MarkerRef.Delete()
	endIf
	; Forms
	ActorRef       = none
	MarkerRef      = none
	HadStrapon     = none
	Strapon        = none
	HDTHeelSpell   = none
	; Voice
	Voice          = none
	ActorVoice     = none
	IsForcedSilent = false
	; Expression
	Expression     = none
	; Flags
	NoRagdoll      = false
	NoUndress      = false
	NoRedress      = false
	NoOrgasm       = false
	; Integers
	Orgasms        = 0
	BestRelation   = 0
	BaseEnjoyment  = 0
	Enjoyment      = 0
	PathingFlag    = 0
	; Floats
	LastOrgasm     = 0.0
	ActorScale     = 0.0
	AnimScale      = 0.0
	StartWait      = 0.1
	; Strings
	EndAnimEvent   = "IdleForceDefaultState"
	StartAnimEvent = ""
	ActorKey       = ""
	PlayingSA      = ""
	CurrentSA      = ""
	; Storage
	StripOverride  = Utility.CreateBoolArray(0)
	Equipment      = Utility.CreateFormArray(0)
	; Make sure alias is emptied
	TryToClear()
endFunction

function LoadLib()
	; Reset function Libraries - SexLabQuestFramework
	if !Config || !ActorLib || !Stats
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config   = SexLabQuestFramework as sslSystemConfig
			ActorLib = SexLabQuestFramework as sslActorLibrary
			Stats    = SexLabQuestFramework as sslActorStats
		endIf
	endIf
	PlayerRef = Game.GetPlayer()
	Thread    = GetOwningQuest() as sslThreadController
	OrgasmFX  = Config.OrgasmFX
	DebugMode = Config.DebugMode
	AnimatingFaction = Config.AnimatingFaction
endFunction

function Log(string msg, string src = "")
	msg = "ActorAlias["+ActorName+"] "+src+" - "+msg
	Debug.Trace("SEXLAB - " + msg)
	if DebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
endFunction

function PlayLouder(Sound SFX, ObjectReference FromRef, float Volume)
	if SFX && FromRef && Volume > 0.0
		if Volume > 0.5
			Sound.SetInstanceVolume(SFX.Play(FromRef), 1.0)
		else
			Sound.SetInstanceVolume(SFX.Play(FromRef), Volume)
		endIf
	endIf
endFunction

; ------------------------------------------------------- ;
; --- State Restricted                                --- ;
; ------------------------------------------------------- ;

; Ready
function PrepareActor()
endFunction
function PathToCenter()
endFunction
function waitForOther(float Distance, ObjectReference WaitRef, ObjectReference actorRef, bool isFirstActor) 
endFunction
; Prepare
function PrepareFinished()
endFunction
; Animating
function StartAnimating()
endFunction
function SyncActor()
endFunction
function SyncThread()
endFunction
function SyncLocation(bool Force = false)
endFunction
function RefreshLoc()
endFunction
function Snap()
endFunction
event OnTranslationComplete()
endEvent
function OrgasmEffect()
endFunction
function DoOrgasm(bool Forced = false)
endFunction
event ResetActor()
endEvent
;/ function RefreshActor()
endFunction /;
event OnOrgasm()
	OrgasmEffect()
endEvent
event OrgasmStage()
	OrgasmEffect()
endEvent

function OffsetCoords(float[] Output, float[] CenterCoords, float[] OffsetBy) global native
bool function IsInPosition(Actor CheckActor, ObjectReference CheckMarker, float maxdistance = 30.0) global native
int function CalcEnjoyment(float[] XP, float[] SkillsAmounts, bool IsLeadin, bool IsFemaleActor, float Timer, int OnStage, int MaxStage) global native

int function IntIfElse(bool check, int isTrue, int isFalse)
	if check
		return isTrue
	endIf
	return isFalse
endfunction

; function AdjustCoords(float[] Output, float[] CenterCoords, ) global native
; function AdjustOffset(int i, float amount, bool backwards, bool adjustStage)
; 	Animation.
; endFunction

; function OffsetBed(float[] Output, float[] BedOffsets, float CenterRot) global native

; bool function _SetActor(Actor ProspectRef) native
; function _ApplyExpression(Actor ProspectRef, int[] Presets) global native


; function GetVars()
; 	IntShare = Thread.IntShare
; 	FloatShare = Thread.FloatS1hare
; 	StringShare = Thread.StringShare
; 	BoolShare
; endFunction

; int[] property IntShare auto hidden ; Stage, ActorCount, BedStatus[1]
; float[] property FloatShare auto hidden ; RealTime, StartedAt
; string[] property StringShare auto hidden ; AdjustKey
; bool[] property BoolShare auto hidden ; 
; sslBaseAnimation[] property _Animation auto hidden ; Animation


; alton added
function SetActorPosition (bool isFace= true)
	; pre-move to starting position near other actors
	Offsets[0] = 0.0
	Offsets[1] = 0.0
	Offsets[2] = 5.0 ; hopefully prevents some users underground/teleport to giant camp problem?
	Offsets[3] = 0.0
	; Starting position
	
	if Position == 1
		Offsets[0] = 25.0

		if isFace
			Offsets[3] = 180.0
		else 
			Offsets[3] = 0.0
		endif 

	elseif Position == 2
		Offsets[1] = -25.0
		Offsets[3] = 90.0

	elseif Position == 3
		Offsets[1] = 25.0
		Offsets[3] = -90.0

	elseif Position == 4
		Offsets[0] = -25.0
	endIf
		
	OffsetCoords(Loc, Center, Offsets)
	ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
	ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
endfunction

;
;	solo
;
function soloScene(bool _isWorn, String _gender)
	setActorPosition(true)		
	int _nextKeyFrame = 0
	_nextKeyFrame = arousedScene(_nextKeyFrame, 5,_isWorn, _gender)	
	_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
	_nextKeyFrame = endScene(_nextKeyFrame)
endfunction

;
;	lover
;
function loverScene(bool _isWorn, String _gender, string _pos)
	setActorPosition(false)
	int _nextKeyFrame = 0	

	_nextKeyFrame = kissScene(_nextKeyFrame, _isWorn, _gender, _pos)
	_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
	_nextKeyFrame = endScene(_nextKeyFrame)
endfunction 

;
;	enjoy
;
function enjoyScene(bool _isWorn, String _gender, string _pos)
	setActorPosition(true)
	int _nextKeyFrame = 0	

	if _gender == "F"
		_nextKeyFrame = lureScene(_nextKeyFrame, _isWorn, _gender, _pos)
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender)
		_nextKeyFrame = arousedScene(_nextKeyFrame, 1,_isWorn, _gender)	
	else 			
		_nextKeyFrame = watchBelowScene(_nextKeyFrame, 20)
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = arousedScene(_nextKeyFrame, 1,_isWorn, _gender, "SOSSlowErect")
	endif

	_nextKeyFrame = endScene(45)
endfunction 

;
;	prostitue
;
function prostitueScene(bool _isWorn, String _gender, string _pos)
	setActorPosition(true)
	int _nextKeyFrame = 0	

	if _gender == "F"
		_nextKeyFrame = showbodyScene(_nextKeyFrame, 14, _pos)
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = blowJobScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
	else 		
		_nextKeyFrame = arousedScene(_nextKeyFrame, 8, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = arousedScene(_nextKeyFrame, 6, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = setAdjustPosition(_nextKeyFrame, _forward = 25)
		_nextKeyFrame = blowJobScene(_nextKeyFrame, _isWorn, _gender, "SOSFastErect")
	endif

	_nextKeyFrame = endScene(45)
endfunction
;
;	rape
;
function rapeDownScene(bool _isWorn, String _gender, string _pos)
	setActorPosition(false)
	int _nextKeyFrame = 0

	if _gender == "F"
		_nextKeyFrame = embarrasedScene(_nextKeyFrame, 8)
		_nextKeyFrame = downToEarthScene(_nextKeyFrame, _isWorn, _gender)
	else 			
		_nextKeyFrame = watchRudlyScene(_nextKeyFrame, 8)
		_nextKeyFrame = setAdjustPosition(_nextKeyFrame, _forward = 15)
		_nextKeyFrame = downToEarthScene(_nextKeyFrame, _isWorn, _gender, "SOSFastErect")
		_nextKeyFrame = setAdjustPosition(_nextKeyFrame, _rotate = 180, _forward = 25)
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
	endif

	_nextKeyFrame = endScene(60)
endfunction 

function rapeBackHugScene(bool _isWorn, String _gender, string _pos)
	setActorPosition(true)
	int _nextKeyFrame = 0

	if _gender == "F"		
		_nextKeyFrame = embarrasedScene(_nextKeyFrame, 8)	
		_nextKeyFrame = undressVictimScene(_nextKeyFrame, _isWorn, _gender)
		_nextKeyFrame = backhugToEarthScene(_nextKeyFrame, _isWorn, _gender)
		_nextKeyFrame = giveupScene(_nextKeyFrame, 7)
	else 			
		_nextKeyFrame = arousedScene(_nextKeyFrame, 8, _isWorn, _gender, "SOSSlowErect")
		_nextKeyFrame = setAdjustPosition(_nextKeyFrame, _rotate = 180)
		_nextKeyFrame = undressVictimScene(_nextKeyFrame, _isWorn, _gender)			
		_nextKeyFrame = setAdjustPosition(_nextKeyFrame, _forward = 25, _rotate = 180)
		_nextKeyFrame = backhugToEarthScene(_nextKeyFrame, _isWorn, _gender, "SOSFastErect")
		_nextKeyFrame = undressScene(_nextKeyFrame, _isWorn, _gender, "SOSSlowErect")
	endif
	_nextKeyFrame = endScene(66)
endfunction 

; scene
int function setAdjustPosition(int _startKeyFrame, int _forward = 1000, int _rotate = 1000)
	return setKeyFrame(_startKeyFrame, 0, "", _forward = _forward, _rotate = _rotate)	
endfunction

int function embarrasedScene(int _startKeyFrame, int _waitKeyFrame)
	return setKeyFrame(_startKeyFrame, _waitKeyFrame, "00_Embarassed")	
endfunction 

int function watchBelowScene(int _startKeyFrame, int _waitKeyFrame)
	return setKeyFrame(_startKeyFrame, _waitKeyFrame, "00_Watch_Low")	
endfunction 

int function watchRudlyScene(int _startKeyFrame, int _waitKeyFrame)
	return setKeyFrame(_startKeyFrame, _waitKeyFrame, "01_Watch_Badly")	
endfunction 

int function giveupScene(int _startKeyFrame, int _waitKeyFrame)
	return setKeyFrame(_startKeyFrame, _waitKeyFrame, "50_Giveup_A1_S1")	
endfunction 

int function showbodyScene(int _startKeyFrame, int _waitKeyFrame, string _pos, string _SosType = "SOSSlowErect")
	int _nextKeyFrame = _startKeyFrame

	_nextKeyFrame = setKeyFrame(_nextKeyFrame, _waitKeyFrame, "30_Lure_" + _pos + "S1", _sos = _SosType)
	return _nextKeyFrame
endfunction

int function arousedScene(int _startKeyFrame, int _waitKeyFrame, bool _isWorn,  string _gender, string _SosType = "SOSSlowErect")
	int _nextKeyFrame = _startKeyFrame
	String naked = ""

	if _isWorn
		naked = "_Naked"
	endif 

	_nextKeyFrame = setKeyFrame(_nextKeyFrame, _waitKeyFrame, "00_" + _gender + Utility.RandomInt(1, 2) + naked + "_Aroused", _sos = _SosType)

	return _nextKeyFrame
endfunction 

int function blowJobScene(int _startKeyFrame, bool _isWorn, string _gender, string _pos, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame

	if _gender == "F"
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "40_Blowjob_A1_S1")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "40_Blowjob_A1_S2")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "40_Blowjob_A1_S3")
	else 
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "40_Blowjob_A2_S1", _sos = _SosType)
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "40_Blowjob_A2_S2")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "40_Blowjob_A2_S3")
	endif 

	return _nextKeyFrame
endfunction

int function lureScene(int _startKeyFrame, bool _isWorn, string _gender, string _pos, string _SosType = "SOSSlowErect")
	int _nextKeyFrame = _startKeyFrame

	_nextKeyFrame = setKeyFrame(_nextKeyFrame, 8, "30_Lure_" + _pos + "S1", _sos = _SosType)
	_nextKeyFrame = setKeyFrame(_nextKeyFrame, 8, "30_Lure_" + _pos + "S2")
	_nextKeyFrame = setKeyFrame(_nextKeyFrame, 8, "30_Lure_" + _pos + "S3")
	_nextKeyFrame = setKeyFrame(_nextKeyFrame, 8, "30_Lure_" + _pos + "S4")
	return _nextKeyFrame
endfunction

int function kissScene(int _startKeyFrame, bool _isWorn, string _gender, string _pos, string _SosType = "SOSSlowErect")
	int _nextKeyFrame = _startKeyFrame

	if _pos == "Long_Kiss"
		if _gender == "F"
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 34, "20_" + _pos + "_A1_S1")
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 24, "20_" + _pos + "_A1_S2")
		else
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 34, "21_" + _pos + "_A2_S1", _forward = -1, _sos = _SosType)
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 24, "21_" + _pos + "_A2_S2")
		endif 
	else 
		if _gender == "F"
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 20, "20_" + _pos + "_A1_S1")
		else
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 20, "21_" + _pos + "_A2_S1", _forward = -1, _sos = _SosType)
		endif 
	endif
	return _nextKeyFrame
endfunction

int function downToEarthScene(int _startKeyFrame, bool _isWorn, string _gender, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame

	if _gender == "F"
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,20, "50_Down_A1_S1")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "50_Down_A1_S2")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "50_Down_A1_S3",_action = "undress", _actionIdxOffset = 8)
	else 
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,20, "51_Down_A2_S1", _sos = _SosType)
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "51_Down_A2_S2", _sos = _SosType)
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,10, "51_Down_A2_S3", _sos = _SosType)
	endif 
	return _nextKeyFrame
endfunction

int function backhugToEarthScene(int _startKeyFrame,bool _isWorn,  string _gender, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame

	if _gender == "F"
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "50_BackHug_A1_S1")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "50_BackHug_A1_S2")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,2,  "50_BackHug_A1_S3")
	else 
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "50_BackHug_A2_S1", _sos = _SosType)
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,15, "50_BackHug_A2_S2")
		_nextKeyFrame = setKeyFrame(_nextKeyFrame,2,  "50_BackHug_A2_S3")
	endif 
	return _nextKeyFrame
endfunction

int function undressVictimScene(int _startKeyFrame, bool _isWorn, string _gender, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame

	if _isWorn		
		if _gender == "F"
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 3, "10_Undressed_Stand_A1_S1", _action = "undress", _actionIdxOffset = 1)
		else 
			_nextKeyFrame = setKeyFrame(_nextKeyFrame, 3, "11_Undressed_Stand_A2_S1")
		endif 
	endif
	return _nextKeyFrame
endfunction 

int function undressFaintVictimScene(int _startKeyFrame, bool _isWorn, string _gender, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame

	if _isWorn		
		if _gender == "F"
			_nextKeyFrame = setKeyFrame(_nextKeyFrame,3, _action = "undress")
			_nextKeyFrame = setKeyFrame(_nextKeyFrame,1, _action = "50_Giveup_A1_S22")
		else 
			_nextKeyFrame = setKeyFrame(_nextKeyFrame,4, "10_Uncover_Cloth")
		endif 
	endif
	return _nextKeyFrame
endfunction 

int function undressScene(int _startKeyFrame, bool _isWorn, string _gender, string _SosType = "SOSFastErect")
	int _nextKeyFrame = _startKeyFrame
	if _isWorn		
		_nextKeyFrame = setKeyFrame(_nextKeyFrame, 6, "10_" + _gender + "_Undress", _action = "undress", _actionIdxOffset = 5)		
	endif
		_nextKeyFrame = setKeyFrame(_nextKeyFrame, 1, "00_" + _gender + "1" + "_Naked_Aroused", _sos= _SosType)
	return _nextKeyFrame
endfunction 

int function endScene(int _startKeyFrame)	
	return setKeyFrame(_startKeyFrame + 6, _aniName = "end")
endfunction

int function setKeyFrame (int _idx, int _offset = 0, String _aniName = "", String _action = "", int _actionIdxOffset = -1, String _sos = "", float _forward = 1000.0, float _up = 1000.0, float _rotate = 1000.0)
	actorAnimationArray[_idx]  = _aniName	
	actorSosArray[_idx] = _sos
	if _forward != 1000.0
		actorForwardArray[_idx] = _forward
	endif 
	if _rotate != 1000.0
		actorRotateArray[_idx] = _rotate
	endif

	if _actionIdxOffset != -1
		actorActionArray[_idx + _actionIdxOffset] = _action
	endif

	return _idx + _offset
endfunction