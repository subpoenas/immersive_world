Scriptname YamMCM extends SKI_ConfigBase

; -------------------------- Properties
YamCore Property Core Auto
sslSystemConfig Property SLMCM Auto

Quest Property Yam_Scan Auto

; -------------------------- Variables
bool bPauseMod = false
bool bKillScanQuest = false
; --- General
int Property iTickIntDefault = 5 Auto Hidden
bool Property bCheckForNewActors = true Auto Hidden
int Property iTickIntCombat = 10 Auto Hidden
bool Property bCustomBleed = true Auto Hidden
;KnockOut, Master
bool bUseMasterKO = true
int iHealSelf = 50
int iWkHpThresh = 50
bool bWkBlock = false
bool bWkMelee = false
;SL
bool Property bTreatAsVictim = true Auto Hidden
bool Property bFemaleFirst = false Auto Hidden
bool Property bShowNotify = false Auto Hidden
bool Property bShowNotifyColor = false Auto Hidden
;Debug
int Property iPauseKey = 47 Auto Hidden
bool Property bSLScenes = true Auto Hidden
; --- Player
;As Victim
bool Property bPlVicMaster = true Auto Hidden
int Property iHealPlayer = 50 Auto Hidden
int Property iWkHpThreshPl = 50 Auto Hidden
bool Property bWkBlockPl = false Auto Hidden
bool Property bWkMeleePl = false Auto Hidden
;Scenario
string[] Property PlayerScenarioList Auto Hidden
bool Property bPlUseGhost = true Auto Hidden
int Property iPlayerScenario = 0 Auto Hidden
int Property iPlBleedDur = 60 Auto Hidden
bool Property bPlBleedKeepGhost = true Auto Hidden
;As Aggressor
int Property iPlAggrKey = 34 Auto Hidden
bool Property bKnockdownAnyway = true Auto Hidden
;Assault
bool Property bAssPlFol = true Auto Hidden
bool Property bAssPlMale = true Auto Hidden
bool Property bAssPlFemale = true Auto Hidden
bool Property bAssPlFuta = true Auto Hidden
bool Property bAssPlMaleCreat = false Auto Hidden
bool Property bAssPlFemCreat = false Auto Hidden
; --- Followers
;As Victim
bool Property bFolVicMaster = true Auto Hidden
int Property iHealFollower = 50 Auto Hidden
int Property iWkHpThreshFol = 50 Auto Hidden
bool Property bWkBlockFol = false Auto Hidden
bool Property bWkMeleeFol = false Auto Hidden
;Scenario
string[] Property FollowerScenarioList Auto Hidden
bool Property bFolUseGhost = true Auto Hidden
int Property iFollowerScenario = 0 Auto Hidden
int Property iFolFleeDur = 20 Auto Hidden
int Property iFolBleedDur = 60 Auto Hidden
bool Property bFolBleedKeepGhost = false Auto Hidden
;As Aggressor
int Property iAssFolPl = 80 Auto Hidden
int Property iAssFolNPC = 40 Auto Hidden
;Assault
bool Property bAssFolGenMal = true Auto Hidden
bool Property bAssFolGenFem = true Auto Hidden
bool Property bAssFolGenFut = true Auto Hidden
bool Property bAssFolGenPet = true Auto Hidden
bool Property bAssFolPl = false Auto Hidden
bool Property bAssFolMale = true Auto Hidden
bool Property bAssFolFemale = true Auto Hidden
bool Property bAssFolFuta = true Auto Hidden
bool Property bAssFolMaleCreat = false Auto Hidden
bool Property bAssFolFemCreat = false Auto Hidden
; --- NPCs
;As Victim
bool Property bNPCVicMaster = true Auto Hidden
int Property iHealNPC = 50 Auto Hidden
int Property iWkHpThreshNPC = 50 Auto Hidden
bool Property bWkBlockNPC = false Auto Hidden
bool Property bWkMeleeNPC = false Auto Hidden
;Scenario
string[] Property ActorScenarioList Auto Hidden
bool Property bNPCUseGhost = true Auto Hidden
int Property iActorScenario = 0 Auto Hidden
int Property iNPCFleeDur = 20 Auto Hidden
int Property iNPCBleedoutDur = 60 Auto Hidden
bool Property bNPCBleedKeepGhost = false Auto Hidden
;As Aggressor
int Property iAssNpcPl = 70 Auto Hidden
int Property iAssNPCFol = 70 Auto Hidden
int Property iAssNPCNPC = 40 Auto Hidden
;Male Assault Valid Targets
bool Property bAssMalPl = true Auto Hidden
bool Property bAssMalFol = true Auto Hidden
bool Property bAssMalMal = true Auto Hidden
bool Property bAssMalFem = true Auto Hidden
bool Property bAssMalFut = true Auto Hidden
bool Property bAssMalCreat = false Auto Hidden
bool Property bAssMalFemCreat = false Auto Hidden
;Female Assault Valid Targets
bool Property bAssFemPl = true Auto Hidden
bool Property bAssFemFol = true Auto Hidden
bool Property bAssFemMal = true Auto Hidden
bool Property bAssFemFem = true Auto Hidden
bool Property bAssFemFut = true Auto Hidden
bool Property bAssFemCreat = false Auto Hidden
bool Property bAssFemFemCreat = false Auto Hidden
;Futa Assault Valid Targets
bool Property bAssFutPl = true Auto Hidden
bool Property bAssFutFol = true Auto Hidden
bool Property bAssFutMal = true Auto Hidden
bool Property bAssFutFem = true Auto Hidden
bool Property bAssFutFut = true Auto Hidden
bool Property bAssFutCreat = false Auto Hidden
bool Property bAssFutFemCreat = false Auto Hidden
;Male Creature Valid Targets
bool Property bAssMalCrPl = true Auto Hidden
bool Property bAssMalCrFol = true Auto Hidden
bool Property bAssMalCrMal = true Auto Hidden
bool Property bAssMalCrFem = true Auto Hidden
bool Property bAssMalCrFut = true Auto Hidden
bool Property bAssMalCrCreat = false Auto Hidden
bool Property bAssMalCrFemCreat = false Auto Hidden
;Female Creature Valid Targets
bool Property bAssFemCrPl = true Auto Hidden
bool Property bAssFemCrFol = true Auto Hidden
bool Property bAssFemCrMal = true Auto Hidden
bool Property bAssFemCrFem = true Auto Hidden
bool Property bAssFemCrFut = true Auto Hidden
bool Property bAssFemCrCreat = false Auto Hidden
bool Property bAssFemCrFemCreat = false Auto Hidden

; -------------------------- Code
int Function GetVersion()
	return 1
endFunction

Function Initialize()
	Pages = new string[5]
  Pages[0] = "General"
	Pages[1] = "Player"
	Pages[2] = "Follower"
	Pages[3] = "NPC/Creatures"
	Pages[4] = "Scenarios"

	PlayerScenarioList = new string[2]
	PlayerScenarioList[0] = "Basic"
	PlayerScenarioList[1] = "Bleedout1"
	; PlayerScenarioList[2] = "Bleedout2"

	FollowerScenarioList = new string[3]
	FollowerScenarioList[0] = "Basic"
	FollowerScenarioList[1] = "Flee"
	FollowerScenarioList[2] = "Bleedout1"
	; FollowerScenarioList[3] = "Bleedout2"

	ActorScenarioList = new string[3]
	ActorScenarioList[0] = "Basic"
	ActorScenarioList[1] = "Flee"
	ActorScenarioList[2] = "Bleedout1"
	; ActorScenarioList[3] = "Bleedout2"
endFunction

; ==================================
; 							MENU
; ==================================
Event OnConfigInit()
	Initialize()
EndEvent

Event OnVersionUpdate(int newVers)
	Initialize()
endEvent

