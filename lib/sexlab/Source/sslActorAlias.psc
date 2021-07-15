scriptname sslActorAlias extends ReferenceAlias

; 0: missionary, 1: cowgirl, 2: aggressive, 3: rape, 4:doggy, 5: blowjob, 6:kiss

import po3_SKSEFunctions

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
bool IsVirgin

int sfxSoundId
int Position

String emotion

; Current Thread state
sslThreadController Thread

float StartWait
string StartAnimEvent
string EndAnimEvent
string ActorKey
bool NoOrgasm

; Voice
sslBaseVoice Voice
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

string[] sfxSoundTimeBlocks
int 	 sfxSoundBlockIdx
string   sfxPlayStatus
bool 	 isSfxSoundSynchMode
float    moanSoundOffset

Form Strapon
Form HadStrapon

Spell HDTHeelSpell

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
	BaseSex    = BaseRef.GetSex()
	Gender     = ActorLib.GetGender(ActorRef)
	IsMale     = Gender == 0
	IsFemale   = Gender == 1
	IsCreature = Gender >= 2
	IsTracked  = Config.ThreadLib.IsActorTracked(ActorRef)
	IsPlayer   = ActorRef == PlayerRef
	IsAggressor = !IsVictim
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
	Debug.Notification("ClearAlias")
	; Maybe got here prematurely, give it 10 seconds before forcing the clear
	if GetState() == "Resetting"
		float Failsafe = Utility.GetCurrentRealTime() + 10.0
		while GetState() == "Resetting" && Utility.GetCurrentRealTime() < Failsafe
			Utility.WaitMenuMode(0.2)
		endWhile
	endIf

	if !isPlayer
		ActorRef.SetUnconscious(false)
	endif

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
		
		endScene()

		UnlockActor()
		Unstrip()
	endIf
	Initialize()
	GoToState("")
endFunction

function endScene ()
			; 애니메이션 종료 후 추가 액션 처리
			if Config.OrgasmEffects && position == 0 && isFemale
				bool isEndPlay = false
	
				; 거리에 따른 대화 내용 출력
				if getvolume() >= 0.2
					ActorRef.SetFactionRank(Thread.SfxStageFaction, 100)
					SayDialog()			
				endif			
	
				if ActorRef.GetFactionRank(Thread.SfxRoleFaction) == 4
					Debug.SendAnimationEvent(ActorRef, "Scene_AfterFuck_Back_01")
					Utility.wait(4.0)
				elseif ActorRef.GetFactionRank(Thread.SfxRoleFaction) < 5
					Offsets[3] = 180			
					OffsetCoords(Loc, Center, Offsets)
					ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
					ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])				
	
					Debug.SendAnimationEvent(ActorRef, "Scene_AfterFuck_Front_01")			
					Utility.wait(4.0)
				endif
	
				int soundEmotionId = -999
				if emotion == "happy"
					soundEmotionId = Thread.SfxHappyBreathSound.Play(actorRef)
				elseif emotion == "afraid"
					soundEmotionId = Thread.SfxSadBreathSound.Play(actorRef)
				endif
				Sound.SetInstanceVolume(soundEmotionId, 3.0)
				
				if ActorRef.GetFactionRank(Thread.SfxRoleFaction) == 4
					int _randomValue = Utility.RandomInt(2, 3)
					Debug.SendAnimationEvent(ActorRef, "Scene_AfterFuck_Back_0" + _randomValue)
					Utility.wait(5.0)
					isEndPlay = true
				elseif ActorRef.GetFactionRank(Thread.SfxRoleFaction) < 5
					int _randomValue = Utility.RandomInt(2, 3)
					Debug.SendAnimationEvent(ActorRef, "Scene_AfterFuck_Front_0" + _randomValue)
					Utility.wait(5.0)
					isEndPlay = true
				endif	
				Sound.StopInstance(soundEmotionId)
	
				if isEndPlay
					if isPlayer
						Game.DisablePlayerControls( true, true, true, false, true, false, true, false )
					else 
						Debug.SendAnimationEvent(ActorRef, "Scene_StandUp")
						Utility.wait(1.0)
						Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
					endif
				endif			
	
				; 액션 이후 적대관계 관계 설정  
				if IsAggressor
					thread.positions[0].SetRelationshipRank(actorRef, -3)
				endif
			endif 	
