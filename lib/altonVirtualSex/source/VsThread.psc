scriptname VsThread extends Quest
;
;	중심 포지션 찾기 (Available Bed or First Actor)
;	중심 포지션으로 전체 엑터 이동
;	애니메이션 시작
;	애니메이션 종료
;

; Library
VsActorUtil ActorUtil

Actor PlayerRef
String sceneMode = ""
Actor[] actors
bool isRun = false
String[] frameArray
int      frameIdx

bool function IsRun ()
	return isRun
endFunction 

function init (Actor[] _actors, String _sceneMode)
	if !ActorUtil
		ActorUtil = Game.GetFormFromFile(0xD62, "SexLab.esm") as VsActorUtil
	endIf
	
	sceneMode = _sceneMode
	actors = _actors
	isRun = true
	PlayerRef = Game.GetPlayer()

	frameIdx = 0

	frameArray = new String[128]
	frameArray[0] = "fadeIn"
	frameArray[2] = "setPos"
	frameArray[6] = "fadeOut"
	frameArray[8] = "next"

	Debug.Trace("[VS] init in VsThread")
endFunction

function startScene ()
	GotoState("prepareState")
endFunction

state prepareState
	event OnUpdate()

		if frameArray[frameIdx] == "fadeIn"
			Game.FadeOutGame(true, true, 1.0, 2.0)
		elseif frameArray[frameIdx] == "fadeOut"
			Game.FadeOutGame(false, true, 1.0, 2.0)
		elseif frameArray[frameIdx] == "setPos"
			ActorUtil.movePos(actors, PlayerRef)
		elseif frameArray[frameIdx] == "next"
			GotoState("prepareState")
			return
		endif

		RegisterForSingleUpdate(1.0)
	endEvent
endstate


; 리드 액션 수행
function leadScene ()
	ObjectReference bedRef = ActorUtil.FindBed(actors[0], IgnoreUsed = false)

	if bedRef 
		; bed 로 엑터 이동
	else 
		; 첫번째 엑터로 나머지 엑터 이동		
	endif 
endFunction

function playScene ()
endFunction

function endScene ()
endFunction
