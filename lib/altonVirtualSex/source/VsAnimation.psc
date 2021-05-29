scriptname virtualSexAnimation extends Quest

; Library
virtualSexActorUtil ActorUtil

; Actor Info
Actor property ActorRef auto hidden
Actor PlayerRef
ActorBase BaseRef
string ActorName
string ActorVoiceType
int Gender
bool IsVictim
bool IsAggressor
bool IsPlayer

; Faction AnimatingFaction

; Voice
float VoiceDelay  = 3.0
; Expression
; Positioning
; Sound
Sound HandFX
Sound OralFX
Sound SnapFX
Sound FurnitureFX
Sound WaterFX

; Strip/Unstrip
Form[] Equipment

;
;	Load Library
;
function LoadLib()
	if !ActorUtil
		Form virtualSexFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if virtualSexFramework
			ActorUtil   = virtualSexFramework as virtualSexActorUtil
		endIf
	endIf
	PlayerRef = Game.GetPlayer()	
endFunction

;
;	Init Actor
;
bool function SetupActor(Actor _actorRef)
	; Equipment
	Equipment      = Utility.CreateFormArray(0)

	; Init actor alias information
	ActorRef   = _actorRef
	BaseRef    = ActorRef.GetLeveledActorBase()
	ActorName  = BaseRef.GetName()
	ActorVoice = BaseRef.GetVoiceType()
	BaseSex    = BaseRef.GetSex()
	Gender	   = ActorRef.GetActorBase().GetSex()
	IsPlayer   = ActorRef == PlayerRef

	; Set base voice/loop delay
	VoiceDelay = 3.0	
	; Ready
	RegisterEvents()
	
	GoToState("Ready")
	Log(self, "SetActor("+ActorRef+")")
	return true
endFunction

;
;	Prepare scene
;
int      	curArrayIdx = 0
String[] 	frameArray
String[] 	actorActionArray
String[] 	actorSosArray
String[] 	actorMounthArray
float[]	 	actorRotateArray
float[]	 	actorForwardArray

state Ready
	function PrepareActor()
		; Scene 이전에 발생했던 불필요한 효과 제거
		ActorUtil.ClearEffects()

		if IsPlayer
			Game.SetPlayerAIDriven()
		endIf		
		ActorRef.SetFactionRank(AnimatingFaction, 1)
		ActorRef.EvaluatePackage()		

		; Fade out

		; 첫번째 actor를 중심으로 Actors 모임

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