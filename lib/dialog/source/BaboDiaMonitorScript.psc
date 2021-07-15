Scriptname BaboDiaMonitorScript extends Quest  

Import Game

;\\\\\\\\\Property Zone\\\\\\\\\\
Quest Property BaboSexController Auto

BaboReputationMasterScript Property BRMQuest Auto
BaboXmarkerMover Property BaboXmarkerMoverScript Auto

ObjectReference Property MiscReferences Auto

SexLabFramework Property SexLab Auto
;Location[] Property EventLocations Auto
Location Property WhiterunBreezehomeLocation Auto
Location Property BYOHHouse1LocationInterior Auto
Location Property BYOHHouse2LocationInterior Auto
Location Property BYOHHouse3LocationInterior Auto
BaboDialogueConfigMenu Property BDConfig Auto
BaboDialogueHirelingsQuest Property BaboDialogueHirelings Auto
BaboBoyFriendVariableScript Property BaboBoyFriendVariable Auto
Quest Property BDDibella Auto
Quest Property BaboDialogueWhiterun Auto
Perk Property AllurePerkPlus Auto
Actor Property PlayerRef Auto
Actor crosshairRef = None
ReferenceAlias Property ViceCaptainRef Auto
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property BaboWhiterunBreezehomeGameDay Auto
GlobalVariable Property BaboWhiterunBreezehomeGameDayInterval Auto
GlobalVariable Property BaboBYOHHouse1LocationInteriorGameDay Auto
GlobalVariable Property BaboBYOHHouse1LocationInteriorGameDayInterval Auto
GlobalVariable Property BaboBYOHHouse2LocationInteriorGameDay Auto
GlobalVariable Property BaboBYOHHouse2LocationInteriorGameDayInterval Auto
GlobalVariable Property BaboBYOHHouse3LocationInteriorGameDay Auto
GlobalVariable Property BaboBYOHHouse3LocationInteriorGameDayInterval Auto

GlobalVariable Property BaboMonitorScriptCreaturePackageActive Auto
GlobalVariable Property BaboHorribleHarassment Auto
GlobalVariable Property BaboSexlabStatVaginal Auto
GlobalVariable Property BaboSexlabStatAnal Auto
GlobalVariable Property BaboSexlabStatOral Auto
GlobalVariable Property BaboSexlabStatMales Auto
GlobalVariable Property BaboSexlabStatFemales Auto
GlobalVariable Property BaboSexlabStatCreatures Auto
GlobalVariable Property BaboSexlabStatVictim Auto
GlobalVariable Property BaboSexlabStatAggressor Auto

GlobalVariable Property BaboSexlabStatCorruptionSpeed Auto
GlobalVariable Property BaboSexlabStatCorruption Auto
GlobalVariable Property BaboSexlabStatExhibitionist Auto
GlobalVariable Property BaboSexlabStatLewdness Auto

GlobalVariable Property BaboDetectSpectatorUpdateInterval Auto
GlobalVariable Property BaboDetectSpectatorHowMany Auto

GlobalVariable Property BaboReputation Auto

Faction Property sla_Arousal Auto
Faction Property BaboCreatureMatePartnerFaction Auto
Faction Property BaboCreatureArousedFaction Auto
Faction Property BaboTrollFaction Auto
Faction Property TrollFaction Auto
Faction Property Babopacifiedcreaturefaction Auto
Faction Property BaboTrollAllyFaction Auto
Faction Property JobMerchantFaction Auto
Faction Property PotentialHireling Auto

Faction Property SLAX_SubmissiveFaction Auto
Faction Property SLAX_CumFilledFaction Auto
Faction Property SLAX_WillBrokenFaction Auto
Faction Property SLAX_WillfulFaction Auto
Faction Property SLAX_SexAddictFaction Auto
Faction Property SLAX_NudismAddictFaction Auto


Package Property DoNothing Auto
Spell Property EnthrallMerchantSpell Auto
Bool Isplaying = false

Float Property DistanceZ Auto
Float Property DistanceInFront Auto

ObjectReference Dummy

ReferenceAlias[] Property CreatureReferences Auto
FormList Property BaboCreatureNonPacifiedRace  Auto
FormList Property BaboCreaturePacified  Auto
FormList Property BaboCreatureTrollRace  Auto
Keyword Property ActorTypeUndead Auto
Keyword Property ActorTypeDragon Auto
Keyword Property ActorTypeDaedra Auto
Keyword Property ActorTypeDwarven Auto
Keyword Property ActorTypeFamiliar Auto
Keyword Property ActorTypeGhost Auto
Keyword Property ActorTypeNPC Auto
Race Property TrollRace Auto
Race Property TrollFrostRace Auto
Race Property DLC1TrollRaceArmored Auto
Race Property DLC1TrollFrostRaceArmored Auto

Keyword Property SLA_ArmorSpendex Auto
Keyword Property SLA_ArmorPretty Auto
Keyword Property EroticArmor Auto
Keyword Property SLA_ArmorHalfNakedBikini Auto
Keyword Property SLA_ArmorHalfNaked Auto


Quest Property zadquest Auto

Keyword Property zad_Lockable Auto
Keyword Property zad_DeviousCollar Auto
Keyword Property zad_DeviousBelt Auto
Keyword Property zad_DeviousArmbinder Auto
Keyword Property zad_DeviousHarness Auto
Keyword Property zad_DeviousBra Auto
Keyword Property zad_DeviousSuit Auto
Keyword Property zad_DeviousYoke Auto
Keyword Property zad_DeviousGag Auto
Keyword Property zad_DeviousPlug Auto
Keyword Property zad_DeviousBlindfold Auto
Keyword Property zad_DeviousPiercingsVaginal Auto
Keyword Property zad_DeviousPlugVaginal Auto
Keyword Property zad_DeviousPlugAnal Auto
Keyword Property zad_DeviousBoots Auto
Keyword Property zad_DeviousHood Auto
Keyword Property zad_DeviousCorset Auto
Keyword Property zad_DeviousPiercingsNipple Auto

Key Property zad_ChastityKey Auto
Key Property zad_PiercingsRemovalTool Auto
Key Property zad_RestraintsKey Auto

Faction Property _BF_ParentFaction Auto
GlobalVariable Property _BFPlayerState Auto; 0"Follicular_State" / 1"Ovulation_State" / 2"Luteal_State" / 3"Menstruation_State" / 4"PregnancyFirst_State" / 5"PregnancySecond_State" / 6"PregnancyThird_State" / 7"LaborPains_State" / 8"Replanish_State"

Faction Property zzEstrusChaurusBreederFaction Auto

Faction Property SR_InflateFaction Auto Hidden

Potion Property _JSW_BB_PotionFertility Auto

Float[] Property FertilityLastBirth Auto

Float Property ExhibitionistExp = 0.0 Auto Hidden
Float Property CorruptionExp = 0.0 Auto Hidden
Float Property LewdnessExp = 0.0 Auto Hidden

Float Property BikExp = 0.0 Auto Hidden
Float Property ExpPerLevel = 100.0 Auto Hidden
Float LastUpdate = 0.0
Float InflationFloat = 0.0

Quest Property MQ101 Auto

GlobalVariable Property BaboSexlabStatTrauma Auto
GlobalVariable Property BaboSexlabStatSkimpySpeed Auto
GlobalVariable Property BaboSexlabStatSkimpyExpLevel Auto
GlobalVariable Property BaboSexlabStatExhibitionistSpeed Auto
GlobalVariable Property BaboSexlabStatSkimpyDecrease  Auto
GlobalVariable Property BaboSexlabStatLewdnessSpeed Auto
GlobalVariable Property BaboPlayerPubicHair Auto

GlobalVariable Property BaboSexCountRiekling Auto
GlobalVariable Property BaboSexCountTroll Auto
GlobalVariable Property BaboSexCountChaurus Auto
GlobalVariable Property BaboSexCountGiant Auto
GlobalVariable Property BaboSexCountWerewolf Auto
GlobalVariable Property BaboSexCountDraugr Auto
GlobalVariable Property BaboSexCountFalmer Auto
GlobalVariable Property BaboSexCountBear Auto
GlobalVariable Property BaboSexCountSabreCat Auto
GlobalVariable Property BaboSexCountWolf Auto
GlobalVariable Property BaboSexCountDwarven Auto
GlobalVariable Property BaboSexCountDragon Auto

GlobalVariable Property BaboSexlabStatusFHU  Auto