Event OnPageReset(String Page)
	If(Page == "")
		Page = "General"
	endIf
	SetCursorFillMode(TOP_TO_BOTTOM)
	If(Page == "General")
		int MasterFlag = GetFlag(Page)
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("General")
		AddSliderOptionST("DefaultTick", "Tick Interval (Default)", iTickIntDefault, "{0}s")
		AddSliderOptionST("CombatTick", "Tick Interval (Combat)", iTickIntCombat, "{0}s")
		AddEmptyOption()
		AddToggleOptionST("CustomBleed", "Use custom Bleedout Animations", bCustomBleed)
		AddHeaderOption("Victim Master")
		AddToggleOptionST("KOMaster", "Use Global Knockout Settings", bUseMasterKO)
		AddSliderOptionST("HealSelf", "Heal after Assault", iHealSelf, "{0}%", MasterFlag)
		AddTextOption("- Weakened", none, MasterFlag)
		AddSliderOptionST("WkHpThreshhold", "Health Threshhold", iWkHpThreshPl, "{0}%", MasterFlag)
		AddToggleOptionST("WkBlockOnly", "Unblocked only", bWkBlock, MasterFlag)
		AddToggleOptionST("WkMeleeOnly", "Melee only", bWkMelee, MasterFlag)
		SetCursorPosition(1)
		AddHeaderOption("SexLab")
		AddToggleOptionST("TreatAsVictim", "Treat as Victim", bTreatAsVictim)
		AddToggleOptionST("FemaleFirst", "Female Actors always 1st Pos", bFemaleFirst)
		AddEmptyOption()
		AddToggleOptionST("ShowNotify", "Notification on Assault", bShowNotify)
		AddToggleOptionST("ShowNotifyColor", "Colored Notification", bShowNotifyColor, NotifyColorFlag())
		AddHeaderOption("Status")
		AddTextOption(GetStatus(), none)
		AddEmptyOption()
		AddHeaderOption("Debug")
		AddTextOptionST("PauseMod", "Pause/Resume Scan", none)
		AddKeyMapOptionST("DebugPauseKey", "Pause/Unpause Hotkey", iPauseKey)
		AddTextOptionST("KillScanQuest", "Force-Stop Quest (Combat)", none)
		AddToggleOptionST("SLScenery", "Start SL Scenes", bSLScenes)
	ElseIf(Page == "Player")
		int MasterFlag = GetFlag(Page)
		AddHeaderOption("Player as Victim")
		AddToggleOptionST("PlAsVic", "Player can be Victim", bPlVicMaster)
		AddEmptyOption()
		AddSliderOptionST("HealPlayer", "Heal Player after Assault", iHealPlayer, "{0}%", MasterFlag)
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Scenario")
		AddMenuOptionST("PlayerScenario", "Scenario", PlayerScenarioList[iPlayerScenario])
		AddToggleOptionST("PlUseGhost", "Use Ghost Flag", bPlUseGhost)
		AddSliderOptionST("PlayerBleedDur", "Bleedout Duration", iPlBleedDur, "{0}s", BleedOutFlagPlayer())
		AddToggleOptionST("PlayerBleedGhost", "Keep Ghost Flag", bPlBleedKeepGhost, BleedOutGhostFlagPlayer())
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Conditions")
		AddTextOption("- Weakened", none, MasterFlag)
		AddSliderOptionST("WkHpThreshholdPl", "Health Threshhold", iWkHpThreshPl, "{0}%", MasterFlag)
		AddToggleOptionST("WkBlockOnlyPl", "Unblocked only", bWkBlockPl, MasterFlag)
		AddToggleOptionST("WkMeleeOnlyPl", "Melee only", bWkMeleePl, MasterFlag)
		AddEmptyOption()
		;Other Knockdown scenarios here
		SetCursorPosition(1)
		AddHeaderOption("Player as Aggressor")
		AddKeyMapOptionST("PlAggrKey", "Aura of the Aggressor Hotkey", iPlAggrKey)
		AddToggleOptionST("PlKdAnyway", "Knockdown anyway", bKnockdownAnyway)
		AddEmptyOption()
		AddHeaderOption("Assault Options")
		AddTextOption("Player can assault...", none)
		AddToggleOptionST("PlFolAssault", "..Followers", bAssPlFol)
		AddToggleOptionST("PlMaleAssault", "..male Actors.", bAssPlMale)
		AddToggleOptionST("PlFemaleAssault", "..female Actors.", bAssPlFemale)
		AddToggleOptionST("PlFutaAssault", "..futa Actors.", bAssPlFuta)
		If(SLMCM.UseCreatureGender)
			AddToggleOptionST("PlMaleCreatAssault", "..male Creatures.", bAssPlMaleCreat)
			AddToggleOptionST("PlFemCreatAssault", "..female Creatures.", bAssPlFemCreat)
		else
			AddToggleOptionST("PlMaleCreatAssault", "..Creatures.", bAssPlMaleCreat)
		EndIf
	ElseIf(Page == "Follower")
		int MasterFlag = GetFlag(Page)
		AddHeaderOption("Follower as Victim")
		AddToggleOptionST("FolAsVic", "Follower can be Victim", bFolVicMaster)
		AddSliderOptionST("HealFollower", "Heal Follower after Assault", iHealFollower, "{0}%", MasterFlag)
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Scenario")
		AddMenuOptionST("FollowerScenario", "Scenario", FollowerScenarioList[iFollowerScenario])
		AddToggleOptionST("FolUseGhost", "Use Ghost Flag", bFolUseGhost)
		AddSliderOptionST("FolFleeDur", "Flee Duration", iFolFleeDur, "{0}s", FleeFlagFol())
		AddSliderOptionST("FolBleedDur", "Bleedout Duration", iFolBleedDur, "{0}s", BleedoutFlagFollower())
		AddToggleOptionST("FolBleedGhost", "Keep Ghost Flag", bFolBleedKeepGhost, BleedoutGhostFlagFollower())
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Conditions")
		AddTextOption("- Weakened", none, MasterFlag)
		AddSliderOptionST("WkHpThreshholdFol", "Health Threshhold", iWkHpThreshFol, "{0}%", MasterFlag)
		AddToggleOptionST("WkBlockOnlyFol", "Unblocked only", bWkBlockFol, MasterFlag)
		AddToggleOptionST("WkMeleeOnlyFol", "Melee only", bWkMeleeFol, MasterFlag)
		SetCursorPosition(1)
		AddHeaderOption("Follower as Aggressor")
		AddSliderOptionST("PerCentFolPl", "Chance to assault the Player", iAssFolPl, "{0}%")
		AddSliderOptionST("PerCentFolNPC", "Chance to assault a NPC/Creature", iAssFolNPC, "{0}%")
		AddEmptyOption()
		AddHeaderOption("Assault Options")
		AddTextOption("Followers can assault if..", none)
		AddToggleOptionST("FolGenderMale", "..they are male.", bAssFolGenMal)
		AddToggleOptionST("FolGenderFemale", "..they are female.", bAssFolGenFem)
		AddToggleOptionST("FolGenderFuta", "..they are a futa.", bAssFolGenFut)
		AddToggleOptionST("FolGenderPet", "..they are a Pet.", bAssFolGenPet)
		AddTextOption("Followers can assault...", none)
		AddToggleOptionST("FolPlayerAssault", "..the Player", bAssFolPl)
		AddToggleOptionST("FolMaleAssault", "..male Actors.", bAssFolMale)
		AddToggleOptionST("FolFemaleAssault", "..female Actors.", bAssFolFemale)
		AddToggleOptionST("FolFutaAssault", "..futa Actors.", bAssFolFuta)
		If(SLMCM.UseCreatureGender)
			AddToggleOptionST("FolMaleCreatAssault", "..male Creatures.", bAssFolMaleCreat)
			AddToggleOptionST("FolFemCreatAssault", "..female Creatures.", bAssFolFemCreat)
		else
			AddToggleOptionST("FolMaleCreatAssault", "..Creatures.", bAssFolMaleCreat)
		EndIf
	ElseIf(Page == "NPC/Creatures")
		int MasterFlag = GetFlag(Page)
		AddHeaderOption("NPCs as Victim")
		AddToggleOptionST("NPCAsVic", "NPCs can be Victim", bNPCVicMaster)
		AddSliderOptionST("HealNPC", "Heal NPCs after Assault", iHealNPC, "{0}%", MasterFlag)
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Scenario")
		AddMenuOptionST("ActorScenario", "Scenario", ActorScenarioList[iActorScenario])
		AddToggleOptionST("NPCUseGhost", "Use Ghost Flag", bNPCUseGhost)
		AddSliderOptionST("NPCFleeDur", "Flee duration", iNPCFleeDur, "{0}s", FleeFlagNPC())
		AddSliderOptionST("NPCBleedDur", "Bleedout Duration", iNPCBleedoutDur, "{0}s", BleedoutFlagNPC())
		AddToggleOptionST("NPCBleedGhost", "Keep Ghost Flag", bNPCBleedKeepGhost, BleedoutGhostFlagNPC())
		; -----------------------------------------------------------------
		AddHeaderOption("Knockdown Conditions")
		AddTextOption("- Weakened", none, MasterFlag)
		AddSliderOptionST("WkHpThreshholdNPC", "Health Threshhold", iWkHpThreshNPC, "{0}%", MasterFlag)
		AddToggleOptionST("WkBlockOnlyNPC", "Unblocked only", bWkBlockNPC, MasterFlag)
		AddToggleOptionST("WkMeleeOnlyNPC", "Melee only", bWkMeleeNPC, MasterFlag)
		SetCursorPosition(1)
		AddHeaderOption("NPC as Aggressor")
		AddSliderOptionST("PerCentNpcPl", "Chance to assault the Player", iAssNpcPl, "{0}%")
		AddSliderOptionST("PerCentNPCFol", "Chance to assault a Follower", iAssNPCFol, "{0}%")
		AddSliderOptionST("PerCentNPCNPC", "Chance to assault a NPC", iAssNPCNPC, "{0}%")
		AddEmptyOption()
		AddHeaderOption("Assault Options")
		AddTextOption("- A \"male\" Actor can assault...", none)
		AddToggleOptionST("MalePlayerAssault", "..the Player", bAssMalPl)
		AddToggleOptionST("MalFollowerAssault", "..Followers", bAssMalFol)
		AddToggleOptionST("MaleMaleAssault", "..male Actors.", bAssMalMal)
		AddToggleOptionST("MaleFemaleAssault", "..female Actors.", bAssMalFem)
		AddToggleOptionST("MaleFutaAssault", "..futa Actors.", bAssMalFut)
		If(SLMCM.UseCreatureGender)
			AddToggleOptionST("MaleCreatureAssault", "..male Creatures.", bAssMalCreat)
			AddToggleOptionST("MaleFemCreaAssault", "..female Creatures.", bAssMalFemCreat)
		else
			AddToggleOptionST("MaleCreatureAssault", "..Creatures.", bAssMalCreat)
		EndIf
		; -----------------------------------------------------------------
		AddHeaderOption("")
		AddTextOption("- A \"female\" Actor can assault...", none)
		AddToggleOptionST("FemalePlayerAssault", "..the Player", bAssFemPl)
		AddToggleOptionST("FemalFollowerAssault", "..Followers", bAssFemFol)
		AddToggleOptionST("FemaleMaleAssault", "..male Actors.", bAssFemMal)
		AddToggleOptionST("FemaleFemaleAssault", "..female Actors.", bAssFemFem)
		AddToggleOptionST("FemaleFutaAssault", "..futa Actors.", bAssFemFut)
		If(SLMCM.UseCreatureGender)
			AddToggleOptionST("FemaleCreatureAssault", "..male Creatures.", bAssFemCreat)
			AddToggleOptionST("FemaleFemCreaAssault", "..female Creatures.", bAssFemFemCreat)
		else
			AddToggleOptionST("FemaleCreatureAssault", "..Creatures.", bAssFemCreat)
		EndIf
		; -----------------------------------------------------------------
		AddHeaderOption("")
		AddTextOption("- A \"futa\" Actor can assault...", none)
		AddToggleOptionST("FutaPlayerAssault", "..the Player", bAssFutPl)
		AddToggleOptionST("FutaFollowerAssault", "..Followers", bAssFutFol)
		AddToggleOptionST("FutaMaleAssault", "..male Actors.", bAssFutMal)
		AddToggleOptionST("FutaFemaleAssault", "..female Actors.", bAssFutFem)
		AddToggleOptionST("FutaFutaAssault", "..futa Actors.", bAssFutFut)
		If(SLMCM.UseCreatureGender)
			AddToggleOptionST("FutaCreatureAssault", "..male Creatures.", bAssFutCreat)
			AddToggleOptionST("FutaFemCreaAssault", "..female Creatures.", bAssFutFemCreat)
		else
			AddToggleOptionST("FutaCreatureAssault", "..Creatures.", bAssFutCreat)
		EndIf
		If(SLMCM.UseCreatureGender)
			; -----------------------------------------------------------------
			AddHeaderOption("")
			AddTextOption("- A \"male\" Creature can assault...", none)
			AddToggleOptionST("MalCrPlayerAssault", "..the Player", bAssMalCrPl)
			AddToggleOptionST("MalCrFollowerAssault", "..Followers", bAssMalCrFol)
			AddToggleOptionST("MalCrMaleAssault", "..male Actors.", bAssMalCrMal)
			AddToggleOptionST("MalCrFemaleAssault", "..female Actors.", bAssMalCrFem)
			AddToggleOptionST("MalCrFutaAssault", "..futa Actors.", bAssMalCrFut)
			If(SLMCM.UseCreatureGender)
				AddToggleOptionST("MalCrCreatureAssault", "..male Creatures.", bAssMalCrCreat)
				AddToggleOptionST("MalCrFemCreaAssault", "..female Creatures.", bAssMalCrFemCreat)
			else
				AddToggleOptionST("MalCrCreatureAssault", "..Creatures.", bAssMalCrCreat)
			EndIf
			; -----------------------------------------------------------------
			AddHeaderOption("")
			AddTextOption("- A \"female\" Creature can assault...", none)
			AddToggleOptionST("FemCrPlayerAssault", "..the Player", bAssFemCrPl)
			AddToggleOptionST("FemCrFollowerAssault", "..Followers", bAssFemCrFol)
			AddToggleOptionST("FemCrMaleAssault", "..male Actors.", bAssFemCrMal)
			AddToggleOptionST("FemCrFemaleAssault", "..female Actors.", bAssFemCrFem)
			AddToggleOptionST("FemCrFutaAssault", "..futa Actors.", bAssFemCrFut)
			If(SLMCM.UseCreatureGender)
				AddToggleOptionST("FemCrCreatureAssault", "..male Creatures.", bAssFemCrCreat)
				AddToggleOptionST("FemCrFemCreaAssault", "..female Creatures.", bAssFemCrFemCreat)
			else
				AddToggleOptionST("FemCrCreatureAssault", "..Creatures.", bAssFemCrCreat)
			EndIf
		else
			; -----------------------------------------------------------------
			AddHeaderOption("")
			AddTextOption("- A Creature can assault...", none)
			AddToggleOptionST("MalCrPlayerAssault", "..the Player", bAssMalCrPl)
			AddToggleOptionST("MalCrFollowerAssault", "..Followers", bAssMalCrFol)
			AddToggleOptionST("MalCrMaleAssault", "..male Actors.", bAssMalCrMal)
			AddToggleOptionST("MalCrFemaleAssault", "..female Actors.", bAssMalCrFem)
			AddToggleOptionST("MalCrFutaAssault", "..futa Actors.", bAssMalCrFut)
			If(SLMCM.UseCreatureGender)
				AddToggleOptionST("MalCrCreatureAssault", "..male Creatures.", bAssMalCrCreat)
				AddToggleOptionST("MalCrFemCreaAssault", "..female Creatures.", bAssMalCrFemCreat)
			else
				AddToggleOptionST("MalCrCreatureAssault", "..Creatures.", bAssMalCrCreat)
			EndIf
		EndIf
	ElseIf(Page == "Scenarios")
		AddHeaderOption("Scenarios")
		AddTextOptionST("Scenario1", "Scenario: Basic", none)
		AddEmptyOption()
		AddTextOptionST("Scenario2", "Scenario: Flee", none)
		AddEmptyOption()
		SetCursorPosition(1)
		AddHeaderOption("")
		AddEmptyOption()
		AddTextOptionST("Scenario3", "Scenario: Bleedout1", none)
		AddEmptyOption()
		; AddTextOptionST("Scenario4", "Scenario: Bleedout2", none)
		AddEmptyOption()
	EndIf
