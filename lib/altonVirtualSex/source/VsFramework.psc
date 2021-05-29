scriptname VsFramework extends Quest

VsThread[] Property threadPool Auto Hidden

int function GetVersion()
	return 10001
endFunction

string function GetStringVer()
	return "VertualSex v0.01"
endFunction

function init ()
	if threadPool[0] == None
		threadPool = new VsThread[3]

		threadPool[0] =  (Game.GetFormFromFile(0x05005901, "VirtualSexFramework.esp") As VsThread)
		threadPool[1] =  (Game.GetFormFromFile(0x05005901, "VirtualSexFramework.esp") As VsThread)
		threadPool[2] =  (Game.GetFormFromFile(0x05005901, "VirtualSexFramework.esp") As VsThread)
	endif
endFunction

;/* 
	External Interface
*/;

function runSoloScene(Actor _actorRef, string _AnimationTags = "", bool _skipBed = true, bool _skipLeadScene = false, bool _skipEndScene = false)

	VsThread thread = findAvailableThread()

	Actor[] actors = new Actor[1]
	actors[0] = _actorRef

	if thread
		Debug.Trace("[VS] found available thread")
		thread.init(actors, "solo" )
		thread.startScene()
	endif
endFunction

function runLoverScene(Actor[] _actorsRef, string _AnimationTags = "", bool _skipBed = true, bool _skipLeadScene = false, bool _skipEndScene = false)
endFunction

function runProstituteScene(Actor[] _actorsRef, string _AnimationTags = "", bool _skipBed = true, bool _skipLeadScene = false, bool _skipEndScene = false)
endFunction

function runRapeScene(Actor[] _actorsRef, string _AnimationTags = "", bool _skipBed = true, bool _skipLeadScene = false, bool _skipEndScene = false)
	; controller.setAnimationInfo("rape", _actorsRef, _AnimationTags, _AllowBed, _jumpLeadScene)
endFunction

function runSlaveScene(Actor[] _actorsRef, string _AnimationTags = "", bool _skipBed = true, bool _skipLeadScene = false, bool _skipEndScene = false)
	; controller.setAnimationInfo("slave", _actorsRef, _AnimationTags, _AllowBed, _jumpLeadScene)
endFunction

;/* 
	Search available thread from ThreadPool
*/;
VsThread function findAvailableThread()
	int idx = 0
	while idx < threadPool.length 

		if threadPool[idx] && !threadPool[idx].IsRun()
			return threadPool[idx]
		endif
		idx += 1
	endwhile	

	return none
endFunction