GlobalVariable Property BaboSexlabSurvivalGlobal Auto
GlobalVariable Property BaboFHU Auto
GlobalVariable Property BaboBF Auto
GlobalVariable Property BaboDDI Auto
GlobalVariable Property BaboFertility Auto
GlobalVariable Property BaboEstrusChaurus Auto

Keyword Property _SLS_BikiniArmor Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto
Keyword Property Armorcuirass Auto
Keyword Property ClothingBody Auto
Keyword Property SLA_BraBikini Auto
Keyword Property SLA_PantyNormal Auto
Keyword Property SLA_ThongCString Auto
Keyword Property SLA_ThongLowleg Auto
Keyword Property SLA_ThongT Auto

;SLS_Mcm Property Menu Auto
;_SLS_InterfaceSlax Property Sla Auto

Book Property _SLS_LicenceMagic Auto
Book Property _SLS_LicenceArmor Auto
Book Property _SLS_LicenceWeapon Auto
Book Property _SLS_LicenceBikini Auto
Book Property _SLS_LicenceClothes Auto

Faction Property BaboFactionStatCorruption Auto
Faction Property BaboFactionStatExhibitionist Auto
Faction Property BaboFactionStatLewdness Auto

Quest Property BaboDetectSpectatorQuest Auto

Keyword Property BaboDetectSpectatorKeyword Auto

referencealias property Alias_Male01 auto
referencealias property Alias_Male02 auto
referencealias property Alias_Male03 auto

Race Property FalmerRace Auto
Race Property ChaurusRace Auto
Race Property ChaurusReaperRace Auto
Race Property DLC1_BF_ChaurusRace Auto
Race Property DLC1ChaurusHunterRace Auto

Race Property GiantRace Auto
Race Property DLC2GhostFrostGiantRace Auto

Race Property WerewolfBeastRace Auto
Race Property DLC2WerebearBeastRace Auto

Race Property SabreCatRace Auto
Race Property SabreCatSnowyRace Auto
Race Property DLC1SabreCatGlowRace Auto

Race Property BearBlackRace Auto
Race Property BearBrownRace Auto
Race Property BearSnowRace Auto

Race Property WolfRace Auto

Keyword Property ActorTypeCreature Auto
Keyword Property DLC2RieklingKeyword Auto
Keyword Property ActorTypeTroll Auto

Globalvariable Property BaboSexlabStatCreatureTrauma Auto

Faction Property BaboFactionWhiterunOrcFuckToyTitle Auto
Faction Property BaboFactionRieklingThirskFuckToyTitle Auto
Faction Property BaboFactionNightgateInnVictoryTitle Auto
Faction Property BaboFactionNightgateInnFuckedTitle Auto
Faction Property BaboFactionInvestigationMarkarthTitle Auto
Faction Property BaboFactionDeviousNobleSonFuckToyTitle Auto
Faction Property BaboFactionChallengerFucktoyTitle Auto
Faction Property BaboFactionArgonianDisplayedFuckToyTitle Auto
Faction Property BaboFactionArgonianDefeatedTitle Auto
Faction Property BaboFactionPitifulHeroineTitle Auto
Faction Property BaboFactionLoanSharkSlaveTitle Auto

;Bool bTriggeredEvent = false
;======================================
;===============Event Zone================
;======================================

Event OnInit()
	RegisterFunction()
EndEvent

Event OnKeyDown( int keyCode )
	If (!Utility.IsInMenuMode() && BDConfig.NotificationKey == keyCode)
		If BDDibella.getstage() >= 20 && !PlayerRef.isincombat()
			;Debug.Notification("I press it!")

			If (crosshairRef != None)
				if EnthrallMerchants(crosshairRef)
					;Nothing
				else
					BaboXmarkerMoverScript.KeyPressSelfCommentary(0)
				endif
			Else
				;Debug.Notification("SelfCommentary")
				BaboXmarkerMoverScript.KeyPressSelfCommentary(0)
			EndIf
		Else
			;Debug.Notification("SelfCommentary")
			BaboXmarkerMoverScript.KeyPressSelfCommentary(0)
		Endif
	EndIf
EndEvent

;Event OnKeyUp(Int KeyCode, Float HoldTime)
;	If (!Utility.IsInMenuMode() && BDConfig.NotificationKey == keyCode)
;		If (HoldTime > 2.0)			
;		EndIf
;	EndIf
;EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	crosshairRef = ref as actor
;	if ref != none
;			crosshairRef = ref as actor
;	Else
;		crosshairRef = none
;	endIf
EndEvent

Event BaboSLAPPMercenaryEvent(form akSpeakerform)
	Actor akspeaker = akspeakerform as actor
	BaboDialogueHirelings.SexlabApproachRegister(akspeaker)
EndEvent

Event BaboSLAPPBoyFriendEvent(form akSpeakerform)
	Actor akspeaker = akspeakerform as actor
EndEvent


Event BaboSexlabEnd(int tid, bool HasPlayer)
if HasPlayer
	BaboSexlabStatVaginal.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Vaginal"))
	BaboSexlabStatAnal.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Anal"))
	BaboSexlabStatOral.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Oral"))
	BaboSexlabStatMales.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Males"))
	BaboSexlabStatFemales.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Females"))
	BaboSexlabStatCreatures.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Creatures"))
	BaboSexlabStatAggressor.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Aggressor"))
	BaboSexlabStatVictim.setvalue(SexLab.Stats.GetInt(SexLab.PlayerRef, "Victim"))
	CalcLewdnessExpGain(1.0)
endif
EndEvent

event PlayerVictim(string eventName, string argString, float argNum, form sender)
	sslThreadController Thread = SexLab.HookController(argString)
	Actor Victim = SexLab.HookActors(argString)[0]
	Actor Rapist01 = SexLab.HookActors(argString)[1]

	if Thread.IsVictim(Victim)
		CalcTraumaExpGain(1.0)
		CalcCorruptionExpGain(1.0)
		if Rapist01.haskeyword(ActorTypeCreature)
			BaboSexlabStatCreatures.setvalue(BaboSexlabStatCreatures.getvalue() + 1)
			CalcCreatureTraumaExpGain(1.0)
			
			if Rapist01.haskeyword(ActorTypeTroll)
				BaboSexCountTroll.setvalue(BaboSexCountTroll.getvalue() + 1)
			elseif Rapist01.haskeyword(DLC2RieklingKeyword)
				BaboSexCountRiekling.setvalue(BaboSexCountRiekling.getvalue() + 1)
			elseif Rapist01.haskeyword(ActorTypeUndead)
				BaboSexCountDraugr.setvalue(BaboSexCountDraugr.getvalue() + 1)
			elseif Rapist01.getrace() == WolfRace
				BaboSexCountWolf.setvalue(BaboSexCountWolf.getvalue() + 1)
			elseif Rapist01.getrace() == SabreCatRace || Rapist01.getrace() == SabreCatSnowyRace || Rapist01.getrace() == DLC1SabreCatGlowRace
				BaboSexCountSabreCat.setvalue(BaboSexCountSabreCat.getvalue() + 1)
			elseif Rapist01.getrace() == BearBlackRace || Rapist01.getrace() == BearBrownRace || Rapist01.getrace() == BearSnowRace
				BaboSexCountBear.setvalue(BaboSexCountBear.getvalue() + 1)
			elseif Rapist01.getrace() == GiantRace || Rapist01.getrace() == DLC2GhostFrostGiantRace || Rapist01.getrace() == DLC1_BF_ChaurusRace || Rapist01.getrace() == DLC1ChaurusHunterRace
				BaboSexCountGiant.setvalue(BaboSexCountGiant.getvalue() + 1)
			elseif Rapist01.getrace() == ChaurusRace || Rapist01.getrace() == ChaurusReaperRace || Rapist01.getrace() == DLC1_BF_ChaurusRace || Rapist01.getrace() == DLC1ChaurusHunterRace
				BaboSexCountChaurus.setvalue(BaboSexCountChaurus.getvalue() + 1)
			elseif Rapist01.getrace() == WerewolfBeastRace || Rapist01.getrace() == DLC2WerebearBeastRace
				BaboSexCountWerewolf.setvalue(BaboSexCountWerewolf.getvalue() + 1)
			elseif Rapist01.getrace() == FalmerRace
				BaboSexCountFalmer.setvalue(BaboSexCountFalmer.getvalue() + 1)
			elseif Rapist01.haskeyword(ActorTypeDragon)
				BaboSexCountDragon.setvalue(BaboSexCountDragon.getvalue() + 1)
			elseif Rapist01.haskeyword(ActorTypeDwarven)
				BaboSexCountDwarven.setvalue(BaboSexCountDwarven.getvalue() + 1)
			endif
		endif
	endIf
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if (akSource == PlayerRef) && (asEventName == "SLHH_Drunk_S04_A01") ; Failed
		CalcCorruptionExpGain(1.0)
	endIf
	if (akSource == PlayerRef) && (asEventName == "SLHH_Drunk_S05_A01") ; Success
		CalcCorruptionExpLoss(1.0)
	endIf

	if (akSource == PlayerRef) && (asEventName == "SLHH_ChokeHug_S04_A01") ; Failed
		CalcCorruptionExpGain(2.0)
	endIf
	if (akSource == PlayerRef) && (asEventName == "SLHH_ChokeHug_S05_A01") ; Success
		CalcCorruptionExpLoss(2.0)
	endIf

	if (akSource == PlayerRef) && (asEventName == "BaboBackHugClimaxG")
		CalcCorruptionExpGain(1.0)
	endIf

	if (akSource == PlayerRef) && (asEventName == "BaboBackhugStruggling02G")
		CalcCorruptionExpLoss(1.0)
	endIf

	if (akSource == PlayerRef) && (asEventName == "BaboBackHugClimaxGfortroll")
		CalcCorruptionExpGain(1.0)
	endIf

	if (akSource == PlayerRef) && (asEventName == "BaboBackhugStruggling02Gfortroll")
		CalcCorruptionExpLoss(1.0)
	endIf
