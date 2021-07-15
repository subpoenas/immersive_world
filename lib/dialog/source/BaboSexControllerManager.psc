Scriptname BaboSexControllerManager extends Quest  

String file = "../BaboDialogue/BakaStrings.json"

Quest Property BaboMonitorScript Auto
Quest Property BaboReputationScript Auto
Quest Property BaboLoanSharks Auto
Quest Property BaboBadEnd Auto
Quest Property BaboPotionDealer Auto
Quest Property BaboSpectatorScript Auto

Quest Property BaboEventWhiterunOrcVisitiors Auto
Quest Property BaboEventWindhelmNewgnisis Auto
Quest Property BaboEventOrcVillage01 Auto
Quest Property BaboEventMogrul Auto
Quest Property BaboEventMarkarthGuard Auto
Quest Property BaboEventDibellaTemplePerk Auto
Quest Property BaboDialogueWhiterun Auto

Quest Property BaboChangeLocationEvent01 Auto
Quest Property BaboChangeLocationEvent02 Auto
Quest Property BaboChangeLocationEvent03 Auto
Quest Property BaboChangeLocationEvent04a Auto
Quest Property BaboChangeLocationEvent05 Auto
Quest Property BaboChangeLocationEvent06 Auto
Quest Property BaboChangeLocationEvent07 Auto

Quest Property BaboEncounter01 Auto
Quest Property BaboEncounter02 Auto
Quest Property BaboEncounter03 Auto
Quest Property BaboEncounter04 Auto
Quest Property BaboEncounter05 Auto
Quest Property BaboEncounter06 Auto
Quest Property BaboEncounter07 Auto
Quest Property BaboEncounter08 Auto
Quest Property BaboEncounter09 Auto
Quest Property BaboEncounter10 Auto
Quest Property BaboEncounter11 Auto
Quest Property BaboEncounter12 Auto


SexLabFramework Property SexLab  Auto 
Quest MyQuest
BaboDiaMonitorScript Property BDMScript Auto

GlobalVariable Property BaboSimpleSlavery Auto
GlobalVariable Property BaboGlobalSpectatorSwitch Auto

Idle Property BaboDefeatedPanting01 Auto
Idle Property BaboKnockOut01Start Auto
Idle Property BaboExhaustedFront01 Auto
Idle Property BaboExhaustedFront02 Auto
Idle Property BaboExhaustedFront03 Auto
Idle Property BaboExhaustedBack01 Auto
Idle Property BaboExhaustedBack02 Auto
Idle Property BaboExhaustedBack03 Auto

Idle Property BaboFlirt_A01 Auto
Idle Property BaboFlirt_A02 Auto
Idle Property BaboFlirt_A02D Auto
Idle Property BaboFlirtBreast_A01 Auto
Idle Property BaboFlirtBreast_A02 Auto
Idle Property BaboFlirtPussy_A01 Auto
Idle Property BaboFlirtPussy_A02 Auto

Actor Property PlayerRef Auto


Armor Property BaboGagLogBit01 Auto
Armor Property BaboCollarLeatherBinds Auto
Armor Property BaboWristRope01 Auto
Armor Property BaboAnkleRope01 Auto
Armor Property BaboAnkleIronBlack Auto
Armor Property BaboYokeWood01 Auto

Armor Property BaboCumLowerBod1Playable Auto
Armor Property BaboCumMesh1Playable Auto
Armor Property BaboCumUpperBodyPlayable Auto
Armor Property BaboCumVaginaMeshPlayable Auto
Armor Property BaboTearsMesh1Playable Auto

Spell Property BaboCalmSpell Auto

Faction Property BaboHateFaction Auto
Faction Property BaboPlayerFaction Auto
Faction Property BaboHateNPC01Faction Auto
Faction Property BaboHateNPC02Faction Auto

BaboDialogueConfigMenu Property BDMCM Auto

ImageSpaceModifier Property FadeToBlackImod  Auto  
ImageSpaceModifier Property FadeToBlackHoldImod  Auto  
ImageSpaceModifier Property FadeToBlackBackImod  Auto  

Keyword Property BaboSpectatorKeyword Auto

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Sex Setting Area \\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Event Onint()
	RegisterSexlabHooks()
