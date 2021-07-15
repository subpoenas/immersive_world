Scriptname BaboDialogueConfigMenu extends ski_configbase  Conditional

Event OnGameReload()
	parent.OnGameReload()
	VerifyMods()
EndEvent

event OnConfigInit()
	PageReset()
	Debug.notification("Babodialogue MCM started")
endevent

Function PageReset()
	Pages = new string[6]
	Pages[0] = "$BaboAppearanceSetting"
	Pages[1] = "$BaboEventSetting"
	Pages[2] = "$BaboDialogueSetting"
	Pages[3] = "$BaboCompatibilitySetting"
	Pages[4] = "$BaboTitleDisplay"
	Pages[5] = "$BaboDebug"
	
	PubicHairString = new String[6]
	PubicHairString[0] = "$BaboPubicHairStyle00"
	PubicHairString[1] = "$BaboPubicHairStyle01"
	PubicHairString[2] = "$BaboPubicHairStyle02"
	PubicHairString[3] = "$BaboPubicHairStyle03"
	PubicHairString[4] = "$BaboPubicHairStyle04"
	PubicHairString[5] = "$BaboPubicHairStyle05"
EndFunction

Event OnConfigClose()
	If BaboResetQuestGlobal.getvalue() == 1
		BaboResetQuestGlobal.setvalue(0)
		SetToggleOptionValue(OID_ResetQuest, 0)
		BaboResetMCM.RestartQuests()
	Else
		BaboResetQuestGlobal.setvalue(0)
		BDMonitor.UpdateKeyRegistery()
	EndIf

	If ResetNewgnisis
		BaboResetMCM.RestartNewgnisisQuest()
		ResetNewgnisis = 0
		SetToggleOptionValue(OID_ResetNewgnisisQuest, 0)
	EndIf
	
	If ResetWhiterunorcvisit
		BaboResetMCM.ResetWhiterunOrcQuest()
		ResetWhiterunorcvisit = 0
		SetToggleOptionValue(OID_ResetWhiterunOrcVisitQuest, 0)
	EndIf
	
	If ResetWhiterunViceCaptain
		BaboResetMCM.ResetWhiterunViceCaptainQuest()
		ResetWhiterunViceCaptain = 0
		SetToggleOptionValue(OID_ResetWhiterunViceCaptainQuest, 0)
	EndIf

	If ResetLoanShark
		BaboResetMCM.RestartLoanShark()
		ResetLoanShark = 0
		SetToggleOptionValue(OID_ResetLoanSharkQuest, 0)
	EndIf
	
	If TestQuestBaboBadEnd
		TestQuestBaboBadEnd = 0
		SetToggleOptionValue(OID_TestQuestBaboBadEnd, 0)
		BaboPosRef.moveto(PlayerRef)
		BaboBadendKeyword.SendStoryEvent(None, BaboPosRef)
		BaboBadEnd.setstage(2)
		Utility.wait(5.0)
		BaboBadEnd.setstage(3)
		Utility.wait(1.0)
		BaboBadEnd.setstage(5)
	EndIf
EndEvent


Function VerifyMods()

	If Quest.Getquest("FollowerExtension")
		EFF_Installed = true
		BaboEFF.setvalue(1)
	Else
		EFF_Installed = false
		BaboEFF.setvalue(0)
	Endif

	If Quest.Getquest("SLHH")
		SexlabHorribleHarassmentExpansion_Installed = true
		BaboHorribleHarassment.setvalue(1)
	Else
		SexlabHorribleHarassmentExpansion_Installed = false
		BaboHorribleHarassment.setvalue(0)
	Endif

	If Quest.Getquest("SSLV_Config")
		SimpleSlavery_Installed = true
		SimpleSlavery.setvalue(1)
	Else
		SimpleSlavery_Installed = false
		SimpleSlavery.setvalue(0)
	Endif

	If Quest.Getquest("sr_inflateQuest")
		FillHerUp_Installed = true
		BaboFHU.setvalue(1)
	Else
		FillHerUp_Installed = false
		BaboFHU.setvalue(0)
	Endif

	If Quest.GetQuest("BF_Main")
		BeeingFemale_Installed = true
		BaboBF.setvalue(1)
	Else
		BeeingFemale_Installed = false
		BaboBF.setvalue(0)
	Endif

	If Quest.Getquest("_SLS_Main")
		SexlabSurvival_Installed = true
		BaboSexlabSurvivalGlobal.setvalue(1)
	Else
		SexlabSurvival_Installed = false
		BaboSexlabSurvivalGlobal.setvalue(0)
	Endif
	
	If Quest.Getquest("zadQuest")
		DeviousDevicesIntegration_Installed = true
		BaboDDI.setvalue(1)
	Else
		DeviousDevicesIntegration_Installed = false
		BaboDDI.setvalue(0)
	Endif

	If Quest.Getquest("_JSW_BB_ConfigQuest")
		Fertility_Installed = true
		BaboFertility.setvalue(1)
	Else
		Fertility_Installed = false
		BaboFertility.setvalue(0)
	Endif

	If Quest.Getquest("zzEstrusChaurusMCM")
		EstrusChaurus_Installed = true
		BaboEstrusChaurus.setvalue(1)
	Else
		EstrusChaurus_Installed = false
		BaboEstrusChaurus.setvalue(0)
	Endif
EndFunction


