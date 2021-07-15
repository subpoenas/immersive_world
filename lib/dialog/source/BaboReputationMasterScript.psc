Scriptname BaboReputationMasterScript extends Quest Conditional

;\\\\\\\\\\\\\\\\
;\\\Property Zone\\\\\\\
;\\\\\\\\\\\\\\\\

BaboDiaMonitorScript Property BDMScript Auto

Referencealias Property PlayerRef Auto
Referencealias Property BaboChangeLocationEvent05Visitor Auto

Quest Property BaboChangeLocationEvent02 Auto
Quest Property BaboChangeLocationEvent05 Auto
Quest Property BaboChangeLocationEvent06 Auto
Quest Property BaboDialogueWhiterun Auto
Quest Property BaboDialogueHirelings Auto
BaboBoyFriendVariableScript Property BoyFriendVariableScript Auto
Referencealias Property ViceCaptainRef Auto

GlobalVariable Property BaboMonitorScriptCreaturePackageActive auto
GlobalVariable Property SexCountGangBang auto
GlobalVariable Property SexCount auto
GlobalVariable Property BaboSpendableFavor auto
GlobalVariable Property BaboReputation auto
Faction Property RankAdventurer Auto Conditional ;0x0246D9
Faction property RankBadPrisioner Auto Conditional;0x02E8E4
Faction property RankBeggar Auto Conditional ;0x0246D6
Faction property RankBodyGuard Auto Conditional;0x0297DD
Faction property RankBountyHunter Auto Conditional;0x0297DE
Faction property RankHunter Auto Conditional;0x0246DA
Faction property RankKnight Auto Conditional;0x0297E1
Faction property RankLowCitizen Auto Conditional;0x0246D5
Faction property RankMercenary Auto Conditional;0x0297DF
Faction property RankMerchant Auto Conditional;0x0297E0
Faction property RankMiddleCitizen Auto Conditional;0x0246D7
Faction property RankNoble Auto Conditional;0x0246D8
Faction property RankRefugee Auto Conditional;0x0125E9
Faction property RankPilgrim Auto Conditional;0x0246DB

Faction property BaboCurrentHireling Auto
Faction property BaboCurrentAnimalHireling Auto
Faction property BaboCreatureArousedFaction Auto
Faction property BaboCreatureMatePartnerFaction Auto

Faction property BaboChangeLocationEvent06Faction Auto


Bool Function RegisterFactionPopulatedSkyrim()
	If Game.GetModByName("Populated Skyrim Legendary.esp") != 255
		RankAdventurer		= Game.GetFormFromFile(0x000246D9, "Populated Skyrim Legendary.esp") as Faction
		RankBadPrisioner		= Game.GetFormFromFile(0x0002E8E4, "Populated Skyrim Legendary.esp") as Faction
		RankBeggar		= Game.GetFormFromFile(0x000246D6, "Populated Skyrim Legendary.esp") as Faction
		RankBodyGuard		= Game.GetFormFromFile(0x000297DD, "Populated Skyrim Legendary.esp") as Faction
		RankBountyHunter		= Game.GetFormFromFile(0x000297DE, "Populated Skyrim Legendary.esp") as Faction
		RankHunter		= Game.GetFormFromFile(0x000246DA, "Populated Skyrim Legendary.esp") as Faction
		RankKnight		= Game.GetFormFromFile(0x000297E1, "Populated Skyrim Legendary.esp") as Faction
		RankLowCitizen		= Game.GetFormFromFile(0x000246D5, "Populated Skyrim Legendary.esp") as Faction
		RankMercenary		= Game.GetFormFromFile(0x000297DF, "Populated Skyrim Legendary.esp") as Faction
		RankMerchant		= Game.GetFormFromFile(0x000297E0, "Populated Skyrim Legendary.esp") as Faction
		RankMiddleCitizen		= Game.GetFormFromFile(0x000246D7, "Populated Skyrim Legendary.esp") as Faction
		RankNoble		= Game.GetFormFromFile(0x000246D8, "Populated Skyrim Legendary.esp") as Faction
		RankRefugee		= Game.GetFormFromFile(0x000125E9, "Populated Skyrim Legendary.esp") as Faction
		RankPilgrim		= Game.GetFormFromFile(0x000246DB, "Populated Skyrim Legendary.esp") as Faction
		Return True
	Else
		Return False
	EndIf