EndEvent

Event OnConfigClose()
	If(bPauseMod && Core.ModPaused)
		Core.UnregisterForUpdate()
		bPauseMod = false
	ElseIf(bPauseMod && !Core.ModPaused)
		Core.RegisterForSingleUpdate(iTickIntDefault)
		bPauseMod = false
	EndIf
	If(bKillScanQuest)
		Yam_Scan.Stop()
		bKillScanQuest = false
	EndIf
EndEvent

; ==================================
; 				States // General
; ==================================
State DefaultTick
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iTickIntDefault)
		SetSliderDialogDefaultValue(5)
		SetSliderDialogRange(1, 30)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iTickIntDefault = value as int
		SetSliderOptionValueST(iTickIntDefault)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How often the mod looks for Combat. Low values allows for more responsive combat detection but may impact performance.")
	EndEvent
EndState

State CheckForNewActors
	Event OnSelectST()
		bCheckForNewActors = !bCheckForNewActors
		SetToggleOptionValueST(bCheckForNewActors)
		If(bCheckForNewActors)
			SetOptionFlagsST(OPTION_FLAG_NONE, true, "CombatTick")
		else
			SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "CombatTick")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("Wether or not the mod searches for new Actors during Combat.\nIf disabled, Actors that join an already started fight will be ignored.")
	EndEvent
