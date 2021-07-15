Scriptname BaboDiaQuest extends Quest

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Sex Setting Area \\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

function RegisterSexlabHooks()
	RegisterForModEvent("HookStageStart", "BakaSexlabStart")
	RegisterForModEvent("HookAnimationEnd", "BakaSexlabEnd")
endFunction

function UnregisterSexlabHooks()
	UnregisterForModEvent("HookStageStart")
	UnregisterForModEvent("HookAnimationEnd")
endFunction

Function RapeCustom(ReferenceAlias Victim, ReferenceAlias Raper01, ReferenceAlias Raper02, ReferenceAlias Raper03, ReferenceAlias Raper04, String Tag01, String Tag02, String Tag03, Bool NextScene, String EventRegisterDummy, String EventName, Bool Rape = true)

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




function ExaminePussyPlayer(ReferenceAlias Raper)
	Actor ActorRef = Raper.GetActorReference()
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = ActorRef
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Fisting", "Aggressive", "Binding",  TagSuppress = "Femdom")
	;debug.messagebox ("He tries to penetrate my pussy with his fist!!")
	RegisterForModEvent("AnimationEnd_AfterSexS2", "AfterSexScene2")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS2")
EndFunction


function RapeFemalePlayerActor(Actor Rapist)
	
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = Rapist
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Rape", "Aggressive", "Vaginal",  TagSuppress = "Femdom")
	RegisterForModEvent("AnimationEnd_AfterSexS", "AfterSexScene")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS")
EndFunction

function RapeFemalePlayer(ReferenceAlias Raper)
	Actor ActorRef = Raper.GetActorReference()
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = ActorRef
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Rape", "Aggressive", "Vaginal",  TagSuppress = "Femdom")
	RegisterForModEvent("AnimationEnd_AfterSexS", "AfterSexScene")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS")
EndFunction

function RapeFaintedFemalePlayer(ReferenceAlias Raper)
	Actor ActorRef = Raper.GetActorReference()
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = ActorRef
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Faint", "Necro", "Vaginal",  TagSuppress = "Femdom")
	(BaboSexController as BaboSexControllerManager).BaboDiaMessagebox(2)
	RegisterForModEvent("AnimationEnd_AfterSexS", "AfterSexScene")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS")
EndFunction

function RapeFemalePlayeragain(ReferenceAlias Raper)
	Actor ActorRef = Raper.GetActorReference()
	actor[] sexActors = new actor[2]
	sexActors[0] = Game.GetPlayer()
	sexActors[1] = ActorRef
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Necro", "Aggressive", "Vaginal" ,  TagSuppress = "Femdom")
	(BaboSexController as BaboSexControllerManager).BaboDiaMessagebox(3)
	RegisterForModEvent("AnimationEnd_AfterSexS2", "AfterSexScene2")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0])
;	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS2")
EndFunction

function RapeGangbang4(ReferenceAlias Actor01, ReferenceAlias Actor02, ReferenceAlias Actor03, ReferenceAlias Actor04)
	Actor Victim = Actor01.GetActorReference()
	Actor Raper01 = Actor02.GetActorReference()
	Actor Raper02 = Actor03.GetActorReference()
	Actor Raper03 = Actor04.GetActorReference()
	actor[] sexActors = new actor[4]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sexActors[2] = Raper02
	sexActors[3] = Raper03
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(4, "MMMF", "Aggressive")
	RegisterForModEvent("AnimationEnd_AfterSexSceneMMMF01S", "AfterSexSceneMMMF01")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexSceneMMMF01S")
EndFunction