EndFunction
;\\\\\\\\\\\\\\\\
;\\\Event Zone\\\\\\\
;\\\\\\\\\\\\\\\\

Event PutSexCountEvent()
	SexCount(1)
	Debug.Trace("SexCount + 1")
EndEvent

Event PutSexGangBangCountEvent()
	SexCountgangbang(1)
	Debug.Trace("SexGangBangCount + 1")
EndEvent

Event CorruptionGainEvent()
	BDMScript.CalcCorruptionExpGain(1.0)
EndEvent

Event CorruptionLossEvent()
	BDMScript.CalcCorruptionExpLoss(1.0)
EndEvent

;\\\\\\\\\\\\\\\\
;\\\Function Zone\\\\\\\
;\\\\\\\\\\\\\\\\


Function RegisterEvent()
	RegisterForModEvent("OnCorruptionLossEvent", "CorruptionLossEvent")
	RegisterForModEvent("OnCorruptionGainEvent", "CorruptionGainEvent")
	RegisterForModEvent("OnPutSexCountEvent", "PutSexCountEvent")
	RegisterForModEvent("OnPutSexGangBangCountEvent", "PutSexGangBangCountEvent")
	RegisterExternalModEvent()
;	RegisterFactionPopulatedSkyrim()
	Debug.trace("BaboReputation Script Registering External Triggers")
EndFunction


Function DecreaseReputation(Int BaboRepuetationNum, Int BaboFavorNum)
	BaboReputation.setvalue((BaboReputation.getvalue() as Int) - BaboRepuetationNum)
	If BaboSpendableFavor.getvalue() > 0
		BaboSpendableFavor.setvalue((BaboSpendableFavor.getvalue() as Int) - BaboFavorNum)
	Else
		BaboSpendableFavor.setvalue(0)
	EndIf
EndFunction

Function IncreaseReputation(Int BaboRepuetationNum, Int BaboFavorNum)
	BaboReputation.setvalue((BaboReputation.getvalue() as Int) + BaboRepuetationNum)
	BaboSpendableFavor.setvalue((BaboSpendableFavor.getvalue() as Int) + BaboFavorNum)
EndFunction

Function SpendFavor(Int BaboFavorNum)
	If BaboSpendableFavor.getvalue() > 0
		BaboSpendableFavor.setvalue((BaboSpendableFavor.getvalue() as Int) - BaboFavorNum)
	Else
		BaboSpendableFavor.setvalue(0)
	EndIf
EndFunction

Function SexCount(Int Count)
	SexCount.setvalue((SexCount.getvalue() as Int) + Count)
	BDMScript.CalcTraumaExpGain(Count)
EndFunction

Function SexCountgangbang(Int Count)
	SexCountGangBang.setvalue((SexCountGangBang.getvalue() as Int) + Count)
	BDMScript.CalcTraumaExpGain(Count)
EndFunction

Function AddingTitletoPlayerRef(faction FTitle)
	Game.getplayer().Addtofaction(FTitle)
EndFunction

Function RemovingTitletoPlayerRef(faction FTitle)
	Game.getplayer().Removefromfaction(FTitle)
EndFunction

Function SetTitleGlobal(Globalvariable FGlobal, Int Num)
	FGlobal.setvalue(FGlobal.getvalue() + Num)
Endfunction

;---------------------------SLAPP Related-----------------------------------

Function SLAPPAcquaintanceTrigger(Actor akSpeaker, Bool HadSex = false)
	int handle = ModEvent.Create("SLAPP_AcquaintanceEvent")
	form akspeakerform = akspeaker as form
	if (handle)
		ModEvent.PushForm(handle, akspeakerform)
		ModEvent.PushBool(handle, Hadsex)
		ModEvent.PushString(handle, "BaboDialogue activated SLAPPAcquaintanceEventEvent")
		ModEvent.Send(handle)
	endIf
EndFunction

Function SLAPPHateTrigger(Actor akSpeaker, Bool HadSex = false)
	int handle = ModEvent.Create("SLAPP_HateEvent")
	form akspeakerform = akspeaker as form
	if (handle)
		ModEvent.PushForm(handle, akspeakerform)
		ModEvent.PushBool(handle, Hadsex)
		ModEvent.PushString(handle, "BaboDialogue activated SLAPPHateEvent")
		ModEvent.Send(handle)
	endIf
EndFunction