EndState

State CombatTick
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iTickIntCombat)
		SetSliderDialogDefaultValue(2)
		SetSliderDialogRange(1, 60)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iTickIntCombat = value as int
		SetSliderOptionValueST(iTickIntCombat)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How often the mod checks if new Actors entered Combat. Low values allow for more accurate detection but may impact performance.")
	EndEvent
EndState

State CustomBleed
	Event OnSelectST()
		bCustomBleed = !bCustomBleed
		SetToggleOptionValueST(bCustomBleed)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Use customized bleedout animations instead of the Default one.")
	EndEvent
EndState
; --- Master Settings
State KOMaster
	Event OnSelectST()
		bUseMasterKO = !bUseMasterKO
		SetToggleOptionValueST(bUseMasterKO)
		If(bUseMasterKO)
			;Master
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "HealSelf")
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "WkHpThreshhold")
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "WkBlockOnly")
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "WkMeleeOnly")
		else
			;Master
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "HealSelf")
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "WkHpThreshhold")
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "WkBlockOnly")
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "WkMeleeOnly")
		EndIf
	endEvent
	Event OnHighlightST()
		SetInfoText("This Option allows you to change to set most Victim Settings globally. If you want to use the same Knock Out-Conditions for everyone enable this Option and change the options below, otherwise disable this Option and change the Settings in the individual MCM Pages.")
	EndEvent
EndState

State HealSelf
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iHealSelf)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iHealSelf = value as int
		SetSliderOptionValueST(iHealSelf)
		; ---
		iHealPlayer = value as int
		iHealFollower = value as int
		iHealNPC = value as int
	EndEvent
	Event OnHighlightST()
		SetInfoText("How much Hp is regenerated after an Assault.\nSet to 0 to disable.")
	EndEvent
EndState

State WkHpThreshhold
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iWkHpThresh)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iWkHpThresh = value as int
		SetSliderOptionValueST(iWkHpThresh)
		; ---
		iWkHpThreshPl = value as int
		iWkHpThreshFol = value as int
		iWkHpThreshNPC = value as int
	EndEvent
	Event OnHighlightST()
		SetInfoText("Victims will be knocked down when their Hp falls below this value.\nSet to 0 to disable.")
	EndEvent
EndState

State WkBlockOnly
	Event OnSelectST()
		bWkBlock = !bWkBlock
		SetToggleOptionValueST(bWkBlock)
		; ---
		bWkBlockPl = bWkBlock
		bWkBlockFol = bWkBlock
		bWkBlockNPC = bWkBlock
	endEvent
	Event OnHighlightST()
		SetInfoText("Only unblocked hits can knock you down.")
	EndEvent
EndState

State WkMeleeOnly
	Event OnSelectST()
		bWkMelee = !bWkMelee
		SetToggleOptionValueST(bWkMelee)
		; ---
		bWkMeleePl = bWkMelee
		bWkMeleeFol = bWkMelee
		bWkMeleeNPC = bWkMelee
	EndEvent
	Event OnHighlightST()
		SetInfoText("Only melee hits can knock you down.")
	EndEvent
EndState
; --- SL Settings
State TreatAsVictim
	Event OnSelectST()
		bTreatAsVictim = !bTreatAsVictim
		SetToggleOptionValueST(bTreatAsVictim)
	endEvent
	Event OnHighlightST()
		SetInfoText("Is a Victim in this mod also considered as a Victim by SexLab?")
	EndEvent
EndState

State FemaleFirst
	Event OnSelectST()
		bFemaleFirst = !bFemaleFirst
		SetToggleOptionValueST(bFemaleFirst)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Enabling this option will put female Actors always on Position 1 - even when they arent Victim. This may break immersion as the Scene may depict a female Aggressor as Victim (especially when you have \"Treat as Victim\" enabled) but you wont have females going after males with strap-ons. :)")
	EndEvent
EndState

State ShowNotify
	Event OnSelectST()
		bShowNotify = !bShowNotify
		SetToggleOptionValueST(bShowNotify)
		If(bShowNotify)
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "ShowNotifyColor")
		else
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "ShowNotifyColor")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("Get a notification in the corner of your Screen when an Assault happens, stating Name of the Aggressor & Victim.")
	EndEvent
EndState

State ShowNotifyColor
	Event OnSelectST()
		bShowNotifyColor = !bShowNotifyColor
		SetToggleOptionValueST(bShowNotifyColor)
	EndEvent
	Event OnHighlightST()
		SetInfoText("The notification will be colored red.\n!This can break custom UIs.")
	EndEvent
EndState
; --- Debug Settings
State PauseMod
	Event OnSelectST()
		bPauseMod = true
		Core.ModPaused = !Core.ModPaused
		Debug.MessageBox("Changes will apply once you exit the MCM.")
	EndEvent
	Event OnHighlightST()
		SetInfoText("Pause or resume scanning for combat.\nThis does not stop any already ongoing Scenarios.")
	EndEvent
EndState

State DebugPauseKey
	Event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		bool continue = true
		if(conflictControl != "")
			string msg
			if(conflictName != "")
				msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
			if (continue)
				Core.UnregisterForKey(iPauseKey)
				iPauseKey = newKeyCode
				SetKeyMapOptionValueST(iPauseKey)
				Core.RegisterForKey(iPauseKey)
			endIf
		endEvent
	event OnDefaultST()
		Core.UnregisterForKey(iPauseKey)
		iPauseKey = 47
		SetKeyMapOptionValueST(iPauseKey)
		Core.RegisterForKey(iPauseKey)
	endEvent
	event OnHighlightST()
		SetInfoText("Hotkey to pause or unpause the mod.\nThis will also kill the Combat Quest if necessary.")
	endEvent