EndEvent

function RegisterSexlabHooks()
	RegisterForModEvent("HookStageStart", "BSCStart")
	RegisterForModEvent("HookAnimationEnd", "BSCEnd")
endFunction

function UnregisterSexlabHooks()
	UnregisterForModEvent("BSCStart")
	UnregisterForModEvent("BSCEnd")
endFunction

Function SexCustomActor(Actor Actor01, Actor Actor02, Actor Actor03, Actor Actor04, Actor Actor05, String Tag01, String Tag02, String Tag03, Bool NextScene, String EventRegisterDummy, String EventName, Bool Rape)

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

Function SexCustom(ReferenceAlias ActorRef01, ReferenceAlias ActorRef02, ReferenceAlias ActorRef03, ReferenceAlias ActorRef04, ReferenceAlias ActorRef05, String Tag01, String Tag02, String Tag03, Bool NextScene, String EventRegisterDummy, String EventName, Bool Rape)

	Actor Actor01 = ActorRef01.GetActorReference()
	Actor Actor02 = ActorRef02.GetActorReference()
	Actor Actor03 = ActorRef03.GetActorReference()
	Actor Actor04 = ActorRef04.GetActorReference()
	Actor Actor05 = ActorRef05.GetActorReference()
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

Function EquipRestraints(actor akactor, bool gag)
	akactor.Additem(BaboWristRope01, 1, true)
	akactor.Additem(BaboAnkleRope01, 1, true)
	akactor.Additem(BaboCollarLeatherBinds, 1, true)
	akactor.EquipItem(BaboWristRope01, true, true)
	akactor.EquipItem(BaboAnkleRope01, true, true)
	akactor.EquipItem(BaboCollarLeatherBinds, true, true)
	if gag
		akactor.Additem(BaboGagLogBit01, 1, true)
		akactor.EquipItem(BaboGagLogBit01, true, true)
	endif
EndFunction

Function EquipRestraintsYoke(actor akactor, bool gag)
	akactor.Additem(BaboYokeWood01, 1, true)
	akactor.Additem(BaboAnkleIronBlack, 1, true)
	akactor.EquipItem(BaboYokeWood01, true, true)
	akactor.EquipItem(BaboAnkleIronBlack, true, true)
	if gag
		akactor.Additem(BaboGagLogBit01, 1, true)
		akactor.EquipItem(BaboGagLogBit01, true, true)
	endif
EndFunction

Function UnEquipRestraints(actor akactor)
	akactor.UnequipItem(BaboYokeWood01, true, true)
	akactor.UnequipItem(BaboWristRope01, true, true)
	akactor.UnequipItem(BaboAnkleRope01, true, true)
	akactor.UnequipItem(BaboGagLogBit01, true, true)
	akactor.UnequipItem(BaboCollarLeatherBinds, true, true)
	akactor.UnequipItem(BaboAnkleIronBlack, true, true)
EndFunction


Function EquipCumItem(actor akactor)
	akactor.addItem(BaboCumLowerBod1Playable, 1, false)
	akactor.addItem(BaboCumMesh1Playable, 1, false)
	akactor.addItem(BaboCumUpperBodyPlayable, 1, false)
	akactor.addItem(BaboCumUpperBodyPlayable, 1, false)
	akactor.addItem(BaboTearsMesh1Playable, 1, false)
	akactor.EquipItem(BaboCumLowerBod1Playable, true, true)
	akactor.EquipItem(BaboCumMesh1Playable, true, true)
	akactor.EquipItem(BaboCumUpperBodyPlayable, true, true)
	akactor.EquipItem(BaboCumUpperBodyPlayable, true, true)
	akactor.EquipItem(BaboTearsMesh1Playable, true, true)
EndFunction