endEvent

;======================================
;===============Functions================
;======================================
Function CreatureRegister(Actor creatureRef, Race CreatureRace)
	if creatureRef.haskeyword(ActorTypeNPC)
		return
	endif

	if creatureRef.haskeyword(ActorTypeUndead) || creatureRef.haskeyword(ActorTypeDragon) || creatureRef.haskeyword(ActorTypeDaedra) || creatureRef.haskeyword(ActorTypeDwarven) || creatureRef.haskeyword(ActorTypeFamiliar) || creatureRef.haskeyword(ActorTypeGhost)
		return
	endif

	if creatureRef.isinfaction(Babopacifiedcreaturefaction) || creatureRef.isinfaction(BaboCreatureMatePartnerFaction)
		return
	endif

	if BaboCreatureNonPacifiedRace.hasform(CreatureRace)
		return
	endif

	; Filter non-sexually aroused creatures
	Bool IsSexCreature = 0

	if (BaboCreatureTrollRace.hasform(CreatureRace)) && !(creatureRef.isinFaction(BaboTrollAllyFaction)) && !(creatureRef.isinFaction(BaboCreatureArousedFaction))
		creatureRef.AddToFaction(BaboTrollAllyFaction)
		BaboCreaturePacified.addform(creatureref)
		creatureRef.stopcombatalarm()
		IsSexCreature = 0
	elseif creatureRef.isinFaction(BaboTrollAllyFaction)
		creatureRef.removefromFaction(BaboTrollAllyFaction)
		creatureRef.removefromFaction(TrollFaction)
		creatureRef.removefromFaction(BaboTrollFaction)
		creatureRef.AddToFaction(BaboCreatureArousedFaction)
		IsSexCreature = 0
	elseif creatureRef.isinFaction(BaboCreatureArousedFaction)
		if creatureRef.isincombat()
			return
		else
			IsSexCreature = 1
		endif
	else
		creatureRef.AddToFaction(Babopacifiedcreaturefaction)
		BaboCreaturePacified.addform(creatureref)
		IsSexCreature = 0
		return
	endif

	if isSexCreature == 1
		Float ArousalState = creatureRef.getfactionrank(sla_Arousal)

		if PlayerRef.WornHasKeyword(SLA_Armorpretty)
			ArousalState += 10
		elseif PlayerRef.WornHasKeyword(SLA_ArmorSpendex)
			ArousalState += 20
		elseif PlayerRef.WornHasKeyword(EroticArmor)
			ArousalState += 40
		elseif PlayerRef.WornHasKeyword(SLA_ArmorHalfNakedBikini)
			ArousalState += 60
		elseif PlayerRef.WornHasKeyword(SLA_ArmorHalfNaked)
			ArousalState += 70
		endif
		if ArousalState >= 95
			creatureRef.SetFactionRank(sla_Arousal, 100 as int)
		else
			creatureRef.SetFactionRank(sla_Arousal, (ArousalState + 5) as int)
		endif
		
		Debug.notification("ArousalState is" + creatureRef.GetFactionRank(sla_Arousal) as int)
		if BaboMonitorScriptCreaturePackageActive.getvalue() == 0
			BaboMonitorScriptCreaturePackageActive.setvalue(1)
			ManageCreature(creatureRef)
			creatureRef.evaluatepackage()
		elseif BaboMonitorScriptCreaturePackageActive.getvalue() == 1
			if creatureRef == CreatureReferences[0].GetReference() as Actor || creatureRef == CreatureReferences[1].GetReference() as Actor || creatureRef == CreatureReferences[2].GetReference() as Actor
				creatureRef.evaluatepackage()
			else
				ManageCreature(creatureRef)
				creatureRef.evaluatepackage()
			endif
		endif
	endif
EndFunction

Function Creatureunregister()
	int iIndex = BaboCreaturePacified.getsize()
	While iIndex > 0
		Actor akList = BaboCreaturePacified.GetAt(iIndex) as actor

		if !(akList as actor).is3dLoaded()
			BaboCreaturePacified.RemoveAddedForm(akList)
			akList.Removefromfaction(Babopacifiedcreaturefaction)
			akList.Removefromfaction(BaboTrollAllyFaction)
			akList.Removefromfaction(BaboCreatureArousedFaction)
		endIf
		iIndex -= 1
	EndWhile
EndFunction

Actor Function ManageCreature(actor ArousedAnimal)
	Debug.trace("ManageCreature")
	int iIndex = 0
	While iIndex < 3
	Actor a1 = CreatureReferences[iIndex].GetReference() as Actor
		if !a1 || a1.isdead() || !a1.is3dLoaded()
			;Debug.notification(iIndex)
			CreatureReferences[iIndex].clear()
			CreatureReferences[iIndex].forcerefto(ArousedAnimal)
			return	ArousedAnimal
		endif
		iIndex += 1
	EndWhile
EndFunction

Function PlayerChangeLocation(Location akOldLoc, Location akNewLoc)
	if akNewLoc == WhiterunBreezehomeLocation
		if (BaboDialogueWhiterun.getstage() >= 30) && (BaboDialogueWhiterun.getstage() < 65)
			if BaboWhiterunBreezehomeGameDayInterval.getvalue() <= (GameDaysPassed.getvalue() - BaboWhiterunBreezehomeGameDay.getvalue())
				Actor ViceCaptain = ViceCaptainRef.GetReference() as Actor
				if ViceCaptain.is3dloaded()
					;vice captain's variable change
					BaboBoyFriendVariable.Variable06DiceRoll(ViceCaptainRef.GetReference() as Actor, 1)
				endif
			endif
			BaboWhiterunBreezehomeGameDay.setvalue(GameDaysPassed.getvalue())
		endif
	elseif akNewLoc == BYOHHouse1LocationInterior
	elseif akNewLoc == BYOHHouse2LocationInterior
	elseif akNewLoc == BYOHHouse3LocationInterior
	endif
EndFunction

Function RegisterExternalModEvent()
	RegisterForModEvent("Babo_SLAPPMercenaryEvent", "BaboSLAPPMercenaryEvent")
	RegisterForModEvent("Babo_SLAPPBoyFriendEvent", "BaboSLAPPBoyFriendEvent")
EndFunction

Function RegisterFunction()
	RegisterForCrosshairRef()
	UpdateKeyRegistery()
	RegisterForSexLabEvents()
	RegisterExternalModEvent()
	BeginUpdates()
	
	CD_FHU()
	CD_BF()
	CD_SLS()
	CD_DDI()
	CD_Fertility()
	CD_EstrusChaurus()
	
	Debug.Trace("BaboDialogue Keysetting Completed")
EndFunction

Function RegisterForSexLabEvents()
	RegisterForModEvent("PlayerTrack_End", "BaboSexlabEnd")
	
	if BaboHorribleHarassment.getvalue() == 1
		SLHHRegisterAnimationEvent()
	endif
EndFunction