event OnPageReset(string page)

	If Page == ("")

	DisplayBaboPage()

	Elseif Page == ("$BaboAppearanceSetting")

	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		AddHeaderOption("$BaboBaboDialogueTitle")
		AddEmptyOption()
		AddHeaderOption("$BaboPlayerAppearance")
		AddEmptyOption()
		OID_BeautyValue = AddSliderOption("$BaboBeautyValue", Beautyint, "{0}")
		OID_BreastsValue = AddSliderOption("$BaboBreastsValue", Breastsint, "{0}")
		OID_ButtocksValue = AddSliderOption("$BaboButtocksValue", Buttocksint, "{0}")
		AddEmptyOption()
		AddHeaderOption("$BaboPubicHair")
		OID_PubicHair = AddMenuOption("$BaboPubicHairCheck", PubicHairString[PubicHairint])
		AddEmptyOption()
		AddHeaderOption("$BaboRealisticarmorsetting")
		OID_RealisticSetting = AddToggleOption("$BaboRealisticarmor", BaboNakedRealityGlobal.GetValue())
	SetCursorPosition(1)
		AddHeaderOption("$BaboMiscSetting")
		AddEmptyOption()
		OID_BaboGlobalLoadScreen = AddToggleOption("$BaboLoadingScreen", BaboGlobalLoadScreen.GetValue())

		
	Elseif Page == ("$BaboEventSetting")

	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		AddHeaderOption("$BaboRoadEventPercentage")
		OID_Encounter01Percent = AddSliderOption("$BaboEvent01", BaboEncounter01percentage.GetValue(), "{0}")
		OID_Encounter02Percent = AddSliderOption("$BaboEvent02", BaboEncounter02percentage.GetValue(), "{0}")
		OID_Encounter03Percent = AddSliderOption("$BaboEvent03", BaboEncounter03percentage.GetValue(), "{0}")
		OID_Encounter04Percent = AddSliderOption("$BaboEvent04", BaboEncounter04percentage.GetValue(), "{0}")
		OID_Encounter05Percent = AddSliderOption("$BaboEvent05", BaboEncounter05percentage.GetValue(), "{0}")
		OID_Encounter06Percent = AddSliderOption("$BaboEvent06", BaboEncounter06percentage.GetValue(), "{0}")
		OID_Encounter08Percent = AddSliderOption("$BaboEvent08", BaboEncounter08percentage.GetValue(), "{0}")
		OID_Encounter09Percent = AddSliderOption("$BaboEvent09", BaboEncounter09percentage.GetValue(), "{0}")
		OID_Encounter10Percent = AddSliderOption("$BaboEvent10", BaboEncounter10percentage.GetValue(), "{0}")
		OID_Encounter11Percent = AddSliderOption("$BaboEvent11", BaboEncounter11percentage.GetValue(), "{0}")
		OID_Encounter12Percent = AddSliderOption("$BaboEvent12", BaboEncounter12percentage.GetValue(), "{0}")
		AddEmptyOption()
		AddHeaderOption("$BaboChangeLocationEventPercentage")
		OID_BaboChangeLocation01Percentage = AddSliderOption("$BaboChangeLocationEvent01", BaboChangeLocation01Percentage.GetValue(), "{0}")
		OID_BaboChangeLocation02Percentage = AddSliderOption("$BaboChangeLocationEvent02", BaboChangeLocation02Percentage.GetValue(), "{0}")
		OID_BaboChangeLocation03Percentage = AddSliderOption("$BaboChangeLocationEvent03", BaboChangeLocation03Percentage.GetValue(), "{0}")
		OID_BaboChangeLocation04Percentage = AddSliderOption("$BaboChangeLocationEvent04", BaboChangeLocation04Percentage.GetValue(), "{0}")
		OID_BaboChangeLocation05Percentage = AddSliderOption("$BaboChangeLocationEvent05", BaboChangeLocation05Percentage.GetValue(), "{0}")
		OID_BaboChangeLocation06Percentage = AddSliderOption("$BaboChangeLocationEvent06", BaboChangeLocation06Percentage.GetValue(), "{0}")
		AddEmptyOption()
		AddHeaderOption("$BaboUniqueEventSetting")
		OID_BaboEventWhiterunOrcVisitorsNextVisitInterval = AddSliderOption("$BaboWhiterunOrcVisitInterval", BaboEventWhiterunOrcVisitorsNextVisitInterval.GetValue(), "{0}")
		OID_BaboWhiterunBreezehomeGameDayInterval = AddSliderOption("$BaboWhiterunViceCaptainInterval", BaboWhiterunBreezehomeGameDayInterval.GetValue(), "{0}")
		AddEmptyOption()
		AddHeaderOption("$BaboVanillaEventSetting")
		OID_DLC2RieklingRescueChance = AddSliderOption("$BaboDLC2RieklingRescue", DLC2RieklingRescueChance.GetValue(), "{0}")
		SetCursorPosition(1)
		AddHeaderOption("$BaboFunctionOption")
		OID_BaboGlobalSpectatorSwitch = AddToggleOption("$BaboSpectatorSwitch", BaboGlobalSpectatorSwitch.GetValue())
		AddEmptyOption()
		OID_BaboCombatEssentialSwitch = AddToggleOption("$BaboEssentialSwitch", BaboCombatEssentialSwitch.GetValue())
		OID_BaboCombatWoundPercentMaximum = AddSliderOption("$BaboMaximumHealthPercentage", BaboCombatWoundPercentMaximum.GetValue(), "{0}")
		OID_BaboCombatWoundPercentMinimum = AddSliderOption("$BaboMinimumHealthPercentage", BaboCombatWoundPercentMinimum.GetValue(), "{0}")
		AddEmptyOption()
		OID_BaboSimpleSlaveryChance = AddSliderOption("$BaboSimpleSlaveryChance", BaboSimpleSlaveryChance.GetValue(), "{0}")
		AddHeaderOption("$BaboHireingSetting")
		OID_HirelingGold = AddSliderOption("$BaboDefaultHirelingGold", HirelingGold.GetValue(), "{0}")
		OID_discountedHirelingGold = AddSliderOption("$BaboHirelingGoldDiscounted", DiscountedHirelingGold.GetValue(), "{0}")
		OID_BaboTipHirelingGold = AddSliderOption("$BaboTipHirelingGold", BaboTipHirelingGold.GetValue(), "{0}")
		OID_BaboHirelingintimidating = AddSliderOption("$BaboSeductingFailureChance", BaboHirelingintimidating.GetValue(), "{0}")
		OID_BaboHirelingintimidatingWhenRefused = AddSliderOption("$BaboRefusalFailureChance", BaboHirelingintimidatingWhenRefused.GetValue(), "{0}")
		OID_BaboHirelingBleedOutTimes = AddSliderOption("$BaboHirelingBleedOutTimes", BaboHirelingBleedoutCountLimit.GetValue(), "{0}")
		AddEmptyOption()
		AddHeaderOption("$BaboStealingSetting")
		OID_Stripswitch = AddToggleOption("$Babocanbestripped", Stripswitch as int)
		OID_FakeSteal = AddToggleOption("$BaboFakeSteal", FakeSteal as int)
		OID_BaboGlobalDropItem = AddSliderOption("$BaboStripchance", BaboGlobalDropItem.GetValue(), "{0}")

	Elseif Page == ("$BaboDialogueSetting")

	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
		AddHeaderOption("$BaboGeneralDialogue")
		
		OID_BaboDialoguePercentageMerchant = AddSliderOption("$BaboMerchantDialoguePercent", BaboDialoguePercentageMerchant.GetValue(), "{0}")
		OID_BaboDialoguePercentageFollower = AddSliderOption("$BaboFollowerDialoguePercent", BaboDialoguePercentageFollower.GetValue(), "{0}")
		OID_BaboDialoguePercentageGuard = AddSliderOption("$BaboGuardDialoguePercent", BaboDialoguePercentageGuard.GetValue(), "{0}")
		OID_BaboDialoguePercentageHint = AddSliderOption("$BaboEventHintDialoguePercent", BaboDialoguePercentageHint.GetValue(), "{0}")
		
		AddHeaderOption("$BaboCitizenDialogue")
		
		OID_BaboDialoguePercentageNormalCitizen = AddSliderOption("$BaboCitizenDialoguePercent", BaboDialoguePercentageNormalCitizen.GetValue(), "{0}")
		
		AddHeaderOption("$BaboBanditDialogue")
		
		OID_BaboDialoguePercentageBandit = AddSliderOption("$BaboBanditTauntingChance", BaboDialoguePercentageBandit.GetValue(), "{0}")
		
		AddHeaderOption("$BaboPopulatedModDialogue")
		
		OID_BaboRankCitizenDialogueGlobal = AddToggleOption("$BaboCitizenTalkingSwitch", BaboRankCitizenDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuCitizen = AddSliderOption("$BaboCitizenTalkingChance", BaboDialoguePercentagePopuCitizen.GetValue(), "{0}")
		OID_BaboRankAdventurerDialogueGlobal = AddToggleOption("$BaboAdventurerTalkingSwitch", BaboRankAdventurerDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuAdventurer = AddSliderOption("$BaboAdventurerTalkingChance", BaboDialoguePercentagePopuAdventurer.GetValue(), "{0}")
		OID_BaboRankPrisonerDialogueGlobal = AddToggleOption("$BaboPrisonerTalkingSwitch", BaboRankPrisonerDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuPrisoner = AddSliderOption("$BaboPrisonerTalkingChance", BaboDialoguePercentagePopuPrisoner.GetValue(), "{0}")
		OID_BaboRankPilgrimDialogueGlobal = AddToggleOption("$BaboPilgrimTalkingSwitch", BaboRankPilgrimDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuPilgrim = AddSliderOption("$BaboPilgrimTalkingChance", BaboDialoguePercentagePopuPilgrim.GetValue(), "{0}")
		OID_BaboRankMercenaryDialogueGlobal = AddToggleOption("$BaboMercenaryTalkingSwitch", BaboRankMercenaryDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuMercenary = AddSliderOption("$BaboMercenaryTalkingChance", BaboDialoguePercentagePopuMercenary.GetValue(), "{0}")
		OID_BaboRankBeggerDialogueGlobal = AddToggleOption("$BaboBeggerTalkingSwitch", BaboRankBeggerDialogueGlobal.getvalue())
		OID_BaboDialoguePercentagePopuBegger = AddSliderOption("$BaboBeggerTalkingChance", BaboDialoguePercentagePopuBegger.GetValue(), "{0}")
		
		AddHeaderOption("$BaboDialogueProbability")
		
		OID_RelationSetting = AddSliderOption("$BaboRelationshipSetting", BaboRelationshipSetting.GetValue(), "{0}")
		OID_BaboSexualHarassmentGlobal = AddToggleOption("$BaboSexualHarassmentComment", BaboSexualHarassmentGlobal.GetValue())
		
		SetCursorPosition(1) ; Move cursor to top right position
		AddHeaderOption("$BaboUniqueNPCDialogue")
		
		OID_BaboUniqueNPCRiverwoodGlobal = AddToggleOption("$BaboRiverwoodNPCDialogue", BaboUniqueNPCRiverwoodGlobal.getvalue())
		OID_BaboDialoguePercentageRiverwood = AddSliderOption("$BaboRiverwoodNPCDialogueChance", BaboDialoguePercentageRiverwood.GetValue(), "{0}")
		OID_BaboUniqueNPCWhiterunGlobal = AddToggleOption("$BaboWhiterunNPCDialogue", BaboUniqueNPCWhiterunGlobal.getvalue())
		OID_BaboDialoguePercentageWhiterun = AddSliderOption("$BaboWhiterunNPCDialogueChance", BaboDialoguePercentageWhiterun.GetValue(), "{0}")
		OID_BaboUniqueNPCWindhelmGlobal = AddToggleOption("$BaboWindhelmNPCDialogue", BaboUniqueNPCWindhelmGlobal.getvalue())
		OID_BaboDialoguePercentageWindhelm = AddSliderOption("$BaboWindhelmNPCDialogueChance", BaboDialoguePercentageWindhelm.GetValue(), "{0}")
		
		AddHeaderOption("$BaboNPCXNPCDialogue")
		
		OID_BaboActorDialogueEventPercentage = AddSliderOption("$BaboActorDialoguePercentage", BaboActorDialogueEventPercentage.GetValue(), "{0}")
		
		AddHeaderOption("$BaboMonologue")
		
		OID_BaboSoliloquyOnLocationChange = AddToggleOption("$BaboLocationChangeMonologue", BaboSoliloquyOnLocationChange.getvalue())
		OID_BaboSoliloquyOnStartGlobal = AddToggleOption("$BaboOnStartMonologue", BaboSoliloquyOnStartGlobal.getvalue())
		OID_BaboSoliloquySelfCommenteGlobal = AddToggleOption("$BaboConstantMonologue", BaboSoliloquySelfCommentGlobal.getvalue())
		OID_BaboSoliloquySelfFreeCommenteGlobal = AddToggleOption("$BaboFreeMonologue", BaboSoliloquySelfFreeCommentGlobal.getvalue())
		OID_BaboSoliloquyUpdateGameTimeInterval = AddSliderOption("$BaboMonologueInterval", BaboSoliloquyUpdateGameTimeInterval.GetValue(), "{0}")
		OID_BaboSoliloquyUpdateInterval = AddSliderOption("$BaboSoliloquyIntervalMminimum", BaboSoliloquyUpdateInterval.GetValue(), "{0}")
		OID_BaboSoliloquyUpdateIntervalMax = AddSliderOption("$BaboSoliloquyIntervalMaximum", BaboSoliloquyUpdateIntervalMax.GetValue(), "{0}")
		
		Elseif Page == ("$BaboCompatibilitySetting")

	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		AddHeaderOption("$BaboAutoCompatibleModsCheck")
		AddEmptyOption()
		If DeviousDevicesIntegration_Installed
			BaboDDIIntegrationOID = AddToggleOption("$BaboDDIIntegration", true)
		Else
			BaboDDIIntegrationOID = AddToggleOption("$BaboDDIIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If FillHerUp_Installed
			BaboFHUIntegrationOID = AddToggleOption("$BaboFHUIntegration", true)
		Else
			BaboFHUIntegrationOID = AddToggleOption("$BaboFHUIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If BeeingFemale_Installed
			BaboBFIntegrationOID = AddToggleOption("$BaboBFIntegration", true)
		Else
			BaboBFIntegrationOID = AddToggleOption("$BaboBFIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If Fertility_Installed
			BaboFertIntegrationOID = AddToggleOption("$BaboFertIntegration", true)
		Else
			BaboFertIntegrationOID = AddToggleOption("$BaboFertIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If EstrusChaurus_Installed
			BaboEstrusCIntegrationOID = AddToggleOption("$BaboEstrusCIntegration", true)
		Else
			BaboEstrusCIntegrationOID = AddToggleOption("$BaboEstrusCIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If SexlabSurvival_Installed
			BaboSLSIntegrationOID = AddToggleOption("$BaboSLSurvivalIntegration", true)
		Else
			BaboSLSIntegrationOID = AddToggleOption("$BaboSLSurvivalIntegration", false, OPTION_FLAG_DISABLED)
		Endif
		If SimpleSlavery_Installed
			OID_SimpleSlavery = AddToggleOption("$BaboSimpleSlaveryCheck", true)
		Else
			OID_SimpleSlavery = AddToggleOption("$BaboSimpleSlaveryCheck", false, OPTION_FLAG_DISABLED)
		Endif
		If SexlabHorribleHarassmentExpansion_Installed
			OID_BaboHorribleHarassment = AddToggleOption("$BaboSLHHCheck", true)
		Else
			OID_BaboHorribleHarassment = AddToggleOption("$BaboSLHHCheck", false, OPTION_FLAG_DISABLED)
		Endif
		If EFF_Installed
			OID_BaboEFF = AddToggleOption("$BaboEFFCheck", true)
		Else
			OID_BaboEFF = AddToggleOption("$BaboEFFCheck", false, OPTION_FLAG_DISABLED)
		Endif

	Elseif Page == ("$BaboTitleDisplay")
	
	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		AddHeaderOption("$BaboDishonoredTitles")
		If playerref.isinfaction(BaboFactionWhiterunOrcFuckToyTitle)
		Addtextoption("$BaboWhiterunOrcFuckToyTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboWhiterunOrcFuckToyTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionRieklingThirskFuckToyTitle)
		Addtextoption("$BaboRieklingThirskFuckToyTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboRieklingThirskFuckToyTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionNightgateInnVictoryTitle)
		Addtextoption("$BaboNightgateInnVictoryTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboNightgateInnVictoryTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionNightgateInnFuckedTitle)
		Addtextoption("$BaboNightgateInnFuckedTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboNightgateInnFuckedTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionInvestigationMarkarthTitle)
		Addtextoption("$BaboInvestigationMarkarthTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboInvestigationMarkarthTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionDeviousNobleSonFuckToyTitle)
		Addtextoption("$BaboDeviousNobleSonFuckToyTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboDeviousNobleSonFuckToyTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionChallengerFucktoyTitle)
		Addtextoption("$BaboChallengerFucktoyTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboChallengerFucktoyTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionArgonianDisplayedFuckToyTitle)
		Addtextoption("$BaboArgonianDisplayedFuckToyTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboArgonianDisplayedFuckToyTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionArgonianDefeatedTitle)
		Addtextoption("$BaboArgonianDefeatedTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboArgonianDefeatedTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionPitifulHeroineTitle)
		Addtextoption("$BaboPitifulHeroineTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboPitifulHeroineTitle", "$BaboNotAcquired")
		EndIf
		If playerref.isinfaction(BaboFactionLoanSharkSlaveTitle)
		Addtextoption("$BaboLoanSharkSlaveTitle", "$BaboAcquired")
		Else
		Addtextoption("$BaboLoanSharkSlaveTitle", "$BaboNotAcquired")
		EndIf

		SetCursorPosition(1)
		AddHeaderOption("$BaboStatusStats")
		LewdnessOID = Addtextoption("$BaboLewdness", BaboSexlabStatLewdness.getvalue() as int)
		OID_LewdnessSpeed = AddSliderOption("$BaboLewdnessSpeed", BaboSexlabStatLewdnessSpeed.getvalue(), "{0}")
		
		CorruptionOID = Addtextoption("$BaboCorruption", BaboSexlabStatCorruption.getvalue() as int)
		OID_CorruptionSpeed = AddSliderOption("$BaboCorruptionSpeed", BaboSexlabStatCorruptionSpeed.getvalue(), "{0}")
		
		ExhibitionistOID = Addtextoption("$BaboExhibitionist", BaboSexlabStatExhibitionist.getvalue() as int)
		OID_ExhibitionistSpeed = AddSliderOption("$BaboExhibitionistSpeed", BaboSexlabStatExhibitionistSpeed.getvalue(), "{0}")

		BikiniExpOID = Addtextoption("$BaboBikiniExp", BaboSexlabStatSkimpyExpLevel.getvalue() as int)
		OID_SkimpySpeed = AddSliderOption("$BaboSkimpySpeed", BaboSexlabStatSkimpySpeed.getvalue(), "{0}")
	
		TraumaOID = Addtextoption("$BaboTrauma", BaboSexlabStatTrauma.getvalue() as int)
		
		OID_DetectSpectator = AddSliderOption("$BaboDetectSpectatorSpeed", BaboDetectSpectatorUpdateInterval.getvalue(), "{0}")
		
	Elseif Page == ("$BaboDebug")

	UnloadCustomContent()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
		AddHeaderOption("$BaboControlOption")
		AddEmptyOption()
		OID_UnequipOption = AddToggleOption("$BaboUnequipRestraints", 0)
		OID_RecoverControl = AddToggleOption("$BaboRecoverControl", 0)
		OID_RecoverEquipments = AddToggleOption("$BaboRecoverEquipments", 0)
		OID_DisableEssential = AddToggleOption("$BaboDisableEssential", 0)
		;OID_InstantManipulation = AddToggleOption("$BaboInstantManipulation", 0)
		Addtextoption("$BaboRescueWholeCounts", (BaboRescueCounts.getvalue() as int) as string)
		Addtextoption("$BaboRescueTriggerCounts", (BaboRescueTCounts.getvalue() as int) as string)
		OID_BaboRescueCounts = AddSliderOption("$BaboRescueCountSlider", BaboRescueCounts.GetValue(), "{0}")
		Addtextoption("$BaboMerchantDisaffection", (BaboMerchantDisaffectionValue.getvalue() as int) as string)
		OID_BaboMerchantDisaffectionValue = AddSliderOption("$BaboMerchantDisaffectionSlider", BaboMerchantDisaffectionValue.GetValue(), "{0}")
		Addtextoption("$BaboPlayerReputation", (BaboReputation.getvalue() as int) as string)
		OID_BaboReputation = AddSliderOption("$BaboPlayerReputationSlider", BaboReputation.GetValue(), "{0}")
	SetCursorPosition(1) ; Move cursor to top right position
		AddHeaderOption("$BaboKeyOption")
		OID_NotificationKey = AddKeyMapOption("$BaboMagicCursorKey", NotificationKey)
		AddHeaderOption("$BaboMCMSettings")
		OID_ExportSettings = AddTextOption("$BaboExportSettings", "$CLICK")
		OID_ImportSettings = AddTextOption("$BaboImportSettings", "$CLICK")
		AddEmptyOption()
		AddHeaderOption("$BaboResetQuest")
		OID_ResetQuest = AddToggleOption("$BaboResetQuestSwitch", BaboResetQuestGlobal.GetValue())
		OID_ResetNewgnisisQuest = AddToggleOption("$BaboResetNewgnisisEvent", ResetNewgnisis)
		OID_ResetWhiterunOrcVisitQuest = AddToggleOption("$BaboResetWhiterunOrcVisitEvent", ResetWhiterunorcvisit)
		OID_ResetWhiterunViceCaptainQuest = AddToggleOption("$BaboResetWhiterunViceCaptainEvent", ResetWhiterunViceCaptain)
		OID_ResetLoanSharkQuest = AddToggleOption("$BaboResetLoanSharkEvent", ResetLoanShark)
		AddHeaderOption("$BaboQuestTest")
		OID_TestQuestBaboBadEnd = AddToggleOption("$BaboTestQuestBaboBadEnd", TestQuestBaboBadEnd)

		
	EndIF

EndEvent

Event OnOptionDefault(int option)
	if Option == OID_BeautyValue
		Beautyint = 50
		BeautyValue.SetValue(Beautyint)
	elseif Option == OID_BreastsValue
		Breastsint = 50
		BreastsValue.SetValue(Breastsint)
	elseif Option == OID_ButtocksValue
		Buttocksint = 50
		ButtocksValue.SetValue(Buttocksint)
	elseIf Option == OID_PubicHair
		PubicHairint = 0
		PubicHairValue.SetValue(PubicHairint)
		SetMenuOptionValue(Option, PubicHairString[PubicHairint])
	endif
EndEvent

Event OnOptionMenuAccept(Int OptionID, Int MenuItemIndex)
	If OptionID == OID_PubicHair
		If MenuItemIndex >= 0 && MenuItemIndex < PubicHairString.Length
			SetMenuOptionValue(OptionID, PubicHairString[MenuItemIndex])
			PubicHairint = MenuItemIndex
			PubicHairValue.SetValue(PubicHairint)
		EndIf
	Endif
Endevent

Event OnOptionMenuOpen(Int OptionID)
	if OptionID == OID_PubicHair
		SetMenuDialogOptions(PubicHairString)
		SetMenuDialogStartIndex(PubicHairint)
		SetMenuDialogDefaultIndex(0)
	Endif
EndEvent

Event OnOptionSliderOpen(Int Option)

If option == OID_BeautyValue
	SetSliderDialogStartValue(Beautyint)
	SetSliderDialogDefaultValue(80)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BreastsValue
	SetSliderDialogStartValue(Breastsint)
	SetSliderDialogDefaultValue(80)
	SetSliderDialogRange(0, 120)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_ButtocksValue
	SetSliderDialogStartValue(Buttocksint)
	SetSliderDialogDefaultValue(80)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_RelationSetting
	SetSliderDialogStartValue(BaboRelationshipSetting.GetValue())
	SetSliderDialogDefaultValue(1.0)
	SetSliderDialogRange(-3.0, 5.0)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_HirelingGold
	SetSliderDialogStartValue(HirelingGold.GetValue())
	SetSliderDialogDefaultValue(500)
	SetSliderDialogRange(0, 50000)
	SetSliderDialogInterval(100.0)
ElseIf option == OID_DiscountedHirelingGold
	SetSliderDialogStartValue(discountedHirelingGold.GetValue())
	SetSliderDialogDefaultValue(100)
	SetSliderDialogRange(0, 50000)
	SetSliderDialogInterval(100.0)
ElseIf option == OID_BaboTipHirelingGold
	SetSliderDialogStartValue(BaboTipHirelingGold.GetValue())
	SetSliderDialogDefaultValue(100)
	SetSliderDialogRange(100, 1000)
	SetSliderDialogInterval(100.0)
ElseIf option == OID_BaboHirelingintimidating
	SetSliderDialogStartValue(BaboHirelingintimidating.GetValue())
	SetSliderDialogDefaultValue(0)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboHirelingintimidatingWhenRefused
	SetSliderDialogStartValue(BaboHirelingintimidatingWhenRefused.GetValue())
	SetSliderDialogDefaultValue(0)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboHirelingBleedOutTimes
	SetSliderDialogStartValue(BaboHirelingBleedoutCountLimit.GetValue())
	SetSliderDialogDefaultValue(10)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboGlobalDropItem
	SetSliderDialogStartValue(BaboGlobalDropItem.GetValue())
	SetSliderDialogDefaultValue(0)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation01Percentage
	SetSliderDialogStartValue(BaboChangeLocation01Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation02Percentage
	SetSliderDialogStartValue(BaboChangeLocation02Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation03Percentage
	SetSliderDialogStartValue(BaboChangeLocation03Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation04Percentage
	SetSliderDialogStartValue(BaboChangeLocation04Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation05Percentage
	SetSliderDialogStartValue(BaboChangeLocation05Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboChangeLocation06Percentage
	SetSliderDialogStartValue(BaboChangeLocation06Percentage.GetValue())
	SetSliderDialogDefaultValue(50)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboEventWhiterunOrcVisitorsNextVisitInterval
	SetSliderDialogStartValue(BaboEventWhiterunOrcVisitorsNextVisitInterval.GetValue())
	SetSliderDialogDefaultValue(84)
	SetSliderDialogRange(1, 84)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboWhiterunBreezehomeGameDayInterval
	SetSliderDialogStartValue(BaboWhiterunBreezehomeGameDayInterval.GetValue())
	SetSliderDialogDefaultValue(24)
	SetSliderDialogRange(1, 84)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_DLC2RieklingRescueChance
	SetSliderDialogStartValue(DLC2RieklingRescueChance.GetValue())
	SetSliderDialogDefaultValue(25)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboCombatWoundPercentMaximum
	SetSliderDialogStartValue(BaboCombatWoundPercentMaximum.GetValue())
	SetSliderDialogDefaultValue(10)
	SetSliderDialogRange(0, 99)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboCombatWoundPercentMinimum
	SetSliderDialogStartValue(BaboCombatWoundPercentMinimum.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 99)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboSimpleSlaveryChance
	SetSliderDialogStartValue(BaboSimpleSlaveryChance.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 99)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageMerchant
	SetSliderDialogStartValue(BaboDialoguePercentageMerchant.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)	
ElseIf option == OID_BaboDialoguePercentageFollower
	SetSliderDialogStartValue(BaboDialoguePercentageFollower.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageGuard
	SetSliderDialogStartValue(BaboDialoguePercentageGuard.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageHint
	SetSliderDialogStartValue(BaboDialoguePercentageHint.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageBandit
	SetSliderDialogStartValue(BaboDialoguePercentageBandit.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageNormalCitizen
	SetSliderDialogStartValue(BaboDialoguePercentageNormalCitizen.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopuCitizen
	SetSliderDialogStartValue(BaboDialoguePercentagePopuCitizen.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopuAdventurer
	SetSliderDialogStartValue(BaboDialoguePercentagePopuAdventurer.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopubegger
	SetSliderDialogStartValue(BaboDialoguePercentagePopubegger.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopuMercenary
	SetSliderDialogStartValue(BaboDialoguePercentagePopuMercenary.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopuPilgrim
	SetSliderDialogStartValue(BaboDialoguePercentagePopuPilgrim.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentagePopuPrisoner
	SetSliderDialogStartValue(BaboDialoguePercentagePopuPrisoner.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageRiverwood
	SetSliderDialogStartValue(BaboDialoguePercentageRiverwood.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageWhiterun
	SetSliderDialogStartValue(BaboDialoguePercentageWhiterun.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboDialoguePercentageWindhelm
	SetSliderDialogStartValue(BaboDialoguePercentageWindhelm.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboActorDialogueEventPercentage
	SetSliderDialogStartValue(BaboActorDialogueEventPercentage.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboSoliloquyUpdateGameTimeInterval
	SetSliderDialogStartValue(BaboSoliloquyUpdateGameTimeInterval.GetValue())
	SetSliderDialogDefaultValue(3)
	SetSliderDialogRange(1, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboSoliloquyUpdateInterval
	SetSliderDialogStartValue(BaboSoliloquyUpdateInterval.GetValue())
	SetSliderDialogDefaultValue(4)
	SetSliderDialogRange(1, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboSoliloquyUpdateIntervalMax
	SetSliderDialogStartValue(BaboSoliloquyUpdateIntervalMax.GetValue())
	SetSliderDialogDefaultValue(8)
	SetSliderDialogRange(1, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboRescueCounts
	SetSliderDialogStartValue(BaboRescueCounts.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 500)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboMerchantDisaffectionValue
	SetSliderDialogStartValue(BaboMerchantDisaffectionValue.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 3000)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_BaboReputation
	SetSliderDialogStartValue(BaboReputation.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(-3000, 3000)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter01Percent
	SetSliderDialogStartValue(BaboEncounter01percentage.GetValue())
	SetSliderDialogDefaultValue(60)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter02Percent
	SetSliderDialogStartValue(BaboEncounter02percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter03Percent
	SetSliderDialogStartValue(BaboEncounter03percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter04Percent
	SetSliderDialogStartValue(BaboEncounter04percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter05Percent
	SetSliderDialogStartValue(BaboEncounter05percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter06Percent
	SetSliderDialogStartValue(BaboEncounter06percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter08Percent
	SetSliderDialogStartValue(BaboEncounter08percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter09Percent
	SetSliderDialogStartValue(BaboEncounter09percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter10Percent
	SetSliderDialogStartValue(BaboEncounter10percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter11Percent
	SetSliderDialogStartValue(BaboEncounter11percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_Encounter12Percent
	SetSliderDialogStartValue(BaboEncounter12percentage.GetValue())
	SetSliderDialogDefaultValue(70)
	SetSliderDialogRange(0, 100)
	SetSliderDialogInterval(1.0)
ElseIf option == OID_LewdnessSpeed
	SetSliderDialogStartValue(BaboSexlabStatLewdnessSpeed.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 3)
	SetSliderDialogInterval(0.1)
ElseIf option == OID_CorruptionSpeed
	SetSliderDialogStartValue(BaboSexlabStatCorruptionSpeed.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 3)
	SetSliderDialogInterval(0.1)
ElseIf option == OID_ExhibitionistSpeed
	SetSliderDialogStartValue(BaboSexlabStatExhibitionistSpeed.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 3)
	SetSliderDialogInterval(0.1)
ElseIf option == OID_SkimpySpeed
	SetSliderDialogStartValue(BaboSexlabStatSkimpySpeed.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0, 3)
	SetSliderDialogInterval(0.1)
ElseIf option == OID_DetectSpectator
	SetSliderDialogStartValue(BaboDetectSpectatorUpdateInterval.GetValue())
	SetSliderDialogDefaultValue(1)
	SetSliderDialogRange(0.5, 3.0)
	SetSliderDialogInterval(0.5)
EndIf
EndEvent

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	bool continue = true
	; Check for conflict
	if conflictControl != ""
		string msg
		if conflictName != ""
			msg = "This key is already mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\nAre you sure you want to continue?"
		else
			msg = "This key is already mapped to:\n'" + conflictControl + "'\n\nAre you sure you want to continue?"
		endIf
		continue = ShowMessage(msg, true, "Yes", "No")
	endIf
	; Set allowed key change
	if continue
		if option == OID_NotificationKey
			NotificationKey = keyCode			
		endIf
		; Set MCM value
		SetKeymapOptionValue(option, keyCode)
	endIf
endEvent

Event OnOptionSliderAccept(Int Option, Float Value)

	If option == OID_BeautyValue
		Beautyint = Value as int
		BeautyValue.SetValue(Beautyint)
		if Value < 19
			playerref.removefromfaction(SLAX_FacePlainFaction)
			playerref.removefromfaction(SLAX_FaceAverageFaction)
			playerref.removefromfaction(SLAX_FacePrettyFaction)
			playerref.removefromfaction(SLAX_FaceBeautifulFaction)
			playerref.addtofaction(SLAX_FaceUglyFaction)
		elseif Value < 40
			playerref.removefromfaction(SLAX_FaceUglyFaction)
			playerref.removefromfaction(SLAX_FaceAverageFaction)
			playerref.removefromfaction(SLAX_FacePrettyFaction)
			playerref.removefromfaction(SLAX_FaceBeautifulFaction)
			playerref.addtofaction(SLAX_FacePlainFaction)
		elseif Value < 60
			playerref.removefromfaction(SLAX_FaceUglyFaction)
			playerref.removefromfaction(SLAX_FacePlainFaction)
			playerref.removefromfaction(SLAX_FacePrettyFaction)
			playerref.removefromfaction(SLAX_FaceBeautifulFaction)
			playerref.addtofaction(SLAX_FaceAverageFaction)
		elseif Value < 80
			playerref.removefromfaction(SLAX_FaceUglyFaction)
			playerref.removefromfaction(SLAX_FacePlainFaction)
			playerref.removefromfaction(SLAX_FaceAverageFaction)
			playerref.removefromfaction(SLAX_FaceBeautifulFaction)
			playerref.addtofaction(SLAX_FacePrettyFaction)
		elseif Value < 101
			playerref.removefromfaction(SLAX_FaceUglyFaction)
			playerref.removefromfaction(SLAX_FacePlainFaction)
			playerref.removefromfaction(SLAX_FaceAverageFaction)
			playerref.addtofaction(SLAX_FacePrettyFaction)
			playerref.addtofaction(SLAX_FaceBeautifulFaction)
		else
			playerref.removefromfaction(SLAX_FaceUglyFaction)
			playerref.removefromfaction(SLAX_FacePlainFaction)
			playerref.removefromfaction(SLAX_FaceAverageFaction)
			playerref.removefromfaction(SLAX_FacePrettyFaction)
			playerref.removefromfaction(SLAX_FaceBeautifulFaction)
		endif
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BreastsValue
		Breastsint = Value as int
		BreastsValue.SetValue(Breastsint)
		if Value < 30
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.removefromfaction(SLAX_BoobsBigFaction)
			playerref.removefromfaction(SLAX_BoobsFullFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.addtofaction(SLAX_BoobsTinyFaction)
		elseif Value < 50
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.removefromfaction(SLAX_BoobsBigFaction)
			playerref.removefromfaction(SLAX_BoobsFullFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.addtofaction(SLAX_BoobsNiceFaction)
		elseif Value < 70
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.removefromfaction(SLAX_BoobsFullFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.addtofaction(SLAX_BoobsBigFaction)
		elseif Value < 90
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.addtofaction(SLAX_BoobsBigFaction)
			playerref.addtofaction(SLAX_BoobsFullFaction)
		elseif Value < 101
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.addtofaction(SLAX_BoobsFullFaction)
			playerref.addtofaction(SLAX_BoobsBigFaction)
			playerref.addtofaction(SLAX_BoobsAmazingFaction)
		elseif Value <= 120
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.addtofaction(SLAX_BoobsFullFaction)
			playerref.addtofaction(SLAX_BoobsBigFaction)
			playerref.addtofaction(SLAX_BoobsEnormousFaction)
		else
			playerref.removefromfaction(SLAX_BoobsTinyFaction)
			playerref.removefromfaction(SLAX_BoobsAmazingFaction)
			playerref.removefromfaction(SLAX_BoobsBigFaction)
			playerref.removefromfaction(SLAX_BoobsFullFaction)
			playerref.removefromfaction(SLAX_BoobsEnormousFaction)
			playerref.removefromfaction(SLAX_BoobsNiceFaction)
		endif
		;sla_BreastsScale.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_ButtocksValue
		Buttocksint = Value as int
		ButtocksValue.SetValue(Buttocksint)
		if Value < 30
			playerref.removefromfaction(SLAX_AssNiceFaction)
			playerref.removefromfaction(SLAX_AssAmazingFaction)
			playerref.removefromfaction(SLAX_AssBigFaction)
			playerref.addtofaction(SLAX_AssTinyFaction)
		elseif Value < 50
			playerref.removefromfaction(SLAX_AssTinyFaction)
			playerref.removefromfaction(SLAX_AssAmazingFaction)
			playerref.removefromfaction(SLAX_AssBigFaction)
			playerref.addtofaction(SLAX_AssNiceFaction)
		elseif Value < 80
			playerref.removefromfaction(SLAX_AssTinyFaction)
			playerref.removefromfaction(SLAX_AssNiceFaction)
			playerref.removefromfaction(SLAX_AssAmazingFaction)
			playerref.addtofaction(SLAX_AssBigFaction)
		elseif Value < 101
			playerref.removefromfaction(SLAX_AssTinyFaction)
			playerref.removefromfaction(SLAX_AssNiceFaction)
			playerref.addtofaction(SLAX_AssBigFaction)
			playerref.addtofaction(SLAX_AssAmazingFaction)
		else
			playerref.removefromfaction(SLAX_AssTinyFaction)
			playerref.removefromfaction(SLAX_AssNiceFaction)
			playerref.removefromfaction(SLAX_AssBigFaction)
			playerref.removefromfaction(SLAX_AssAmazingFaction)
		endif
		;sla_ButtocksScale.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_RelationSetting
		BaboRelationshipSetting.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_HirelingGold
		HirelingGold.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_discountedHirelingGold
		discountedHirelingGold.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option ==OID_BaboTipHirelingGold
		BaboTipHirelingGold.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboHirelingintimidating
		BaboHirelingintimidating.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboHirelingintimidatingWhenRefused
		BaboHirelingintimidatingWhenRefused.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboHirelingBleedOutTimes
		BaboHirelingBleedoutCountLimit.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboGlobalDropItem
		BaboGlobalDropItem.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboChangeLocation01Percentage
		BaboChangeLocation01Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboChangeLocation02Percentage
		BaboChangeLocation02Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboChangeLocation03Percentage
		BaboChangeLocation03Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboChangeLocation04Percentage
		BaboChangeLocation04Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboChangeLocation05Percentage
		BaboChangeLocation05Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboChangeLocation06Percentage
		BaboChangeLocation06Percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboEventWhiterunOrcVisitorsNextVisitInterval
		BaboEventWhiterunOrcVisitorsNextVisitInterval.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboWhiterunBreezehomeGameDayInterval
		BaboWhiterunBreezehomeGameDayInterval.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_DLC2RieklingRescueChance
		DLC2RieklingRescueChance.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboCombatWoundPercentMaximum
		BaboCombatWoundPercentMaximum.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboCombatWoundPercentMinimum
		BaboCombatWoundPercentMinimum.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")		

	ElseIf option == OID_BaboSimpleSlaveryChance
		BaboSimpleSlaveryChance.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	

	ElseIf option == OID_BaboDialoguePercentageMerchant
		BaboDialoguePercentageMerchant.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_BaboDialoguePercentageFollower
		BaboDialoguePercentageFollower.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_BaboDialoguePercentageGuard
		BaboDialoguePercentageGuard.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	

	ElseIf option == OID_BaboDialoguePercentageHint
		BaboDialoguePercentageHint.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	
		
	ElseIf option == OID_BaboDialoguePercentageBandit
		BaboDialoguePercentageBandit.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	

	ElseIf option == OID_BaboDialoguePercentageNormalCitizen
		BaboDialoguePercentageNormalCitizen.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	

	ElseIf option == OID_BaboDialoguePercentagePopuCitizen
		BaboDialoguePercentagePopuCitizen.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	

	ElseIf option == OID_BaboDialoguePercentagePopuAdventurer
		BaboDialoguePercentagePopuAdventurer.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")	
		
	ElseIf option == OID_BaboDialoguePercentagePopuPrisoner
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentagePopuPrisoner.SetValue(Value)

	ElseIf option == OID_BaboDialoguePercentagePopuPilgrim
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentagePopuPilgrim.SetValue(Value)

	ElseIf option == OID_BaboDialoguePercentagePopuMercenary
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentagePopuMercenary.SetValue(Value)

	ElseIf option == OID_BaboDialoguePercentagePopubegger
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentagePopubegger.SetValue(Value)

	ElseIf option == OID_BaboDialoguePercentageRiverwood
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentageRiverwood.SetValue(Value)
		
	ElseIf option == OID_BaboDialoguePercentageWhiterun
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentageWhiterun.SetValue(Value)

	ElseIf option == OID_BaboDialoguePercentageWindhelm
		SetSliderOptionValue(option, value as int, "{0}")
		BaboDialoguePercentageWindhelm.SetValue(Value)
		
	ElseIf option == OID_BaboActorDialogueEventPercentage
		SetSliderOptionValue(option, value as int, "{0}")
		BaboActorDialogueEventPercentage.SetValue(Value)

	ElseIf option == OID_BaboSoliloquyUpdateGameTimeInterval
		SetSliderOptionValue(option, value as int, "{0}")
		BaboSoliloquyUpdateGameTimeInterval.SetValue(Value)
		
	ElseIf option == OID_BaboSoliloquyUpdateInterval
		SetSliderOptionValue(option, value as int, "{0}")
		BaboSoliloquyUpdateInterval.SetValue(Value)
		
	ElseIf option == OID_BaboSoliloquyUpdateIntervalMax
		SetSliderOptionValue(option, value as int, "{0}")
		BaboSoliloquyUpdateIntervalMax.SetValue(Value)
		
	ElseIf option == OID_BaboRescueCounts
		SetSliderOptionValue(option, value as int, "{0}")
		BaboRescueCounts.SetValue(Value)
		BaboRescueTCounts.SetValue(BaboRescueTCounts.GetValue() + (Value))

	ElseIf option == OID_BaboMerchantDisaffectionValue
		SetSliderOptionValue(option, value as int, "{0}")
		BaboMerchantDisaffectionValue.SetValue(Value)
		
	ElseIf option == OID_BaboReputation
		SetSliderOptionValue(option, value as int, "{0}")
		BaboReputation.SetValue(Value)
		
	ElseIf option == OID_Encounter01Percent
		BaboEncounter01percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter02Percent
		BaboEncounter02percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter03Percent
		BaboEncounter03percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter04Percent
		BaboEncounter04percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter05Percent
		BaboEncounter05percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter06Percent
		BaboEncounter06percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter08Percent
		BaboEncounter08percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter09Percent
		BaboEncounter09percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_Encounter10Percent
		BaboEncounter10percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter11Percent
		BaboEncounter11percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_Encounter12Percent
		BaboEncounter12percentage.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")
		
	ElseIf option == OID_LewdnessSpeed
		BaboSexlabStatLewdnessSpeed.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_CorruptionSpeed
		BaboSexlabStatCorruptionSpeed.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_ExhibitionistSpeed
		BaboSexlabStatExhibitionistSpeed.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_SkimpySpeed
		BaboSexlabStatSkimpySpeed.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

	ElseIf option == OID_DetectSpectator
		BaboDetectSpectatorUpdateInterval.SetValue(Value)
		SetSliderOptionValue(option, value as int, "{0}")

EndIf

EndEvent

Event OnOptionSelect(Int Option)

	If (option == OID_BaboGlobalSpectatorSwitch)
		If BaboGlobalSpectatorSwitch.GetValue() == 1
			BaboGlobalSpectatorSwitch.SetValue(0)
			SetToggleOptionValue(OID_BaboGlobalSpectatorSwitch, 0)
		ElseIf BaboGlobalSpectatorSwitch.GetValue() == 0
			BaboGlobalSpectatorSwitch.SetValue(1)
			SetToggleOptionValue(OID_BaboGlobalSpectatorSwitch, 1)
		EndIf

	ElseIf (option == OID_FakeSteal)
		If FakeSteal == True
			FakeSteal = False
			BSAQuest.FakeStealSetting(false)
			SetToggleOptionValue(OID_FakeSteal, 0)
		ElseIf FakeSteal == False
			FakeSteal = True
			BSAQuest.FakeStealSetting(True)
			SetToggleOptionValue(OID_FakeSteal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankCitizenDialogueGlobal)
		If BaboRankCitizenDialogueGlobal.getvalue() == 1
			BaboRankCitizenDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankCitizenDialogueGlobal, 0)
		ElseIf BaboRankCitizenDialogueGlobal.getvalue() == 0
			BaboRankCitizenDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankCitizenDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankAdventurerDialogueGlobal)
		If BaboRankAdventurerDialogueGlobal.getvalue() == 1
			BaboRankAdventurerDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankAdventurerDialogueGlobal, 0)
		ElseIf BaboRankAdventurerDialogueGlobal.getvalue() == 0
			BaboRankAdventurerDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankAdventurerDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankPrisonerDialogueGlobal)
		If BaboRankPrisonerDialogueGlobal.getvalue() == 1
			BaboRankPrisonerDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankPrisonerDialogueGlobal, 0)
		ElseIf BaboRankPrisonerDialogueGlobal.getvalue() == 0
			BaboRankPrisonerDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankPrisonerDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankPilgrimDialogueGlobal)
		If BaboRankPilgrimDialogueGlobal.getvalue() == 1
			BaboRankPilgrimDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankPilgrimDialogueGlobal, 0)
		ElseIf BaboRankPilgrimDialogueGlobal.getvalue() == 0
			BaboRankPilgrimDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankPilgrimDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankMercenaryDialogueGlobal)
		If BaboRankMercenaryDialogueGlobal.getvalue() == 1
			BaboRankMercenaryDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankMercenaryDialogueGlobal, 0)
		ElseIf BaboRankMercenaryDialogueGlobal.getvalue() == 0
			BaboRankMercenaryDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankMercenaryDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboRankBeggerDialogueGlobal)
		If BaboRankBeggerDialogueGlobal.getvalue() == 1
			BaboRankBeggerDialogueGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboRankBeggerDialogueGlobal, 0)
		ElseIf BaboRankBeggerDialogueGlobal.getvalue() == 0
			BaboRankBeggerDialogueGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboRankBeggerDialogueGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboUniqueNPCRiverwoodGlobal)
		If BaboUniqueNPCRiverwoodGlobal.getvalue() == 1
			BaboUniqueNPCRiverwoodGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboUniqueNPCRiverwoodGlobal, 0)
		ElseIf BaboUniqueNPCRiverwoodGlobal.getvalue() == 0
			BaboUniqueNPCRiverwoodGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboUniqueNPCRiverwoodGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboUniqueNPCWhiterunGlobal)
		If BaboUniqueNPCWhiterunGlobal.getvalue() == 1
			BaboUniqueNPCWhiterunGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboUniqueNPCWhiterunGlobal, 0)
		ElseIf BaboUniqueNPCWhiterunGlobal.getvalue() == 0
			BaboUniqueNPCWhiterunGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboUniqueNPCWhiterunGlobal, 1)
		EndIf

	ElseIf (option == OID_BaboUniqueNPCWindhelmGlobal)
		If BaboUniqueNPCWindhelmGlobal.getvalue() == 1
			BaboUniqueNPCWindhelmGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboUniqueNPCWindhelmGlobal, 0)
		ElseIf BaboUniqueNPCWindhelmGlobal.getvalue() == 0
			BaboUniqueNPCWindhelmGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboUniqueNPCWindhelmGlobal, 1)
		EndIf

	ElseIf (option == OID_BaboSoliloquyOnLocationChange)
		If BaboSoliloquyOnLocationChange.getvalue() == 1
			BaboSoliloquyOnLocationChange.setvalue(0)
			SetToggleOptionValue(OID_BaboSoliloquyOnLocationChange, 0)
		ElseIf BaboSoliloquyOnLocationChange.getvalue() == 0
			BaboSoliloquyOnLocationChange.setvalue(1)
			SetToggleOptionValue(OID_BaboSoliloquyOnLocationChange, 1)
		EndIf
		
	ElseIf (option == OID_BaboSoliloquyOnStartGlobal)
		If BaboSoliloquyOnStartGlobal.getvalue() == 1
			BaboSoliloquyOnStartGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboSoliloquyOnStartGlobal, 0)
		ElseIf BaboSoliloquyOnStartGlobal.getvalue() == 0
			BaboSoliloquyOnStartGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboSoliloquyOnStartGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboSoliloquySelfCommenteGlobal)
		If BaboSoliloquySelfCommentGlobal.getvalue() == 1
			BaboSoliloquySelfCommentGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboSoliloquySelfCommenteGlobal, 0)
		ElseIf BaboSoliloquySelfCommentGlobal.getvalue() == 0
			BaboSoliloquySelfCommentGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboSoliloquySelfCommenteGlobal, 1)
		EndIf

		ElseIf (option == OID_BaboSoliloquySelfFreeCommenteGlobal)
		If BaboSoliloquySelfFreeCommentGlobal.getvalue() == 1
			BaboSoliloquySelfFreeCommentGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboSoliloquySelfFreeCommenteGlobal, 0)
		ElseIf BaboSoliloquySelfFreeCommentGlobal.getvalue() == 0
			BaboSoliloquySelfFreeCommentGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboSoliloquySelfFreeCommenteGlobal, 1)
		EndIf
		
	ElseIf (option == OID_BaboSexualHarassmentGlobal)
		If BaboSexualHarassmentGlobal.getvalue() == 1
			BaboSexualHarassmentGlobal.setvalue(0)
			SetToggleOptionValue(OID_BaboSexualHarassmentGlobal, 0)
		ElseIf BaboSexualHarassmentGlobal.getvalue() == 0
			BaboSexualHarassmentGlobal.setvalue(1)
			SetToggleOptionValue(OID_BaboSexualHarassmentGlobal, 1)
		EndIf
		
	ElseIf (option == OID_Stripswitch)
		If Stripswitch == True
			Stripswitch = False
			PlayerStripRef.forcerefto(playerref)
			SetToggleOptionValue(OID_Stripswitch, 0)
		ElseIf Stripswitch == False
			Stripswitch = True
			PlayerStripRef.clear()
			SetToggleOptionValue(OID_Stripswitch, 1)
		EndIf
		
		
	ElseIf (option == OID_BaboCombatEssentialSwitch)
		If BaboCombatEssentialSwitch.GetValue() == 1
			BaboCombatEssentialSwitch.SetValue(0)
			SetToggleOptionValue(OID_BaboCombatEssentialSwitch, 0)
		ElseIf BaboCombatEssentialSwitch.GetValue() == 0
			BaboCombatEssentialSwitch.SetValue(1)
			SetToggleOptionValue(OID_BaboCombatEssentialSwitch, 1)
		EndIf

	ElseIf (option == OID_BaboHirelingCompatibility)
		If BaboHirelingCompatibility.GetValue() == 1
			BaboHirelingCompatibility.SetValue(0)
			SetToggleOptionValue(OID_BaboHirelingCompatibility, 0)
		ElseIf BaboHirelingCompatibility.GetValue() == 0
			BaboHirelingCompatibility.SetValue(1)
			SetToggleOptionValue(OID_BaboHirelingCompatibility, 1)
		EndIf
	
	ElseIf (option == OID_RealisticSetting)
		If BaboNakedRealityGlobal.GetValue() == 1
			Removeperks()
		ElseIf BaboNakedRealityGlobal.GetValue() == 0
			Addperks()
		EndIf
		
	ElseIf (option == OID_BaboGlobalLoadScreen)
		If BaboGlobalLoadScreen.GetValue() == 1
			BaboGlobalLoadScreen.SetValue(0)
			SetToggleOptionValue(OID_BaboGlobalLoadScreen, 0)
		ElseIf BaboGlobalLoadScreen.GetValue() == 0
			BaboGlobalLoadScreen.SetValue(1)
			SetToggleOptionValue(OID_BaboGlobalLoadScreen, 1)
		EndIf

	ElseIf (option == OID_ResetQuest)
		If BaboResetQuestGlobal.GetValue() == 0
			ResetQuestsSwitch(True)
		Else
			ResetQuestsSwitch(False)
		EndIf

	ElseIf (option == OID_ResetNewgnisisQuest)
		If ResetNewgnisis == 0
			ResetNewgnisis = 1
			SetToggleOptionValue(OID_ResetNewgnisisQuest, 1)
		Else
			ResetNewgnisis = 0
			SetToggleOptionValue(OID_ResetNewgnisisQuest, 0)
		EndIf
		
	ElseIf (option == OID_ResetWhiterunOrcVisitQuest)
		If ResetWhiterunorcvisit == 0
			ResetWhiterunorcvisit = 1
			SetToggleOptionValue(OID_ResetWhiterunOrcVisitQuest, 1)
		Else
			ResetWhiterunorcvisit = 0
			SetToggleOptionValue(OID_ResetWhiterunOrcVisitQuest, 0)
		EndIf
		
	ElseIf (option == OID_ResetWhiterunViceCaptainQuest)
		If ResetWhiterunViceCaptain == 0
			ResetWhiterunViceCaptain = 1
			SetToggleOptionValue(OID_ResetWhiterunViceCaptainQuest, 1)
		Else
			ResetWhiterunViceCaptain = 0
			SetToggleOptionValue(OID_ResetWhiterunViceCaptainQuest, 0)
		EndIf
		
	ElseIf (option == OID_ResetLoanSharkQuest)
		If ResetLoanShark == 0
			ResetLoanShark = 1
			SetToggleOptionValue(OID_ResetLoanSharkQuest, 1)
		Else
			ResetLoanShark = 0
			SetToggleOptionValue(OID_ResetLoanSharkQuest, 0)
		EndIf

	ElseIf (option == OID_TestQuestBaboBadEnd)
		If TestQuestBaboBadEnd == 0
			TestQuestBaboBadEnd = 1
			SetToggleOptionValue(OID_TestQuestBaboBadEnd, 1)
		Else
			TestQuestBaboBadEnd = 0
			SetToggleOptionValue(OID_TestQuestBaboBadEnd, 0)
		EndIf
		
	ElseIf (option == OID_UnequipOption)
;			SetToggleOptionValue(OID_UnequipOption, 0)
			BSAQuest.FindArmor(PlayerRef, None, BaboRestraints, False, False)
			ShowMessage("Your restraints in this mod got removed")
			
	ElseIf (option == OID_RecoverControl)
			RecoverControl()
			ShowMessage("You gained your control")

	ElseIf (option == OID_RecoverEquipments)
			RecoverEquipments()
			ShowMessage("You get your Equipments back")
			
	ElseIf (option == OID_DisableEssential)
			(playerref.getactorbase()).setessential(false)
			Disableinvincibility()
			ShowMessage("You are no longer invincible")
			
	ElseIf (option == OID_InstantManipulation)
			Seteveryvalue()
			ShowMessage("Every and each value is now manipulated.")
			
	Elseif Option == OID_ExportSettings
		If ShowMessage("$ExportWarningMessage") 
			ExportSettings()
		Endif
		
	Elseif Option == OID_ImportSettings
		If ShowMessage("$ImportWarningMessage") 
			ImportSettings()
		Endif
	ElseIf (option == OID_NotificationKey)
		NotificationKey = 49 ; default value
		SetKeymapOptionValue(option, NotificationKey)
		
	EndIf
EndEvent

Event OnOptionHighlight(Int Option)

If (Option == OID_BeautyValue)
		SetInfoText("$BaboBeautyValueInfo")
ElseIf (Option == OID_BreastsValue)
		SetInfoText("$BaboBreastsValueInfo")
ElseIf (Option == OID_ButtocksValue)
		SetInfoText("$BaboButtocksValueInfo")
ElseIf (Option == OID_BaboGlobalSpectatorSwitch)
		SetInfoText("$BaboSpectatorSwitchInfo")
ElseIf (Option == OID_FakeSteal)
		SetInfoText("$BaboFakeStealInfo")
ElseIf (Option == OID_Stripswitch)
		SetInfoText("$BabocanbestrippedInfo")
ElseIf (Option == OID_BaboCombatEssentialSwitch)
		SetInfoText("$BaboEssentialSwitchInfo")
ElseIf (Option == OID_BaboCombatWoundPercentMaximum)
		SetInfoText("$BaboMaximumHealthPercentageInfo")
ElseIf (Option == OID_BaboCombatWoundPercentMinimum)
		SetInfoText("$BaboMinimumHealthPercentageInfo")
ElseIf (Option == OID_BaboSimpleSlaveryChance)
		SetInfoText("$BaboSimpleSlaveryChanceInfo")
ElseIf (Option == OID_BaboDialoguePercentageGuard)
		SetInfoText("$BaboGuardDialoguePercentInfo")
ElseIf (Option == OID_BaboDialoguePercentageMerchant)
		SetInfoText("$BaboMerchantDialoguePercentInfo")
ElseIf (Option == OID_BaboDialoguePercentageFollower)
		SetInfoText("$BaboFollowerDialoguePercentInfo")
ElseIf (Option == OID_BaboDialoguePercentageHint)
		SetInfoText("$BaboEventHintDialoguePercentInfo")
ElseIf (Option == OID_BaboDialoguePercentageBandit)
		SetInfoText("$BaboBanditTauntingChanceInfo")
ElseIf (Option == OID_BaboDialoguePercentageNormalCitizen)
		SetInfoText("$BaboCitizenDialoguePercentInfo")
ElseIf (Option == OID_BaboDialoguePercentagePopuCitizen)
		SetInfoText("$BaboCitizenTalkingChanceInfo")
ElseIf (Option == OID_BaboDialoguePercentagePopuAdventurer)
		SetInfoText("$BaboAdventurerTalkingChanceInfo")	
ElseIf (Option == OID_SimpleSlavery)
		SetInfoText("$BaboSimpleSlaveryCheckInfo")
ElseIf (Option == OID_SexlabSurvival)
		SetInfoText("$BaboSimpleSlaveryCheckInfo")
ElseIf (Option == OID_BaboHorribleHarassment)
		SetInfoText("$BaboSLHHCheckInfo")
ElseIf (Option == OID_BaboEFF)
		SetInfoText("$BaboEFFCheckInfo")
ElseIf (Option == OID_BaboHirelingCompatibility)
		SetInfoText("$BaboHirelingCompatibilityInfo")
ElseIf (Option == OID_BaboGlobalLoadScreen)
		SetInfoText("$BaboLoadingScreenInfo")
ElseIf (Option == OID_PubicHair)
		SetInfoText("$BaboPubicHairCheckInfo")
ElseIf (Option == OID_BaboChangeLocation01Percentage)
		SetInfoText("$BaboChangeLocationEvent01Info")
ElseIf (Option == OID_BaboChangeLocation02Percentage)
		SetInfoText("$BaboChangeLocationEvent02Info")
ElseIf (Option == OID_BaboChangeLocation03Percentage)
		SetInfoText("$BaboChangeLocationEvent03Info")
ElseIf (Option == OID_BaboChangeLocation04Percentage)
		SetInfoText("$BaboChangeLocationEvent04Info")
ElseIf (Option == OID_BaboChangeLocation05Percentage)
		SetInfoText("$BaboChangeLocationEvent05Info")
ElseIf (Option == OID_BaboChangeLocation06Percentage)
		SetInfoText("$BaboChangeLocationEvent06Info")
ElseIf (Option == OID_BaboEventWhiterunOrcVisitorsNextVisitInterval)
		SetInfoText("$BaboWhiterunOrcVisitIntervalInfo")
ElseIf (Option == OID_BaboWhiterunBreezehomeGameDayInterval)
		SetInfoText("$BaboWhiterunViceCaptainIntervalInfo")
ElseIf (Option == OID_DLC2RieklingRescueChance)
		SetInfoText("$BaboDLC2RieklingRescueInfo")
ElseIf (Option == OID_Encounter01Percent)
		SetInfoText("$BaboEvent01Info")
ElseIf (Option == OID_Encounter02Percent)
		SetInfoText("$BaboEvent02Info")
ElseIf (Option == OID_Encounter03Percent)
		SetInfoText("$BaboEvent03Info")
ElseIf (Option == OID_Encounter04Percent)
		SetInfoText("$BaboEvent04Info")
ElseIf (Option == OID_Encounter05Percent)
		SetInfoText("$BaboEvent05Info")
ElseIf (Option == OID_Encounter06Percent)
		SetInfoText("$BaboEvent06Info")
ElseIf (Option == OID_Encounter08Percent)
		SetInfoText("$BaboEvent08Info")
ElseIf (Option == OID_Encounter09Percent)
		SetInfoText("$BaboEvent09Info")
ElseIf (Option == OID_Encounter10Percent)
		SetInfoText("$BaboEvent10Info")
ElseIf (Option == OID_Encounter11Percent)
		SetInfoText("$BaboEvent11Info")
ElseIf (Option == OID_Encounter12Percent)
		SetInfoText("$BaboEvent12Info")
ElseIf (Option == OID_UnequipOption)
		SetInfoText("$BaboUnequipRestraintsInfo")
ElseIf (Option == OID_RecoverControl)
		SetInfoText("$BaboRecoverControlInfo")
ElseIf (Option == OID_RecoverEquipments)
		SetInfoText("$BaboRecoverEquipmentsInfo")
ElseIf (Option == OID_DisableEssential)
		SetInfoText("$BaboDisableEssentialInfo")
ElseIf (Option == OID_InstantManipulation)
		SetInfoText("$BaboInstantManipulationInfo")
ElseIf (Option == OID_RealisticSetting)
		SetInfoText("$BaboRealisticarmorsettingInfo")
ElseIf (Option == OID_ResetQuest)
		SetInfoText("$BaboResetQuestSwitchInfo")
ElseIf (option == OID_NotificationKey)
		SetInfoText("$BaboMagicCursorKeyInfo")
ElseIf (option == OID_RelationSetting)
		SetInfoText("$BaboRelationshipSettingInfo")
ElseIf (option == OID_HirelingGold)
		SetInfoText("$BaboDefaultHirelingGoldInfo")
ElseIf (option == OID_discountedHirelingGold)
		SetInfoText("$BaboHirelingGoldDiscountedInfo")
ElseIf (option == OID_BaboTipHirelingGold)
		SetInfoText("$BaboTipHirelingGoldInfo")
ElseIf (option == OID_BaboHirelingintimidating)
		SetInfoText("$BaboSeductingFailureChanceInfo")
ElseIf (option == OID_BaboHirelingintimidatingWhenRefused)
		SetInfoText("$BaboRefusalFailureChanceInfo")
ElseIf (option == OID_BaboHirelingBleedOutTimes)
		SetInfoText("$BaboHirelingBleedOutTimesInfo")
ElseIf (option == OID_BaboGlobalDropItem)
		SetInfoText("$BaboStripchanceInfo")
ElseIf (option == OID_BaboRankCitizenDialogueGlobal)
		SetInfoText("$BaboCitizenTalkingSwitchInfo")
ElseIf (option == OID_BaboRankAdventurerDialogueGlobal)
		SetInfoText("$BaboAdventurerTalkingSwitchInfo")
ElseIf (option == OID_BaboRankPrisonerDialogueGlobal)
		SetInfoText("$BaboPrisonerTalkingSwitchInfo")
ElseIf (option == OID_BaboRankPilgrimDialogueGlobal)
		SetInfoText("$BaboPilgrimTalkingSwitchInfo")
ElseIf (option == OID_BaboRankMercenaryDialogueGlobal)
		SetInfoText("$BaboMercenaryTalkingSwitchInfo")
ElseIf (option == OID_BaboRankBeggerDialogueGlobal)
		SetInfoText("$BaboBeggerTalkingSwitchInfo")
ElseIf (option == OID_BaboSexualHarassmentGlobal)
		SetInfoText("$BaboSexualHarassmentCommentInfo")
ElseIf (option == OID_BaboUniqueNPCRiverwoodGlobal)
		SetInfoText("$BaboRiverwoodNPCDialogueInfo")
ElseIf (option == OID_BaboUniqueNPCWhiterunGlobal)
		SetInfoText("$BaboWhiterunNPCDialogueInfo")
ElseIf (option == OID_BaboUniqueNPCWindhelmGlobal)
		SetInfoText("$BaboWindhelmNPCDialogueInfo")
ElseIf (option == OID_BaboSoliloquyOnLocationChange)
		SetInfoText("$BaboLocationChangeMonologueInfo")
ElseIf (option == OID_BaboSoliloquyOnStartGlobal)
		SetInfoText("$BaboOnStartMonologueInfo")
ElseIf (option == OID_BaboSoliloquySelfCommenteGlobal)
		SetInfoText("$BaboConstantMonologueInfo")
ElseIf (option == OID_BaboSoliloquySelfFreeCommenteGlobal)
		SetInfoText("$BaboFreeMonologueInfo")
ElseIf (option == LewdnessOID)
		SetInfoText("$BaboLewdnessInfo")
ElseIf (option == CorruptionOID)
		SetInfoText("$BaboCorruptionInfo")
ElseIf (option == ExhibitionistOID)
		SetInfoText("$BaboExhibitionistInfo")
ElseIf (option == TraumaOID)
		SetInfoText("$BaboTraumaInfo")
ElseIf (option == BikiniExpOID)
		SetInfoText("$BaboBikiniExpInfo")
ElseIf (option == OID_DetectSpectator)
		SetInfoText("$BaboDetectSpectatorSpeedInfo")
EndIf
EndEvent



Function DisplayBaboPage()
	UnloadCustomContent()
	LoadCustomContent("BaboDialogue/Babologo.dds", 120, 0)
EndFunction

Function RecoverControl()
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(false)
	BDMonitor.StruggleAnim(playerref, None, False, None, None)
EndFunction

Function DisableSLHH(Bool Botton)
GlobalVariable SLHHSwitch = Game.GetFormFromFile(0x0000BFAB, "SexLabHorribleHarassment.esp") as GlobalVariable
If Botton
	If SLHHStatus == True && BaboHorribleHarassment.GetValue() == 1
		SLHHSwitch.setvalue(1)
	EndIf
Else
		SLHHSwitch.setvalue(0)
EndIf
EndFunction

;Function DisableDefeat()
;	If Defeat.getvalue() == 1
;		DefeatQuest = Quest.GetQuest("DefeatMCMQst") as defeatmcmscr
;		If DefeatQuest.KDWayThreshold == True
;			DefeatQuest.KDWayThreshold = False
;		EndIF
;	EndIf
;EndFunction

Function ResetQuestsSwitch(Bool TriggerSwitch)
	Bool Continue = True
	string msg
	if TriggerSwitch == True
		msg = "$ResetConfirmMessage"
		continue = ShowMessage(msg, true, "$Yes", "$No")
		ShowMessage(msg)
		
		If Continue == True
		BaboResetQuestGlobal.SetValue(1)
		SetToggleOptionValue(OID_ResetQuest, 1)
		EndIf
	Else
		msg = "$CancelYourDecisionMessage"
		continue = ShowMessage(msg, true, "$Yes", "$No")
		ShowMessage(msg)
		
		If Continue == True
		BaboResetQuestGlobal.SetValue(0)
		SetToggleOptionValue(OID_ResetQuest, 0)
		EndIf
	endIf
EndFunction

Function Addperks()
		PlayerRef.addperk(Babo_PrettyClothesLevel)
		PlayerRef.addperk(Babo_PrettyHeavyArmorLevel)
		PlayerRef.addperk(Babo_PrettyLightArmorLevel)
		PlayerRef.addperk(Babo_SpendexClothesLevel)
		PlayerRef.addperk(Babo_SpendexHeavyArmorLevel)
		PlayerRef.addperk(Babo_SpendexLightArmorLevel)
		PlayerRef.addperk(Babo_EroticClothesLevel)
		PlayerRef.addperk(Babo_EroticHeavyArmorLevel)
		PlayerRef.addperk(Babo_EroticLightArmorLevel)
		PlayerRef.addperk(Babo_HalfNakedBikiniClothesLevel)
		PlayerRef.addperk(Babo_HalfNakedBikiniHeavyArmorLevel)
		PlayerRef.addperk(Babo_HalfNakedBikiniLightArmorLevel)
		PlayerRef.addperk(Babo_HalfNakedClothesLevel)
		PlayerRef.addperk(Babo_HalfNakedHeavyArmorLevel)
		PlayerRef.addperk(Babo_HalfNakedLightArmorLevel)
		string msg
			If PlayerRef.hasperk(Babo_HalfNakedLightArmorLevel)
				msg = "$RemovalSuccessBeforeDebug"
				BaboNakedRealityGlobal.SetValue(1)
				SetToggleOptionValue(OID_RealisticSetting, 1)
			Else
				msg = "$SomethingWrongBeforeDebug"
			EndIf
		ShowMessage(msg)
EndFunction

Function RemovePerks()
		PlayerRef.removeperk(Babo_PrettyClothesLevel)
		PlayerRef.removeperk(Babo_PrettyHeavyArmorLevel)
		PlayerRef.removeperk(Babo_PrettyLightArmorLevel)
		PlayerRef.removeperk(Babo_SpendexClothesLevel)
		PlayerRef.removeperk(Babo_SpendexHeavyArmorLevel)
		PlayerRef.removeperk(Babo_SpendexLightArmorLevel)
		PlayerRef.removeperk(Babo_EroticClothesLevel)
		PlayerRef.removeperk(Babo_EroticHeavyArmorLevel)
		PlayerRef.removeperk(Babo_EroticLightArmorLevel)
		PlayerRef.removeperk(Babo_HalfNakedBikiniClothesLevel)
		PlayerRef.removeperk(Babo_HalfNakedBikiniHeavyArmorLevel)
		PlayerRef.removeperk(Babo_HalfNakedBikiniLightArmorLevel)
		PlayerRef.removeperk(Babo_HalfNakedClothesLevel)
		PlayerRef.removeperk(Babo_HalfNakedHeavyArmorLevel)
		PlayerRef.removeperk(Babo_HalfNakedLightArmorLevel)
		string msg
			If !PlayerRef.hasperk(Babo_HalfNakedLightArmorLevel)
				msg = "$RemovalSuccessDebug"
				BaboNakedRealityGlobal.SetValue(0)
				SetToggleOptionValue(OID_RealisticSetting, 0)
			Else
				msg = "$SomethingWrongDebug"
			EndIf
		ShowMessage(msg)
EndFunction

Function CheckStats()
;House Owned List
If (Game.QueryStat("Houses Owned") >= 3) && HouseOwned == 0
	BRMQuest.IncreaseReputation(30, 0)
	HouseOwned = 3
ElseIf (Game.QueryStat("Houses Owned") >= 6) && HouseOwned == 3
	BRMQuest.IncreaseReputation(50, 0)
	HouseOwned = 6
Endif

;Quest Completed List
If (Game.QueryStat("Quests Completed") >= 30) && QuestCompleted == 0
	BRMQuest.IncreaseReputation(30, 20)
	QuestCompleted = 30
ElseIf (Game.QueryStat("Quests Completed") >= 60) && QuestCompleted == 30
	BRMQuest.IncreaseReputation(40, 25)
	QuestCompleted = 60
ElseIf (Game.QueryStat("Quests Completed") >= 90) && QuestCompleted == 60
	BRMQuest.IncreaseReputation(40, 30)
	QuestCompleted = 90
ElseIf (Game.QueryStat("Quests Completed") >= 120) && QuestCompleted == 90
	BRMQuest.IncreaseReputation(50, 40)
	QuestCompleted = 120
ElseIf (Game.QueryStat("Quests Completed") >= 160) && QuestCompleted == 120
	BRMQuest.IncreaseReputation(60, 40)
	QuestCompleted = 160
ElseIf (Game.QueryStat("Quests Completed") >= 200) && QuestCompleted == 160
	BRMQuest.IncreaseReputation(60, 40)
	QuestCompleted = 200
ElseIf (Game.QueryStat("Quests Completed") >= 250) && QuestCompleted == 200
	BRMQuest.IncreaseReputation(70, 50)
	QuestCompleted = 250
ElseIf (Game.QueryStat("Quests Completed") >= 300) && QuestCompleted == 250
	BRMQuest.IncreaseReputation(100, 100)
	QuestCompleted = 300 ; You're a hero..
endif

;Stores Invest List
If (Game.QueryStat("Stores Invested In") >= 5) && StoresInvest == 0
	BRMQuest.IncreaseReputation(15, 5)
	StoresInvest = 5
ElseIf (Game.QueryStat("Stores Invested In") >= 10) && StoresInvest == 5
	BRMQuest.IncreaseReputation(30, 15)
	StoresInvest = 10
ElseIf (Game.QueryStat("Stores Invested In") >= 20) && StoresInvest == 10
	BRMQuest.IncreaseReputation(60, 30)
	StoresInvest = 20
EndIf
EndFunction

Function CheckGlobal()
	BDMonitor.Creatureunregister()
EndFunction

Function RegisterUpdate(Int TimeLimit)
	If TimeSwitch == True
		RegisterForSingleUpdateGameTime(TimeLimit); this is Customizable
		TimeSwitch = False
	Else
		TimeSwitch = True
	EndIf
EndFunction

Function OrganizeFaction()
CurrentFollowerFaction.Setenemy(BaboHateFaction)
CurrentFollowerFaction.Setenemy(BaboHateFalmerFaction)
CurrentFollowerFaction.Setenemy(BaboHateNoFollowerFaction, True,  True)
CurrentFollowerFaction.Setenemy(BaboPlayerHateFaction, True,  True)
PotentialFollowerFaction.Setenemy(BaboHateFaction)
PotentialFollowerFaction.Setenemy(BaboHateFalmerFaction)
PotentialFollowerFaction.Setenemy(BaboHateNoFollowerFaction, True,  True)
PotentialFollowerFaction.Setenemy(BaboPlayerHateFaction, True,  True)
EndFunction

Function RecoverEquipments()
	BaboTempStolenGoodsRef.removeallitems(playerref, false, true)
EndFunction

Function CheckCompatibility()
;Quest SLHHQuest = Quest.GetQuest("SLHH")
;Quest EFFQuest = Quest.GetQuest("FollowerExtension")
;Quest SLSQuest = Quest.GetQuest("_SLS_Main")
;	if SLHHQuest
;  		debug.trace("found SLHH Mod",0)
;		SLHHStatus = True
;	Else
;		SLHHStatus = False
;	endif

;	if EFFQuest
;  		debug.trace("found EFF Mod",0)
;		EFFStatus = True
;	Else
;		EFFStatus = False
;	endif
	
;	if SLSQuest
;  		debug.trace("found SLS Mod",0)
;		SLSStatus = True
;	Else
;		SLSStatus = False
;	endif
EndFunction

Event OnUpdateGameTime()
	CheckStats()
	CheckGlobal()
	TimeSwitch = True
	RegisterUpdate(48)
EndEvent

Function Disableinvincibility()
	PlayerAlias.clear()
EndFunction

Function Seteveryvalue()
BaboReputation.setvalue(BaboReputation.getvalue() + 100)
BaboRescueCounts.setvalue(BaboRescueCounts.getvalue() + 50)
BaboRescueTCounts.setvalue(BaboRescueTCounts.getvalue() + 50)
BaboMerchantDisaffectionValue.setvalue(BaboMerchantDisaffectionValue.getvalue() + 5000)
Endfunction

;####################################################
;################ JSON Export #######################
;####################################################

Function ExportSettings()
	String File = "../BaboDialogue/BaboDialogueConfig.json"
	
	JsonUtil.SetintValue(File, "BeautyValue", Beautyint)
	JsonUtil.SetintValue(File, "BreastsValue", Breastsint)
	JsonUtil.SetintValue(File, "ButtocksValue", Buttocksint)
	
	JsonUtil.SetintValue(File, "BaboPubicHairCheck", PubicHairint)
	
	JsonUtil.SetintValue(File, "BaboRealisticarmor", BaboNakedRealityGlobal.GetValue() as int) as bool
	JsonUtil.SetintValue(File, "BaboLoadingScreen", BaboGlobalLoadScreen.GetValue() as int) as bool
	
	JsonUtil.SetintValue(File, "BaboEvent01", BaboEncounter01percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent02", BaboEncounter02percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent03", BaboEncounter03percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent04", BaboEncounter04percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent05", BaboEncounter05percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent06", BaboEncounter06percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent08", BaboEncounter08percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent09", BaboEncounter09percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent10", BaboEncounter10percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent11", BaboEncounter11percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEvent12", BaboEncounter12percentage.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent01", BaboChangeLocation01Percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent02", BaboChangeLocation02Percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent03", BaboChangeLocation03Percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent04", BaboChangeLocation04Percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent05", BaboChangeLocation05Percentage.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboChangeLocationEvent06", BaboChangeLocation06Percentage.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboWhiterunOrcVisitInterval", BaboEventWhiterunOrcVisitorsNextVisitInterval.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboWhiterunViceCaptainInterval", BaboWhiterunBreezehomeGameDayInterval.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboDLC2RieklingRescue", DLC2RieklingRescueChance.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSpectatorSwitch", BaboGlobalSpectatorSwitch.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEssentialSwitch", BaboCombatEssentialSwitch.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboMaximumHealthPercentage", BaboCombatWoundPercentMaximum.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboMinimumHealthPercentage", BaboCombatWoundPercentMinimum.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSimpleSlaveryChance", BaboSimpleSlaveryChance.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboDefaultHirelingGold", HirelingGold.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboHirelingGoldDiscounted", DiscountedHirelingGold.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboTipHirelingGold", BaboTipHirelingGold.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSeductingFailureChance", BaboHirelingintimidating.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboRefusalFailureChance", BaboHirelingintimidatingWhenRefused.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboHirelingBleedOutTimes", BaboHirelingBleedoutCountLimit.GetValue() as int)
	
	JsonUtil.SetintValue(File, "Babocanbestripped", Stripswitch as int)
	JsonUtil.SetintValue(File, "BaboFakeSteal", FakeSteal as int)
	JsonUtil.SetintValue(File, "BaboStripchance", BaboGlobalDropItem.GetValue() as int)

;BaboDialogueSetting

	JsonUtil.SetintValue(File, "BaboMerchantDialoguePercent", BaboDialoguePercentageMerchant.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboFollowerDialoguePercent", BaboDialoguePercentageFollower.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboGuardDialoguePercent", BaboDialoguePercentageGuard.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEventHintDialoguePercent", BaboDialoguePercentageHint.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboCitizenDialoguePercent", BaboDialoguePercentageNormalCitizen.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboBanditTauntingChance", BaboDialoguePercentageBandit.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboCitizenTalkingSwitch", BaboRankCitizenDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboCitizenTalkingChance", BaboDialoguePercentagePopuCitizen.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboAdventurerTalkingSwitch", BaboRankAdventurerDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboAdventurerTalkingChance", BaboDialoguePercentagePopuAdventurer.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboPrisonerTalkingSwitch", BaboRankPrisonerDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboPrisonerTalkingChance", BaboDialoguePercentagePopuPrisoner.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboPilgrimTalkingSwitch", BaboRankPilgrimDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboPilgrimTalkingChance", BaboDialoguePercentagePopuPilgrim.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboMercenaryTalkingSwitch", BaboRankMercenaryDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboMercenaryTalkingChance", BaboDialoguePercentagePopuMercenary.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboBeggerTalkingSwitch", BaboRankBeggerDialogueGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboBeggerTalkingChance", BaboDialoguePercentagePopuBegger.GetValue() as int)

;BaboDialogueProbability

	JsonUtil.SetintValue(File, "BaboRelationshipSetting", BaboRelationshipSetting.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSexualHarassmentComment", BaboSexualHarassmentGlobal.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboRiverwoodNPCDialogue", BaboUniqueNPCRiverwoodGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboRiverwoodNPCDialogueChance", BaboDialoguePercentageRiverwood.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboWhiterunNPCDialogue", BaboUniqueNPCWhiterunGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboWhiterunNPCDialogueChance", BaboDialoguePercentageWhiterun.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboWindhelmNPCDialogue", BaboUniqueNPCWindhelmGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboWindhelmNPCDialogueChance", BaboDialoguePercentageWindhelm.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboActorDialoguePercentage", BaboActorDialogueEventPercentage.GetValue() as int)
	
	
	JsonUtil.SetintValue(File, "BaboLocationChangeMonologue", BaboSoliloquyOnLocationChange.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboOnStartMonologue", BaboSoliloquyOnStartGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboConstantMonologue", BaboSoliloquySelfCommentGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboFreeMonologue", BaboSoliloquySelfFreeCommentGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboMonologueInterval", BaboSoliloquyUpdateGameTimeInterval.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSoliloquyIntervalMminimum", BaboSoliloquyUpdateInterval.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSoliloquyIntervalMaximum", BaboSoliloquyUpdateIntervalMax.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboSimpleSlaveryCheck", SimpleSlavery.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSexlabSurvivalCheck", BaboSexlabSurvivalGlobal.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSLHHCheck", BaboHorribleHarassment.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboEFFCheck", BaboEFF.GetValue() as int)
	
	JsonUtil.SetintValue(File, "BaboLewdness", BaboSexlabStatLewdness.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboLewdnessSpeed", BaboSexlabStatLewdnessSpeed.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboCorruption", BaboSexlabStatCorruption.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboCorruptionSpeed", BaboSexlabStatCorruptionSpeed.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboExhibitionist", BaboSexlabStatExhibitionist.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboExhibitionistSpeed", BaboSexlabStatExhibitionistSpeed.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboBikiniExp", BaboSexlabStatSkimpyExpLevel.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboSkimpySpeed", BaboSexlabStatSkimpySpeed.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboTrauma", BaboSexlabStatTrauma.GetValue() as int)
	JsonUtil.SetintValue(File, "BaboDetectSpectatorSpeed", BaboDetectSpectatorUpdateInterval.GetValue() as int)
	

	JsonUtil.Save(File, False)
EndFunction


Function ImportSettings()
	String File = "../BaboDialogue/BaboDialogueConfig.json"
	
	Beautyint = JsonUtil.GetintValue(File, "BeautyValue")
	Breastsint = JsonUtil.GetintValue(File, "BreastsValue")
	Buttocksint = JsonUtil.GetintValue(File, "ButtocksValue")
	
	PubicHairint = JsonUtil.GetintValue(File, "BaboPubicHairCheck")
	
	BaboNakedRealityint = JsonUtil.GetintValue(File, "BaboRealisticarmor")
	BaboGlobalLoadScreenint = JsonUtil.GetintValue(File, "BaboLoadingScreen")
	
	BaboEncounter01percentageint = JsonUtil.GetintValue(File, "BaboEvent01")
	BaboEncounter02percentageint = JsonUtil.GetintValue(File, "BaboEvent02")
	BaboEncounter03percentageint = JsonUtil.GetintValue(File, "BaboEvent03")
	BaboEncounter04percentageint = JsonUtil.GetintValue(File, "BaboEvent04")
	BaboEncounter05percentageint = JsonUtil.GetintValue(File, "BaboEvent05")
	BaboEncounter06percentageint = JsonUtil.GetintValue(File, "BaboEvent06")
	BaboEncounter08percentageint = JsonUtil.GetintValue(File, "BaboEvent08")
	BaboEncounter09percentageint = JsonUtil.GetintValue(File, "BaboEvent09")
	BaboEncounter10percentageint = JsonUtil.GetintValue(File, "BaboEvent10")
	BaboEncounter11percentageint = JsonUtil.GetintValue(File, "BaboEvent11")
	BaboEncounter12percentageint = JsonUtil.GetintValue(File, "BaboEvent12")
	
	BaboChangeLocation01Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent01")
	BaboChangeLocation02Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent02")
	BaboChangeLocation03Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent03")
	BaboChangeLocation04Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent04")
	BaboChangeLocation05Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent05")
	BaboChangeLocation06Percentageint = JsonUtil.GetintValue(File, "BaboChangeLocationEvent06")
	
	BaboEventWhiterunOrcVisitorsNextVisitIntervalint = JsonUtil.GetintValue(File, "BaboWhiterunOrcVisitInterval", BaboEventWhiterunOrcVisitorsNextVisitInterval.GetValue() as int)
	BaboWhiterunBreezehomeGameDayIntervalint = JsonUtil.GetintValue(File, "BaboWhiterunViceCaptainInterval", BaboWhiterunBreezehomeGameDayInterval.GetValue() as int)
	DLC2RieklingRescueChanceint = JsonUtil.GetintValue(File, "BaboDLC2RieklingRescue", DLC2RieklingRescueChance.GetValue() as int)
	BaboGlobalSpectatorSwitchint = JsonUtil.GetintValue(File, "BaboSpectatorSwitch", BaboGlobalSpectatorSwitch.GetValue() as int)
	BaboCombatEssentialSwitchint = JsonUtil.GetintValue(File, "BaboEssentialSwitch", BaboCombatEssentialSwitch.GetValue() as int)
	BaboCombatWoundPercentMaximumint = JsonUtil.GetintValue(File, "BaboMaximumHealthPercentage", BaboCombatWoundPercentMaximum.GetValue() as int)
	BaboCombatWoundPercentMinimumint = JsonUtil.GetintValue(File, "BaboMinimumHealthPercentage", BaboCombatWoundPercentMinimum.GetValue() as int)
	BaboSimpleSlaveryChanceint = JsonUtil.GetintValue(File, "BaboSimpleSlaveryChance", BaboSimpleSlaveryChance.GetValue() as int)

	BaboDefaultHirelingGoldint = JsonUtil.GetintValue(File, "BaboDefaultHirelingGold")
	BaboHirelingGoldDiscountedint = JsonUtil.GetintValue(File, "BaboHirelingGoldDiscounted")
	BaboTipHirelingGoldint = JsonUtil.GetintValue(File, "BaboTipHirelingGold")
	BaboSeductingFailureChanceint = JsonUtil.GetintValue(File, "BaboSeductingFailureChance")
	BaboRefusalFailureChanceint = JsonUtil.GetintValue(File, "BaboRefusalFailureChance")
	BaboHirelingBleedOutTimesint = JsonUtil.GetintValue(File, "BaboHirelingBleedOutTimes")
	
	Stripswitch = JsonUtil.GetintValue(File, "Babocanbestripped")
	FakeSteal = JsonUtil.GetintValue(File, "BaboFakeSteal")
	BaboStripchanceint = JsonUtil.GetintValue(File, "BaboStripchance")

;BaboDialogueSetting

	
	BaboMerchantDialoguePercentint = JsonUtil.GetintValue(File, "BaboMerchantDialoguePercent")
	BaboFollowerDialoguePercentint = JsonUtil.GetintValue(File, "BaboFollowerDialoguePercent")
	BaboGuardDialoguePercentint = JsonUtil.GetintValue(File, "BaboGuardDialoguePercent")
	BaboEventHintDialoguePercentint = JsonUtil.GetintValue(File, "BaboEventHintDialoguePercent")
	
	BaboCitizenDialoguePercentint = JsonUtil.GetintValue(File, "BaboCitizenDialoguePercent")
	BaboBanditTauntingChanceint = JsonUtil.GetintValue(File, "BaboBanditTauntingChance")
	
	BaboCitizenTalkingSwitchint = JsonUtil.GetintValue(File, "BaboCitizenTalkingSwitch")
	BaboCitizenTalkingChanceint = JsonUtil.GetintValue(File, "BaboCitizenTalkingChance")
	BaboAdventurerTalkingSwitchint =  JsonUtil.GetintValue(File, "BaboAdventurerTalkingSwitch")
	BaboAdventurerTalkingChanceint = JsonUtil.GetintValue(File, "BaboAdventurerTalkingChance")
	BaboPrisonerTalkingSwitchint = JsonUtil.GetintValue(File, "BaboPrisonerTalkingSwitch")
	BaboPrisonerTalkingChanceint = JsonUtil.GetintValue(File, "BaboPrisonerTalkingChance")
	BaboPilgrimTalkingSwitchint = JsonUtil.GetintValue(File, "BaboPilgrimTalkingSwitch")
	
	
	BaboPilgrimTalkingChanceint = JsonUtil.GetintValue(File, "BaboPilgrimTalkingChance")
	BaboMercenaryTalkingSwitchint = JsonUtil.GetintValue(File, "BaboMercenaryTalkingSwitch")
	BaboMercenaryTalkingChanceint = JsonUtil.GetintValue(File, "BaboMercenaryTalkingChance")
	BaboBeggerTalkingSwitchint = JsonUtil.GetintValue(File, "BaboBeggerTalkingSwitch")
	BaboBeggerTalkingChanceint = JsonUtil.GetintValue(File, "BaboBeggerTalkingChance")

;BaboDialogueProbability

	BaboRelationshipSettingint = JsonUtil.GetintValue(File, "BaboRelationshipSetting")
	BaboSexualHarassmentCommentint = JsonUtil.GetintValue(File, "BaboSexualHarassmentComment")
	
	BaboRiverwoodNPCDialogueint = JsonUtil.GetintValue(File, "BaboRiverwoodNPCDialogue")
	BaboRiverwoodNPCDialogueChanceint = JsonUtil.GetintValue(File, "BaboRiverwoodNPCDialogueChance")
	BaboWhiterunNPCDialogueint = JsonUtil.GetintValue(File, "BaboWhiterunNPCDialogue")
	BaboWhiterunNPCDialogueChanceint = JsonUtil.GetintValue(File, "BaboWhiterunNPCDialogueChance")
	BaboWindhelmNPCDialogueint = JsonUtil.GetintValue(File, "BaboWindhelmNPCDialogue")
	BaboWindhelmNPCDialogueChanceint = JsonUtil.GetintValue(File, "BaboWindhelmNPCDialogueChance")
	
	BaboActorDialoguePercentageint = JsonUtil.GetintValue(File, "BaboActorDialoguePercentage")

	BaboLocationChangeMonologueint = JsonUtil.GetintValue(File, "BaboLocationChangeMonologue")
	BaboOnStartMonologueint = JsonUtil.GetintValue(File, "BaboOnStartMonologue")
	BaboConstantMonologueint = JsonUtil.GetintValue(File, "BaboConstantMonologue")
	BaboFreeMonologueint = JsonUtil.GetintValue(File, "BaboFreeMonologue")
	BaboMonologueIntervalint = JsonUtil.GetintValue(File, "BaboMonologueInterval")
	BaboSoliloquyIntervalMminimumint = JsonUtil.GetintValue(File, "BaboSoliloquyIntervalMminimum")
	BaboSoliloquyIntervalMaximumint = JsonUtil.GetintValue(File, "BaboSoliloquyIntervalMaximum")

	BaboLewdnessint = JsonUtil.GetintValue(File, "BaboLewdness")
	BaboLewdnessSpeedint = JsonUtil.GetintValue(File, "BaboLewdnessSpeed")
	BaboCorruptionint = JsonUtil.GetintValue(File, "BaboCorruption")
	BaboCorruptionSpeedint = JsonUtil.GetintValue(File, "BaboCorruptionSpeed")
	BaboExhibitionistint = JsonUtil.GetintValue(File, "BaboExhibitionist")
	BaboExhibitionistSpeedint = JsonUtil.GetintValue(File, "BaboExhibitionistSpeed")
	BaboBikiniExpint = JsonUtil.GetintValue(File, "BaboBikiniExp")
	BaboSkimpySpeedint = JsonUtil.GetintValue(File, "BaboSkimpySpeed")
	BaboTraumaint = JsonUtil.GetintValue(File, "BaboTrauma")
	BaboDetectSpectatorSpeedint = JsonUtil.GetintValue(File, "BaboDetectSpectatorSpeed")

	
	
	BeautyValue.SetValue(Beautyint)
	BreastsValue.SetValue(Breastsint)
	ButtocksValue.SetValue(Buttocksint)
	PubicHairValue.SetValue(PubicHairint)
	
	BaboNakedRealityGlobal.SetValue(BaboNakedRealityint)
	BaboGlobalLoadScreen.SetValue(BaboGlobalLoadScreenint)
	
	BaboEncounter01percentage.SetValue(BaboEncounter01percentageint)
	BaboEncounter02percentage.SetValue(BaboEncounter02percentageint)
	BaboEncounter03percentage.SetValue(BaboEncounter03percentageint)
	BaboEncounter04percentage.SetValue(BaboEncounter04percentageint)
	BaboEncounter05percentage.SetValue(BaboEncounter05percentageint)
	BaboEncounter06percentage.SetValue(BaboEncounter06percentageint)
	BaboEncounter08percentage.SetValue(BaboEncounter08percentageint)
	BaboEncounter09percentage.SetValue(BaboEncounter09percentageint)
	BaboEncounter10percentage.SetValue(BaboEncounter10percentageint)
	BaboEncounter11percentage.SetValue(BaboEncounter11percentageint)
	BaboEncounter12percentage.SetValue(BaboEncounter12percentageint)

	BaboChangeLocation01Percentage.SetValue(BaboChangeLocation01Percentageint)
	BaboChangeLocation02Percentage.SetValue(BaboChangeLocation02Percentageint)
	BaboChangeLocation03Percentage.SetValue(BaboChangeLocation03Percentageint)
	BaboChangeLocation04Percentage.SetValue(BaboChangeLocation04Percentageint)
	BaboChangeLocation05Percentage.SetValue(BaboChangeLocation05Percentageint)
	BaboChangeLocation06Percentage.SetValue(BaboChangeLocation06Percentageint)


	BaboEventWhiterunOrcVisitorsNextVisitInterval.Setvalue(BaboEventWhiterunOrcVisitorsNextVisitIntervalint)
	BaboWhiterunBreezehomeGameDayInterval.Setvalue(BaboWhiterunBreezehomeGameDayIntervalint)
	DLC2RieklingRescueChance.Setvalue(DLC2RieklingRescueChanceint)
	BaboGlobalSpectatorSwitch.Setvalue(BaboGlobalSpectatorSwitchint)
	BaboCombatEssentialSwitch.Setvalue(BaboCombatEssentialSwitchint)
	BaboCombatWoundPercentMaximum.Setvalue(BaboCombatWoundPercentMaximumint)
	BaboCombatWoundPercentMinimum.Setvalue(BaboCombatWoundPercentMinimumint)
	BaboSimpleSlaveryChance.Setvalue(BaboSimpleSlaveryChanceint)
	
	
	HirelingGold.setValue(BaboDefaultHirelingGoldint)
	DiscountedHirelingGold.setValue(BaboHirelingGoldDiscountedint)
	BaboTipHirelingGold.setValue(BaboTipHirelingGoldint)
	BaboHirelingintimidating.setValue(BaboSeductingFailureChanceint)
	BaboHirelingintimidatingWhenRefused.setValue(BaboRefusalFailureChanceint)
	BaboHirelingBleedoutCountLimit.setValue(BaboHirelingBleedOutTimesint)
	
	BaboGlobalDropItem.setValue(BaboStripchanceint)

	BSAQuest.FakeStealSetting(FakeSteal)
	if StripSwitch == 1
		PlayerStripRef.forcerefto(playerref)
	else
		PlayerStripRef.clear()
	endif	
	
	BaboDialoguePercentageMerchant.SetValue(BaboMerchantDialoguePercentint)
	BaboDialoguePercentageFollower.SetValue(BaboFollowerDialoguePercentint)
	BaboDialoguePercentageGuard.SetValue(BaboGuardDialoguePercentint)
	BaboDialoguePercentageHint.SetValue(BaboEventHintDialoguePercentint)
	BaboDialoguePercentageNormalCitizen.SetValue(BaboCitizenDialoguePercentint)
	BaboDialoguePercentageBandit.SetValue(BaboBanditTauntingChanceint)
	
	BaboRankCitizenDialogueGlobal.SetValue(BaboCitizenTalkingSwitchint)
	BaboDialoguePercentagePopuCitizen.SetValue(BaboCitizenTalkingChanceint)
	BaboRankAdventurerDialogueGlobal.SetValue(BaboAdventurerTalkingSwitchint)
	BaboDialoguePercentagePopuAdventurer.SetValue(BaboAdventurerTalkingChanceint)
	BaboRankPrisonerDialogueGlobal.SetValue(BaboPrisonerTalkingSwitchint)
	BaboDialoguePercentagePopuPrisoner.SetValue(BaboPrisonerTalkingChanceint)
	BaboRankPilgrimDialogueGlobal.SetValue(BaboPilgrimTalkingSwitchint)
	
	BaboDialoguePercentagePopuPilgrim.SetValue(BaboPilgrimTalkingChanceint)
	BaboRankMercenaryDialogueGlobal.SetValue(BaboMercenaryTalkingSwitchint)
	BaboDialoguePercentagePopuMercenary.SetValue(BaboMercenaryTalkingChanceint)
	BaboRankBeggerDialogueGlobal.SetValue(BaboBeggerTalkingSwitchint)
	BaboDialoguePercentagePopuBegger.SetValue(BaboBeggerTalkingChanceint)
	
	
	BaboRelationshipSetting.SetValue(BaboRelationshipSettingint)
	BaboSexualHarassmentGlobal.SetValue(BaboSexualHarassmentCommentint)
	BaboUniqueNPCRiverwoodGlobal.SetValue(BaboRiverwoodNPCDialogueint)
	BaboDialoguePercentageRiverwood.SetValue(BaboRiverwoodNPCDialogueChanceint)
	BaboUniqueNPCWhiterunGlobal.SetValue(BaboWhiterunNPCDialogueint)
	BaboDialoguePercentageWhiterun.SetValue(BaboWhiterunNPCDialogueChanceint)
	BaboUniqueNPCWindhelmGlobal.SetValue(BaboWindhelmNPCDialogueint)
	BaboDialoguePercentageWindhelm.SetValue(BaboWindhelmNPCDialogueChanceint)
	BaboActorDialogueEventPercentage.SetValue(BaboActorDialoguePercentageint)

	BaboSoliloquyOnLocationChange.SetValue(BaboLocationChangeMonologueint)
	BaboSoliloquyOnStartGlobal.SetValue(BaboOnStartMonologueint)
	BaboSoliloquySelfCommentGlobal.SetValue(BaboConstantMonologueint)
	BaboSoliloquySelfFreeCommentGlobal.SetValue(BaboFreeMonologueint)
	BaboSoliloquyUpdateGameTimeInterval.SetValue(BaboMonologueIntervalint)
	BaboSoliloquyUpdateInterval.SetValue(BaboSoliloquyIntervalMminimumint)
	BaboSoliloquyUpdateIntervalMax.SetValue(BaboSoliloquyIntervalMaximumint)
	
	BaboSexlabStatLewdness.SetValue(BaboLewdnessint)
	BaboSexlabStatLewdnessSpeed.SetValue(BaboLewdnessSpeedint)
	BaboSexlabStatCorruption.SetValue(BaboCorruptionint)
	BaboSexlabStatCorruptionSpeed.SetValue(BaboCorruptionSpeedint)
	BaboSexlabStatExhibitionist.SetValue(BaboExhibitionistint)
	BaboSexlabStatExhibitionistSpeed.SetValue(BaboExhibitionistSpeedint)
	BaboSexlabStatSkimpyExpLevel.SetValue(BaboBikiniExpint)
	BaboSexlabStatSkimpySpeed.SetValue(BaboSkimpySpeedint)
	BaboSexlabStatTrauma.SetValue(BaboTraumaint)
	BaboDetectSpectatorUpdateInterval.SetValue(BaboDetectSpectatorSpeedint)
EndFunction

;####################################################
;################ This is a property area #######################
;####################################################

;defeatmcmscr Property DefeatQuest Auto Hidden

Faction Property CurrentFollowerFaction Auto
Faction Property PotentialFollowerFaction Auto

Faction Property BaboHateFaction Auto
Faction Property BaboHateFalmerFaction Auto
Faction Property BaboHateNoFollowerFaction Auto
Faction Property BaboPlayerHateFaction Auto

Bool TimeSwitch = True

Int HouseOwned = 0 Conditional
Int QuestCompleted = 0 Conditional
Int StoresInvest = 0 Conditional
Int EastmarchBounty = 0 Conditional
Int FalkreathBounty = 0 Conditional
Int HaafingarBounty = 0 Conditional
Int HjaalmarchBounty = 0 Conditional
Int PaleBounty = 0 Conditional
Int ReachBounty = 0 Conditional
Int RiftBounty = 0 Conditional
Int TribalOrcsBounty = 0 Conditional
Int WhiterunBounty = 0 Conditional
Int WinterholdBounty = 0 Conditional
Int PoisonsUsed = 0 Conditional
Int PeopleKilled = 0 Conditional
Int SneakAttacks = 0 Conditional
Int ItemsStolen = 0 Conditional
Int ItemsPickpocketed = 0 Conditional
Int LocationsDiscovered = 0 Conditional
Int MostGoldCarried = 0 Conditional


GlobalVariable Property BeautyValue Auto
GlobalVariable Property BreastsValue Auto
GlobalVariable Property ButtocksValue Auto
;GlobalVariable Property sla_Appearance Auto
;GlobalVariable Property sla_BreastsScale Auto
;GlobalVariable Property sla_ButtocksScale Auto

GlobalVariable Property BaboReputation Auto
GlobalVariable Property BaboRelationshipSetting Auto

GlobalVariable Property BaboChangeLocation01Percentage Auto
GlobalVariable Property BaboChangeLocation02Percentage Auto
GlobalVariable Property BaboChangeLocation03Percentage Auto
GlobalVariable Property BaboChangeLocation04Percentage Auto
GlobalVariable Property BaboChangeLocation05Percentage Auto
GlobalVariable Property BaboChangeLocation06Percentage Auto
GlobalVariable Property BaboEncounter01percentage Auto
GlobalVariable Property BaboEncounter02percentage Auto
GlobalVariable Property BaboEncounter03percentage Auto
GlobalVariable Property BaboEncounter04percentage Auto
GlobalVariable Property BaboEncounter05percentage Auto
GlobalVariable Property BaboEncounter06percentage Auto
GlobalVariable Property BaboEncounter07percentage Auto
GlobalVariable Property BaboEncounter08percentage Auto
GlobalVariable Property BaboEncounter09percentage Auto
GlobalVariable Property BaboEncounter10percentage Auto
GlobalVariable Property BaboEncounter11percentage Auto
GlobalVariable Property BaboEncounter12percentage Auto

GlobalVariable Property BaboEventWhiterunOrcVisitorsNextVisitInterval Auto
GlobalVariable Property BaboWhiterunBreezehomeGameDayInterval Auto

GlobalVariable Property BaboGlobalArgonianDefeatedTitle Auto
GlobalVariable Property BaboGlobalArgonianDisplayedFuckToyTitle Auto
GlobalVariable Property BaboGlobalDeviousNobleSonFuckToyTitle Auto
GlobalVariable Property BaboGlobalInvestigationMarkarthTitle Auto
GlobalVariable Property BaboGlobalWhiterunOrcFuckToyTitle Auto

GlobalVariable Property BaboGlobalChallengerFalkreath Auto
GlobalVariable Property BaboGlobalChallengerMarkarth Auto
GlobalVariable Property BaboGlobalChallengerMorthal Auto
GlobalVariable Property BaboGlobalChallengerRiften Auto
GlobalVariable Property BaboGlobalChallengerSolitude Auto
GlobalVariable Property BaboGlobalChallengerWhiterun Auto
GlobalVariable Property BaboGlobalChallengerWindhelm Auto

GlobalVariable Property BaboGlobalChallengerFucktoyTitle Auto

GlobalVariable Property BaboGlobalBlackBriarFuckToyTitle Auto
GlobalVariable Property BaboGlobalDibellaTempleFuckToyTitle Auto
GlobalVariable Property BaboGlobalMarkarthGuardFuckToyTitle Auto
GlobalVariable Property BaboGlobalMorgulFuckToyTitle Auto



GlobalVariable Property PubicHairValue Auto

GlobalVariable Property SimpleSlavery Auto
GlobalVariable Property Defeat Auto
GlobalVariable Property BaboHorribleHarassment Auto
GlobalVariable Property BaboEFF Auto
GlobalVariable Property UnequipOption Auto
GlobalVariable Property RecoverControl Auto
GlobalVariable Property RecoverEquipments Auto
GlobalVariable Property BaboGlobalSpectatorSwitch Auto
GlobalVariable Property BaboRankCitizenDialogueGlobal Auto
GlobalVariable Property BaboRankAdventurerDialogueGlobal Auto
GlobalVariable Property BaboRankBeggerDialogueGlobal Auto
GlobalVariable Property BaboRankMercenaryDialogueGlobal Auto
GlobalVariable Property BaboRankPilgrimDialogueGlobal Auto
GlobalVariable Property BaboRankPrisonerDialogueGlobal Auto
GlobalVariable Property BaboCombatEssentialSwitch Auto
GlobalVariable Property BaboSexualHarassmentGlobal Auto

GlobalVariable Property BaboCombatWoundPercentMaximum Auto
GlobalVariable Property BaboCombatWoundPercentMinimum Auto

GlobalVariable Property BaboDialoguePercentageMerchant Auto
GlobalVariable Property BaboDialoguePercentageFollower Auto
GlobalVariable Property BaboDialoguePercentageGuard Auto
GlobalVariable Property BaboDialoguePercentageBandit Auto
GlobalVariable Property BaboDialoguePercentagePopuCitizen Auto
GlobalVariable Property BaboDialoguePercentagePopuAdventurer Auto
GlobalVariable Property BaboDialoguePercentagePopuPrisoner Auto
GlobalVariable Property BaboDialoguePercentagePopuPilgrim Auto
GlobalVariable Property BaboDialoguePercentagePopuMercenary Auto
GlobalVariable Property BaboDialoguePercentagePopuBegger Auto
GlobalVariable Property BaboDialoguePercentageHint Auto

GlobalVariable Property BaboDialoguePercentageNormalCitizen Auto
GlobalVariable Property BaboDialoguePercentageRiverwood Auto
GlobalVariable Property BaboDialoguePercentageWhiterun Auto
GlobalVariable Property BaboDialoguePercentageWindhelm Auto
GlobalVariable Property BaboUniqueNPCRiverwoodGlobal Auto
GlobalVariable Property BaboUniqueNPCWhiterunGlobal Auto
GlobalVariable Property BaboUniqueNPCWindhelmGlobal Auto

GlobalVariable Property BaboSoliloquyOnLocationChange Auto
GlobalVariable Property BaboSoliloquyOnStartGlobal Auto
GlobalVariable Property BaboSoliloquySelfCommentGlobal Auto
GlobalVariable Property BaboSoliloquySelfFreeCommentGlobal Auto

GlobalVariable Property FacetypeCute Auto
GlobalVariable Property FacetypeSexy Auto
GlobalVariable Property FacetypeFox Auto
GlobalVariable Property FacetypeDull Auto
GlobalVariable Property FacetypeApathetic Auto

GlobalVariable Property HirelingGold Auto
GlobalVariable Property DiscountedHirelingGold Auto
GlobalVariable Property BaboTipHirelingGold Auto
GlobalVariable Property BaboHirelingintimidating Auto
GlobalVariable Property BaboHirelingintimidatingWhenRefused Auto
GlobalVariable Property BaboHirelingBleedoutCountLimit Auto
GlobalVariable Property BaboGlobalDropItem Auto

GlobalVariable Property BaboSexlabSurvivalGlobal Auto


GlobalVariable Property BaboActorDialogueEventPercentage Auto

GlobalVariable Property BaboSoliloquyUpdateGameTimeInterval Auto
GlobalVariable Property BaboSoliloquyUpdateInterval Auto
GlobalVariable Property BaboSoliloquyUpdateIntervalMax Auto

Int OID_BeautyValue
Int OID_BreastsValue
Int OID_ButtocksValue

Int OID_BaboEventWhiterunOrcVisitorsNextVisitInterval
Int OID_BaboWhiterunBreezehomeGameDayInterval

Int OID_BaboChangeLocation01Percentage
Int OID_BaboChangeLocation02Percentage
Int OID_BaboChangeLocation03Percentage
Int OID_BaboChangeLocation04Percentage
Int OID_BaboChangeLocation05Percentage
Int OID_BaboChangeLocation06Percentage
Int OID_Encounter01Percent
Int OID_Encounter02Percent
Int OID_Encounter03Percent
Int OID_Encounter04Percent
Int OID_Encounter05Percent
Int OID_Encounter06Percent
Int OID_Encounter07Percent
Int OID_Encounter08Percent
Int OID_Encounter09Percent
Int OID_Encounter10Percent
Int OID_Encounter11Percent
Int OID_Encounter12Percent

Int OID_PubicHair

Int OID_SimpleSlavery
Int OID_SexlabSurvival
Int OID_BaboHorribleHarassment
Int OID_BaboEFF
Int OID_BaboHirelingCompatibility
Int OID_UnequipOption
Int OID_RecoverControl
Int OID_RecoverEquipments
Int OID_DisableEssential
Int OID_InstantManipulation
Int OID_BaboGlobalSpectatorSwitch
Int OID_BaboRankCitizenDialogueGlobal
Int OID_BaboRankAdventurerDialogueGlobal
Int OID_BaboRankMercenaryDialogueGlobal
Int OID_BaboRankPilgrimDialogueGlobal
Int OID_BaboRankPrisonerDialogueGlobal
Int OID_BaboRankBeggerDialogueGlobal
Int OID_BaboCombatEssentialSwitch
Int OID_BaboCombatWoundPercentMaximum
Int OID_BaboCombatWoundPercentMinimum
Int OID_BaboSimpleSlaveryChance
Int OID_FakeSteal
Int OID_Stripswitch
Int OID_BaboGlobalDropItem
Int OID_BaboSexualHarassmentGlobal

Int OID_BaboUniqueNPCRiverwoodGlobal
Int OID_BaboUniqueNPCWhiterunGlobal
Int OID_BaboUniqueNPCWindhelmGlobal
Int OID_BaboDialoguePercentageRiverwood
Int OID_BaboDialoguePercentageWhiterun
Int OID_BaboDialoguePercentageWindhelm

Int OID_BaboSoliloquyOnLocationChange
Int OID_BaboSoliloquyOnStartGlobal
Int OID_BaboSoliloquySelfCommenteGlobal
Int OID_BaboSoliloquySelfFreeCommenteGlobal

Int OID_BaboRescueCounts
Int OID_BaboMerchantDisaffectionValue
Int OID_BaboReputation

Int OID_BaboActorDialogueEventPercentage

Int OID_BaboSoliloquyUpdateGameTimeInterval
Int OID_BaboSoliloquyUpdateInterval
Int OID_BaboSoliloquyUpdateIntervalMax


Int OID_BaboDialoguePercentageMerchant
Int OID_BaboDialoguePercentageFollower
Int OID_BaboDialoguePercentageGuard
Int OID_BaboDialoguePercentageBandit
Int OID_BaboDialoguePercentageNormalCitizen
Int OID_BaboDialoguePercentagePopuCitizen
Int OID_BaboDialoguePercentagePopuAdventurer
Int OID_BaboDialoguePercentagePopuPrisoner
Int OID_BaboDialoguePercentagePopuPilgrim
Int OID_BaboDialoguePercentagePopuMercenary
Int OID_BaboDialoguePercentagePopuBegger
Int OID_BaboDialoguePercentageHint

Int OID_RealisticSetting
Int OID_RelationSetting
Int OID_NotificationKey
Int OID_ExportSettings
Int OID_ImportSettings
Int OID_ResetQuest
Int OID_ResetNewgnisisQuest
Int OID_ResetWhiterunOrcVisitQuest
Int OID_ResetWhiterunViceCaptainQuest
Int OID_ResetLoanSharkQuest
Int OID_TestQuestBaboBadEnd



Int OID_FacetypeCute
Int OID_FacetypeSexy
Int OID_FacetypeFox
Int OID_FacetypeDull
Int OID_FacetypeApathetic

Int OID_HolyKnight

Int OID_BaboGlobalLoadScreen

Int OID_HirelingGold
Int OID_DiscountedHirelingGold
Int OID_BaboTipHirelingGold
Int OID_BaboHirelingintimidating
Int OID_BaboHirelingintimidatingWhenRefused
Int OID_BaboHirelingBleedOutTimes

Int OID_DLC2RieklingRescueChance

int LewdnessOID
int CorruptionOID
int ExhibitionistOID
int TraumaOID
int BikiniExpOID

int OID_LewdnessSpeed
int OID_CorruptionSpeed
int OID_ExhibitionistSpeed
int OID_SkimpySpeed
int OID_DetectSpectator

GlobalVariable Property BaboSimpleSlaveryChance Auto

GlobalVariable Property BaboSexlabStatLewdnessSpeed Auto
GlobalVariable Property BaboSexlabStatCorruptionSpeed Auto
GlobalVariable Property BaboSexlabStatExhibitionistSpeed Auto
GlobalVariable Property BaboSexlabStatSkimpySpeed Auto

GlobalVariable Property BaboSexlabStatCorruption Auto
GlobalVariable Property BaboSexlabStatExhibitionist Auto
GlobalVariable Property BaboSexlabStatTrauma Auto
GlobalVariable Property BaboSexlabStatSkimpyExpLevel Auto
GlobalVariable Property BaboSexlabStatLewdness Auto

Int ResetNewgnisis
Int ResetWhiterunorcvisit
Int ResetWhiterunViceCaptain
Int ResetLoanShark
Int TestQuestBaboBadEnd

Bool SLHHStatus = False
Bool EFFStatus = False
Bool SLSStatus = False

Bool DeviousDevicesIntegration_Installed
Bool SimpleSlavery_Installed
Bool FillHerUp_Installed
Bool BeeingFemale_Installed
Bool Fertility_Installed
Bool EstrusChaurus_Installed
Bool SexlabSurvival_Installed
Bool SexlabHorribleHarassmentExpansion_Installed
Bool EFF_Installed

int BaboDDIIntegrationOID
int BaboFHUIntegrationOID
int BaboBFIntegrationOID
int BaboFertIntegrationOID
int BaboEstrusCIntegrationOID
int BaboSLSIntegrationOID



int Beautyint
int Breastsint
int Buttocksint
int PubicHairint

int BaboEncounter01percentageint
int BaboEncounter02percentageint
int BaboEncounter03percentageint
int BaboEncounter04percentageint
int BaboEncounter05percentageint
int BaboEncounter06percentageint
int BaboEncounter07percentageint
int BaboEncounter08percentageint
int BaboEncounter09percentageint
int BaboEncounter10percentageint
int BaboEncounter11percentageint
int BaboEncounter12percentageint

int BaboNakedRealityint
int BaboGlobalLoadScreenint

int BaboChangeLocation01Percentageint
int BaboChangeLocation02Percentageint
int BaboChangeLocation03Percentageint
int BaboChangeLocation04Percentageint
int BaboChangeLocation05Percentageint
int BaboChangeLocation06Percentageint

int BaboEventWhiterunOrcVisitorsNextVisitIntervalint
int BaboWhiterunBreezehomeGameDayIntervalint
int DLC2RieklingRescueChanceint
int BaboGlobalSpectatorSwitchint
int BaboCombatEssentialSwitchint
int BaboCombatWoundPercentMaximumint
int BaboCombatWoundPercentMinimumint
int BaboSimpleSlaveryChanceint

int BaboDefaultHirelingGoldint
int BaboHirelingGoldDiscountedint
int BaboTipHirelingGoldint
int BaboSeductingFailureChanceint
int BaboRefusalFailureChanceint
int BaboHirelingBleedOutTimes
int BaboStripchanceint


int BaboMerchantDialoguePercentint
int BaboFollowerDialoguePercentint
int BaboGuardDialoguePercentint
int BaboEventHintDialoguePercentint
int BaboCitizenDialoguePercentint
int BaboBanditTauntingChanceint
int BaboCitizenTalkingSwitchint
int BaboCitizenTalkingChanceint
int BaboAdventurerTalkingSwitchint
int BaboAdventurerTalkingChanceint
int BaboPrisonerTalkingSwitchint
int BaboPrisonerTalkingChanceint
int BaboHirelingBleedOutTimesint
int BaboPilgrimTalkingSwitchint

int BaboPilgrimTalkingChanceint
int BaboMercenaryTalkingSwitchint
int BaboMercenaryTalkingChanceint
int BaboBeggerTalkingSwitchint
int BaboBeggerTalkingChanceint

int BaboRelationshipSettingint
int BaboSexualHarassmentCommentint
int BaboRiverwoodNPCDialogueint
int BaboRiverwoodNPCDialogueChanceint
int BaboWhiterunNPCDialogueint
int BaboWhiterunNPCDialogueChanceint
int BaboWindhelmNPCDialogueint
int BaboWindhelmNPCDialogueChanceint
int BaboActorDialoguePercentageint

int BaboLocationChangeMonologueint
int BaboOnStartMonologueint
int BaboConstantMonologueint
int BaboFreeMonologueint
int BaboMonologueIntervalint
int BaboSoliloquyIntervalMminimumint
int BaboSoliloquyIntervalMaximumint

int BaboLewdnessint
int BaboLewdnessSpeedint
int BaboCorruptionint
int BaboCorruptionSpeedint
int BaboExhibitionistint
int BaboExhibitionistSpeedint
int BaboBikiniExpint
int BaboSkimpySpeedint
int BaboTraumaint
int BaboDetectSpectatorSpeedint

GlobalVariable Property BaboDDI auto
GlobalVariable Property BaboFHU auto
GlobalVariable Property BaboBF auto
GlobalVariable Property BaboFertility auto
GlobalVariable Property BaboEstrusChaurus auto

Bool FakeSteal = False
Bool Stripswitch = False



Faction Property HolyKnight Auto

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


Faction Property SLAX_BoobsTinyFaction Auto
Faction Property SLAX_BoobsNiceFaction Auto
Faction Property SLAX_BoobsAmazingFaction Auto
Faction Property SLAX_BoobsBigFaction Auto
Faction Property SLAX_BoobsFullFaction Auto
Faction Property SLAX_BoobsEnormousFaction Auto

Faction Property SLAX_FaceUglyFaction Auto
Faction Property SLAX_FacePlainFaction Auto
Faction Property SLAX_FaceAverageFaction Auto
Faction Property SLAX_FacePrettyFaction Auto
Faction Property SLAX_FaceBeautifulFaction Auto
Faction Property SLAX_FaceScarredFaction Auto

Faction Property SLAX_AssTinyFaction Auto
Faction Property SLAX_AssNiceFaction Auto
Faction Property SLAX_AssAmazingFaction Auto
Faction Property SLAX_AssBigFaction Auto

Perk Property Babo_PrettyClothesLevel Auto
Perk Property Babo_PrettyHeavyArmorLevel Auto
Perk Property Babo_PrettyLightArmorLevel Auto

Perk Property Babo_SpendexClothesLevel Auto
Perk Property Babo_SpendexHeavyArmorLevel Auto
Perk Property Babo_SpendexLightArmorLevel Auto

Perk Property Babo_EroticClothesLevel Auto
Perk Property Babo_EroticHeavyArmorLevel Auto
Perk Property Babo_EroticLightArmorLevel Auto

Perk Property Babo_HalfNakedBikiniClothesLevel Auto
Perk Property Babo_HalfNakedBikiniHeavyArmorLevel Auto
Perk Property Babo_HalfNakedBikiniLightArmorLevel Auto

Perk Property Babo_HalfNakedClothesLevel Auto
Perk Property Babo_HalfNakedHeavyArmorLevel Auto
Perk Property Babo_HalfNakedLightArmorLevel Auto

GlobalVariable Property BaboGlobalLoadScreen Auto
GlobalVariable Property BaboNakedRealityGlobal Auto
GlobalVariable Property BaboResetQuestGlobal Auto
GlobalVariable Property BaboRescueCounts Auto
GlobalVariable Property BaboRescueTCounts Auto
GlobalVariable Property BaboMerchantDisaffectionValue Auto

GlobalVariable Property BaboHirelingCompatibility Auto
GlobalVariable Property BaboDetectSpectatorUpdateInterval Auto

GlobalVariable Property DLC2RieklingRescueChance Auto

GlobalVariable Property BaboMarkarthStrictGuardTriggerGlobal Auto
ObjectReference Property TriggerSwitchStrictGuard Auto

ObjectReference Property BaboTempStolenGoodsRef Auto
ObjectReference Property BaboPosRef Auto

Actor Property PlayerRef Auto

Referencealias Property PlayerAlias Auto
Referencealias Property PlayerStripRef Auto

Int Property NotificationKey = -1 Auto hidden
String[] Property PubicHairString Auto

Keyword Property BaboRestraints Auto
Keyword Property BaboBadendKeyword Auto

BaboDiaMonitorScript Property BDMonitor Auto
BaboMCMRestart Property BaboResetMCM Auto
BaboReputationMasterScript Property BRMQuest Auto
BaboStealingArmorScript Property BSAQuest Auto
Quest Property BaboEventMarkarthGuard Auto
Quest Property BaboBadEnd Auto