Function UnEquipCumItem(actor akactor)
	akactor.UnEquipItem(BaboCumLowerBod1Playable, true, true)
	akactor.UnEquipItem(BaboCumMesh1Playable, true, true)
	akactor.UnEquipItem(BaboCumUpperBodyPlayable, true, true)
	akactor.UnEquipItem(BaboCumUpperBodyPlayable, true, true)
	akactor.UnEquipItem(BaboTearsMesh1Playable, true, true)
	akactor.RemoveItem(BaboCumLowerBod1Playable, 1, false)
	akactor.RemoveItem(BaboCumMesh1Playable, 1, false)
	akactor.RemoveItem(BaboCumUpperBodyPlayable, 1, false)
	akactor.RemoveItem(BaboCumUpperBodyPlayable, 1, false)
	akactor.RemoveItem(BaboTearsMesh1Playable, 1, false)
EndFunction

Function LosingControl()
	Game.DisablePlayerControls( true, true, true, false, true, false, true, false )
	Game.SetPlayerAIDriven( true )
	Game.ForceThirdPerson()
EndFunction

Function RecoverControl()
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(false)
	PlayerRef.SetRestrained(false)
	PlayerRef.SetDontMove(false)
	Game.ForceThirdPerson()
EndFunction

Function CompatiblityCheck(Bool Botton)
If Botton == true
	BDMCM.DisableSLHH(True)
Else
	BDMCM.DisableSLHH(False)
EndIf
EndFunction

Function NPCChallengeStart(ReferenceAlias Alias01, ReferenceAlias Alias02)
	Actor ActorRef01 = Alias01.GetActorReference()
	Actor ActorRef02 = Alias02.GetActorReference()
	ActorRef01.RemoveSpell(BaboCalmSpell)
	ActorRef02.RemoveSpell(BaboCalmSpell)
	actorRef01.addtoFaction(BaboHateNPC01Faction)
	actorRef02.addtoFaction(BaboHateNPC02Faction)
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
	actorRef.addtoFaction(BaboHateFaction)
	PlayerRef.addtoFaction(BaboPlayerFaction)
	if actorRef.GetActorValue("Confidence") < 4
		actorRef.SetActorValue("Confidence", 4) 
	EndIf
	actorRef.startCombat(PlayerRef)
EndFunction

Function pacifyAlias(ReferenceAlias AliasToPacify)
	Actor ActorRef = AliasToPacify.GetActorReference()
	actorRef.RemoveFromFaction(BaboHateFaction)
	PlayerRef.RemoveFromFaction(BaboPlayerFaction)
	ActorRef.AddSpell(BaboCalmSpell)
	actorRef.SetActorValue("Confidence", 2) 
	actorRef.StopCombat()
EndFunction

Function DisableEssential()
	BDMCM.Disableinvincibility()
EndFunction

Function FadeinMove(ReferenceAlias akactorRef, ReferenceAlias MovePoint, Int Callstage, int Stage)
Actor akactor = akactorRef.GetReference() as actor
ObjectReference MP = MovePoint.getref() as objectreference
	FadeToBlackImod.Apply()
	Utility.wait(4.0)
	FadeToBlackImod.PopTo(FadeToBlackHoldImod)
	akactor.moveto(MP);move actor to xmarker
	Utility.wait(5.0)
	
	If stage == 1;WhiterunViceCaptain
		BaboDialogueWhiterun.setstage(Callstage)
	EndIF
	
	Utility.wait(3.0)
	FadeToBlackHoldImod.PopTo(FadeToBlackBackImod)
	Utility.wait(5.0)
	FadeToBlackBackImod.Remove()
EndFunction


GlobalVariable Property BaboHorribleHarassment Auto

Function SLHHActivate(Actor pTarget, Actor pTargetFriend = None)
	If BaboHorribleHarassment.getvalue() == 1
		Keyword SLHHScriptEventKeyword = Game.GetFormFromFile(0x0000C510, "SexLabHorribleHarassment.esp") as Keyword
		SLHHScriptEventKeyword.SendStoryEvent(None, pTarget, pTargetFriend)
	EndIf
endFunction

Function SLHHChokeActivate(Actor pTarget)
	BDMScript.SLHHBCActivate(pTarget, None, 1)
endFunction

Function SpectatorActivate(Actor pTarget, Actor pTargetFriend = None)
	If BaboGlobalSpectatorSwitch.getvalue() == 1
		BaboSpectatorKeyword.SendStoryEvent(None, pTarget, pTargetFriend)
	EndIf