Function SLHHRegisterAnimationEvent()
	String BaboBackHugClimaxGfortroll = Game.GetFormFromFile(0x01ED98, "SexLabHorribleHarassment.esp") as Idle
	String BaboBackHugClimaxG = Game.GetFormFromFile(0x014BC9, "SexLabHorribleHarassment.esp") as Idle
	
	String BaboBackhugStruggling02Gfortroll = Game.GetFormFromFile(0x01ED99, "SexLabHorribleHarassment.esp") as Idle
	String BaboBackhugStruggling02G = Game.GetFormFromFile(0x0089B6, "SexLabHorribleHarassment.esp") as Idle

	String SLHH_ChokeHug_S04_A01 = Game.GetFormFromFile(0x0233C1, "SexLabHorribleHarassment.esp") as Idle
	String SLHH_ChokeHug_S05_A01 = Game.GetFormFromFile(0x0233C3, "SexLabHorribleHarassment.esp") as Idle

	RegisterForAnimationEvent(PlayerRef, BaboBackHugClimaxGfortroll)
	RegisterForAnimationEvent(PlayerRef, BaboBackHugClimaxG)
	RegisterForAnimationEvent(PlayerRef, BaboBackhugStruggling02Gfortroll)
	RegisterForAnimationEvent(PlayerRef, BaboBackhugStruggling02G)
	RegisterForAnimationEvent(PlayerRef, SLHH_ChokeHug_S04_A01)
	RegisterForAnimationEvent(PlayerRef, SLHH_ChokeHug_S05_A01)
	RegisterForAnimationEvent(PlayerRef, "SLHH_DeathLoop")
	RegisterForAnimationEvent(PlayerRef, "SLHH_Drunk_SBD_A01Loop")
	RegisterForAnimationEvent(PlayerRef, "SLHH_Drunk_S04_A01")
	RegisterForAnimationEvent(PlayerRef, "SLHH_Drunk_S05_A01")
EndFunction

Function UpdateKeyRegistery()
	UnregisterForAllKeys()
	If BDConfig.NotificationKey != -1
		RegisterForKey(BDConfig.NotificationKey)
		Debug.Trace(self + ": Updated notification key to " + BDConfig.NotificationKey)
	EndIf
EndFunction

Bool Function EnthrallMerchants(Actor Merchant)
	If Merchant && !Merchant.isincombat()
		If Merchant.IsinFaction(JobMerchantFaction) || Merchant.IsinFaction(PotentialHireling)
			;Merchant.addperk(AllurePerkPlus)
			Debug.SendAnimationEvent(Merchant, "IdleForceDefaultState")
			Utility.wait(1.0)
			Merchant.setlookat(PlayerRef, True)
			Utility.wait(2.0)
			int random = Utility.RandomInt(0, 99)
			If random <= 33
				Debug.SendAnimationEvent(PlayerRef, "BaboAllurePussyShowing01")
				Debug.SendAnimationEvent(Merchant, "BaboAllureManPussyResponse01")
			ElseIf random > 33 && random <= 66
				Debug.SendAnimationEvent(PlayerRef, "BaboAllureBreastShowing01")
				Debug.SendAnimationEvent(Merchant, "BaboAllureManBreastResponse01")
			ElseIf random > 66 && random <= 99
				Debug.SendAnimationEvent(PlayerRef, "BaboAllureSeducingkiss01")
				Debug.SendAnimationEvent(Merchant, "IdleExamine")
			EndIf
			EnthrallMerchantSpell.cast(Merchant)
			Return true
		EndIf
	Else
		(BaboSexController as BaboSexControllerManager).MonitorMessagebox(1)
	EndIf

	Return False
EndFunction

Function BeginUpdates()
	LastUpdate = GameDaysPassed.GetValue()
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Event OnUpdateGameTime()
	DoUpdate()
	DoStatus()
EndEvent

;======================================
;===============Status=================
;======================================

Function DoStatus()

if BaboFHU.getvalue() == 1
	SR_InflateFaction = Game.GetFormFromFile(0x00A991, "sr_FillHerUp.esp") as Faction
	InflationFloat = PlayerRef.getfactionrank(SR_InflateFaction)
	
	if InflationFloat < 5
		BaboSexlabStatusFHU.setvalue(0)
	elseif InflationFloat >= 5 && InflationFloat < 20
		BaboSexlabStatusFHU.setvalue(1)
	elseif InflationFloat >= 20 && InflationFloat < 40
		BaboSexlabStatusFHU.setvalue(2)
	elseif InflationFloat >= 40 && InflationFloat < 60
		BaboSexlabStatusFHU.setvalue(3)
	elseif InflationFloat >= 60 && InflationFloat < 80
		BaboSexlabStatusFHU.setvalue(4)
	elseif InflationFloat >= 80
		BaboSexlabStatusFHU.setvalue(5)
	endif
	PlayerRef.setfactionrank(SLAX_CumFilledFaction, BaboSexlabStatusFHU.getvalue() as int) ; It will be replaced by FillHerUp mod
endif
ExportStatus()
EndFunction

;======================================
;===============Experience=============
;======================================
Function DoUpdate()
	BaboDetectSpectatorKeyword.SendStoryEvent(None, PlayerRef)

	Utility.wait(5.0);Wait for the quest to start

	Alias_Male01 = BaboDetectSpectatorQuest.getalias(2) as referencealias
	Alias_Male02 = BaboDetectSpectatorQuest.getalias(3) as referencealias
	Alias_Male03 = BaboDetectSpectatorQuest.getalias(4) as referencealias

	int HowManyPeople = 0
	if Alias_Male01
		HowManyPeople += 1
	endif
	if Alias_Male02
		HowManyPeople += 1
	endif
	if Alias_Male03
		HowManyPeople += 1
	endif

	BaboDetectSpectatorHowMany.setvalue(HowManyPeople)

	If (_SLS_BikiniArmor && PlayerRef.WornHasKeyword(_SLS_BikiniArmor)) ||  PlayerRef.WornHasKeyword(SLA_ArmorPretty) || PlayerRef.WornHasKeyword(EroticArmor) || PlayerRef.WornHasKeyword(SLA_ArmorSpendex) || PlayerRef.WornHasKeyword(SLA_ArmorHalfNakedBikini) || PlayerRef.WornHasKeyword(SLA_ArmorHalfNaked)
		CalcExpGain()
	ElseIf PlayerRef.WornHasKeyword(Armorcuirass) || PlayerRef.WornHasKeyword(ClothingBody)
		CalcExpLoss()
	Elseif !PlayerRef.WornHasKeyword(Armorcuirass) && !PlayerRef.WornHasKeyword(ClothingBody)
		CalcExpNakedGain()
	EndIf

	CalcLevel()
	LastUpdate = GameDaysPassed.GetValue()
	RegisterForSingleUpdateGameTime(BaboDetectSpectatorUpdateInterval.getvalue())
EndFunction

Function CalcExpNakedGain()
	;Alias_Male01.getreference() as actor  I am not sure if an alias alone can detect whether there is a designated actor or not
	if Alias_Male01
		ExhibitionistExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 3)
		CalcLewdnessExpGain(3.0)
		BRMQuest.DecreaseReputation(1, 0)
	endif

	if Alias_Male02
		ExhibitionistExp *= 2
		CalcLewdnessExpGain(1.0)
	elseif	Alias_Male02 && Alias_Male03
		ExhibitionistExp *= 3
		CalcLewdnessExpGain(2.0)
	endif
EndFunction