endFunction

; Thread/alias shares
bool DebugMode
; bool SeparateOrgasms
int[] BedStatus
float[] RealTime
float[] SkillBonus
string AdjustKey
bool[] IsType

sslBaseAnimation Animation

function LoadShares()

	UseLipSync = Config.UseLipSync && !IsCreature

	Center     = Thread.CenterLocation
	BedStatus  = Thread.BedStatus
	RealTime   = Thread.RealTime
	SkillBonus = Thread.SkillBonus
	AdjustKey  = Thread.AdjustKey
	IsType     = Thread.IsType
	Position = Thread.Positions.Find(ActorRef)
endFunction

function GetPositionInfo()
	if ActorRef
		if !AdjustKey
			SetAdjustKey(Thread.AdjustKey)
		endIf
		
		Animation  = Thread.Animation
		Flags      = Animation.PositionFlags(Flags, AdjustKey, Position, Thread.Stage)
		Offsets    = Animation.PositionOffsets(Offsets, AdjustKey, Position, Thread.Stage, BedStatus[1])
		CurrentSA  = Animation.Registry		
	endIf
endFunction
; ------------------------------------------------------- ;
; --- Actor Prepartion                                --- ;
; ------------------------------------------------------- ;

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
		ActorRef.SetFactionRank(Config.AnimatingFaction, 1)
		ActorRef.EvaluatePackage()
		; Starting Information
		LoadShares()
		GetPositionInfo()		
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
		; pre-move to starting position near other actors
		Offsets[0] = 0.0
		Offsets[1] = 0.0
		Offsets[2] = 5.0 ; hopefully prevents some users underground/teleport to giant camp problem?
		Offsets[3] = 0.0
		; Starting position
		if Position == 1
			Offsets[0] = 25.0
			Offsets[3] = 180.0

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
		MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
		ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
		AttachMarker()			

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
			; Strip actor
			Strip()
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
		LogInfo += "BaseEnjoyment["+BaseEnjoyment+"]"
		Log(LogInfo)
		; Play custom starting animation event
		if StartAnimEvent != ""
			Debug.SendAnimationEvent(ActorRef, StartAnimEvent)
		endIf
		if StartWait < 0.1
			StartWait = 0.1
		endIf
		GoToState("Prepare")
		RegisterForSingleUpdate(StartWait)
	endFunction

	function PathToCenter()
		ObjectReference CenterRef = Thread.CenterAlias.GetReference()
		if CenterRef && ActorRef && (Thread.ActorCount > 1 || CenterRef != ActorRef)
			ObjectReference WaitRef = CenterRef
			if CenterRef == ActorRef
				WaitRef = Thread.Positions[IntIfElse(Position != 0, 0, 1)]
			endIf
			float Distance = ActorRef.GetDistance(WaitRef)
			if WaitRef && Distance < 8000.0 && Distance > 135.0
				if CenterRef != ActorRef
					ActorRef.SetFactionRank(Config.AnimatingFaction, 2)
					ActorRef.EvaluatePackage()
				endIf
				ActorRef.SetLookAt(WaitRef, true)

				; Start wait loop for actor pathing.
				int StuckCheck  = 0
				float Failsafe  = Utility.GetCurrentRealTime() + 30.0
				while Distance > 80.0 && Utility.GetCurrentRealTime() < Failsafe
					Utility.Wait(1.0)
					float Previous = Distance
					Distance = ActorRef.GetDistance(WaitRef)
					Log("Current Distance From WaitRef["+WaitRef+"]: "+Distance+" // Moved: "+(Previous - Distance))
					; Check if same distance as last time.
					if Math.Abs(Previous - Distance) < 1.0
						if StuckCheck > 2 ; Stuck for 2nd time, end loop.
							Distance = 0.0
						endIf
						StuckCheck += 1 ; End loop on next iteration if still stuck.
						Log("StuckCheck("+StuckCheck+") No progress while waiting for ["+WaitRef+"]")
					else
						StuckCheck -= 1 ; Reset stuckcheck if progress was made.
					endIf
				endWhile

				ActorRef.ClearLookAt()
				if CenterRef != ActorRef
					ActorRef.SetFactionRank(Config.AnimatingFaction, 1)
					ActorRef.EvaluatePackage()
				endIf
			endIf
		endIf
	endFunction

