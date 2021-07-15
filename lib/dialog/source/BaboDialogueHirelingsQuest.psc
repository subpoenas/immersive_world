Scriptname BaboDialogueHirelingsQuest extends Quest

BaboDiaQuest Property BDQuest Auto
Quest Property DialogueFollower Auto
BaboReputationMasterScript Property BRMS Auto
Miscobject Property Gold001 Auto
Quest Property BaboDialogueHirelings Auto
GlobalVariable Property BaboPlayerFollowerCount Auto
GlobalVariable Property BaboHirelingBleedoutCountLimit Auto
GlobalVariable Property BaboTipHirelingGold Auto
GlobalVariable Property BaboEFF Auto
Faction Property BaboCurrentHireling Auto
Faction Property BaboPotentialHireling Auto
Faction Property PotentialHireling Auto
Faction Property BaboWasHireling Auto
ReferenceAlias Property AliasPlayerRef Auto
ReferenceAlias Property MercenaryRef Auto
ReferenceAlias property pAnimalAlias Auto
ReferenceAlias Property WasMercenaryRef  Auto 
Int Property BleedoutStacks Auto
Message Property BaboFollowerMessageWait Auto
Message Property BaboFollowerDismissMessageWait Auto
Message Property BaboFollowerDismissMessage Auto
Message Property BaboFollowerDismissMessageRapeFailed Auto

Scene Property BaboDialogueHirelingsWasHirelingScene01 Auto
Scene Property BaboDialogueHirelingsWasHirelingScene02 Auto

FormList Property BaboBadRelationshipHirelingsList Auto
FormList Property BaboNPCRaperList Auto
FormList Property BaboNPCHadSexList Auto

String Property tag01 Auto
String Property tag02 Auto
String Property tag03 Auto
String Property AfterSexSH Auto
String Property AfterSexSceneHireling Auto

Bool WasPotentialHireling

Idle Property OrgasmAfter Auto

SexLabFramework Property SexLab  Auto 

;Variable07
;1. Just a normal mercenary
;2. Opportunist
;3. Criminal

;Variable08
;0. Hire Quit
;1. After 3 days waiting for player, he will decide whether to chase after player either in a good intention or in a evil intention, we don't know.
;2. Sexlab Approach Redux integration part: he flirts player constantly.
;3. SLHH Activation
;4. Pissedoff


Function RegisterEvent()
	RegisterForModEvent("Babo_SLAPPMercenaryEvent", "BaboSLAPPMercenaryEvent")
	RegisterForSleep()
EndFunction

;Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
;
;EndEvent

Event OnSleepStop(bool abInterrupted)

;Scene Start

Endevent

Function FollowerWait()
	actor FollowerActor = MercenaryRef.GetActorRef() as Actor
	FollowerActor.SetAv("WaitingForPlayer", 1)
	FollowerActor.evaluatepackage()
	BaboFollowerMessageWait.Show()
	;BaboDialogueHirelings.setstage(15)
	;SetObjectiveDisplayed(10, abforce = true)
	;follower will wait 3 days
	MercenaryRef.RegisterForSingleUpdateGameTime(72)
EndFunction

Function FollowerAnimalWait()

actor FollowerAnimal = pAnimalAlias.GetActorRef() as Actor

	FollowerAnimal.SetAv("WaitingForPlayer", 1)
	FollowerAnimal.evaluatepackage()
	BaboFollowerMessageWait.Show()
	BaboDialogueHirelings.setstage(16)
	MercenaryRef.RegisterForSingleUpdateGameTime(72)
EndFunction

Function FollowAgain()
	actor FollowerActor = MercenaryRef.GetActorRef() as Actor
	FollowerActor.SetAv("WaitingForPlayer", 0)
	FollowerActor.evaluatepackage()
	;BaboDialogueHirelings.setstage(20)
	MercenaryRef.UnregisterForUpdateGameTime()
EndFunction

Function SetFollower(Actor FollowerActor, Bool Seduction = false)