Function CalcExpGain()
	Float ExhibitionistExpT
	Float LewdnessExpT

	ExhibitionistExpT = 0.0
	LewdnessExpT = 0.0
	if	PlayerRef.WornHasKeyword(SLA_Brabikini) && !(PlayerRef.WornHasKeyword(SLA_PantyNormal)) && !(PlayerRef.WornHasKeyword(SLA_ThongCString)) && !(PlayerRef.WornHasKeyword(SLA_ThongLowleg)) && !(PlayerRef.WornHasKeyword(SLA_ThongT))
		ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.4)
	endif

	if PlayerRef.WornHasKeyword(SLA_ArmorHalfNaked)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatSkimpySpeed.getvalue() * 1.5)
	elseif PlayerRef.WornHasKeyword(SLA_ArmorSpendex)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatSkimpySpeed.getvalue() * 1.0)
	elseif PlayerRef.WornHasKeyword(SLA_ArmorHalfNakedBikini)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatSkimpySpeed.getvalue() * 1.3)
	elseif PlayerRef.WornHasKeyword(EroticArmor)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatSkimpySpeed.getvalue() * 1.1)
	elseif PlayerRef.WornHasKeyword(SLA_ArmorPretty)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatSkimpySpeed.getvalue() * 0.8)
	elseif _SLS_BikiniArmor && PlayerRef.WornHasKeyword(_SLS_BikiniArmor)
		BikExp += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * BaboSexlabStatSkimpySpeed.getvalue()
	endif

	if Alias_Male01
		if PlayerRef.WornHasKeyword(SLA_ArmorHalfNaked)
			ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 2)
			LewdnessExpT += 2.0
		elseif PlayerRef.WornHasKeyword(SLA_ArmorSpendex)
			ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.15)
			LewdnessExpT += 0.5
		elseif PlayerRef.WornHasKeyword(SLA_ArmorHalfNakedBikini)
			ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.3)
			LewdnessExpT += 1.2
		elseif PlayerRef.WornHasKeyword(EroticArmor)
			ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.1)
			LewdnessExpT += 1.0
		endif

		if BaboPlayerPubicHair.getvalue() == 1
			if PlayerRef.WornHasKeyword(SLA_ThongCString)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.3)
				LewdnessExpT += 0.8
			elseif PlayerRef.WornHasKeyword(SLA_ThongLowleg)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.25);Including G String
				LewdnessExpT += 0.6
			elseif PlayerRef.WornHasKeyword(SLA_ThongT)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.1)
				LewdnessExpT += 0.4
			endif
		else
			if PlayerRef.WornHasKeyword(SLA_ThongCString)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.15)
				LewdnessExpT += 0.7
			elseif PlayerRef.WornHasKeyword(SLA_ThongLowleg)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.1)
				LewdnessExpT += 0.5
			elseif PlayerRef.WornHasKeyword(SLA_ThongT)
				ExhibitionistExpT += ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * (BaboSexlabStatExhibitionistSpeed.getvalue() * 1.05)
				LewdnessExpT += 0.3
			endif
		endif

		if	Alias_Male02
			ExhibitionistExpT *= 2
			LewdnessExpT *= 2
		elseif	Alias_Male02 && Alias_Male03
			ExhibitionistExpT *= 3
			LewdnessExpT *= 3
		endif
	endif

	ExhibitionistExp += ExhibitionistExpT
	CalcLewdnessExpGain(LewdnessExpT)
	If BikExp > ExpPerLevel * 7.5 ; Cap experience
		BikExp = ExpPerLevel * 7.5
	EndIf
	;Debug.Messagebox("OldExp: " + OldExp + "\nExpGain: " + ExpGain + "\nNewExp: " + BikExp)
EndFunction

Function CalcCreatureTraumaExpGain(Float Mult)
	BaboSexlabStatCreatureTrauma.setvalue(BaboSexlabStatCreatureTrauma.getvalue() + Mult)
EndFunction

Function CalcCreatureTraumaExpLoss(Float Mult)
	BaboSexlabStatCreatureTrauma.setvalue(BaboSexlabStatCreatureTrauma.getvalue() - Mult)
EndFunction

Function CreatureIdentification()
EndFunction

Function CalcCorruptionExpGain(Float Mult)
	BaboSexlabStatCorruption.setvalue(BaboSexlabStatCorruption.getvalue() + (BaboSexlabStatCorruptionSpeed.getvalue() * Mult))
	PlayerRef.setfactionrank(SLAX_SubmissiveFaction, BaboSexlabStatCorruption.getvalue() as int)
EndFunction

Function CalcCorruptionExpLoss(Float Mult)
	BaboSexlabStatCorruption.setvalue(BaboSexlabStatCorruption.getvalue() - (BaboSexlabStatCorruptionSpeed.getvalue() * Mult))
	if BaboSexlabStatCorruption.getvalue() < 0
		BaboSexlabStatCorruption.setvalue(0)
	endif
	
	PlayerRef.setfactionrank(SLAX_SubmissiveFaction, BaboSexlabStatCorruption.getvalue() as int)
EndFunction

Function CalcTraumaExpGain(Float Mult)
	BaboSexlabStatTrauma.setvalue(BaboSexlabStatTrauma.getvalue() + Mult)
EndFunction

Function CalcTraumaExpLoss(Float Mult)
	BaboSexlabStatTrauma.setvalue(BaboSexlabStatTrauma.getvalue() - Mult)
	if BaboSexlabStatTrauma.getvalue() < 0
		BaboSexlabStatTrauma.setvalue(0)
	endif
	
	PlayerRef.setfactionrank(SLAX_WillBrokenFaction, BaboSexlabStatTrauma.getvalue() as int)
	
	if PlayerRef.getfactionrank(SLAX_WillBrokenFaction) == 0
		PlayerRef.setfactionrank(SLAX_WillfulFaction, 1)
	else
		PlayerRef.removefromfaction(SLAX_WillfulFaction)
	endif
EndFunction

Function CalcLewdnessExpGain(Float Mult)
	Float ArousalState = PlayerRef.getfactionrank(sla_Arousal)
	if ArousalState >= 10
		BaboSexlabStatLewdness.setvalue(BaboSexlabStatLewdness.getvalue() + (BaboSexlabStatLewdnessSpeed.getvalue() * Mult * ArousalState/10))
	else
		BaboSexlabStatLewdness.setvalue(BaboSexlabStatLewdness.getvalue() + (BaboSexlabStatLewdnessSpeed.getvalue() * Mult))
	endif
	
	PlayerRef.setfactionrank(SLAX_SexAddictFaction, BaboSexlabStatLewdness.getvalue() as int)
EndFunction

Function CalcLewdnessExpLoss(Float Mult)
	Float ArousalState = PlayerRef.getfactionrank(sla_Arousal)
	if ArousalState >= 10
		BaboSexlabStatLewdness.setvalue(BaboSexlabStatLewdness.getvalue() - (BaboSexlabStatLewdnessSpeed.getvalue() + (Mult / ArousalState/10)))
	else
		BaboSexlabStatLewdness.setvalue(BaboSexlabStatLewdness.getvalue() - (BaboSexlabStatLewdnessSpeed.getvalue() - Mult))
	endif
	
	if BaboSexlabStatLewdness.getvalue() < 0
		BaboSexlabStatLewdness.setvalue(0)
	endif
	PlayerRef.setfactionrank(SLAX_SexAddictFaction, BaboSexlabStatLewdness.getvalue() as int)
EndFunction

Function CalcExpLoss()
	ExhibitionistExp -= ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * BaboSexlabStatExhibitionistSpeed.getvalue()
	BikExp -= ((GameDaysPassed.GetValue() - LastUpdate) * 24.0) * BaboSexlabStatSkimpyDecrease.getvalue()
	CalcLewdnessExpLoss(10.0)
	
	If ExhibitionistExp < 0.0
		ExhibitionistExp = 0.0
	EndIf

	If LewdnessExp < 0.0
		LewdnessExp = 0.0
	EndIf

	If BikExp < 0.0
		BikExp = 0.0
	EndIf
	;Debug.Messagebox("ExpLoss")
EndFunction

Function CalcLevel()
	Int OldLevel = BaboSexlabStatSkimpyExpLevel.GetValue() as Int
	If BikExp > ExpPerLevel * 5.5
		BaboSexlabStatSkimpyExpLevel.SetValue(4)
	ElseIf BikExp > ExpPerLevel * 3.5
		BaboSexlabStatSkimpyExpLevel.SetValue(3)
	ElseIf BikExp > ExpPerLevel * 2.0
		BaboSexlabStatSkimpyExpLevel.SetValue(2)
	ElseIf BikExp > ExpPerLevel
		BaboSexlabStatSkimpyExpLevel.SetValue(1)
	Else
		BaboSexlabStatSkimpyExpLevel.SetValue(0)
	EndIf

	If ExhibitionistExp > ExpPerLevel * 30.0
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 5)
		BaboSexlabStatExhibitionist.SetValue(5)
	ElseIf ExhibitionistExp > ExpPerLevel * 15.0
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 4)
		BaboSexlabStatExhibitionist.SetValue(4)
	ElseIf ExhibitionistExp > ExpPerLevel * 10.0
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 3)
		BaboSexlabStatExhibitionist.SetValue(3)
	ElseIf ExhibitionistExp > ExpPerLevel * 7.5
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 2)
		BaboSexlabStatExhibitionist.SetValue(2)
	ElseIf ExhibitionistExp > ExpPerLevel * 5.0
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 1)
		BaboSexlabStatExhibitionist.SetValue(1)
	Else
		PlayerRef.setfactionrank(SLAX_NudismAddictFaction, 0)
		BaboSexlabStatExhibitionist.SetValue(0)
	EndIf

	Int NewLevel = BaboSexlabStatSkimpyExpLevel.GetValue() as Int
	If NewLevel > OldLevel
		Debug.Messagebox("You've gained more experience wearing bikini armors\nBikini Experience Rank: " + GetBikRankString())
		
	ElseIf NewLevel < OldLevel
		Debug.Messagebox("You've lost bikini armor experience\nBikini Experience Rank: " + GetBikRankString())
	EndIf
	
	BaboDetectSpectatorQuest.stop()