function RapeGangbang5(ReferenceAlias Actor01, ReferenceAlias Actor02, ReferenceAlias Actor03, ReferenceAlias Actor04, ReferenceAlias Actor05)
	Actor Victim = Actor01.GetActorReference()
	Actor Raper01 = Actor02.GetActorReference()
	Actor Raper02 = Actor03.GetActorReference()
	Actor Raper03 = Actor04.GetActorReference()
	Actor Raper04 = Actor05.GetActorReference()
	actor[] sexActors = new actor[5]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sexActors[2] = Raper02
	sexActors[3] = Raper03
	sexActors[4] = Raper04
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(5, "MMMMF", "Aggressive")
	 RegisterForModEvent("AnimationEnd_AfterSexSceneMMMF01S", "AfterSexSceneMMMF01")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexSceneMMMF01S")
EndFunction

function Rape2Gangbang5(ReferenceAlias Actor01, ReferenceAlias Actor02, ReferenceAlias Actor03, ReferenceAlias Actor04, ReferenceAlias Actor05)
	Actor Victim = Actor01.GetActorReference()
	Actor Raper01 = Actor02.GetActorReference()
	Actor Raper02 = Actor03.GetActorReference()
	Actor Raper03 = Actor04.GetActorReference()
	Actor Raper04 = Actor05.GetActorReference()
	actor[] sexActors = new actor[5]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sexActors[2] = Raper02
	sexActors[3] = Raper03
	sexActors[4] = Raper04
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(5, "MMMMF", "Aggressive")
	RegisterForModEvent("AnimationEnd_AfterSexScene01S", "AfterSexScene01")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexScene01S")
EndFunction

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Array Area \\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

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



;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Event Area \\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Event AfterSexScene(string eventName, string argString, float argNum, form sender)
;Debug.notification( "AfterSexScene")
	Scene01.ForceStart()

	If DisalbeControl01Switch
		Game.DisablePlayerControls(abmenu = true)
	EndIf
	Utility.wait(2.0)
	PlayerREF.playIdle(OrgasmAfter01)
	If NexStageSwitch == true
		WERaperQ.setstage(nextstage)
	EndIf
;	UnregisterForModEvent("AnimationEnd_AfterSexS")
EndEvent

Event AfterSexScene01(string eventName, string argString, float argNum, form sender)
	Scene02.ForceStart()
	Game.EnablePlayerControls(abmenu = true)
	Game.GetPlayer().SetUnconscious(false)
	PlayerREF.playIdle(OrgasmAfter02)
;	UnregisterForModEvent("AnimationEnd_AfterSexScene01S")
EndEvent

Event AfterSexScene2(string eventName, string argString, float argNum, form sender)
	Scene03.ForceStart()
	Game.DisablePlayerControls(abmenu = true)
	PlayerREF.playIdle(OrgasmAfter03)
	If NexStageSwitch02 == true
		WERaperQ.setstage(nextstage02)
	EndIf
;	UnregisterForModEvent("AnimationEnd_AfterSexS2")
EndEvent

Event AfterSexScene3(string eventName, string argString, float argNum, form sender)
	PlayerREF.playIdle(OrgasmAfter04)
	If NexStageSwitch04 == true
		If WERaperQ.getstage() == Currentstage0401
			WERaperQ.setstage(nextstage0401)
		ElseIf WERaperQ.getstage() == Currentstage0402
			WERaperQ.setstage(nextstage0402)
			UnregisterForModEvent("AnimationEnd_AfterSexS3")
		EndIf
	EndIf
EndEvent



Event AfterSexSceneMMMF01(string eventName, string argString, float argNum, form sender)
	Actor Victim = SexLab.HookActors(argString)[0]
	Actor Raper01 = SexLab.HookActors(argString)[1]
	Actor Raper02 = SexLab.HookActors(argString)[2]
	Actor Raper03 = SexLab.HookActors(argString)[3]
	actor[] sexActors = new actor[4]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sexActors[2] = Raper02
	sexActors[3] = Raper03
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(4, "MMMF", "Aggressive")
	(BaboSexController as BaboSexControllerManager).BaboDiaMessagebox(1)
	RegisterForModEvent("AnimationEnd_AfterSexS", "AfterSexScene")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS")