if MercenaryRef
	MercenaryRef.clear()
	debug.notification("Mercenary Alias is already filled")
else
	debug.notification("Mercenary proceed")
endif
String FollowerName = FollowerActor.getbaseobject().getname()
debug.notification(FollowerName)


	FollowerActor.RemoveFromFaction(BaboPotentialHireling)
	if FollowerActor.isinfaction(PotentialHireling)
		FollowerActor.RemoveFromFaction(PotentialHireling)
		WasPotentialHireling = true
	endif
	FollowerActor.AddtoFaction(BaboCurrentHireling)
	If FollowerActor.GetRelationshipRank(Game.GetPlayer()) < 3 && FollowerActor.GetRelationshipRank(Game.GetPlayer()) >= 0
		FollowerActor.SetRelationshipRank(Game.GetPlayer(), 3)
	EndIf
	
	If BaboEFF.getvalue() == 0
		(DialogueFollower as DialogueFollowerScript).SetFollower(FollowerActor);Register current hireling on the vanilla follower system.
	Else
;		Quest EFFQuest = Quest.GetQuest("DialogueFollowerExtended")
		Quest EFFQuest = Quest.GetQuest("FollowerExtension")
		(EFFQuest as EFFCore).XFL_SetFollow(FollowerActor)
	Endif

	;FollowerActor.SetPlayerTeammate()
	FollowerActor.SetActorValue("Morality", 0)
	MercenaryRef.ForceRefTo(FollowerActor)
	BaboPlayerFollowerCount.SetValue(1)
	
	int RandomChar = Utility.Randomint(1, 3) 
	
	if !FollowerActor.isinfaction(BaboWasHireling)
		FollowerActor.setactorvalue("Variable07", RandomChar)
	endif
	
	;if BaboNPCRaperList.Hasform(FollowerActor)
	;	FollowerActor.setactorvalue("Variable07", 3)
	;endif

	FollowerActor.setactorvalue("Variable08", 2)
EndFunction

Function DismissFollower(Int iMessage = 0)
	actor DismissedFollowerActor = MercenaryRef.GetActorRef() as Actor
	If BaboEFF.getvalue() == 0
		(DialogueFollower as DialogueFollowerScript).DismissFollower(0, 0)
	Else
;		Quest EFFQuest = Quest.GetQuest("DialogueFollowerExtended")
		Quest EFFQuest = Quest.GetQuest("FollowerExtension")
		(EFFQuest as EFFCore).XFL_RemoveFollower(DismissedFollowerActor, 0, 0)
	Endif

	If MercenaryRef && MercenaryRef.GetActorRef().IsDead() == False
		If iMessage == 0
			BaboFollowerDismissMessage.Show()
		elseif iMessage == 1
			BaboFollowerDismissMessageWait.Show()
		elseif iMessage == 2
			;Nothing
		elseif iMessage == 3
			BaboFollowerDismissMessageRapeFailed.Show()
		Else
			BaboFollowerDismissMessage.Show()
		EndIf
		

		DismissedFollowerActor.StopCombatAlarm()
		if WasPotentialHireling
			DismissedFollowerActor.AddToFaction(PotentialHireling)
		endif
		;DismissedFollowerActor.setactorvalue("Variable08", 0)
		DismissedFollowerActor.AddToFaction(BaboPotentialHireling)
		DismissedFollowerActor.AddToFaction(BaboWasHireling)
		DismissedFollowerActor.SetPlayerTeammate(false)
		DismissedFollowerActor.RemoveFromFaction(BaboCurrentHireling)
		DismissedFollowerActor.SetAV("WaitingForPlayer", 0)	

		MercenaryRef.Clear()
		BaboPlayerFollowerCount.SetValue(0)
	EndIf

EndFunction

Function BadRelationshipHireling(actor akactor)
	BaboBadRelationshipHirelingsList.addform(akactor)
EndFunction

Function AfterRapeSceneStart()
	BaboDialogueHirelingsWasHirelingScene02.ForceStart()
	Game.DisablePlayerControls(abmenu = true)
	Utility.wait(1.0)
	Game.getplayer().playIdle(OrgasmAfter)