EndFunction

String Function GetBikRankString()
	Int i = BaboSexlabStatSkimpyExpLevel.GetValue() as Int
	If i == 0
		Return "Untrained "
	ElseIf i == 1
		Return "Apprentice "
	ElseIf i == 2
		Return "Adept "
	ElseIf i == 3
		Return "Expert "
	ElseIf i == 4
		Return "Master "
	EndIf	
EndFunction

;======================================
;===============Animation================
;======================================
Function PlayAnim(Actor Victim, Actor Aggressor, Bool Animate = True, String VictimAnim, String AggressorAnim, Scene AfterScene = none)
	If Animate
		If (Aggressor != PlayerRef)
			ActorUtil.AddPackageOverride(Aggressor, DoNothing, 100, 1)
			Aggressor.EvaluatePackage()
			Aggressor.SetRestrained()
			Aggressor.SetDontMove(True)
			Game.DisablePlayerControls( true, true, false, false, false, false, false, false )
			Game.SetPlayerAIDriven( true )
		Else
			Game.SetPlayerAiDriven()
		Endif
		MiscReferences.MoveTo(Aggressor) ; PosRef
		Float AngleZ = Victim.GetAngleZ()
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Victim.SetVehicle(MiscReferences) ; PosRef
		Aggressor.SetVehicle(MiscReferences) ; PosRef
		If isplaying == false
			Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
			Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		Endif
		Utility.wait(1.0)
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Debug.SendAnimationEvent(Victim, VictimAnim as string)
		Debug.SendAnimationEvent(Aggressor, AggressorAnim as string)
		AfterScene.Forcestart()
		isplaying = True
	Else
		Victim.SetVehicle(None)
		Aggressor.SetVehicle(None)
		If (Aggressor != PlayerRef)
			Game.EnablePlayerControls()
			Game.SetPlayerAIDriven(false)
			Victim.SetRestrained(False)
			Victim.SetDontMove(False)
			Aggressor.SetRestrained(False)
			Aggressor.SetDontMove(False)
			ActorUtil.RemovePackageOverride(Aggressor, DoNothing)
		Else
			Game.SetPlayerAiDriven(False)
		Endif
		Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
		Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		AfterScene.Stop()
		isplaying = false
	Endif
EndFunction

Function StruggleAnim(Actor Victim, Actor Aggressor, Bool Animate = True, String VictimAnim, String AggressorAnim)
	If Animate
		If (Aggressor != PlayerRef)
			ActorUtil.AddPackageOverride(Aggressor, DoNothing, 100, 1)
			Aggressor.EvaluatePackage()
			Aggressor.SetRestrained()
			Aggressor.SetDontMove(True)
			;Victim.SetDontMove(True)
			Game.DisablePlayerControls( true, true, false, false, true, true, false, false )

			Game.SetPlayerAIDriven( true )
			if Game.GetCameraState() == 0
				Game.ForceThirdPerson()
			endIf
		Else
			Game.SetPlayerAiDriven()
		Endif
		MiscReferences.MoveTo(Aggressor) ; PosRef
		Float AngleZ = Victim.GetAngleZ()
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Victim.SetVehicle(MiscReferences) ; PosRef
		Aggressor.SetVehicle(MiscReferences) ; PosRef
		If isplaying == false
			Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
			Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		Endif
		Utility.wait(1.0)
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Debug.SendAnimationEvent(Victim, VictimAnim as string)
		Debug.SendAnimationEvent(Aggressor, AggressorAnim as string)
		isplaying = True
	Else
		Victim.SetVehicle(None)
		Aggressor.SetVehicle(None)
		If (Aggressor != PlayerRef)
			Game.EnablePlayerControls()
			Game.SetPlayerAIDriven(false)
			Victim.SetRestrained(False)
			Victim.SetDontMove(False)
			Aggressor.SetRestrained(False)
			Aggressor.SetDontMove(False)
			ActorUtil.RemovePackageOverride(Aggressor, DoNothing)
		Else
			Game.SetPlayerAiDriven(False)
		Endif
		Debug.SendAnimationEvent(Aggressor, "IdleForceDefaultState")
		Debug.SendAnimationEvent(Victim, "IdleForceDefaultState")
		isplaying = false
	Endif
EndFunction

Function PairedAnim(Actor Victim, Actor Aggressor, Idle PairedMotion, Bool Paired, Idle VictimAnim, Idle AggressorAnim)
	If Paired
		if Aggressor.PlayIdleWithTarget(PairedMotion, Victim)
			Debug.Trace("Aggressor does somthing to Victim")
		else
			Debug.Trace("Something went wrong")
		endIf
	Else
		If (Aggressor != PlayerRef)
			ActorUtil.AddPackageOverride(Aggressor, DoNothing, 100, 1)
			Aggressor.EvaluatePackage()
			Aggressor.SetRestrained()
			Aggressor.SetDontMove(True)
			Game.DisablePlayerControls( true, true, false, false, true, false, false, false )
			Game.SetPlayerAIDriven( true )
		Else
			Game.SetPlayerAiDriven()
		Endif
		MiscReferences.MoveTo(Aggressor) ; PosRef
		Float AngleZ = Victim.GetAngleZ()
		Aggressor.MoveTo(Victim, 0.0 * Math.Sin(AngleZ), 0.0 * Math.Cos(AngleZ))
		Victim.SetVehicle(MiscReferences) ; PosRef
		Aggressor.SetVehicle(MiscReferences) ; PosRef
		Victim.PlayIdle(VictimAnim)
		Aggressor.PlayIdle(AggressorAnim)
	EndIf
EndFunction

Function FurnitureDisplay(Actor Victim, Furniture DisplayTool)
	Dummy = Victim.PlaceAtMe(DisplayTool, 1, false, true)
	Float CharacterAngle = Victim.GetAngleZ()
	Dummy.MoveTo(Victim,DistanceInFront*Math.Sin(CharacterAngle),DistanceInFront*Math.Cos(CharacterAngle),DistanceZ)
	Dummy.SetAngle(0,0,CharacterAngle)
	Dummy.Enable()
EndFunction

Function FurnitureActivate(Actor Victim)
	If Victim == PlayerRef
		Game.DisablePlayerControls( true, true, true, false, true, false, true, false )
		Game.SetPlayerAIDriven( true )
	endif

	Victim.moveto(Dummy)
	utility.wait(2.0)
	Dummy.Activate(Victim)
EndFunction

Function FurnitureDespawn(Actor Victim)
	Victim.evaluatepackage()
;	Victim.pushactoraway(Victim, 1.0)
	Utility.wait(2.0)
;	Dummy.pushactoraway(Victim, 1.0)
	Dummy.Disable()
EndFunction

Function SLHHActivate(Actor pTarget, Actor pTargetFriend = None)
	If BaboHorribleHarassment.getvalue() == 1
		BaboMonitorScriptCreaturePackageActive.setvalue(2)
		Game.DisablePlayerControls( true, true, false, false, true, true, false, false )
		Game.SetPlayerAIDriven( true )
		(BaboSexController as BaboSexControllerManager).MonitorMessagebox(2)
		Utility.wait(5.0);wait for the script reading

		Keyword SLHHScriptEventKeyword = Game.GetFormFromFile(0x00C510, "SexLabHorribleHarassment.esp") as Keyword
		SLHHScriptEventKeyword.SendStoryEvent(None, pTarget, pTargetFriend)
	EndIf
	;SLHH is on.
	CreatureReferences[0].clear()
	CreatureReferences[1].clear()
	CreatureReferences[2].clear()
endFunction