EndState

State KillScanQuest
	Event OnSelectST()
		If(Yam_Scan.IsRunning())
			bKillScanQuest = true
			Debug.MessageBox("Changes will apply once you exit the MCM.")
		else
			Debug.MessageBox("Invalid call.\n Quest is not running.")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("Forces the mod to stop its Combat Quest.\nNote that this wont pause the mod. Meaning if you are currently in Combat, the Quest may restart during the next (default) Tick.")
	EndEvent
EndState

State SLScenery
		Event OnSelectST()
			bSLScenes = !bSLScenes
			SetToggleOptionValueST(bSLScenes)
		endEvent
		Event OnHighlightST()
			SetInfoText("Disable any SL Scenes playing. This is meant for internal testing only.")
		EndEvent
EndState

; ==================================
; 				States // Player
; ==================================
State PlAsVic
	Event OnSelectST()
		bPlVicMaster = !bPlVicMaster
		SetToggleOptionValueST(bPlVicMaster)
	endEvent
EndState

State HealPlayer
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iHealPlayer)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iHealPlayer = value as int
		SetSliderOptionValueST(iHealPlayer)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How much Hp the Player regenerates after an assault.\nSet to 0 to disable.")
	EndEvent
EndState
; --- Scenario
State PlayerScenario
	Event OnMenuOpenST()
		If(Yam_Scan.IsRunning())
			Debug.MessageBox("Combat Quest is currently running. Make sure you are out of Combat and the mod went back to \"Searching to Combat\" before changing this Setting.")
			OnMenuAcceptST(iPlayerScenario)
			return
		EndIf
		SetMenuDialogStartIndex(iPlayerScenario)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(PlayerScenarioList)
	EndEvent
	Event OnMenuAcceptST(int index)
		iPlayerScenario = index
		SetMenuOptionValueST(PlayerScenarioList[iPlayerScenario])
		CheckScenarioFlagsPlayer()
	EndEvent
	Event OnDefaultST()
		iPlayerScenario = 1
		SetMenuOptionValueST(PlayerScenarioList[iPlayerScenario])
	EndEvent
	Event OnHighlightST()
		SetInfoText("The Scenario Setting describes the general Behavior of a Knockdown. For further Information what each Scenario does, check the \"Scenarios\" MCM Page.")
	endEvent
EndState

State PlUseGhost
	Event OnSelectST()
		bPlUseGhost = !bPlUseGhost
		SetToggleOptionValueST(bPlUseGhost)
		If(bPlUseGhost && (iPlayerScenario == 1 || iPlayerScenario == 2))
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "PlayerBleedGhost")
		else
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "PlayerBleedGhost")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true, you and your Aggressor receive a Ghost Flag (invincibility) duing the SL Scene ony.\nUseful to avoid Scene participants dying during the Animation. This has no visual Effect.")
	EndEvent
EndState
; BleedOut Scenario
State PlayerBleedDur
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iPlBleedDur)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(5)
	EndEvent
	Event OnSliderAcceptST(float value)
		iPlBleedDur = value as int
		SetSliderOptionValueST(iPlBleedDur)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How long does the Player stay in Bleedout?\nSetting this to 0 forces them to stay in Bleedout until Combat ends.")
	EndEvent
EndState

State PlayerBleedGhost
	Event OnSelectST()
		bPlBleedKeepGhost = !bPlBleedKeepGhost
		SetToggleOptionValueST(bPlBleedKeepGhost)
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true and youre currenlty playing through a Bleedout Scenario, you will keep your Ghost Flag (invincibility) until the Scenario ends. Otherwise the Flag is removed after the SL Scene ends")
	EndEvent
EndState
; --- Knock Out
State WkHpThreshholdPl
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iWkHpThreshPl)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iWkHpThreshPl = value as int
		SetSliderOptionValueST(iWkHpThreshPl)
	EndEvent
	Event OnHighlightST()
		SetInfoText("You will be knocked down when your Hp falls below this value.\nSet to 0 to disable.")
	EndEvent
EndState

State WkBlockOnlyPl
	Event OnSelectST()
		bWkBlock = !bWkBlock
		SetToggleOptionValueST(bWkBlock)
	endEvent
	Event OnHighlightST()
		SetInfoText("Only unblocked hits can knock you down.")
	EndEvent
EndState

State WkMeleeOnlyPl
	Event OnSelectST()
		bWkMelee = !bWkMelee
		SetToggleOptionValueST(bWkMelee)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Only melee hits can knock you down.")
	EndEvent
EndState
; --- As Aggressor
State PlAggrKey
	event OnKeyMapChangeST(int newKeyCode, string conflictControl, string conflictName)
		bool continue = true
		if(conflictControl != "")
			string msg
			if(conflictName != "")
				msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
			if (continue)
				Core.UnregisterForKey(iPlAggrKey)
				iPlAggrKey = newKeyCode
				SetKeyMapOptionValueST(iPlAggrKey)
				Core.RegisterForKey(iPlAggrKey)
			endIf
		endEvent
	event OnDefaultST()
		Core.UnregisterForKey(iPlAggrKey)
		iPlAggrKey = 34
		SetKeyMapOptionValueST(iPlAggrKey)
		Core.RegisterForKey(iPlAggrKey)
	endEvent
	event OnHighlightST()
		SetInfoText("Hotkey to enable/disable \"Aura of the Aggressor\". This effect allows you to Assault others.")
	endEvent
EndState

State PlKdAnyway
	Event OnSelectST()
		bKnockdownAnyway = !bKnockdownAnyway
		SetToggleOptionValueST(bKnockdownAnyway)
	EndEvent
	Event OnHighlightST()
		SetInfoText("When the Player attacks a Target which is using a Bleedout Scenario:\nIf true, this Target is being knocked out even when the player choses to not Assault this Target.")
	EndEvent
EndState
; --- Assault
State PlFolAssault
	Event OnSelectST()
		bAssPlFol = !bAssPlFol
		SetToggleOptionValueST(bAssPlFol)
	EndEvent
EndState

State PlMaleAssault
	Event OnSelectST()
		bAssPlMale = !bAssPlMale
		SetToggleOptionValueST(bAssPlMale)
	endEvent
EndState

State PlFemaleAssault
	Event OnSelectST()
		bAssPlFemale = !bAssPlFemale
		SetToggleOptionValueST(bAssPlFemale)
	endEvent
EndState

State PlFutaAssault
	Event OnSelectST()
		bAssPlFuta = !bAssPlFuta
		SetToggleOptionValueST(bAssPlFuta)
	endEvent
EndState

State PlMaleCreatAssault
	Event OnSelectST()
		bAssPlMaleCreat = !bAssPlMaleCreat
		SetToggleOptionValueST(bAssPlMaleCreat)
	endEvent
EndState

State PlFemCreatAssault
	Event OnSelectST()
		bAssPlFemCreat = !bAssPlFemCreat
		SetToggleOptionValueST(bAssPlFemCreat)
	endEvent
EndState

; ==================================
; 				States // Follower
; ==================================
State FolAsVic
	Event OnSelectST()
		bFolVicMaster = !bFolVicMaster
		SetToggleOptionValueST(bFolVicMaster)
	endEvent
EndState

State HealFollower
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iHealFollower)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iHealFollower = value as int
		SetSliderOptionValueST(iHealFollower)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How much Hp a Follower regenerates after an assault.\nSet to 0 to disable.")
	EndEvent
