Scriptname dxFlowerGirlsBase extends Quest  
{Provides API functions.}

Actor Property PlayerRef Auto
{Specifc reference to the Player actor.}

dxAliasPlayer Property PlayerAlias Auto

dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
{Accessor to the common config elements for the FG mod.}
dxTokenToIdleBase Property TokenToIdle  Auto 
{Accessor to the dxTokenToIdle class, this is the database.}
dxThreadManager Property ThreadManager Auto
{Accessor to the dxThreadManager class.}
dxFlowerGirlsSoundFX Property FlowerGirlsSFX  Auto 
{Accessor to the Flower Girls sound fx.}
dxFlowerGirlsMod Property FlowerGirlsMod Auto
{Accessor to the Flower Girls mod class.}
dxSeductionScript Property Seduction Auto
{Accessor to the Seduction class.}
dxPositions Property SexPositions Auto
{Accessor to the Sex Positions class.}

; Keywords used to send storyevents when the scene progresses.
; These are defined here so sub-classing this script they can be redefined.
Keyword Property KeywordSexStarted  Auto 
Keyword Property KeywordStageAdvanced Auto
Keyword Property KeywordSexClimax  Auto  
Keyword Property KeywordSexCompleted  Auto  

; Shortcut property to retrieve the players sexual preference.
; Possible values are:
; 0 : Bi-Sexual
; 1 : Straight
; 2 : Gay
int Property PlayerSexualPreference Hidden
	int Function Get()
		return FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.GetValueInt()
	endFunction
endProperty

; Shortcut property to retrieve the maximum number of scene threads.
int Property MaxThreads Hidden
	int Function Get()
		return ThreadManager.MaxThreads
	endFunction
endProperty

; Shortcut property to retrieve the last time the player was involved in a scene in GameTime.
float Property PlayerLastHadSceneGametime Hidden
	float Function Get()
		return PlayerAlias.PlayerLastHadSceneGametime
	endFunction
	Function Set(float sexGameTime)
		PlayerAlias.PlayerLastHadSceneGametime = sexGameTime
	endFunction
endProperty

; Shortcut property to retrieve the last time the player had sex in GameTime.
float Property PlayerLastHadSexGametime Hidden
	float Function Get()
		return PlayerAlias.PlayerLastHadSexGametime
	endFunction
	Function Set(float sexGameTime)
		PlayerAlias.PlayerLastHadSexGametime = sexGameTime
		PlayerAlias.PlayerLastHadSceneGametime = sexGameTime
	endFunction
endProperty

;--------------------------------------------------------------------------------------------------
; GetActiveThreadForActor(): Locates the active thread containing the passed in 
; actor reference. Returns NONE if the reference is not located.
;--------------------------------------------------------------------------------------------------
dxSceneThread Function GetActiveThreadForActor(ObjectReference actorRef)
	return ThreadManager.GetActiveThreadForActor(actorRef)
endFunction

;---------------------------------------------------------------------------------
; ValidateThread(): Over-ride the base to add the local aliases if
;	required.
;---------------------------------------------------------------------------------
;	@firstActor: First Actor in the scene.
; 	@secondActor: Second Actor in the scene.
;---------------------------------------------------------------------------------
dxSceneThread Function ValidateThread(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (thread)
		if (firstActor != NONE) 
			thread.Participant01.ForceRefTo(firstActor)
		endIf
		if (secondActor != NONE)
			thread.Participant02.ForceRefTo(secondActor)
		endIf
	else
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
	endIf
	return thread
endFunction

Function AddFlowerGirlsBed(Furniture bed)
	FlowerGirlsMod.AddFlowerGirlsBed(bed)
endFunction

Function AddFlowerGirlsBeds(Furniture[] beds)
	FlowerGirlsMod.AddFlowerGirlsBeds(beds)
endFunction

Function AddFlowerGirlsChair(Furniture chair)
	FlowerGirlsMod.AddFlowerGirlsChair(chair)
endFunction

Function AddFlowerGirlsChairs(Furniture[] chairs)
	FlowerGirlsMod.AddFlowerGirlsChairs(chairs)
endFunction

Function AddFlowerGirlsTable(Furniture table)
	FlowerGirlsMod.AddFlowerGirlsTable(table)
endFunction

Function AddFlowerGirlsTables(Furniture[] tables)
	FlowerGirlsMod.AddFlowerGirlsTables(tables)
endFunction

Function AddFlowerGirlsThrone(Furniture throne)
	FlowerGirlsMod.AddFlowerGirlsThrone(throne)
endFunction

Function AddFlowerGirlsThrones(Furniture[] thrones)
	FlowerGirlsMod.AddFlowerGirlsThrones(thrones)
endFunction

Function AddFlowerGirlsWorkbench(Furniture workbench)
	FlowerGirlsMod.AddFlowerGirlsWorkbench(workbench)
endFunction

Function AddFlowerGirlsWorkbenches(Furniture[] workbenches)
	FlowerGirlsMod.AddFlowerGirlsWorkbenches(workbenches)
endFunction

Function AddFlowerGirlsAlchemyBench(Furniture alchemyBench)
	FlowerGirlsMod.AddFlowerGirlsAlchemyBench(alchemyBench)
endFunction

Function AddFlowerGirlsAlchemyBenches(Furniture[] alchemyBenches)
	FlowerGirlsMod.AddFlowerGirlsAlchemyBenches(alchemyBenches)
endFunction

bool Function HasAvailableBed()
	ObjectReference objRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(FlowerGirlsConfig.PermittedFurnitureBeds, PlayerREF, 256.0)
	if (objRef != NONE)
		if (objRef.Is3DLoaded())
			Debug.Trace(Self + " HasAvailableBed(): Located suitable bed: " + objRef)
			return True
		endIf
	endIf
	return False
endFunction

Function DebugThis(string func, string msg)
	if (FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt())
		Debug.Trace((Self + " " + func + ": " + msg))
	endIf
endFunction