endFunction

Function SpectatorChangeStatus(int stage)
	If BaboGlobalSpectatorSwitch.getvalue() == 1
		BaboSpectatorScript.Setstage(stage)
	EndIf
endFunction

Function StopAlltheEncounters()
	BaboChangeLocationEvent01.stop()
	BaboChangeLocationEvent02.stop()
	BaboChangeLocationEvent05.stop()
	BaboChangeLocationEvent06.stop()
	BaboChangeLocationEvent07.stop()
	
	BaboEncounter01.stop()
	BaboEncounter02.stop()
	BaboEncounter03.stop()
	BaboEncounter04.stop()
	BaboEncounter05.stop()
	BaboEncounter06.stop()
	BaboEncounter07.stop()
	BaboEncounter08.stop()
	BaboEncounter09.stop()
	BaboEncounter10.stop()
	BaboEncounter11.stop()
	BaboEncounter12.stop()
EndFunction

Function MarkarthGuardMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboeventmarkarthguard01")
		Debug.notification(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboeventmarkarthguard02")
		Debug.notification(msg)
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboeventmarkarthguard03")
		Debug.notification(msg)
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "baboeventmarkarthguard04")
		Debug.notification(msg)
	endif
	
EndFunction

Function StealArmorMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "stealingarmorscriptarmorstolen")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "stealingarmorscriptpantiesstolen")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "stealingarmorscriptclothesstolen")
	endif
	Debug.notification(msg)
EndFunction

Function WindhelmNewgnisisMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript04")
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript05")
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "baboeventnewgnisismasterscript06")
	endif
	Debug.messagebox(msg)
EndFunction


Function WhiterunOrcVisitMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors04")
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors05")
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors06")
	elseif num == 7
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors07")
	elseif num == 8
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors08")
	elseif num == 9
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors09")
	elseif num == 10
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors10")
	elseif num == 11
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunorcvisitiors11")
	endif
	Debug.messagebox(msg)
EndFunction

Function WhiterunViceCaptainMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain04")
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain05")
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain06")
	elseif num == 7
		msg = JsonUtil.getstringvalue(file, "baboeventwhiterunvicecapatain07")
	endif
	Debug.messagebox(msg)
EndFunction

Function BaboDiaMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "babodiaquest01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "babodiaquest02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "babodiaquest03")
	endif
	Debug.messagebox(msg)
EndFunction

Function MonitorMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "babodiamonitor01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "babodiamonitor02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "babodiamonitor03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "babodiamonitor04")
	endif
	Debug.Notification(msg)
EndFunction

Function BadLoanSharkbox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboloanshark01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboloanshark02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboloanshark03")
	endif
	Debug.messagebox(msg)
EndFunction

Function BadEndMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "babobadend01")
		Debug.notification(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "babobadend02")
		Debug.notification(msg)
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "babobadend03")
		Debug.notification(msg)
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "babobadend04")
		Debug.notification(msg)
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "babobadend05")
		Debug.notification(msg)
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "babobadend06")
		Debug.notification(msg)
	endif
EndFunction

Function EncounterEvent01Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent01_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent01_02")
	endif
	Debug.messagebox(msg)
EndFunction

Function EncounterEvent02Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent02_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent02_02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent02_03")
	endif
	Debug.messagebox(msg)
EndFunction

Function EncounterEvent03Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent03_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent03_02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent03_03")
	endif
Debug.messagebox(msg)
EndFunction

Function EncounterEvent04Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent04_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent04_02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent04_03")
	endif
Debug.messagebox(msg)
EndFunction