endState

state Prepare
	event OnUpdate()
		; Utility.Wait(5.0) ; DEV TMP

		ClearEffects()
		; GetPositionInfo()
		; Starting position
		OffsetCoords(Loc, Center, Offsets)
		MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
		ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
		AttachMarker()
		Debug.SendAnimationEvent(ActorRef, "SOSFastErect")

		; Notify thread prep is done
		if Thread.GetState() == "Prepare"
			Thread.SyncEventDone(kPrepareActor)
		else
			StartAnimating()
		endIf
	endEvent

	function StartAnimating()		
		TrackedEvent("Start")
		; Remove from bard audience if in one
		Config.CheckBardAudience(ActorRef, true)
		
		; Prepare for loop
		StopAnimating(true)
		GoToState("Animating")
		SyncAll(true)
		CurrentSA = Animation.Registry
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		; If enabled, start Auto TFC for player
		if IsPlayer && Config.AutoTFC
			MiscUtil.SetFreeCameraState(true)
			MiscUtil.SetFreeCameraSpeed(Config.AutoSUCSM)
		endIf

		if Thread.GetState() == "Prepare"
			Thread.SyncEventDone(kStartup)
		else
			SendAnimation()
		endIf

		; 거리에 따른 대화 내용 출력
		if getvolume() >= 0.2
			ActorRef.SetFactionRank(Thread.SfxStageFaction, 0)
			SayDialog()			
		endif	
		RegisterForSingleUpdate(2.0)
	endFunction
endState

; ------------------------------------------------------- ;
; --- Animation Loop                                  --- ;
; ------------------------------------------------------- ;

function SendAnimation()
endFunction

string CurrentSA
float LoopDelay

float expectedTime

