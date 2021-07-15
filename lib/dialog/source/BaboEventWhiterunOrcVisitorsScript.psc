Scriptname BaboEventWhiterunOrcVisitorsScript extends Quest  

Function GoStateBefore()
	GotoState("Before40")
EndFunction

Function GoState()
	GotoState("After40")
EndFunction

Function RegisterUpdate(Int TimeLimit)
UnregisterForUpdateGameTime()
;Debug.notification("Babo Whiterun Orc Unregister Mod")
Int NextInterval = (BaboEventWhiterunOrcVisitorsNextVisitInterval.getvalue() as int)
RegisterForSingleUpdateGameTime(NextInterval + TimeLimit); this is Customizable
;Debug.notification("RegisterForsingleupdategame " + NextInterval)
EndFunction

Function RegisterUpdateOnLoad(Int TimeLimit)
UnregisterForUpdateGameTime()
;Debug.notification("Babo Whiterun Orc Unregister Mod")
RegisterForSingleUpdateGameTime(TimeLimit); this is Customizable
EndFunction

Function BaboEventWhiterunOrcVisitorsTriggerEventValue(int value)
	BaboEventWhiterunOrcVisitorsTriggerEvent.setvalue(value)
Endfunction

Function AliasClear()
	(LydiaRef.getreference() as actor).evaluatepackage()
	(Child1.getreference() as actor).evaluatepackage()
	(Child2.getreference() as actor).evaluatepackage()
	LydiaRef.Clear()
	Child1.Clear()
	Child2.Clear()
	
	OrcRaper01.getreference().deletewhenable()
	OrcRaper02.getreference().deletewhenable()
	OrcRaper03.getreference().deletewhenable()
	OrcRaper01.Clear()
	OrcRaper02.Clear()
	OrcRaper03.Clear()
EndFunction

Function SpawnOrcs()
Actor StrangeOrcActor01 = SpawnPlace.PlaceActorAtMe(StrangeOrc01, 4)
Actor StrangeOrcActor02 = SpawnPlace.PlaceActorAtMe(StrangeOrc02, 4)
Actor StrangeOrcActor03 = SpawnPlace.PlaceActorAtMe(StrangeOrc03, 4)
OrcRaper01.ForceRefTo(StrangeOrcActor01)
OrcRaper02.ForceRefTo(StrangeOrcActor02)
OrcRaper03.ForceRefTo(StrangeOrcActor03)
IF !LydiaActor.isdead()
	LydiaRef.ForceRefto(LydiaActor)
EndIf
if (OChild1.GetReference() == None)
	Return
Else
	OChild1 = Child1
EndIf
if (OChild2.GetReference() == None)
	Return
Else
	OChild2 = Child2
EndIf
EndFunction

function AttackPeople(ReferenceAlias AliasToAnger)

	Actor ActorRef = AliasToAnger.GetActorReference()
	actorRef.RemoveFromFaction(OrcRaperMild)
	actorRef.addtoFaction(OrcRaperHot)
	
	if actorRef.GetActorValue("Aggression") < 2
		actorRef.SetActorValue("Aggression", 2) 
	EndIf

	actorRef.startCombat(Game.GetPlayer())

EndFunction

function RapeGangbangBE4(ReferenceAlias Actor01, ReferenceAlias Actor02, ReferenceAlias Actor03, ReferenceAlias Actor04)

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
	;RegisterForModEvent("AnimationEnd_Gangbang4AfterBE", "AfterSexBE")
	RegisterForModEvent("AnimationEnd_AfterSexTBE", "AfterSexSceneBE")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexTBE")

EndFunction

Event AfterSexBE(string eventName, string argString, float argNum, form sender)

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
	Self.Messagebox(10)
	RegisterForModEvent("AnimationEnd_AfterSexTBE", "AfterSexSceneBE")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="AfterSexTBE")
	UnregisterForModEvent("AnimationEnd_Gangbang4AfterBE")

EndEvent

Event AfterSexSceneBE(string eventName, string argString, float argNum, form sender)

	Scene01.Start()
	Game.DisablePlayerControls(abmenu = true)
	PlayerREF.playIdle(OrgasmAfter01)
	UnregisterForModEvent("AnimationEnd_AfterSexT")

EndEvent

Function EquipZazItem()

PlayerREF.EquipItem(Yoke, true, true)
PlayerREF.EquipItem(RopeCollar, true, true)
PlayerREF.EquipItem(AnkleChain, true, true)
PlayerREF.EquipItem(Logbit, true, true)

EndFunction

Function UnEquipZazItem()

PlayerREF.UnEquipItem(Yoke, true, true)
PlayerREF.UnEquipItem(RopeCollar, true, true)
PlayerREF.UnEquipItem(AnkleChain, true, true)
PlayerREF.UnEquipItem(Logbit, true, true)

Self.Messagebox(11)

EndFunction