;	UnregisterForModEvent("AnimationEnd_AfterSexSceneMMMF01S")
EndEvent

Event AnotherSexMF01(string eventName, string argString, float argNum, form sender)
	Actor Victim = SexLab.HookActors(argString)[0]
	Actor Raper01 = SexLab.HookActors(argString)[1]
	actor[] sexActors = new actor[2]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Necro", "Aggressive", "Vaginal" ,  TagSuppress = "Femdom")
	RegisterForModEvent("AnimationEnd_AfterSexS3", "AfterSexScene3")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexS3")
;	UnregisterForModEvent("AnimationEnd_AnotherSexMF01S")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
  if (akSource == PlayerRef) && (asEventName == "BaboBackhugStruggling01G")
		Debug.notification("Stage" + SLHHStartStage)
		WERaperQ.setstage(SLHHStartStage)
  endIf
  if (akSource == PlayerRef) && (asEventName == "BaboBackhugStruggling02G")
		Debug.notification("Stage" + SLHHEscapeStage)
		WERaperQ.setstage(SLHHEscapeStage)
  endIf
  if (akSource == PlayerRef) && (asEventName == "BaboBackhugStruggling01PG")
		Debug.notification("Stage" + SLHHGropingStage)
		WERaperQ.setstage(SLHHGropingStage)
  endIf
endEvent

Event BakaSexlabEnd(int tid, bool HasPlayer)	
	sslThreadController Thread = SexLab.GetController(tid)
	Actor[] Positions = Thread.Positions
;	int i = 0
	WERaperQ.setstage(SLHHAfterRaped)
EndEvent

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Basic Function Area \\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Function NPCChallengeStart(ReferenceAlias Alias01, ReferenceAlias Alias02)
	Actor ActorRef01 = Alias01.GetActorReference()
	Actor ActorRef02 = Alias02.GetActorReference()
	ActorRef01.RemoveSpell(BaboCalmSpell)
	ActorRef02.RemoveSpell(BaboCalmSpell)
	actorRef01.addtoFaction(NPCAlias01Faction)
	actorRef02.addtoFaction(NPCAlias02Faction)
	actorRef01.RemoveFromFaction(NPCCrimeFaction01)
	actorRef02.RemoveFromFaction(NPCCrimeFaction02)
	if actorRef01.GetActorValue("Confidence") < 4
		actorRef01.SetActorValue("Confidence", 4) 
	EndIf
	if actorRef02.GetActorValue("Confidence") < 4
		actorRef02.SetActorValue("Confidence", 4) 
	EndIf
	actorRef01.startCombat(actorRef02)
	actorRef02.startCombat(actorRef01)
EndFunction

Function ChallengeStart(ReferenceAlias AliasToAnger)
	Actor ActorRef = AliasToAnger.GetActorReference()
	ActorRef.RemoveSpell(BaboCalmSpell)
	actorRef.addtoFaction(NewChallengerFaction)
	PlayerRef.addtoFaction(NewChallengerPlayerFaction)
	actorRef.RemoveFromFaction(CrimeFaction)
	if actorRef.GetActorValue("Confidence") < 4
		actorRef.SetActorValue("Confidence", 4) 
	EndIf
	actorRef.startCombat(Game.GetPlayer())
EndFunction

Function pacifyAlias(ReferenceAlias AliasToPacify)
	Actor ActorRef = AliasToPacify.GetActorReference()
	actorRef.RemoveFromFaction(NewChallengerFaction)
	PlayerRef.RemoveFromFaction(NewChallengerPlayerFaction)
	actorRef.addtoFaction(CrimeFaction)
	ActorRef.AddSpell(BaboCalmSpell)
	actorRef.SetActorValue("Confidence", 2) 
	actorRef.StopCombat()
EndFunction

Int Function DeathCount()
	DeathCountNum = DeathCountNum + 1
	Debug.Trace(DeathCountNum + " + 1")
		If DeathCountNum >= DeathCountGoalNum
			WERaperQ.setstage(nextstage03)
		EndIf
	Return DeathCountNum