EndState
; --- Scenario
State FollowerScenario
	Event OnMenuOpenST()
		If(Yam_Scan.IsRunning())
			Debug.MessageBox("Combat Quest is currently running. Make sure you are out of Combat and the mod went back to \"Searching to Combat\" before changing this Setting.")
			OnMenuAcceptST(iFollowerScenario)
			return
		EndIf
		SetMenuDialogStartIndex(iFollowerScenario)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(FollowerScenarioList)
	EndEvent
	Event OnMenuAcceptST(int index)
		iFollowerScenario = index
		SetMenuOptionValueST(FollowerScenarioList[iFollowerScenario])
		CheckScenarioFlagsFollower()
	EndEvent
	Event OnDefaultST()
		iFollowerScenario = 1
		SetMenuOptionValueST(FollowerScenarioList[iFollowerScenario])
	EndEvent
	Event OnHighlightST()
		SetInfoText("The Scenario Setting describes the general Behavior of a Knockdown. For further Information what each Scenario does, check the \"Scenarios\" MCM Page.")
	endEvent
EndState

State FolUseGhost
	Event OnSelectST()
		bFolUseGhost = !bFolUseGhost
		SetToggleOptionValueST(bFolUseGhost)
		If(bFolUseGhost && (iFollowerScenario == 2 || iFollowerScenario == 3))
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "FolBleedGhost")
		else
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolBleedGhost")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true, a Victim Follower and their Aggressor receive a Ghost Flag (invincibility) duing the SL Scene ony.\nUseful to avoid Scene participants dying during the Animation. This has no visual Effect.")
	EndEvent
EndState
; Flee
State FolFleeDur
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iFolFleeDur)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(5, 500)
		SetSliderDialogInterval(0)
	EndEvent
	Event OnSliderAcceptST(float value)
		iFolFleeDur = value as int
		SetSliderOptionValueST(iFolFleeDur)
	EndEvent
	Event OnHighlightST()
		SetInfoText("For how long do Followers flee?")
	EndEvent
EndState
; BleedOut Scenarios
State FolBleedDur
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iFolBleedDur)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(5)
	EndEvent
	Event OnSliderAcceptST(float value)
		iFolBleedDur = value as int
		SetSliderOptionValueST(iFolBleedDur)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How long will Followers stay in Bleedout?\nSetting this to 0 forces them to stay in Bleedout until Combat ends.")
	EndEvent
EndState

State FolBleedGhost
	Event OnSelectST()
		bFolBleedKeepGhost = !bFolBleedKeepGhost
		SetToggleOptionValueST(bFolBleedKeepGhost)
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true, a Follower inside a Bleedout Scenario will keep their Ghost Flag (invincibility) until the Scenario ends. Otherwise the Flag is removed after the SL Scene ends")
	EndEvent
EndState
; --- Knock Out
State WkHpThreshholdFol
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iWkHpThreshFol)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iWkHpThreshFol = value as int
		SetSliderOptionValueST(iWkHpThreshFol)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Followers will be knocked down when your Hp falls below this value.\nSet to 0 to disable.")
	EndEvent
EndState

State WkBlockOnlyFol
	Event OnSelectST()
		bWkBlockFol = !bWkBlockFol
		SetToggleOptionValueST(bWkBlockFol)
	endEvent
	Event OnHighlightST()
		SetInfoText("Only unblocked hits can knock a Follower down.")
	EndEvent
EndState

State WkMeleeOnlyFol
	Event OnSelectST()
		bWkMeleeFol = !bWkMeleeFol
		SetToggleOptionValueST(bWkMeleeFol)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Only melee hits can knock a Follower down.")
	EndEvent
EndState
; --- As Aggressor
State PerCentFolPl
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iAssFolPl)
		SetSliderDialogDefaultValue(80)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iAssFolPl = value as int
		SetSliderOptionValueST(iAssFolPl)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Chance that a Follower will assault the Player when one of the Conditions are fulfilled.")
	EndEvent
EndState

State PerCentFolNPC
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iAssFolNPC)
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iAssFolNPC = value as int
		SetSliderOptionValueST(iAssFolNPC)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Chance that a Follower will assault a NPC when one of the Conditions are fulfilled.")
	EndEvent
EndState
; --- Assault
State FolGenderMale
	Event OnSelectST()
		bAssFolGenMal = !bAssFolGenMal
		SetToggleOptionValueST(bAssFolGenMal)
	endEvent
EndState

State FolGenderFemale
	Event OnSelectST()
		bAssFolGenFem = !bAssFolGenFem
		SetToggleOptionValueST(bAssFolGenFem)
	endEvent
EndState

State FolGenderFuta
	Event OnSelectST()
		bAssFolGenFut = !bAssFolGenFut
		SetToggleOptionValueST(bAssFolGenFut)
	endEvent
EndState

State FolGenderPet
	Event OnSelectST()
		bAssFolGenPet = !bAssFolGenPet
		SetToggleOptionValueST(bAssFolGenPet)
	endEvent
EndState

State FolPlayerAssault
	Event OnSelectST()
		bAssFolPl = !bAssFolPl
		SetToggleOptionValueST(bAssFolPl)
	EndEvent
EndState

State FolMaleAssault
	Event OnSelectST()
		bAssFolMale = !bAssFolMale
		SetToggleOptionValueST(bAssFolMale)
	EndEvent
EndState

State FolFemaleAssault
	Event OnSelectST()
		bAssFolFemale = !bAssFolFemale
		SetToggleOptionValueST(bAssFolFemale)
	EndEvent
EndState

State FolFutaAssault
	Event OnSelectST()
		bAssFolFuta = !bAssFolFuta
		SetToggleOptionValueST(bAssFolFuta)
	EndEvent
EndState

State FolMaleCreatAssault
	Event OnSelectST()
		bAssFolMaleCreat = !bAssFolMaleCreat
		SetToggleOptionValueST(bAssFolMaleCreat)
	EndEvent
EndState

State FolFemCreatAssault
	Event OnSelectST()
		bAssFolFemCreat = !bAssFolFemCreat
		SetToggleOptionValueST(bAssFolFemCreat)
	EndEvent
EndState

; ==================================
; 				States // NPC
; ==================================
State NPCAsVic
	Event OnSelectST()
		bNPCVicMaster = !bNPCVicMaster
		SetToggleOptionValueST(bNPCVicMaster)
	endEvent
EndState

State HealNPC
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iHealNPC)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iHealNPC = value as int
		SetSliderOptionValueST(iHealNPC)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How much Hp an Actor regenerates after an assault.\nSet to 0 to disable.")
	EndEvent
EndState
; --- Scenarios
State ActorScenario
	Event OnMenuOpenST()
		If(Yam_Scan.IsRunning())
			Debug.MessageBox("Combat Quest is currently running. Make sure you are out of Combat and the mod went back to \"Searching to Combat\" before changing this Setting.")
			OnMenuAcceptST(iActorScenario)
			return
		EndIf
		SetMenuDialogStartIndex(iActorScenario)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(ActorScenarioList)
	EndEvent
	Event OnMenuAcceptST(int index)
		iActorScenario = index
		SetMenuOptionValueST(ActorScenarioList[iActorScenario])
		CheckScenarioFlagsNPC()
	EndEvent
	Event OnDefaultST()
		iActorScenario = 1
		SetMenuOptionValueST(ActorScenarioList[iActorScenario])
	EndEvent
	Event OnHighlightST()
		SetInfoText("The Scenario Setting describes the general Behavior of a Knockdown. For further Information what each Scenario does, check the \"Scenarios\" MCM Page.")
	endEvent
EndState

State NPCUseGhost
	Event OnSelectST()
		bNPCUseGhost = !bNPCUseGhost
		SetToggleOptionValueST(bNPCUseGhost)
		If(bNPCUseGhost && (iActorScenario == 2 || iActorScenario == 3))
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "NPCBleedGhost")
		else
			SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCBleedGhost")
		EndIf
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true, a Victim NPC/Creature and their Aggressor receive a Ghost Flag (invincibility) duing the SL Scene ony.\nUseful to avoid Scene participants dying during the Animation. This has no visual Effect.")
	EndEvent