Function SLHHBCActivate(Actor pTarget, Actor pTargetFriend = None, int Sex)
	If BaboHorribleHarassment.getvalue() == 1
		Game.DisablePlayerControls( true, true, false, false, true, true, false, false )
		Game.SetPlayerAIDriven( true )
		(BaboSexController as BaboSexControllerManager).MonitorMessagebox(3)
		Utility.wait(5.0);wait for the script reading

		Keyword SLHHScriptEventBCKeyword = Game.GetFormFromFile(0x0233C6, "SexLabHorribleHarassment.esp") as Keyword
		SLHHScriptEventBCKeyword.SendStoryEvent(None, pTarget, pTargetFriend, Sex, 0)
	EndIf
	;SLHH is on.
endFunction

Function SLHHDrunkActivate(Actor pTarget, Actor pTargetFriend = None, int Sex);0 = Sex 1 = NoSex
	If BaboHorribleHarassment.getvalue() == 1
		Game.DisablePlayerControls( true, true, false, false, true, true, false, false )
		Game.SetPlayerAIDriven( true )
		(BaboSexController as BaboSexControllerManager).MonitorMessagebox(4)
		Utility.wait(5.0);wait for the script reading

		Keyword SLHHScriptEventBCKeyword = Game.GetFormFromFile(0x02495B, "SexLabHorribleHarassment.esp") as Keyword
		SLHHScriptEventBCKeyword.SendStoryEvent(None, pTarget, pTargetFriend, Sex, 0)
	EndIf
	;SLHH is on.
endFunction

;####################################################
;################ JSON Export #######################
;####################################################