EndFunction

Int Function FaintCount()
	FaintCountNum = FaintCountNum + 1
	Debug.Trace(FaintCountNum + " + 1")
		If FaintCountNum >= FaintCountGoalNum
			WERaperQ.setstage(nextstage03)
		EndIf
	Return FaintCountNum
EndFunction

Function EquipRestraints(actor Victim)
	Victim.Additem(Yoke, 1, true)
	Victim.Additem(AnkleChain, 1, true)
	Victim.Additem(Logbit, 1, true)
	Victim.Additem(RopeCollar, 1, true)
	Victim.EquipItem(Yoke, true, true)
	Victim.EquipItem(AnkleChain, true, true)
	Victim.EquipItem(Logbit, true, true)
	Victim.EquipItem(RopeCollar, true, true)
EndFunction

Function UnEquipRestraints(actor victim)
	Victim.UnequipItem(Yoke, true, true)
	Victim.UnequipItem(AnkleChain, true, true)
	Victim.UnequipItem(Logbit, true, true)
	Victim.UnequipItem(RopeCollar, true, true)
EndFunction

Function EquipCumItem(actor victim)
	Victim.addItem(CumFace, 1, false)
	Victim.addItem(CumChest, 1, false)
	Victim.addItem(CumBelly, 1, false)
	Victim.addItem(CumVagina, 1, false)
	Victim.EquipItem(CumFace, true, true)
	Victim.EquipItem(CumBelly, true, true)
	Victim.EquipItem(CumChest, true, true)
	Victim.EquipItem(CumVagina, true, true)
EndFunction

Function UnEquipCumItem(actor victim)
	Victim.UnEquipItem(CumFace, true, true)
	Victim.UnEquipItem(CumChest, true, true)
	Victim.UnEquipItem(CumBelly, true, true)
	Victim.UnEquipItem(CumVagina, true, true)
	Victim.RemoveItem(CumFace, 1, false)
	Victim.RemoveItem(CumChest, 1, false)
	Victim.RemoveItem(CumBelly, 1, false)
	Victim.RemoveItem(CumVagina, 1, false)
EndFunction

Function LosingControl()
	Game.DisablePlayerControls( true, true, true, false, true, false, true, false )
	Game.SetPlayerAIDriven( true )
;	PlayerRef.SetRestrained(true)
;	PlayerRef.SetDontMove(true)
	Game.ForceThirdPerson()
EndFunction

Function RecoverControl()
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(false)
	PlayerRef.SetRestrained(false)
	PlayerRef.SetDontMove(false)
	Game.ForceThirdPerson()
EndFunction

Function ConfiscatedEquipments(actor victim)
	victim.RemoveAllItems(TargetBox, True, True)
EndFunction

Function RetrieveEquipments(actor victim)
	TargetBox.RemoveAllItems(victim, True, True)
EndFunction

Function ForceReference(Referencealias ActorREF, Actor aksource)
	If !aksource.isdead()
		ActorREF.forcerefto(aksource)
	Endif
Endfunction

Function DraggingtoSexMarket()
	If Simpleslavery.getvalue() == 1
		sendModEvent("SSLV Entry")
	Else
		WeRaperQ.setstage(AvoidMarket)
	EndIf
EndFunction

Function DraggingtoSexMarketWithPossibility()
	int random = Utility.RandomInt(0, 99)
	If Simpleslavery.getvalue() == 1
		If Random < BaboSimpleSlaveryChance.getvalue() as int
			WeRaperQ.setstage(GotoSlavery)
		Else
			WeRaperQ.setstage(AvoidMarket02)
		EndIf
	Else
		WeRaperQ.setstage(AvoidMarket02)
	EndIf
EndFunction

Function SpectatorActivate(Actor pTarget, Actor pTargetFriend = None)
If BaboGlobalSpectatorSwitch.getvalue() == 1
	BaboSpectatorKeyword.SendStoryEvent(None, pTarget, pTargetFriend)