EndFunction

Function Givetips()

Int Gold = BaboTipHirelingGold.getvalue() as int

	Game.getplayer().removeitem(Gold001, Gold, false, MercenaryRef.Getreference() as actor)
	
	If Gold < 300
		BleedoutCoiuntsDiminish(1)
	elseif (Gold >= 300) && (Gold < 600)
		BleedoutCoiuntsDiminish(2)
	elseif (Gold >= 600) && (Gold < 900)
		BleedoutCoiuntsDiminish(3)
	else
		BleedoutCoiuntsDiminish(4)
	endif
	
EndFunction


Function Havesex(Bool Rough = false, Bool ScenePlay = false)

Actor MercenaryActorRef = MercenaryRef.Getreference() as actor

If Rough == true

tag01 = "Aggressive"
tag02 = "Rape"
tag03 = "MF"

BaboNPCRaperList.addform(MercenaryActorRef)

If ScenePlay == true
AfterSexSH = "AfterSexSH"
AfterSexSceneHireling = "AfterSexSceneHireling"
else
AfterSexSH = none
AfterSexSceneHireling = none
endif

RapeCustom(AliasPlayerRef, MercenaryRef, none, none, none, True, AfterSexSH, AfterSexSceneHireling, true)
BleedoutCoiuntsDiminish(2)
BRMS.SexCount(1)

Else

tag01 = "Cowgirl"
tag02 = "Missionary"
tag03 = "Doggy"
AfterSexSH = none
AfterSexSceneHireling = none

BaboNPCHadSexList.addform(MercenaryActorRef)

RapeCustom(AliasPlayerRef, MercenaryRef, none, none, none, false, AfterSexSH, AfterSexSceneHireling, false)
BleedoutCoiuntsDiminish(4)
BRMS.SexCount(1)

Endif

EndFunction

Function CreatureSexCustom(Actor Actor01, Actor Actor02, Actor Actor03, Actor Actor04, Actor Actor05, Bool NextScene,String Tag01, String Tag02, String Tag03, String EventRegisterDummy, String EventName, Bool Rape = true)

	Actor[] sexActors = MakeActorArray(Actor01, Actor02, Actor03, Actor04, Actor05)
	Int ActorCount = sexActors.Length
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(ActorCount, "Tag01", "Tag02", "Tag03",  TagSuppress = "Femdom")

	If NextScene
		RegisterForModEvent("AnimationEnd_" + EventRegisterDummy, EventName)
		if Rape
			SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook= EventRegisterDummy)
		else
			SexLab.StartSex(sexActors, anims, hook= EventRegisterDummy)
		endif
	Elseif !NextScene
		if Rape
			SexLab.StartSex(sexActors, anims, victim=sexActors[0])
		else
			SexLab.StartSex(sexActors, anims)
		endif
	EndIf
EndFunction


Function RapeCustom(ReferenceAlias Victim, ReferenceAlias Raper01, ReferenceAlias Raper02, ReferenceAlias Raper03, ReferenceAlias Raper04, Bool NextScene, String EventRegisterDummy, String EventName, Bool Rape = true)

	Actor Actor01 = Victim.GetActorReference()
	Actor Actor02 = Raper01.GetActorReference()
	Actor Actor03 = Raper02.GetActorReference()
	Actor Actor04 = Raper03.GetActorReference()
	Actor Actor05 = Raper04.GetActorReference()
	Actor[] sexActors = MakeActorArray(Actor01, Actor02, Actor03, Actor04, Actor05)
	Int ActorCount = sexActors.Length
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(ActorCount, "Tag01", "Tag02", "Tag03",  TagSuppress = "Femdom")

	If NextScene
		RegisterForModEvent("AnimationEnd_" + EventRegisterDummy, EventName)
		if Rape
			SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook= EventRegisterDummy)
		else
			SexLab.StartSex(sexActors, anims, hook= EventRegisterDummy)
		endif
	Elseif !NextScene
		if Rape
			SexLab.StartSex(sexActors, anims, victim=sexActors[0])
		else
			SexLab.StartSex(sexActors, anims)
		endif
	EndIf