state Animating
	function SendAnimation()	
		sfxPlayStatus = "ready"
		UnregisterForUpdate()	
		float startAnimationTime =  Utility.GetCurrentRealTime()

		if !ActorRef.Is3DLoaded() || ActorRef.IsDisabled() || ActorRef.IsDead()			
			Thread.EndAnimation(true)
			return
		endIf

		if Thread.Stage == 1	
			emotion = ""
			LoadShares()	
			StartedAt = Utility.GetCurrentRealTime()
			moanSoundOffset = startAnimationTime
			sfxSoundId = -999

			;팩션 랭크 업데이트
			ActorRef.SetFactionRank(Thread.SfxPositionFaction, position)
			ActorRef.SetFactionRank(Thread.SfxRoleFaction, Thread.SfxPlayRole)

			; 0: missionary, 1: cowgirl, 2: aggressive, 3: rape, 4:doggy, 5: blowjob, 6:kiss
			
			; 보이스는 속성에 따라 보이스 정보 요청
			if !Voice && !IsForcedSilent
				String _actorVoice = ""
				if IsFemale
					_actorVoice = "Female_"
				else 
					_actorVoice = "Male_"
				endif

				; modified by alton		
				String _voiceType = getVoiceType(ActorRef)

				if _voiceType == "Player" || _voiceType == "Young" || _voiceType == "Teen"
					IsVirgin = !IsCreature || Stats.SexCount(ActorRef) == 0
				endif

				_actorVoice += _voiceType			
				SetVoice(Config.VoiceSlots.GetByName(_actorVoice), IsForcedSilent)
			endif			

			if !IsPlayer
				actorRef.SetUnconscious(true)
			endif 
		endIf

		isSfxSoundSynchMode = false		
		expectedTime = 0.0		

		; SFX 사운드 동기화 정보 요청
		String[] sfxTimes = new String[1]
		sfxTimes = Animation.PositionSfxTimes(sfxTimes, Position, Thread.Stage)

		if sfxTimes[0] != ""
			isSfxSoundSynchMode = true
			sfxSoundTimeBlocks = PapyrusUtil.StringSplit(sfxTimes[0], ",")
			sfxSoundBlockIdx = 0
		endif 	

		if position == 0
			Debug.Notification("Animation " + CurrentSA + ", Stage " + Thread.Stage)
		endif
		
		; 거리에 따른 대화 내용 출력
		if getvolume() >= 0.2	
			;팩션 랭크 업데이트
			if Thread.Stage == Animation.StageCount
				ActorRef.SetFactionRank(Thread.SfxStageFaction, 99)	
			else 
				ActorRef.SetFactionRank(Thread.SfxStageFaction, Thread.Stage)	
			endif
			SayDialog()			
		endif

		; 표정 설정
		RefreshExpression()

		if !IsSilent			
			TransitUp(50, 20)
		endIf
		
		; 첫스테이징일 경우 2 초 지연
		float opTime = 0
		if Thread.Stage == 1			
			opTime =  Utility.GetCurrentRealTime() - startAnimationTime
			opTime = 2.0 - opTime	; 애니메이션 초기화에 최대 3초 소요..
		endif 

		RegisterForSingleUpdate(opTime)
	endFunction	

	event OnUpdate() 

		if Utility.IsInMenuMode()
			Sound.StopInstance(sfxSoundId)
			RegisterForSingleUpdate(0.1)
			return
		endif

		float startTime =  Utility.GetCurrentRealTime()
		float delayTime = 0.0

		if sfxPlayStatus == "ready"
			sfxPlayStatus = "playing"		
			Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, Thread.Stage))
		else 
			delayTime = startTime - expectedTime
		endif

		float updateTime = VoiceDelay * 0.35

		if isSfxSoundSynchMode
				float opTime = 0.0
				float idleTime  = 0.0
				updateTime = 0.0
				if sfxSoundBlockIdx >= sfxSoundTimeBlocks.length
					sfxSoundBlockIdx = 0
				endif

				String[] blocks = PapyrusUtil.StringSplit(sfxSoundTimeBlocks[sfxSoundBlockIdx], ":")
				sfxSoundBlockIdx += 1				
				String blockType = blocks[0]

				if blockType == "slt"				; silent
					idleTime = blocks[1] as float									
				elseif blockType == "jmp"			; jump
					sfxSoundBlockIdx = blocks[1] as int			
				elseif blockType == "nxt"			; next
					String[] sfxTimes = new String[1]
					sfxTimes = Animation.PositionSfxTimes(sfxTimes, position, Thread.stage + 1)
					sfxSoundTimeBlocks = PapyrusUtil.StringSplit(sfxTimes[0], ",")
					sfxSoundBlockIdx = 0
				else						
					String[] timeBlocks = PapyrusUtil.StringSplit(blocks[1], "|")
					if timeBlocks.length > 1
						idleTime = timeBlocks[0] as float									
						Utility.wait(idleTime)	
						startTime =  Utility.GetCurrentRealTime() - 0.2							
						idleTime = timeBlocks[1] as float					
					else 
						idleTime = blocks[1] as float
					endif 

					; play sound
					float volume = getvolume()
					if volume > 0.0
						; sfx
						Sound.StopInstance(sfxSoundId)						
						if blockType == "fck"			; fuck
							if Thread.hasFurnitureRole
								Sound.SetInstanceVolume(Thread.SfxBedSound.Play(actorRef), volume - 0.1)
							endif 
							sfxSoundId = Thread.SfxFuckSound.Play(actorRef)
						elseif blockType == "pus"		; pussy
							if Thread.hasFurnitureRole
								Sound.SetInstanceVolume(Thread.SfxBedSound.Play(actorRef), volume - 0.2)
							endif 							
							sfxSoundId = Thread.SfxPussySound.Play(actorRef)
						elseif blockType == "stp"		; stop
							updateTime = 1.0
						else
							if blockType == "lic"		; lick
								sfxSoundId = Thread.SfxLickSound.Play(actorRef)
							elseif blockType == "mou"		; mouth
								sfxSoundId = Thread.SfxMouthSound.Play(actorRef)
							elseif blockType == "dmu"		; deep mouth
								sfxSoundId = Thread.SfxDeepMouthSound.Play(actorRef)
							elseif blockType == "hpy"		; happy
								sfxSoundId = Thread.SfxHappySound.Play(actorRef)
								emotion = "happy"
								volume = volume - 0.2
								Enjoyment = 10
							elseif blockType == "afd"		; afraid
								sfxSoundId = Thread.SfxAfraidSound.Play(actorRef)
								emotion = "afraid"
								volume = volume - 0.1
								Enjoyment = 0
							endif
						endif

						if sfxSoundId != -999
							Sound.SetInstanceVolume(sfxSoundId, volume)
						endif
					
						; moan
						if !IsSilent && blockType != "afd" && blockType != "hpy"
							if startTime - moanSoundOffset > 3
								moanSoundOffset = startTime	
								GetEnjoyment()
								TransitDown(50, 20)								
								Voice.PlayMoan(ActorRef, Enjoyment, UseLipSync, volume)
							endif
						endif 
					endif									
				endif	

				float endTime = Utility.GetCurrentRealTime()
				opTime = opTime + (endTime - startTime)
				if opTime < idleTime
					updateTime = idleTime - opTime						
				endif	

				if updateTime > delayTime
					updateTime -= delayTime
				endif

				; Debug.Notification("uT: " + updateTime + ", dT: " + delayTime + ", oT: " + opTime + ", iT:" + idleTime)
				expectedTime = endTime + updateTime
		else 						
			float volume = getvolume()
			if !IsSilent
					if startTime - moanSoundOffset > 3
						moanSoundOffset = startTime
						GetEnjoyment()
						TransitDown(50, 20)
						Voice.PlayMoan(ActorRef, Enjoyment, UseLipSync, volume)		
					endif
			endIf
		endif				

		if sfxPlayStatus != "ready"
			RegisterForSingleUpdate(updateTime)
		endif
	endEvent

	function SyncThread()
		; Sync with thread info
		GetPositionInfo()
		VoiceDelay = BaseDelay
		if !IsSilent && Thread.Stage > 1
			VoiceDelay -= (Thread.Stage * 0.8) + Utility.RandomFloat(-0.2, 0.4)
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
		Debug.Notification("RefreshActor")
		UnregisterForUpdate()
		SyncThread()
		StopAnimating(true)
		SyncLocation(true)
		; Debug.SendAnimationEvent(ActorRef, "SexLabSequenceExit1")
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Utility.WaitMenuMode(0.1)
		Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
		; Debug.SendAnimationEvent(ActorRef, "SexLabSequenceExit1")
		; Debug.SendAnimationEvent(ActorRef, Animation.FetchPositionStage(Position, 1))
		CurrentSA = Animation.Registry
		SyncLocation(true)
		SendAnimation()
		RegisterForSingleUpdate(1.0)
		Thread.SyncEventDone(kRefreshActor)
	endFunction

	function RefreshLoc()
		Offsets = Animation.PositionOffsets(Offsets, AdjustKey, Position, Thread.Stage, BedStatus[1])
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
		Snap()
	endEvent

	function OrgasmEffect()
		DoOrgasm()
	endFunction

	function DoOrgasm(bool Forced = false)		
		Debug.Notification("DoOrgasm")
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
		
		if Config.OrgasmEffects
			; Shake camera for player
			if IsPlayer && Game.GetCameraState() >= 8
				Game.ShakeCamera(none, 1.00, 2.0)
			endIf
			float _volume = getvolume()
			; Play SFX/Voice
			if !IsSilent
				Debug.Notification("doOrgasmSound")
				PlayLouder(Voice.GetOrgasmSound(), ActorRef, _volume)
			endIf		
			; Apply cum to female positions from male position orgasm
			int i = Thread.ActorCount
			if i > 1 && Config.UseCum && (MalePosition || IsCreature) && (IsMale || IsCreature || (Config.AllowFFCum && IsFemale))
				if i == 2
					Thread.PositionAlias(IntIfElse(Position == 1, 0, 1)).ApplyCum()
				else
					while i > 0
						i -= 1
						if Position != i && Animation.IsCumSource(Position, i, Thread.Stage)
							Thread.PositionAlias(i).ApplyCum()
						endIf
					endWhile
				endIf
			endIf
		endIf
	endFunction

	function OrgasmEffectEnd()
		Debug.Notification("OrgasmEffectEnd")	
	endFunction

	event ResetActor()		
		Debug.Notification("ResetActor")
		if !isPlayer
			actorRef.SetUnconscious(false)
		endif

		ClearEvents()
		GoToState("Resetting")
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
; --- alton added                                     --- ;
; ------------------------------------------------------- ;
; 표정
function TransitUp(int from, int to)
	while from < to
		from += 2
		; MfgConsoleFunc.SetPhonemeModifier(ActorRef, 0, 1, from) ; OLDRIM
		ActorRef.SetExpressionPhoneme(1, (from as float / 100.0)) ; SKYRIM SE
	endWhile
