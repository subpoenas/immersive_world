scriptname VsActorAlias extends ReferenceAlias

; Library
virtualSexActorUtil ActorUtil

; Actor
ObjectReference CenterRef auto hidden
Actor property ActorRef auto hidden
Actor[] property ActorsRef auto hidden

int property ActorIdx auto hidden


; Actor info
Actor PlayerRef
ActorBase BaseRef
string ActorName
string ActorVoiceType
int Gender
bool IsVictim
bool IsAggressor
bool IsPlayer

; Voice
float VoiceDelay  = 3.0
; Expression
; Sound
Sound HandFX
Sound OralFX
Sound SnapFX
Sound FurnitureFX
Sound WaterFX

;
;	Init Library
;
function Init()
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
function SetupActor(Actor _actorRef)
	; Init actor alias information
	ActorRef   = _actorRef
	BaseRef    = ActorRef.GetLeveledActorBase()
	ActorName  = BaseRef.GetName()
	ActorVoice = BaseRef.GetVoiceType()
	BaseSex    = BaseRef.GetSex()
	Gender	   = ActorRef.GetActorBase().GetSex()
	IsPlayer   = ActorRef == PlayerRef
endFunction
;
;	Prepare Scene/Actor
;
String[] actorAnimationArray
String[] actorActionArray
String[] actorSosArray
String[] actorExpressArray
float[]	 actorRotateArray
float[]	 actorForwardArray
int      actorArrayIdx = 0

function PrepareScene()
	actorAnimationArray = new String[128]
	actorActionArray = new String[128]
	actorSosArray = new String[128]
	actorExpressArray = new String[128]
	actorRotateArray = new Float[128]
	actorForwardArray = new Float[128]
	
	actorArrayIdx = 0
	while actorArrayIdx < 128
		actorRotateArray[actorArrayIdx] = 1000.0
		actorForwardArray[actorArrayIdx] = 1000.0
		actorArrayIdx += 1
	endWhile
	actorArrayIdx = 0		
endfunction 

function PrepareActor()
	; Scene 이전에 발생했던 불필요한 효과 제거
	ActorUtil.ClearEffects()
	LockActor()
endFunction

state doLeadScene
	; play lead scene
	event OnUpdate()
		if actorAnimationArray[actorArrayIdx] == "end"
			GoToState("setupPlayScene")
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

endstate 

state setupPlayScene

endstate 

state doPlayScene

endstate 

state setupOrgasmScene

endstate 

state doOrgasmScene

endstate