EndFunction


Actor[] Function MakeActorArray(Actor Actor1, Actor Actor2, Actor Actor3, Actor Actor4, Actor Actor5)
	Actor[] sexActors
	If Actor5
		sexActors = New Actor[5]
		sexActors[0] = Actor1
		sexActors[1] = Actor2
		sexActors[2] = Actor3
		sexActors[3] = Actor4
		sexActors[4] = Actor5
	Elseif Actor4
		sexActors = New Actor[4]
		sexActors[0] = Actor1
		sexActors[1] = Actor2
		sexActors[2] = Actor3
		sexActors[3] = Actor4
	Elseif Actor3
		sexActors = New Actor[3]
		sexActors[0] = Actor1
		sexActors[1] = Actor2
		sexActors[2] = Actor3
	Else
		sexActors = New Actor[2]
		sexActors[0] = Actor1
		sexActors[1] = Actor2
	Endif
	Return sexActors
EndFunction

Event AfterSexSceneHireling(string eventName, string argString, float argNum, form sender)
	AfterRapeSceneStart()
EndEvent


Function TestSex()
String PlayerString = (AliasPlayerRef.getreference() as actor).GetBaseObject().getname()
String MercenaryString = (MercenaryRef.getreference() as actor).GetBaseObject().getname()

Debug.notification(PlayerString + MercenaryString + "Check")
(BaboDialogueHirelings as BaboDiaQuest).RapeCustom(AliasPlayerRef, MercenaryRef, none, none, none, tag01, tag02, tag03, false, none, none, false)

;(BaboDialogueHirelings as BaboDiaQuest).RapeFemalePlayer(MercenaryRef)
EndFunction


Function BleedoutCoiuntsDiminish(int Count)
	BleedoutStacks -= 1
	If BleedoutStacks < BaboHirelingBleedoutCountLimit.getvalue() as int
		MercenaryRef.GetActorRef().setav("Variable08", 2);Turn to the normal state.
	endif
EndFunction

int Function BleedoutCounts(Bool BacktoInitialStage = false)

If BacktoInitialStage
	BleedoutStacks = 0
Else
	BleedoutStacks += 1
	If (BleedoutStacks >= BaboHirelingBleedoutCountLimit.getvalue() as int)
		if MercenaryRef.GetActorRef().getactorvalue("Variable08") <= 2
			MercenaryRef.GetActorRef().setav("Variable08", 4);Ready to take advantage of Player
		endif
	endif

EndIf

Return BleedoutStacks

EndFunction

Function ChasingPlayer();Needs to be improved
actor FollowerActor = MercenaryRef.GetActorRef() as Actor
	If FollowerActor.getactorvalue("Variable07") == 1
		FollowAgain()
	elseif FollowerActor.getactorvalue("Variable07") == 2
		DismissFollower(1)
	elseif FollowerActor.getactorvalue("Variable07") == 3
		FollowAgain()
		BleedoutStacks += BaboHirelingBleedoutCountLimit.getvalue() as int
		FollowerActor.setactorvalue("Variable08", 4)
	else
	
	endif
EndFunction

Function SexlabApproachRegister(Actor akRef)
	;Debug.notification("WasHired Scene Activated")
	
	if akRef == MercenaryRef.getreference() as actor
		SexlabApproachQuit()
	else
		WasMercenaryRef.forcerefto(akref)
		BaboDialogueHirelingsWasHirelingScene01.start()	
	endif

EndFunction

Function SexlabApproachQuit()
	WasMercenaryRef.clear()
	BaboDialogueHirelingsWasHirelingScene01.stop()
EndFunction

Event BaboSLAPPMercenaryEvent(actor MercenaryRef)
;BaboNPCRaperList.addform(MercenaryRef.getactorbase())
;WIP
Endevent