endFunction

function TransitDown( int from, int to)
	while from > to
		from -= 2
		; MfgConsoleFunc.SetPhonemeModifier(ActorRef, 0, 1, from) ; OLDRIM
		ActorRef.SetExpressionPhoneme(1, (from as float / 100.0)) ; SKYRIM SE
	endWhile
endFunction

; 대화
function SayDialog()
	if Thread.SfxDialogTopic
		if isPlayer
			ActorRef.say(Thread.SfxDialogTopic, ActorRef, true)
		endif
		; if !isPlayer
		; 	ActorRef.SetUnconscious(false)
		; endif
		; ActorRef.say(Thread.SfxDialogTopic)
		; if !isPlayer
		; 	ActorRef.SetUnconscious(true)
		; endif
	endif
endFunction

; 행위 대상 주변에 액션에 관여하지 않는 대상이 존재하는지 확인
bool function findPeekingActor(actor _actor,  int _formType = 0, float _distance = 100.0)
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
				; Debug.Notification("someone peeks sex")				
				return true
			endif 
		endif

		i += 1
	endWhile

	return false
endfunction

; 거리에 따라 볼륨값 획득 (조건절 수정 필요)
float function getvolume () 

	if Thread.hasPlayer
		return 0.6
	else 
		ObjectReference _actorRef = ActorRef as ObjectReference
		ObjectReference _playerRef = PlayerRef as ObjectReference
	
		float _distance = _actorRef.GetDistance(_playerRef)
		float _volume = 0.1
	
		if _distance < 1000
			_distance = (_distance / 150) / 10
			_volume = 0.6 - _distance
	
		elseif _distance < 100
			_distance = (_distance / 15) / 100
			_volume = 0.6 - _distance
		else
			_volume = 0.0
		endif

		return _volume
	endif 