EndIf
endFunction

Function SLHHActivate(Actor pTarget, Actor pTargetFriend = None)
If BaboHorribleHarassment.getvalue() == 1
	Keyword SLHHScriptEventKeyword = Game.GetFormFromFile(0x0000C510, "SexLabHorribleHarassment.esp") as Keyword
	SLHHScriptEventKeyword.SendStoryEvent(None, pTarget, pTargetFriend)
EndIf
endFunction

Function SLHHChokeActivate(Actor pTarget)
	BDMScript.SLHHBCActivate(pTarget, None, 1)
endFunction

Function SLHHRegisterAnimationEvent()
	String BaboBackhugStruggling01G = Game.GetFormFromFile(0x0089B5, "SexLabHorribleHarassment.esp") as Idle
	String BaboBackhugStruggling02G = Game.GetFormFromFile(0x0089B6, "SexLabHorribleHarassment.esp") as Idle
	String BaboBackhugStruggling01PG = Game.GetFormFromFile(0x009493, "SexLabHorribleHarassment.esp") as Idle
	String SLHH_ChokeHug_S04_A01 = Game.GetFormFromFile(0x0233C1, "SexLabHorribleHarassment.esp") as Idle
	String SLHH_ChokeHug_S05_A01 = Game.GetFormFromFile(0x0233C3, "SexLabHorribleHarassment.esp") as Idle
	RegisterForAnimationEvent(Game.getplayer(), BaboBackhugStruggling01G)
	RegisterForAnimationEvent(Game.getplayer(), BaboBackhugStruggling02G)
	RegisterForAnimationEvent(Game.getplayer(), BaboBackhugStruggling01PG)
	RegisterForAnimationEvent(Game.getplayer(), SLHH_ChokeHug_S04_A01)
	RegisterForAnimationEvent(Game.getplayer(), SLHH_ChokeHug_S05_A01)
EndFunction

Function SpectatorChangeStatus(int SCNextStage)
If BaboGlobalSpectatorSwitch.getvalue() == 1
	BaboSpectatorScript.Setstage(SCNextStage)
	;Debug.notification("Since the variable is " + BaboGlobalSpectatorSwitch.getvalue() + ". The quest " + BaboSpectatorScript + " will move on to " + SCNextStage)
EndIf
endFunction

Function FadeinMove(ReferenceAlias akactorRef, ReferenceAlias MovePoint, Int Callstage, Bool Stage)
Actor akactor = akactorRef.GetActorReference()
ObjectReference MP = MovePoint.getref() as objectreference
	FadeToBlackImod.Apply()
	Utility.wait(4.0)
	FadeToBlackImod.PopTo(FadeToBlackHoldImod)
	akactor.moveto(MP);move actor to xmarker
	Utility.wait(5.0)
	
	If stage == true
		WeRaperQ.setstage(Callstage)
	EndIF
	
	Utility.wait(3.0)
	FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
	Utility.wait(5.0)
	FadeToBlackBackImod.Remove()
EndFunction

Function FadeOutMove(ReferenceAlias akactorRef, ReferenceAlias MovePoint, Int Callstage, Bool Stage)
Actor akactor = akactorRef.GetActorReference()
ObjectReference MP = MovePoint.getref() as objectreference
	akactor.moveto(MP)
	Utility.wait(1.0)
	
	If stage == true
		WeRaperQ.setstage(Callstage)
	endif
EndFunction

Function IsscenePlayingCheck(Actor Player)
;Scene PlayingScene


EndFunction

Function CompatiblityCheck(Bool Botton)
If Botton == true
	BDMCM.DisableSLHH(True)
Else
	BDMCM.DisableSLHH(False)
EndIf
EndFunction

Function DisableEssential()
	BDMCM.Disableinvincibility()
EndFunction