EndState
;Flee Scenario
State NPCFleeDur
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iNPCFleeDur)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(5, 500)
		SetSliderDialogInterval(5)
	EndEvent
	Event OnSliderAcceptST(float value)
		iNPCFleeDur = value as int
		SetSliderOptionValueST(iNPCFleeDur)
	EndEvent
	Event OnHighlightST()
		SetInfoText("For how long do NPCs flee?")
	EndEvent
EndState
;Bleedout Scenarios
State NPCBleedDur
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iNPCBleedoutDur)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 500)
		SetSliderDialogInterval(5)
	EndEvent
	Event OnSliderAcceptST(float value)
		iNPCBleedoutDur = value as int
		SetSliderOptionValueST(iNPCBleedoutDur)
	EndEvent
	Event OnHighlightST()
		SetInfoText("How long will NPCs stay in Bleedout?\nSetting this to 0 forces them to stay in Bleedout until Combat ends.")
	EndEvent
EndState

State NPCBleedGhost
	Event OnSelectST()
		bNPCBleedKeepGhost = !bNPCBleedKeepGhost
		SetToggleOptionValueST(bNPCBleedKeepGhost)
	EndEvent
	Event OnHighlightST()
		SetInfoText("If true, a NPC inside a Bleedout Scenario will keep their Ghost Flag (invincibility) until the Scenario ends. Otherwise the Flag is removed after the SL Scene ends")
	EndEvent
EndState
; --- Knock Out
State WkHpThreshholdNPC
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iWkHpThreshNPC)
		SetSliderDialogDefaultValue(50)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iWkHpThreshNPC = value as int
		SetSliderOptionValueST(iWkHpThreshNPC)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Actors will be knocked down when your Hp falls below this value.\nSet to 0 to disable.")
	EndEvent
EndState

State WkBlockOnlyNPC
	Event OnSelectST()
		bWkBlockNPC = !bWkBlockNPC
		SetToggleOptionValueST(bWkBlockNPC)
	endEvent
	Event OnHighlightST()
		SetInfoText("Only unblocked hits can knock an Actor down.")
	EndEvent
EndState

State WkMeleeOnlyNPC
	Event OnSelectST()
		bWkMeleeNPC = !bWkMeleeNPC
		SetToggleOptionValueST(bWkMeleeNPC)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Only melee hits can knock an Actor down.")
	EndEvent
EndState
; --- As Agrgessor
State PerCentNpcPl
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iAssNpcPl)
		SetSliderDialogDefaultValue(70)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iAssNpcPl = value as int
		SetSliderOptionValueST(iAssNpcPl)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Chance that a NPC/Creature will assault the Player when one of the Conditions are fulfilled.")
	EndEvent
EndState

State PerCentNPCFol
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iAssNPCFol)
		SetSliderDialogDefaultValue(70)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iAssNPCFol = value as int
		SetSliderOptionValueST(iAssNPCFol)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Chance that a NPC/Creature will assault a Follower when one of the Conditions are fulfilled.")
	EndEvent
EndState

State PerCentNPCNPC
	Event OnSliderOpenST()
		SetSliderDialogStartValue(iAssNPCNPC)
		SetSliderDialogDefaultValue(40)
		SetSliderDialogRange(0, 100)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		iAssNPCNPC = value as int
		SetSliderOptionValueST(iAssNPCNPC)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Chance that a NPC/Creature will assault a NPC/Creature when one of the Conditions are fulfilled.")
	EndEvent
EndState
; --- Assault OPtions
State MalePlayerAssault
	Event OnSelectST()
		bAssMalPl = !bAssMalPl
		SetToggleOptionValueST(bAssMalPl)
	EndEvent
EndState

State MalFollowerAssault
	Event OnSelectST()
		bAssMalFol = !bAssMalFol
		SetToggleOptionValueST(bAssMalFol)
	EndEvent
EndState

State MaleMaleAssault
	Event OnSelectST()
		bAssMalMal = !bAssMalMal
		SetToggleOptionValueST(bAssMalMal)
	endEvent
EndState

State MaleFemaleAssault
	Event OnSelectST()
		bAssMalFem = !bAssMalFem
		SetToggleOptionValueST(bAssMalFem)
	endEvent
EndState

State MaleFutaAssault
	Event OnSelectST()
		bAssMalFut = !bAssMalFut
		SetToggleOptionValueST(bAssMalFut)
	endEvent
EndState

State MaleCreatureAssault
	Event OnSelectST()
		bAssMalCreat = !bAssMalCreat
		SetToggleOptionValueST(bAssMalCreat)
	endEvent
EndState

State MaleFemCreaAssault
	Event OnSelectST()
		bAssMalFemCreat = !bAssMalFemCreat
		SetToggleOptionValueST(bAssMalFemCreat)
	endEvent
EndState

State FemalePlayerAssault
	Event OnSelectST()
		bAssFemPl = !bAssFemPl
		SetToggleOptionValueST(bAssFemPl)
	EndEvent
EndState

State FemalFollowerAssault
	Event OnSelectST()
		bAssFemFol = !bAssFemFol
		SetToggleOptionValueST(bAssFemFol)
	EndEvent
EndState

State FemaleMaleAssault
	Event OnSelectST()
		bAssFemMal = !bAssFemMal
		SetToggleOptionValueST(bAssFemMal)
	EndEvent
EndState

State FemaleFemaleAssault
	Event OnSelectST()
		bAssFemFem = !bAssFemFem
		SetToggleOptionValueST(bAssFemFem)
	EndEvent
EndState

State FemaleFutaAssault
	Event OnSelectST()
		bAssFemFut = !bAssFemFut
		SetToggleOptionValueST(bAssFemFut)
	EndEvent
EndState

State FemaleCreatureAssault
	Event OnSelectST()
		bAssFemCreat = !bAssFemCreat
		SetToggleOptionValueST(bAssFemCreat)
	EndEvent
EndState

State FemaleFemCreaAssault
	Event OnSelectST()
		bAssFemFemCreat = !bAssFemFemCreat
		SetToggleOptionValueST(bAssFemFemCreat)
	EndEvent
EndState

State FutaPlayerAssault
	Event OnSelectST()
		bAssFutPl = !bAssFutPl
		SetToggleOptionValueST(bAssFutPl)
	EndEvent
EndState

State FutaFollowerAssault
	Event OnSelectST()
		bAssFutFol = !bAssFutFol
		SetToggleOptionValueST(bAssFutFol)
	EndEvent
EndState

State FutaMaleAssault
	Event OnSelectST()
		bAssFutMal = !bAssFutMal
		SetToggleOptionValueST(bAssFutMal)
	endEvent
EndState

State FutaFemaleAssault
	Event OnSelectST()
		bAssFutFem = !bAssFutFem
		SetToggleOptionValueST(bAssFutFem)
	endEvent
EndState

State FutaFutaAssault
	Event OnSelectST()
		bAssFutFut = !bAssFutFut
		SetToggleOptionValueST(bAssFutFut)
	endEvent
EndState

State FutaCreatureAssault
	Event OnSelectST()
		bAssFutCreat = !bAssFutCreat
		SetToggleOptionValueST(bAssFutCreat)
	endEvent
EndState

State FutaFemCreaAssault
	Event OnSelectST()
		bAssFutFemCreat = !bAssFutFemCreat
		SetToggleOptionValueST(bAssFutFemCreat)
	endEvent
EndState

State MalCrPlayerAssault
	Event OnSelectST()
		bAssMalCrPl = !bAssMalCrPl
		SetToggleOptionValueST(bAssMalCrPl)
	EndEvent