Function ExportStatus()
	String File = "../BaboDialogue/BaboDialoguePlayerStatus.json"
	
	int WhiterunOrcFuckToyTitleRank
	int RieklingThirskFuckToyTitleRank
	int NightgateInnVictoryTitleRank
	int NightgateInnFuckedTitleRank
	int InvestigationMarkarthTitleRank
	int DeviousNobleSonFuckToyTitleRank
	int ChallengerFucktoyTitleRank
	int ArgonianDisplayedFuckToyTitleRank
	int ArgonianDefeatedTitleRank
	int LoanSharkSlaveTitleRank
	int PitifulHeroineTitleRank

		
		If playerref.isinfaction(BaboFactionWhiterunOrcFuckToyTitle)
			WhiterunOrcFuckToyTitleRank = playerref.getfactionrank(BaboFactionWhiterunOrcFuckToyTitle) as int
			JsonUtil.SetintValue(File, "WhiterunOrcFuckToyTitleRank", WhiterunOrcFuckToyTitleRank)
		Else
			JsonUtil.SetintValue(File, "WhiterunOrcFuckToyTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionRieklingThirskFuckToyTitle)
			RieklingThirskFuckToyTitleRank = playerref.getfactionrank(BaboFactionRieklingThirskFuckToyTitle) as int
			JsonUtil.SetintValue(File, "RieklingThirskFuckToyTitleRank", RieklingThirskFuckToyTitleRank)
		Else
			JsonUtil.SetintValue(File, "RieklingThirskFuckToyTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionNightgateInnVictoryTitle)
			NightgateInnVictoryTitleRank = playerref.getfactionrank(BaboFactionNightgateInnVictoryTitle) as int
			JsonUtil.SetintValue(File, "NightgateInnVictoryTitleRank", NightgateInnVictoryTitleRank)
		Else
			JsonUtil.SetintValue(File, "NightgateInnVictoryTitleRank", -1)
		EndIf
		
		If playerref.isinfaction(BaboFactionNightgateInnFuckedTitle)
			NightgateInnFuckedTitleRank = playerref.getfactionrank(BaboFactionNightgateInnFuckedTitle) as int
			JsonUtil.SetintValue(File, "NightgateInnFuckedTitleRank", NightgateInnFuckedTitleRank)
		Else
			JsonUtil.SetintValue(File, "NightgateInnFuckedTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionInvestigationMarkarthTitle)
			InvestigationMarkarthTitleRank = playerref.getfactionrank(BaboFactionInvestigationMarkarthTitle) as int
			JsonUtil.SetintValue(File, "InvestigationMarkarthTitleRank", InvestigationMarkarthTitleRank)
		Else
			JsonUtil.SetintValue(File, "InvestigationMarkarthTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionDeviousNobleSonFuckToyTitle)
			DeviousNobleSonFuckToyTitleRank = playerref.getfactionrank(BaboFactionDeviousNobleSonFuckToyTitle) as int
			JsonUtil.SetintValue(File, "DeviousNobleSonFuckToyTitleRank", DeviousNobleSonFuckToyTitleRank)
		Else
			JsonUtil.SetintValue(File, "DeviousNobleSonFuckToyTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionChallengerFucktoyTitle)
			ChallengerFucktoyTitleRank = playerref.getfactionrank(BaboFactionChallengerFucktoyTitle) as int
			JsonUtil.SetintValue(File, "ChallengerFucktoyTitleRank", ChallengerFucktoyTitleRank)
		Else
			JsonUtil.SetintValue(File, "ChallengerFucktoyTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionArgonianDisplayedFuckToyTitle)
			ArgonianDisplayedFuckToyTitleRank = playerref.getfactionrank(BaboFactionArgonianDisplayedFuckToyTitle) as int
			JsonUtil.SetintValue(File, "ArgonianDisplayedFuckToyTitleRank", ArgonianDisplayedFuckToyTitleRank)
		Else
			JsonUtil.SetintValue(File, "ArgonianDisplayedFuckToyTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionArgonianDefeatedTitle)
			ArgonianDefeatedTitleRank = playerref.getfactionrank(BaboFactionArgonianDefeatedTitle) as int
			JsonUtil.SetintValue(File, "ArgonianDefeatedTitleRank", ArgonianDefeatedTitleRank)
		Else
			JsonUtil.SetintValue(File, "ArgonianDefeatedTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionPitifulHeroineTitle)
			PitifulHeroineTitleRank = playerref.getfactionrank(BaboFactionPitifulHeroineTitle) as int
			JsonUtil.SetintValue(File, "PitifulHeroineTitleRank", PitifulHeroineTitleRank)
		Else
			JsonUtil.SetintValue(File, "PitifulHeroineTitleRank", -1)
		EndIf

		If playerref.isinfaction(BaboFactionLoanSharkSlaveTitle)
			LoanSharkSlaveTitleRank = playerref.getfactionrank(BaboFactionLoanSharkSlaveTitle) as int
			JsonUtil.SetintValue(File, "LoanSharkSlaveTitleRank", LoanSharkSlaveTitleRank)
		Else
			JsonUtil.SetintValue(File, "LoanSharkSlaveTitleRank", -1)
		EndIf
		JsonUtil.SetintValue(File, "BaboReputation", BaboReputation.getvalue() as int)
	JsonUtil.Save(File, False)
EndFunction


;======================================
;===============Compatibility================
;======================================

Function CD_FHU()
	if BaboFHU.getvalue() == 1
		SR_InflateFaction = Game.GetFormFromFile(0xA991, "sr_FillHerUp.esp") as Faction
	endif
EndFunction

Function CD_BF()
	if BaboBF.getvalue() == 1
		_BF_ParentFaction = Game.GetFormFromFile(0x008448, "BeeingFemale.esm") as Faction
		_BFPlayerState = Game.GetFormFromFile(0x060CC3, "BeeingFemale.esm") as GlobalVariable
	endif
EndFunction

Function CD_SLS()
	if BaboSexlabSurvivalGlobal.getvalue() == 1
		_SLS_BikiniArmor = Game.GetFormFromFile(0x049867, "SL Survival.esp") as Keyword
		_SLS_LicenceMagic = Game.GetFormFromFile(0x041B54, "SL Survival.esp") as Book
		_SLS_LicenceArmor = Game.GetFormFromFile(0x043BAE, "SL Survival.esp") as Book
		_SLS_LicenceWeapon = Game.GetFormFromFile(0x043BAF, "SL Survival.esp") as Book
		_SLS_LicenceBikini = Game.GetFormFromFile(0x0492C7, "SL Survival.esp") as Book
		_SLS_LicenceClothes = Game.GetFormFromFile(0x0492CB, "SL Survival.esp") as Book
	endif
EndFunction

Function CD_DDI()
	if BaboDDI.getvalue() == 1
		zad_DeviousBelt = Game.GetFormFromFile(0x003330, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPlug = Game.GetFormFromFile(0x003331, "Devious Devices - Assets.esm") as Keyword
		zad_Lockable = Game.GetFormFromFile(0x003894, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousCollar = Game.GetFormFromFile(0x003DF7, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousBra = Game.GetFormFromFile(0x003DFA, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPiercingsNipple = Game.GetFormFromFile(0x00CA39, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousArmbinder = Game.GetFormFromFile(0x00CA3A, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousBlindfold = Game.GetFormFromFile(0x011B1A, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousHarness = Game.GetFormFromFile(0x017C43, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPlugVaginal = Game.GetFormFromFile(0x01DD7C, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPlugAnal = Game.GetFormFromFile(0x01DD7D, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousPiercingsVaginal = Game.GetFormFromFile(0x023E70, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousBoots = Game.GetFormFromFile(0x027F29, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousHood = Game.GetFormFromFile(0x02AFA2, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousSuit = Game.GetFormFromFile(0x02AFA3, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousYoke = Game.GetFormFromFile(0x02C531, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousGag = Game.GetFormFromFile(0x007EB8, "Devious Devices - Assets.esm") as Keyword
		zad_DeviousCorset = Game.GetFormFromFile(0x027F28, "Devious Devices - Assets.esm") as Keyword
			
		zad_ChastityKey = Game.GetFormFromFile(0x008A4F, "Devious Devices - Integration.esm") as Key
		zad_PiercingsRemovalTool = Game.GetFormFromFile(0x0409A4, "Devious Devices - Integration.esm") as Key
		zad_RestraintsKey = Game.GetFormFromFile(0x01775F, "Devious Devices - Integration.esm") as Key
			
		zadquest = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as Quest
	endif
EndFunction

Function CD_Fertility()
	if BaboFertility.getvalue() == 1
		Quest HandlerQuest = Game.GetFormFromFile(0x000D62, "Fertility Mode.esp") as Quest
		_JSW_BB_PotionFertility = Game.GetFormFromFile(0x0058D2, "Fertility Mode.esp") as Potion
		FertilityLastBirth = (HandlerQuest as _JSW_BB_Storage).LastBirth as float[]
	endif
EndFunction

Function CD_EstrusChaurus()
	if BaboEstrusChaurus.getvalue() == 1
		zzEstrusChaurusBreederFaction = Game.GetFormFromFile(0x0160A9, "EstrusChaurus.esp") as Faction
	endif
EndFunction

;======================================
;===============Expression================
;======================================
Function Backtoinitial(Actor act)
	act.ClearExpressionOverride()
EndFunction

Function RandomAheMenu(Actor act)
	int Random = Utility.Randomint(1, 6)
	AheMenu(act, random)
EndFunction

Function RandomPainMenu(Actor act)
	int Random = Utility.Randomint(1, 8)
	PainMenu(act, random)
EndFunction

Function PainMenu(Actor act, Int index)
	if index == 1
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 2, 10)
		mfgconsolefunc.SetModifier(act, 3, 10)
		mfgconsolefunc.SetModifier(act, 6, 50)
		mfgconsolefunc.SetModifier(act, 7, 50)
		mfgconsolefunc.SetModifier(act, 11, 30)
		mfgconsolefunc.SetModifier(act, 12, 30)
		mfgconsolefunc.SetModifier(act, 13, 30)
		mfgconsolefunc.SetPhoneme(act, 0, 20)
	elseIf index == 2
		act.SetExpressionOverride(8, 50)
		mfgconsolefunc.SetModifier(act, 0, 100)
		mfgconsolefunc.SetModifier(act, 1, 100)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 40)
	elseIf index == 3
		act.SetExpressionOverride(9, 50)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetPhoneme(act, 0, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 40)
	elseIf index == 4
		act.SetExpressionOverride(8, 50)
		mfgconsolefunc.SetModifier(act, 0, 100)
		mfgconsolefunc.SetModifier(act, 1, 100)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 40)
	elseIf index == 5
		act.SetExpressionOverride(9, 50)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 3, 100)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetPhoneme(act, 0, 30)
		mfgconsolefunc.SetPhoneme(act, 2, 30)
	elseIf index == 6
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 11, 50)
		mfgconsolefunc.SetModifier(act, 13, 14)
		mfgconsolefunc.SetPhoneme(act, 2, 50)
		mfgconsolefunc.SetPhoneme(act, 13, 20)
		mfgconsolefunc.SetPhoneme(act, 15, 40)
	elseIf index == 7
		act.SetExpressionOverride(1, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 20)
		mfgconsolefunc.SetModifier(act, 12, 90)
		mfgconsolefunc.SetModifier(act, 13, 90)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 5, 80)
	elseIf index == 8
		act.SetExpressionOverride(3, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 4, 80)
		mfgconsolefunc.SetModifier(act, 5, 80)
		mfgconsolefunc.SetPhoneme(act, 2, 100)
		mfgconsolefunc.SetPhoneme(act, 4, 50)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
	endIf
endFunction

Function AheMenu(Actor act, Int index)
	if index == 1
		act.SetExpressionOverride(4, 50)
		mfgconsolefunc.SetModifier(act, 0, 30)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 4, 30)
		mfgconsolefunc.SetModifier(act, 5, 30)
		mfgconsolefunc.SetModifier(act, 6, 10)
		mfgconsolefunc.SetModifier(act, 7, 10)
		mfgconsolefunc.SetModifier(act, 11, 80)
		mfgconsolefunc.SetModifier(act, 12, 70)
		mfgconsolefunc.SetModifier(act, 13, 80)
		mfgconsolefunc.SetPhoneme(act, 3, 50)
		mfgconsolefunc.SetPhoneme(act, 11, 50)
		mfgconsolefunc.SetPhoneme(act, 15, 50)
	elseIf index == 2
		act.SetExpressionOverride(4, 50)
		mfgconsolefunc.SetModifier(act, 0, 50)
		mfgconsolefunc.SetModifier(act, 1, 30)
		mfgconsolefunc.SetModifier(act, 2, 100)
		mfgconsolefunc.SetModifier(act, 4, 30)
		mfgconsolefunc.SetModifier(act, 5, 30)
		mfgconsolefunc.SetModifier(act, 7, 10)
		mfgconsolefunc.SetModifier(act, 11, 90)
		mfgconsolefunc.SetModifier(act, 12, 30)
		mfgconsolefunc.SetPhoneme(act, 3, 50)
		mfgconsolefunc.SetPhoneme(act, 8, 50)
		mfgconsolefunc.SetPhoneme(act, 14, 50)
	elseIf index == 3
		act.SetExpressionOverride(2, 60)
		mfgconsolefunc.SetPhoneme(act, 0, 43)
		mfgconsolefunc.SetPhoneme(act, 4, 7)
		mfgconsolefunc.SetPhoneme(act, 14, 90)
		mfgconsolefunc.SetModifier(act, 11, 180)
		mfgconsolefunc.SetModifier(act, 9, 43)
	elseIf index == 4
		act.SetExpressionOverride(2, 60)
		mfgconsolefunc.SetPhoneme(act, 0, 20)
		mfgconsolefunc.SetPhoneme(act, 1, 100)
		mfgconsolefunc.SetPhoneme(act, 14, 3)
		mfgconsolefunc.SetModifier(act, 7, 77)
		mfgconsolefunc.SetModifier(act, 11, 180)
		mfgconsolefunc.SetModifier(act, 11, 60)
	elseIf index == 5
		act.SetExpressionOverride(2, 70)
		mfgconsolefunc.SetPhoneme(act, 1, 7)
		mfgconsolefunc.SetPhoneme(act, 5, 100)
		mfgconsolefunc.SetPhoneme(act, 11, 33)
		mfgconsolefunc.SetPhoneme(act, 12, 3)
		mfgconsolefunc.SetPhoneme(act, 15, 16)
		mfgconsolefunc.SetModifier(act, 4, 100)
		mfgconsolefunc.SetModifier(act, 5, 100)
		mfgconsolefunc.SetModifier(act, 6, 100)
		mfgconsolefunc.SetModifier(act, 7, 100)
		mfgconsolefunc.SetModifier(act, 10, 100)
		mfgconsolefunc.SetModifier(act, 11, 100)
	elseIf index == 6
		act.SetExpressionOverride(4, 70)
		mfgconsolefunc.SetPhoneme(act, 1, 20)
		mfgconsolefunc.SetPhoneme(act, 8, 70)
		mfgconsolefunc.SetPhoneme(act, 13, 30)
		mfgconsolefunc.SetPhoneme(act, 15, 4)
		mfgconsolefunc.SetModifier(act, 3, 70)
		mfgconsolefunc.SetModifier(act, 11, 100)
		mfgconsolefunc.SetModifier(act, 13, 50)
	endIf
endFunction