Bool Function ResetQuest()
	if (self.getstage() == 80)
		if (BaboDialogueWhiterun.getstage() > 5) && (BaboDialogueWhiterun.getstage() < 100)
			Return False
		endif
	EndIf
	OrcRapeScene01.stop()
	BaboEventWhiterunOrcVisitiorsScene02.stop()
	BaboEventWhiterunOrcVisitiorsSceneExtra.stop()
	BaboEventWhiterunOrcVisitiorsSceneIntro.stop()
	UnregisterForUpdateGameTime()
	UnEquipZazItem()
	(BaboSexController as BaboSexControllerManager).RecoverControl()
	AliasClear()
	(BaboSexController as BaboSexControllerManager).CompatiblityCheck(False)
	GoStateBefore()
	
	Return True
EndFunction

Function RemoveWeapons(ReferenceAlias Actor01, ReferenceAlias Actor02, ReferenceAlias Actor03)
(Actor01.getreference() as actor).UnequipItem(BaboEnchOrcishBattleaxeParalysis, false, true)
(Actor02.getreference() as actor).unequipitem(BaboEnchOrcishBattleaxeParalysis, false, true)
(Actor03.getreference() as actor).unequipitem(BaboEnchOrcishBattleaxeParalysis, false, true)
EndFunction

Function AfterWhiterunViceCaptainClearQuest()
	AliasClear()
	GotoState("Before40")
	Utility.wait(1.0)
	ResetScript.UpdateWhiterunOrcQuest()
EndFunction

State Before40
Event OnUpdateGameTime()
;Debug.notification("Before40 On Update")
	If BaboEvent.GetStage() == 8
		BaboEvent.SetStage(10)
	ElseIf (BaboEvent.GetStage() == 35) || (BaboEvent.GetStage() == 37)
		If (BaboEvent.GetStage() <= 45) && (OrcRaper01.getref().GetParentCell() != Game.GetPlayer().GetParentCell())
			BaboEvent.SetStage(40)
		Else
			;Do Nothing
		EndIf
	Endif
;UnregisterForUpdateGameTime()
EndEvent
EndState

State After40
Event OnUpdateGameTime()
;Debug.notification("After40 On Update")
	If  (self.GetStage() == 67) || (self.GetStage() == 69)
		AliasClear()
		GotoState("Before40")
		Utility.wait(1.0)
		;Debug.notification("From 67 or 69 to the starting point 5")
		ResetScript.UpdateWhiterunOrcQuest()
	ElseIf self.GetStage() == 70
		AliasClear()
		GotoState("Before40")
		Utility.wait(1.0)
		;Debug.notification("From 70 to the starting point 4")
		ResetScript.UpdateWhiterunOrcQuest()
	Endif
EndEvent
EndState

Function Messagebox(int num)
	(BaboSexController as BaboSexControllerManager).WhiterunOrcVisitMessagebox(num)
EndFunction

Function WOAS01()
	Game.DisablePlayerControls(abmenu = true)
	Debug.Sendanimationevent(PlayerRef, "BaboExhaustedBack02")
	BaboEventWhiterunOrcVisitiorsScene03.forcestart()
EndFunction

Function WOAS02()
	Game.DisablePlayerControls(abmenu = true)
	Debug.Sendanimationevent(PlayerRef, "BaboExhaustedBack01")
	BaboEventWhiterunOrcVisitiorsScene01.forcestart()
EndFunction

Quest Property BaboSexController Auto
BaboSexControllerManager property BQuest Auto
GlobalVariable property BaboEventWhiterunOrcVisitorsNextVisitInterval Auto
GlobalVariable property BaboEventWhiterunOrcVisitorsTriggerEvent Auto
ReferenceAlias property Child1 Auto
ReferenceAlias property Child2 Auto
ReferenceAlias property OChild1 Auto
ReferenceAlias property OChild2 Auto
Quest Property BaboEvent Auto
Quest Property BaboDialogueWhiterun Auto
Actor property LydiaActor auto
Actorbase property StrangeOrc01 auto
Actorbase property StrangeOrc02 auto
Actorbase property StrangeOrc03 auto
ObjectReference property SpawnPlace auto
ReferenceAlias Property OrcRaper01 Auto
ReferenceAlias Property OrcRaper02 Auto
ReferenceAlias Property OrcRaper03 Auto
ReferenceAlias Property LydiaRef Auto
Scene Property OrcRapeScene01 Auto
Scene Property BaboEventWhiterunOrcVisitiorsScene01 Auto
Scene Property BaboEventWhiterunOrcVisitiorsScene02 Auto
Scene Property BaboEventWhiterunOrcVisitiorsScene03 Auto
Scene Property BaboEventWhiterunOrcVisitiorsSceneExtra Auto
Scene Property BaboEventWhiterunOrcVisitiorsSceneIntro Auto
Faction Property OrcRaperMild Auto
Faction Property OrcRaperHot Auto
SexLabFramework Property SexLab  Auto
Idle property OrgasmAfter01 auto
Scene Property Scene01 Auto
Scene Property Scene02 Auto
Actor property PlayerREF auto
Armor property Yoke auto
Armor property RopeCollar auto
Armor property AnkleChain auto
Armor property Logbit auto
Cell Property WhiterunBreezehome  Auto  
BaboMCMRestart Property ResetScript Auto
Weapon Property BaboEnchOrcishBattleaxeParalysis Auto