Event BaboDialogueSLAPPConsequenceEvent(Actor Raper, Bool RapeTry, string results)
	;Debug.notification(results)
	Debug.trace("BaboDialogueSLAPPConsequenceEvent Started")
	ExternalTriggerSLAPP(raper, RapeTry)
EndEvent

Function ExternalTriggerSLAPP(Actor Raper, Bool RapeTry)
if RapeTry == false
	if (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 30) && (BaboDialogueWhiterun.getstage() < 60)
		Raper.Setactorvalue("Variable06", 5)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene03.start()
	elseif (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 60) && (BaboDialogueWhiterun.getstage() < 65)
		Raper.Setactorvalue("Variable06", 6)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene03.start(); For now below 60 and above 60 are the same.
	EndIf
endif

if RapeTry == true
	if (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 30) && (BaboDialogueWhiterun.getstage() < 60)
		Raper.Setactorvalue("Variable06", 6)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene01.start()
	elseif (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 60) && (BaboDialogueWhiterun.getstage() < 65)
		Raper.Setactorvalue("Variable06", 3)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene01.start()
	EndIf

SexCount(1)
endif
EndFunction

;---------------------------SLHH Related-----------------------------------

Function RegisterExternalModEvent()
	Debug.trace("Registering External Mod Events...")
	RegisterForModEvent("BaboDialogue_ConsequenceEvent", "BaboDialogueConsequenceEvent")
	RegisterForModEvent("BaboDialogue_SLAPPConsequenceEvent", "BaboDialogueSLAPPConsequenceEvent")
EndFunction


Event BaboDialogueConsequenceEvent(Form Raper, Bool Worse, string results)
	BaboMonitorScriptCreaturePackageActive.setvalue(0)
	Debug.trace(results)
	Actor RaperActor = Raper as actor
	ExternalTrigger(raperactor, worse)
EndEvent

Function ExternalTrigger(Actor Raper, Bool Raped)
if Raped == false
	if (BaboChangeLocationEvent05.getstage() == 20) && (BaboChangeLocationEvent05Visitor.getactorref() == Raper)
		BaboChangeLocationEvent05.setstage(30);BaboDiaQuest script handles the escapefail situation. Don't have to add elseif.

	elseif (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 30) && (BaboDialogueWhiterun.getstage() < 60)
		Raper.Setactorvalue("Variable06", 4)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene03.forcestart()
	elseif Raper.isinfaction(BaboCurrentHireling) || Raper.isinfaction(BaboCurrentAnimalHireling)
		(BaboDialogueHirelings as BaboDialogueHirelingsQuest).DismissFollower(3)
	EndIf

	if BaboChangeLocationEvent02.getstage() == 20
		BaboChangeLocationEvent02.setstage(70)
	elseif BaboChangeLocationEvent02.getstage() == 30
		BaboChangeLocationEvent02.setstage(70)
	endif

endif

if Raped == true
	if (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 30) && (BaboDialogueWhiterun.getstage() < 60)
		Raper.Setactorvalue("Variable06", 6)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene01.forcestart()
	elseif (Raper.isinfaction(BaboChangeLocationEvent06Faction))
		if BaboChangeLocationEvent06.getstage() == 10
			BaboChangeLocationEvent06.setstage(11)
		elseif BaboChangeLocationEvent06.getstage() == 20
			BaboChangeLocationEvent06.setstage(21)
		endif
	elseif (ViceCaptainRef.getactorref() == Raper) && (BaboDialogueWhiterun.getstage() >= 60) && (BaboDialogueWhiterun.getstage() < 65)
		Raper.Setactorvalue("Variable06", 3)
		(BaboDialogueWhiterun as BaboDiaQuest).Scene01.forcestart()
	elseif Raper.isinfaction(BaboCurrentHireling) || Raper.isinfaction(BaboCurrentAnimalHireling)
		(BaboDialogueHirelings as BaboDialogueHirelingsQuest).AfterRapeSceneStart()
	EndIf

	if BaboChangeLocationEvent02.getstage() == 20
		Utility.wait(5.0)
		BaboChangeLocationEvent02.setstage(30)
	elseif BaboChangeLocationEvent02.getstage() == 30
		BaboChangeLocationEvent02.setstage(40)
	endif

SexCount(1)
endif

if raper.isinfaction(BaboCreatureArousedFaction)
	raper.removefromfaction(BaboCreatureArousedFaction)
	raper.addtofaction(BaboCreatureMatePartnerFaction)
endif
EndFunction