EndState

State MalCrFollowerAssault
	Event OnSelectST()
		bAssMalCrFol = !bAssMalCrFol
		SetToggleOptionValueST(bAssMalCrFol)
	EndEvent
EndState

State MalCrMaleAssault
	Event OnSelectST()
		bAssMalCrMal = !bAssMalCrMal
		SetToggleOptionValueST(bAssMalCrMal)
	endEvent
EndState

State MalCrFemaleAssault
	Event OnSelectST()
		bAssMalCrFem = !bAssMalCrFem
		SetToggleOptionValueST(bAssMalCrFem)
	endEvent
EndState

State MalCrFutaAssault
	Event OnSelectST()
		bAssMalCrFut = !bAssMalCrFut
		SetToggleOptionValueST(bAssMalCrFut)
	endEvent
EndState

State MalCrCreatureAssault
	Event OnSelectST()
		bAssMalCrCreat = !bAssMalCrCreat
		SetToggleOptionValueST(bAssMalCrCreat)
	endEvent
EndState

State MalCrFemCreaAssault
	Event OnSelectST()
		bAssMalCrFemCreat = !bAssMalCrFemCreat
		SetToggleOptionValueST(bAssMalCrFemCreat)
	endEvent
EndState

State FemCrPlayerAssault
	Event OnSelectST()
		bAssFemCrPl = !bAssFemCrPl
		SetToggleOptionValueST(bAssFemCrPl)
	EndEvent
EndState

State FemCrFollowerAssault
	Event OnSelectST()
		bAssFemCrFol = !bAssFemCrFol
		SetToggleOptionValueST(bAssFemCrFol)
	EndEvent
EndState

State FemCrMaleAssault
	Event OnSelectST()
		bAssFemCrMal = !bAssFemCrMal
		SetToggleOptionValueST(bAssFemCrMal)
	endEvent
EndState

State FemCrFemaleAssault
	Event OnSelectST()
		bAssFemCrFem = !bAssFemCrFem
		SetToggleOptionValueST(bAssFemCrFem)
	endEvent
EndState

State FemCrFutaAssault
	Event OnSelectST()
		bAssFemCrFut = !bAssFemCrFut
		SetToggleOptionValueST(bAssFemCrFut)
	endEvent
EndState

State FemCrCreatureAssault
	Event OnSelectST()
		bAssFemCrCreat = !bAssFemCrCreat
		SetToggleOptionValueST(bAssFemCrCreat)
	endEvent
EndState

State FemCrFemCreaAssault
	Event OnSelectST()
		bAssFemCrFemCreat = !bAssFemCrFemCreat
		SetToggleOptionValueST(bAssFemCrFemCreat)
	endEvent
EndState

; ==================================
; 				STATES // Scenarios
; ==================================
State Scenario1
	Event OnHighlightST()
		SetInfoText("A simple Scenario without any Features:\nWhen an Actor gets knocked out, they will instantly be assaulted by whoever attacked them last. After the Scene, the Fight continues.")
	endEvent
EndState

State Scenario2
	Event OnHighlightST()
		SetInfoText("Upon Knockdown, the Victim will be assaulted by an Aggressor and afterwards, they will Flee from Combat for [Flee Duration] seconds")
	endEvent
EndState

State Scenario3
	Event OnHighlightST()
		SetInfoText("Upon Knockdown, the Victim will be assaulted by an Aggressor and afterwards, they will Bleedout for [Bleed Duration] seconds or until Combat ends.")
	EndEvent
EndState

State Scenario4
	Event OnHighlightST()
		SetInfoText("Upon Knockdown, the Victim will Bleedout for [Bleed Duration] seconds. If combat ends before they recover, they will be assaulted.")
	EndEvent
EndState
; ==================================
; 						UTILITY
; ==================================
string Function GetStatus()
	If(Yam_Scan.IsRunning())
		return "Combat Quest Active"
	ElseIf(!Core.ModPaused)
		return "Searching for Combat"
	Else
		return "Paused"
	EndIf
EndFunction

string Function GetCustomControl(int keyCode)
	if(keyCode == iPlAggrKey)
		return "Yamete: Aura of the Aggressor"
	ElseIf(KeyCode == iPauseKey)
		return "Yamete: Pause/Unpause"
	else
		return ""
	endIf
endFunction
;Assault Notify Flag
int Function NotifyColorFlag()
	If(bShowNotify)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction
;Flag for Master Settings
int Function GetFlag(string Page)
	If(Page == "General" && bUseMasterKO)
		return OPTION_FLAG_NONE
	ElseIf(Page == "General" && !bUseMasterKO)
		return OPTION_FLAG_DISABLED
	ElseIf(bUseMasterKO)
		return OPTION_FLAG_DISABLED
	Else
		return OPTION_FLAG_NONE
	EndIf
EndFunction
;Flag for Scenarios: Player
Function CheckScenarioFlagsPlayer()
	If(iPlayerScenario == 1 || iPlayerScenario == 2)
		SetOptionFlagsST(OPTION_FLAG_NONE, false, "PlayerBleedDur")
		If(bPlUseGhost)
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "PlayerBleedGhost")
		EndIf
	else
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "PlayerBleedDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "PlayerBleedGhost")
	EndIf
endFunction

int Function BleedOutFlagPlayer()
	If(iPlayerScenario == 1 || iPlayerScenario == 2)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

int Function BleedOutGhostFlagPlayer()
	If((iPlayerScenario == 1 || iPlayerScenario == 2) && bPlUseGhost)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction
;Flag for Scenarios: Follower
Function CheckScenarioFlagsFollower()
	If(iFollowerScenario == 1)
		SetOptionFlagsST(OPTION_FLAG_NONE, false, "FolFleeDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolBleedDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolBleedGhost")
	ElseIf(iFollowerScenario == 2 || iFollowerScenario == 3)
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolFleeDur")
		SetOptionFlagsST(OPTION_FLAG_NONE, false, "FolBleedDur")
		If(bFolUseGhost)
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "FolBleedGhost")
		EndIf
	else
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolFleeDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolBleedDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "FolBleedGhost")
	EndIf
endFunction

int Function FleeFlagFol()
	If(iFollowerScenario == 1)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

int Function BleedoutFlagFollower()
	If(iFollowerScenario == 2 || iFollowerScenario == 3)
		return OPTION_FLAG_NONE
	Else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

int Function BleedoutGhostFlagFollower()
	If((iFollowerScenario == 2 || iFollowerScenario == 3) && bFolUseGhost)
		return OPTION_FLAG_NONE
	Else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction
;Flag for Scenarios: NPC
Function CheckScenarioFlagsNPC()
	If(iActorScenario == 1)
		SetOptionFlagsST(OPTION_FLAG_NONE, false, "NPCFleeDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCBleedDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCBleedGhost")
	ElseIf(iActorScenario == 2 || iActorScenario == 3)
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCFleeDur")
		SetOptionFlagsST(OPTION_FLAG_NONE, false, "NPCBleedDur")
		If(bNPCUseGhost)
			SetOptionFlagsST(OPTION_FLAG_NONE, false, "NPCBleedGhost")
		EndIf
	else
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCFleeDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCBleedDur")
		SetOptionFlagsST(OPTION_FLAG_DISABLED, false, "NPCBleedGhost")
	EndIf
endFunction

int Function FleeFlagNPC()
	If(iActorScenario == 1)
		return OPTION_FLAG_NONE
	Else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

int Function BleedoutFlagNPC()
	If(iActorScenario == 2 || iActorScenario == 3)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction

int Function BleedoutGhostFlagNPC()
	If((iActorScenario == 2 || iActorScenario == 3) && bNPCUseGhost)
		return OPTION_FLAG_NONE
	else
		return OPTION_FLAG_DISABLED
	EndIf
endFunction