Function EncounterEvent06Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent06_01")
		Debug.notification(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent06_02")
		Debug.messagebox(msg)
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent06_03")
		Debug.messagebox(msg)
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent06_04")
		Debug.notification(msg)
	endif
EndFunction

Function EncounterEvent08Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent08_01")
		Debug.messagebox(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent08_02")
		Debug.notification(msg)
	endif
EndFunction

Function EncounterEvent10Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent10_01")
		Debug.messagebox(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent10_02")
		Debug.notification(msg)
	endif
EndFunction

Function EncounterEvent11Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent11_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent11_02")
	endif
Debug.messagebox(msg)
EndFunction

Function EncounterEvent12Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_01")
		Debug.messagebox(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_02")
		Debug.messagebox(msg)
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_03")
		Debug.notification(msg)
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_04")
		Debug.messagebox(msg)
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_05")
		Debug.messagebox(msg)
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "baboencounterevent12_06")
		Debug.messagebox(msg)
	endif
EndFunction

Function ChangeLocationEvent01Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_04")
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_05")
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_06")
	elseif num == 7
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_07")
	elseif num == 8
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_08")
	endif
	Debug.messagebox(msg)
EndFunction

Function ChangeLocationEvent02Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent02_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent01_02")
	endif
	Debug.messagebox(msg)
EndFunction

Function NightgateInnMessagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_02")
	elseif num == 3
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_03")
	elseif num == 4
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_04")
	elseif num == 5
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_05")
	elseif num == 6
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_06")
	elseif num == 7
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent03_07")
	endif
		Debug.messagebox(msg)
EndFunction

Function ChangeLocationEvent04Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent04_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent04_02")
	else
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent04_00")
	endif
	Debug.messagebox(msg)
EndFunction

Function ChangeLocationEvent05Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent05_01")
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "BaboChangeLocationEvent05_02")
	endif
	Debug.messagebox(msg)
EndFunction


Function ChangeLocationEvent06Messagebox(int num)
String msg
	if num == 1
		msg = JsonUtil.getstringvalue(file, "babochangelocationevent06_01")
		Debug.notification(msg)
	elseif num == 2
		msg = JsonUtil.getstringvalue(file, "babochangelocationevent06_02")
		Debug.messagebox(msg)
	endif
EndFunction

Function Test()
	JsonUtil.SetStringValue(File, "BaboChangeLocationEvent0301", "TestTest")
EndFunction



Function PairedMotionNPC(actor akactor1, actor akactor2, int num, bool animate)

idle idleAkactor1
idle idleAkactor2
if animate
	if num == 1
		idleAkactor1 = BaboFlirt_A01
		idleAkactor2 = BaboFlirt_A02
	elseif num == 2
		idleAkactor1 = BaboFlirtBreast_A01
		idleAkactor2 = BaboFlirtBreast_A02
	elseif num == 3
		idleAkactor1 = BaboFlirtPussy_A01
		idleAkactor2 = BaboFlirtPussy_A02
	endif
else
	idleAkactor1 = None
	idleAkactor2 = None
endif

NPCPairedAnim(akactor1, akactor2, animate, idleAkactor1, idleAkactor2)

EndFunction

ObjectReference Property BaboPosNPCRef Auto
Faction Property BaboNPCAnimating Auto
Package Property DoNothing Auto

Function NPCPairedAnim(Actor Victim, Actor Aggressor, Bool Animate = True, idle VictimAnim, idle AggressorAnim)
	If Animate
		ActorUtil.AddPackageOverride(Aggressor, DoNothing, 100, 1)
		Aggressor.EvaluatePackage()
		Aggressor.SetRestrained()
		Aggressor.SetDontMove(True)
		
		ActorUtil.AddPackageOverride(Victim, DoNothing, 100, 1)
		Victim.EvaluatePackage()
		Victim.SetRestrained()
		Victim.SetDontMove(True)

		BaboPosNPCRef.MoveTo(Aggressor) ; PosRef
		Float AngleZ = Victim.GetAngleZ()
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Victim.SetVehicle(BaboPosNPCRef) ; PosRef
		Aggressor.SetVehicle(BaboPosNPCRef) ; PosRef
		If !Victim.isinfaction(BaboNPCAnimating) && !Aggressor.isinfaction(BaboNPCAnimating)
			Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
			Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		Endif
		Utility.wait(1.0)
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Victim.playidle(VictimAnim)
		Aggressor.playidle(AggressorAnim)
		Victim.addtofaction(BaboNPCAnimating)
		Aggressor.addtofaction(BaboNPCAnimating)
	Else
		Victim.SetVehicle(None)
		Aggressor.SetVehicle(None)
		Victim.SetRestrained(False)
		Victim.SetDontMove(False)
		Aggressor.SetRestrained(False)
		Aggressor.SetDontMove(False)
		ActorUtil.RemovePackageOverride(Aggressor, DoNothing)
		ActorUtil.RemovePackageOverride(Victim, DoNothing)

		Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
		Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		Victim.removefromfaction(BaboNPCAnimating)
		Aggressor.removefromfaction(BaboNPCAnimating)
	Endif
EndFunction

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ Event Area \\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

;Event BSCEnd(int tid, bool HasPlayer)
;	Actor[] actors = sexlab.HookActors(tid)
;	sslBaseAnimation anim = sexlab.HookAnimation(tid)
;EndEvent

Event LoanSharkAfterSexTest(string eventName, string argString, float argNum, form sender)
	Debug.messagebox("BaboSexControllerManager Test Complete")
;	UnregisterForModEvent("AnimationEnd_LSASTest")
EndEvent

Function DraggingtoSexMarket()
	If BaboSimpleSlavery.getvalue() == 1
		sendModEvent("SSLV Entry")
	EndIf
EndFunction

Event LoanSharkAfterSex01(string eventName, string argString, float argNum, form sender)
	(BaboLoanSharks as BaboLoanSharkScript).LSAS01()
;	UnregisterForModEvent("AnimationEnd_LSAS01")
EndEvent

Event LoanSharkAfterSex02(string eventName, string argString, float argNum, form sender)
	(BaboLoanSharks as BaboLoanSharkScript).LSAS02()
;	UnregisterForModEvent("AnimationEnd_LSAS02")
EndEvent

Event BadEndAfterSex01(string eventName, string argString, float argNum, form sender)
	(BaboBadEnd as BaboBadEndQuest).BEAS01()
;	UnregisterForModEvent("AnimationEnd_BEAS01")
EndEvent

Event WindhelmNewgnisisAfterSex01(string eventName, string argString, float argNum, form sender)
	Actor Victim = SexLab.HookActors(argString)[0]
	Actor Raper01 = SexLab.HookActors(argString)[1]
	actor[] sexActors = new actor[2]
	sexActors[0] = Victim
	sexActors[1] = Raper01
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTag(2, "Necro", "Aggressive", "Vaginal" ,  TagSuppress = "Femdom")
	RegisterForModEvent("AnimationEnd_WNAS01B", "WindhelmNewgnisisAfterSex01B")
	SexLab.StartSex(sexActors, anims, victim=sexActors[0], hook="WNAS01B")
;	UnregisterForModEvent("AnimationEnd_WNAS01")
EndEvent

Event WindhelmNewgnisisAfterSex01B(string eventName, string argString, float argNum, form sender)
	(BaboEventWindhelmNewgnisis as BaboEventNewgnisisMasterScript).WNAS01()
;	UnregisterForModEvent("AnimationEnd_WNAS01B")
EndEvent

Event WindhelmNewgnisisAfterSex02(string eventName, string argString, float argNum, form sender)
	(BaboEventWindhelmNewgnisis as BaboEventNewgnisisMasterScript).WNAS02()
;	UnregisterForModEvent("AnimationEnd_WNAS02")
EndEvent

Event WhiterunOrcVisitorsAfterSex01(string eventName, string argString, float argNum, form sender)
	(BaboEventWhiterunOrcVisitiors as BaboEventWhiterunOrcVisitorsScript).WOAS01()
;	UnregisterForModEvent("AnimationEnd_WOAS01")
EndEvent

Event WhiterunOrcVisitorsAfterSex02(string eventName, string argString, float argNum, form sender)
	(BaboEventWhiterunOrcVisitiors as BaboEventWhiterunOrcVisitorsScript).WOAS02()
;	UnregisterForModEvent("AnimationEnd_WOAS02")
EndEvent

Event WhiterunViceCaptainAfterSex01(string eventName, string argString, float argNum, form sender)
	(BaboDialogueWhiterun as BaboDialogueWhiterunScript).WVAS01()
;	UnregisterForModEvent("AnimationEnd_WVAS01")
EndEvent

;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\ BDM Property \\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

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