Function CorruptionExpLoss(Float Mult)
	BDMScript.CalcCorruptionExpLoss(Mult)
EndFunction

Function CorruptionExp(Float Mult)
	BDMScript.CalcCorruptionExpGain(Mult)
EndFunction

Function TraumaExp(Float Mult)
	BDMScript.CalcTraumaExpGain(Mult)
EndFunction

Function TraumaExpLoss(Float Mult)
	BDMScript.CalcTraumaExpLoss(Mult)
EndFunction

Function LewdnessExp(Float Mult)
	BDMScript.CalcLewdnessExpGain(Mult)
EndFunction

Function LewdnessExpLoss(Float Mult)
	BDMScript.CalcLewdnessExpLoss(Mult)
EndFunction

Function CreatureTraumaExp(Float Mult)
	BDMScript.CalcCreatureTraumaExpGain(Mult)
EndFunction

Function CreatureTraumaExpLoss(Float Mult)
	BDMScript.CalcCreatureTraumaExpLoss(Mult)
EndFunction


Function StopAllSexlabAnimations()
	ThreadSlot.stopall()
EndFunction

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ This is property zone \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

BaboDialogueConfigMenu Property BDMCM Auto
SexLabFramework Property SexLab  Auto 
Quest Property WERaperQ Auto
float Property Num1 auto
Scene Property Scene01 Auto
Scene Property Scene02 Auto
Scene Property Scene03 Auto
Idle property OrgasmAfter01 auto
Idle property OrgasmAfter02 auto
Idle property OrgasmAfter03 auto
Idle property OrgasmAfter04 auto
Actor property PlayerREF auto
Bool Property NexStageSwitch auto
Bool Property NexStageSwitch02 auto
Bool Property NexStageSwitch04 auto
Int Property NextStage auto
Int Property NextStage02 auto
Int Property NextStage03 auto
Int Property NextStage0401 auto
Int Property NextStage0402 auto

Int Property CurrentStage0401 Auto
Int Property CurrentStage0402 Auto

Bool Property DisalbeControl01Switch Auto
Bool RapeSwitch = True

Faction Property NewChallengerFaction Auto
Faction Property NewChallengerPlayerFaction Auto
Faction Property CrimeFaction Auto
Faction Property NPCAlias01Faction Auto
Faction Property NPCAlias02Faction Auto
Faction Property NPCCrimeFaction01 Auto
Faction Property NPCCrimeFaction02 Auto


Int property DeathCountNum = 0 auto hidden conditional
Int Property DeathCountGoalNum Auto

Int property FaintCountNum = 0 auto hidden conditional
Int Property FaintCountGoalNum Auto

Armor property Yoke auto
Armor property RopeCollar auto
Armor property AnkleChain auto
Armor property Logbit auto
Armor property CumFace auto
Armor property CumChest auto
Armor property CumBelly auto
Armor property CumVagina auto

ObjectReference Property TargetBox Auto

GlobalVariable Property SimpleSlavery Auto
Int Property AvoidMarket auto
Int Property AvoidMarket02 auto
Int Property GotoSlavery auto

Int Property SLHHEscapeStage auto
Int Property SLHHStartStage auto
Int Property SLHHGropingStage auto
Int Property SLHHAfterRaped auto


GlobalVariable Property BaboSimpleSlaveryChance Auto
GlobalVariable Property BaboGlobalSpectatorSwitch Auto
GlobalVariable Property BaboHorribleHarassment Auto
Keyword Property BaboSpectatorKeyword Auto
Quest Property BaboSpectatorScript Auto

ImageSpaceModifier Property FadeToBlackImod  Auto  
ImageSpaceModifier Property FadeToBlackHoldImod  Auto  
ImageSpaceModifier Property FadeToBlackBackImod  Auto  

BaboDiaMonitorScript Property BDMScript Auto
Quest Property BaboSexController Auto
Spell Property BaboCalmSpell Auto

sslThreadSlots Property ThreadSlot Auto