endfunction


String function getVoiceType(actor _actor)
	String vType = "Common"

	if isCreature 

	else 
		ActorBase actBase = _actor.GetBaseObject() as ActorBase    
		VoiceType actVoiceType = actBase.GetVoiceType()
		int formId= actVoiceType.GetFormID()

		if _actor.GetActorBase().getSex() == 1 
			; female   
			if IsPlayer
				vType = "Player"
	
			elseif formId == 0x13AE9
				vType = "Teen"
	
			elseif formId == 0x13ADC
				vType = "Young"
				
			elseif formId == 0x13AE5
				vType = "Coward"
	
			elseif formId == 0x13AE0 || formId == 0x13BC3
				vType = "Sultry"
	
			elseif formId == 0x13AE4
				vType = "Confident"     
							
			elseif formId == 0x13ADD
				vType = "Even"              
	
			elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
				vType = "Young"
	
			elseif formId == 0x13AE3 || formId == 0x1B560
				vType = "Solder"
						
			elseif formId == 0x13AE1 || formId == 0x13AE2 
				vType = "Old"
	
			elseif formId == 0x13AE8 ; orc
				vType = "Orc"
	
			elseif formId == 0x13AED ; Khajit
				vType = "Khajit"
	
			elseif formId == 0x13AE9 ; Argonian
				vType = "Argonian"
			endif          
		else 
			; male
		endif        
	
	endif 
	return vType
endFunction

; alton add
; 액션중 공격을 받으면, 진행중인 액션은 종료
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Debug.Notification("under attacked")
	Thread.EndAnimation()
endEvent	

; ------------------------------------------------------- ;
; --- Actor Manipulation                              --- ;
; ------------------------------------------------------- ;

function StopAnimating(bool Quick = false, string ResetAnim = "IdleForceDefaultState")
	if !ActorRef
		return
	endIf

	if !isPlayer
		ActorRef.SetUnconscious(false)
	endif

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
	ActorRef.SetFactionRank(Config.AnimatingFaction, 1)
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

	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)	
	ActorRef.EvaluatePackage()

	Debug.SendAnimationEvent(ActorRef, "SOSFlaccid")

	; Enable movement
	if IsPlayer
		Thread.DisableHotkeys()
		MiscUtil.SetFreeCameraState(false)
		; Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.EnablePlayerControls()
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
		Enjoyment = (PapyrusUtil.ClampFloat(1.0 / 5.0, 0.0, 40.0) + ((Thread.Stage as float / Animation.StageCount as float) * 60.0)) as int
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf		

		; Debug.Notification("gameTime " + Utility.GetCurrentGameTime())	; 1.916

		float perStage = 0.0
		if Thread.Stage == 1
			Enjoyment = BaseEnjoyment
		else 
			perStage =  ((Thread.Stage - 1.0) / Animation.StageCount) * 100
			Enjoyment = BaseEnjoyment + perStage as int
		endif

		; Enjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, Thread.LeadIn, IsFemale, 0, Thread.Stage, Animation.StageCount)
		
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
		int CumID = Animation.GetCumID(Position, Thread.Stage)
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
	int cumID = Animation.GetCumID(Position, Thread.Stage)
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

function Strip()
	if !ActorRef || IsCreature
		return
	endIf
	; Start stripping animation
	if DoUndress
		if !actorRef.GetWornForm(0x00000004)
			Debug.SendAnimationEvent(ActorRef, "Scene_" + BaseSex + "_Undress")
			Utility.Wait(5.0)
		endif
		NoUndress = true
	endIf
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
endFunction

function UnStrip()
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
	RegisterForModEvent(e+"OrgasmEnd", "OrgasmEffectEnd")
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
	;ActorVoice     = none
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
	CurrentSA      = ""
	; Storage
	StripOverride  = Utility.CreateBoolArray(0)
	Equipment      = Utility.CreateFormArray(0)
	; Make sure alias is emptied
	TryToClear()

	if !isPlayer
		ActorRef.SetUnconscious(false)
	endif	

endFunction

function Setup()
	; Reset function Libraries - SexLabQuestFramework
	if !Config || !ActorLib || !Stats
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config   = SexLabQuestFramework as sslSystemConfig
			ActorLib = SexLabQuestFramework as sslActorLibrary
			Stats    = SexLabQuestFramework as sslActorStats
		endIf
	endIf
	DebugMode  = Config.DebugMode
	UseScale   = !Config.DisableScale
	PlayerRef = Game.GetPlayer()
	Thread    = GetOwningQuest() as sslThreadController
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
function OrgasmEffectEnd()
endFunction
function DoOrgasm(bool Forced = false)
endFunction
event ResetActor()
endEvent

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
