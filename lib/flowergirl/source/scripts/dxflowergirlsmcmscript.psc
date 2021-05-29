Scriptname dxFlowerGirlsMCMScript extends SKI_ConfigBase

dxFlowerGirlsMod Property FlowerGirlsMod Auto
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto

string[] sSexualPreference
string[] sStrapOnModels
string[] sSceneDuration

; SCRIPT VERSION ----------------------------------------------------------------------------------
;
; History
;
; 1 - Initial version
; 2 - Added additional duration options

; @overrides SKI_ConfigBase
int function GetVersion()
	return 2
endFunction

; @implements SKI_QuestBase
event OnVersionUpdate(int version)
{Called when a version update of this script has been detected}
	; Version 2 update to durations
	if (version >= 2 && CurrentVersion <= 2)
		sSceneDuration = new string[7]
		sSceneDuration[0] = "$Very Short"
		sSceneDuration[1] = "$Short"
		sSceneDuration[2] = "$Medium"
		sSceneDuration[3] = "$Long"
		sSceneDuration[4] = "$Very Long"
		sSceneDuration[5] = "$Extremely Long"
		sSceneDuration[6] = "$Ultra Long"
	endIf
endEvent

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[5]
	Pages[0] = "$Main Options"
	Pages[1] = "$Scene Options"
	Pages[2] = "$Animation Options"
	Pages[3] = "$Hotkeys"
	Pages[4] = "$Mod Options"
	
	sSexualPreference = new string[3]
	sSexualPreference[0] = "$Bi-Sexual"
	sSexualPreference[1] = "$Straight"
	sSexualPreference[2] = "$Gay"
	
	sStrapOnModels = new string[2]
	sStrapOnModels[0] = "CBBE"
	sStrapOnModels[1] = "UNP"
	
	sSceneDuration = new string[7]
	sSceneDuration[0] = "$Very Short"
	sSceneDuration[1] = "$Short"
	sSceneDuration[2] = "$Medium"
	sSceneDuration[3] = "$Long"
	sSceneDuration[4] = "$Very Long"
	sSceneDuration[5] = "$Extremely Long"
	sSceneDuration[6] = "$Ultra Long"
endEvent

; @implements SKI_ConfigBase
event OnPageReset(string page)
	{Called when a new page is selected, including the initial empty page}
	
	if (page == "")
		; Add splash image
	elseIf (page == Pages[0])	;------------------------------------------ Main Options
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Features")
		oidEnableAnimations = AddToggleOption("$Enable animations", FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.GetValueInt())
		oidCharging = AddToggleOption("$Service charge", FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.GetValueInt())
		oidLoversComfort = AddToggleOption("$Enhanced lover's comfort", FlowerGirlsConfig.DX_USE_COMFORT.GetValueInt())
		oidArrest = AddToggleOption("$Enhanced crime", FlowerGirlsConfig.DX_USE_ARREST.GetValueInt())
		oidBeggars = AddToggleOption("$Enhanced begging", FlowerGirlsConfig.DX_USE_BEGGARS.GetValueInt())
		AddEmptyOption()
		AddHeaderOption("$Seduction")
		bool bSeduction = FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt()
		int iSeductionFlag = OPTION_FLAG_DISABLED
		if (bSeduction)
			iSeductionFlag = OPTION_FLAG_NONE
		endIf
		oidSeduction = AddToggleOption("$Enable seduction", bSeduction)
		oidMoreKissing = AddToggleOption("$More kissing", FlowerGirlsConfig.DX_MORE_KISSING.GetValueInt(), iSeductionFlag)
		oidHellos = AddToggleOption("$Seduction hellos", FlowerGirlsConfig.DX_USE_HELLOS.GetValueInt(), iSeductionFlag)
		oidSexualPreference = AddMenuOption("$Sexual preference:", sSexualPreference[FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.GetValueInt()])
		
		SetCursorPosition(1)
		AddHeaderOption("$Roles")
		
		int iLes = FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt()
		int iLesFlag = OPTION_FLAG_NONE
		if (iLes == 0)
			iLesFlag = OPTION_FLAG_HIDDEN
		endIf
		oidFemaleInMaleRole = AddToggleOption("$Allow female in male role", iLes)
		oidLesbianAnimations = AddToggleOption("$Enable lesbian animations", FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt(), iLesFlag)
		
		int iStrapOn = FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt()
		int iStrapOnMdl = 0
		bool bStrapOn = False
		int iStrapFlag = OPTION_FLAG_HIDDEN
		if (iStrapOn == 1)
			iStrapOnMdl = 1
			bStrapOn = True
			iStrapFlag = OPTION_FLAG_NONE
		elseIf (iStrapOn == 2)
			iStrapOnMdl = 0
			bStrapOn = True
			iStrapFlag = OPTION_FLAG_NONE
		endIf
		oidUseStrapOn = AddToggleOption("$Enable strap-on for females", bStrapOn)
		oidUseStrapOnCBBE = AddMenuOption("$Strap-on model:", sStrapOnModels[iStrapOnMdl], iStrapFlag)
		
	elseIf (page == Pages[1])	;------------------------------------------ Scene Options
	
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Scene Settings")
		oidUseKissing = AddToggleOption("$Use kissing", FlowerGirlsConfig.DX_USE_KISSES.GetValueInt())
		oidScaling = AddToggleOption("$Scale actors", FlowerGirlsConfig.DX_USE_SCALING.GetValueInt())
		oidLighting = AddToggleOption("$Actor scene lighting", FlowerGirlsConfig.DX_SCENE_LIGHTING.GetValueInt())
		oidDuration = AddMenuOption("$Scene duration:",  sSceneDuration[FlowerGirlsConfig.DX_SCENE_DURATION.GetValueInt()])
		
		AddEmptyOption()
		AddHeaderOption("$Stripping")
		int i = FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt()
		bool bStripPlayer = False
		bool bStripNpc = False
		If (i == 1)
			bStripPlayer = True
			bStripNpc = True
		elseIf (i == 2)
			bStripPlayer = True
		elseIf (i == 3)
			bStripNpc = True
		endIf
		oidStripPlayer = AddToggleOption("$Strip player", bStripPlayer)
		oidStripNpcs = AddToggleOption("$Strip NPC's", bStripNpc)
		
		SetCursorPosition(1)
		AddHeaderOption("$Sounds")
		int iSnds = FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.GetValueInt()
		int iSoundsFlag = OPTION_FLAG_HIDDEN
		if (iSnds == 1)
			iSoundsFlag = OPTION_FLAG_NONE
		endIf
		oidSound = AddToggleOption("$Scene sounds", iSnds)
		
		int iSndOpts = FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt()
		bool bSoundsMale = False
		bool bSoundsFemale = False
		if (iSndOpts == 0)
			bSoundsMale = True
			bSoundsFemale = True
		elseIf (iSndOpts == 1)
			bSoundsFemale = True
		elseIf (iSndOpts == 2)
			bSoundsMale = True
		endIf
		oidSoundMale = AddToggleOption("$Enable male voices", bSoundsMale, iSoundsFlag)
		oidSoundFemale = AddToggleOption("$Enable female voices", bSoundsFemale, iSoundsFlag)
		
		AddEmptyOption()
		AddHeaderOption("$Cinematics")
		
		int iCineOpts = FlowerGirlsConfig.DX_CINEMATIC.GetValueInt()
		bool bCineEnabled = False
		if (iCineOpts > 0)
			bCineEnabled = True
		endIf
		int iCineFlag = OPTION_FLAG_NONE
		bool bCineStart = False
		bool bCineEnd = False
		if (iCineOpts == 0)
			iCineFlag = OPTION_FLAG_HIDDEN
		elseIf (iCineOpts == 1)
			bCineStart = True
			bCineEnd = True
		elseIf (iCineOpts == 2)
			bCineStart = True
		elseIf (iCineOpts == 3)
			bCineEnd = True
		endIf		
		oidCinematic = AddToggleOption("$Enable Cinematic effect", bCineEnabled)
		oidCinematicStart = AddToggleOption("$Fade scene start", bCineStart, iCineFlag)
		oidCinematicEnd = AddToggleOption("$Fade scene ending", bCineEnd, iCineFlag)
		
	elseIf (page == Pages[2])	;------------------------------------------ Animation Options
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$Animation Options")
		AddTextOption("This section will allow animations to be ", "")
		AddTextOption("included/excluded.. coming soon..", "")
		
	elseIf (page == Pages[3])	;------------------------------------------ Hotkeys
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$General Hotkeys")
		int iPapyFlag = OPTION_FLAG_DISABLED
		int iWarnFlag = OPTION_FLAG_NONE
		string sWarn = "$(Requires PapyrusUtil SE)"
		if (FlowerGirlsConfig.DX_VR_Mode.GetValueInt())
			sWarn = "$(Not available in VR)"
		else
			if (FlowerGirlsMod.PapyrusUtilsInstalled)
				iPapyFlag = OPTION_FLAG_NONE
				iWarnFlag = OPTION_FLAG_HIDDEN
			endIf
		endIf
		oidToggleFreecam = AddKeyMapOption("$Toggle Freecam: ", FlowerGirlsConfig.KeycodeToggleFreecam, iPapyFlag)
		oidToggleFreecamSpd = AddSliderOption("$Freecam speed:", FlowerGirlsConfig.FreecamSpeed, "{1}", iPapyFlag)
		AddTextOption(sWarn, "", iWarnFlag)
		AddEmptyOption()
		AddHeaderOption("$Scene Hotkeys")
		oidAdvanceStage = AddKeyMapOption("$Advance stage: ", FlowerGirlsConfig.KeycodeAdvanceStage)
		oidEndScene = AddKeyMapOption("$End scene: ", FlowerGirlsConfig.KeycodeEndScene)
		
	elseIf (page == Pages[4])	;------------------------------------------ Mod Options
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$FG_HEAD_ModControl")
		oidDebugMode = AddToggleOption("$Enable Debug Mode for FG", FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt())
		oidOptionalSpells = AddToggleOption("$Use the optional spells", FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.GetValueInt())
		
		AddEmptyOption()
		AddHeaderOption("$FG_HEAD_Restart")
		oidRestartFG = AddTextOption("-[ Restart FG ]- ", "                      ")
		
		AddEmptyOption()
		AddHeaderOption("$FG_HEAD_Uninstall")
		oidUninstallFG = AddTextOption("-[ Un-install FG ]- ", "                        ")
		
		SetCursorPosition(1)
		AddHeaderOption("$Info")
		AddTextOption("$FG Version: ", FlowerGirlsMod.Version)
		string sAmorous = "$False"
		if (FlowerGirlsMod.AmorousAdventuresInstalled)
			sAmorous = "$True"
		endIf
		AddTextOption("$Amorous Adventures installed: ", sAmorous)
		string sOsa = "$False"
		if (FlowerGirlsMod.OsaInstalled)
			sOsa = "$True"
		endIf
		AddTextOption("$OSA/Osex installed: ", sOsa)
		string sPapyrusUtils = "$False"
		if (FlowerGirlsMod.PapyrusUtilsInstalled)
			sPapyrusUtils = "$True"
		endIf
		AddTextOption("$PapyrusUtil SE Installed: ", sPapyrusUtils)
	endIf
	
endEvent

event OnOptionSelect(int option)
	bool bVal = False
	if (CurrentPage == Pages[0])	;------------------------------------------ MAIN Options
	
		if (option == oidEnableAnimations)
			bVal = !FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.GetValueInt()
			FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.SetValueInt(bVal as int)
			SetToggleOptionValue(oidEnableAnimations, bVal)
		elseIf (option == oidCharging)
			bVal = !FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.GetValueInt()
			FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.SetValueInt(bVal as int)
			SetToggleOptionValue(oidCharging, bVal)
		elseIf (option == oidLoversComfort)
			bVal = !FlowerGirlsConfig.DX_USE_COMFORT.GetValueInt()
			FlowerGirlsConfig.DX_USE_COMFORT.SetValueInt(bVal as int)
			SetToggleOptionValue(oidLoversComfort, bVal)
		elseIf (option == oidArrest)
			bVal = !FlowerGirlsConfig.DX_USE_ARREST.GetValueInt()
			FlowerGirlsConfig.DX_USE_ARREST.SetValueInt(bVal as int)
			SetToggleOptionValue(oidArrest, bVal)
		elseIf (option == oidBeggars)
			bVal = !FlowerGirlsConfig.DX_USE_BEGGARS.GetValueInt()
			FlowerGirlsConfig.DX_USE_BEGGARS.SetValueInt(bVal as int)
			SetToggleOptionValue(oidBeggars, bVal)
		elseIf (option == oidSeduction)
			bVal = !FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt()
			FlowerGirlsConfig.DX_IMMERSION_OPTIONS.SetValueInt(bVal as int)
			int iSeductionFlag = OPTION_FLAG_DISABLED
			if (bVal)
				iSeductionFlag = OPTION_FLAG_NONE
			endIf
			SetOptionFlags(oidMoreKissing, iSeductionFlag, True)
			SetOptionFlags(oidHellos, iSeductionFlag, True)
			SetToggleOptionValue(oidSeduction, bVal)
		elseIf (option == oidMoreKissing)
			bVal = !FlowerGirlsConfig.DX_MORE_KISSING.GetValueInt()
			FlowerGirlsConfig.DX_MORE_KISSING.SetValueInt(bVal as int)
			SetToggleOptionValue(oidMoreKissing, bVal)
		elseIf (option == oidHellos)
			bVal = !FlowerGirlsConfig.DX_USE_HELLOS.GetValueInt()
			FlowerGirlsConfig.DX_USE_HELLOS.SetValueInt(bVal as int)
			SetToggleOptionValue(oidHellos, bVal)
		elseIf (option == oidFemaleInMaleRole)
			bVal = !FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt()
			FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.SetValueInt(bVal as int)
			if (bVal)
				SetOptionFlags(oidLesbianAnimations, OPTION_FLAG_NONE, True)
			else
				SetOptionFlags(oidLesbianAnimations, OPTION_FLAG_HIDDEN, True)
			endIf
			SetToggleOptionValue(oidFemaleInMaleRole, bVal)
		elseIf (option == oidLesbianAnimations)
			bVal = !FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt()
			FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.SetValueInt(bVal as int)
			SetToggleOptionValue(oidLesbianAnimations, bVal)
		elseIf (option == oidUseStrapOn)
			int iStrapOn = FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt()
			int iStrapOnNew = 0
			bool bStrapOn = False
			int iStrapFlag = OPTION_FLAG_HIDDEN
			if (iStrapOn == 0)
				iStrapOnNew = 2
				bStrapOn = True
				iStrapFlag = OPTION_FLAG_NONE
			elseIf (iStrapOn >= 1)
				iStrapOnNew = 0
				bStrapOn = False
				iStrapFlag = OPTION_FLAG_DISABLED
			endIf
			FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(iStrapOnNew)
			SetOptionFlags(oidUseStrapOnCBBE, iStrapFlag, True)
			SetToggleOptionValue(oidUseStrapOn, bStrapOn)
		endIf
		
	elseIf (CurrentPage == Pages[1])	;------------------------------------------ SCENE OPTIONS
	
		if (option == oidUseKissing)
			bVal = !FlowerGirlsConfig.DX_USE_KISSES.GetValueInt()
			FlowerGirlsConfig.DX_USE_KISSES.SetValueInt(bVal as int)
			SetToggleOptionValue(oidUseKissing, bVal)
		elseIf (option == oidScaling)
			bVal = !FlowerGirlsConfig.DX_USE_SCALING.GetValueInt()
			FlowerGirlsConfig.DX_USE_SCALING.SetValueInt(bVal as int)
			SetToggleOptionValue(oidScaling, bVal)
		elseIf (option == oidLighting)
			bVal = !FlowerGirlsConfig.DX_SCENE_LIGHTING.GetValueInt()
			FlowerGirlsConfig.DX_SCENE_LIGHTING.SetValueInt(bVal as int)
			SetToggleOptionValue(oidLighting, bVal)
			
		elseIf (option == oidStripPlayer)
			int i = FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt()
			if (i == 0)	; Turn on stripping for player
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(2)
				bVal = True
			elseIf (i == 1) ; Turn off
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(3)
			elseIf (i == 2)
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(0)
			elseIf (i == 3)
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(1)
				bVal = True
			endIf
			SetToggleOptionValue(oidStripPlayer, bVal)
		elseIf (option == oidStripNpcs)
			int i = FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt()
			if (i == 0)	; Turn on stripping for npcs
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(3)
				bVal = True
			elseIf (i == 1) ; Turn off
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(2)
			elseIf (i == 2)
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(1)
			elseIf (i == 3)
				FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(0)
				bVal = True
			endIf
			SetToggleOptionValue(oidStripNpcs, bVal)
			
		elseIf (option == oidSound)
			bVal = !FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.GetValueInt()
			FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.SetValueInt(bVal as int)
			if (bVal)
				SetOptionFlags(oidSoundMale, OPTION_FLAG_NONE, True)
				SetOptionFlags(oidSoundFemale, OPTION_FLAG_NONE, True)
			else
				SetOptionFlags(oidSoundMale, OPTION_FLAG_DISABLED, True)
				SetOptionFlags(oidSoundFemale, OPTION_FLAG_DISABLED, True)
			endIf
			SetToggleOptionValue(oidSound, bVal)
		elseIf (option == oidSoundMale)
			int iSounds = FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt()
			if (iSounds == 0)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(1)
			elseIf (iSounds == 1)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(0)
				bVal = True
			elseIf (iSounds == 2)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(3)
			elseIf (iSounds == 3)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(2)
				bVal = True
			endIf
			SetToggleOptionValue(oidSoundMale, bVal)
		elseIf (option == oidSoundFemale)
			int iSounds = FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt()
			if (iSounds == 0)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(2)
			elseIf (iSounds == 1)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(3)
			elseIf (iSounds == 2)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(0)
				bVal = True
			elseIf (iSounds == 3)
				FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(1)
				bVal = True
			endIf
			SetToggleOptionValue(oidSoundFemale, bVal)
			
		elseIf (option == oidCinematic)
			int iCineOpts = FlowerGirlsConfig.DX_CINEMATIC.GetValueInt()
			int iCineFlag = OPTION_FLAG_NONE
			if (iCineOpts == 0)
				iCineOpts = 1
			else
				iCineOpts = 0
				iCineFlag = OPTION_FLAG_HIDDEN
			endIf
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(iCineOpts)
			SetOptionFlags(oidCinematicStart, iCineFlag, True)
			SetOptionFlags(oidCinematicEnd, iCineFlag, True)
			SetToggleOptionValue(oidCinematic, iCineOpts)
			
		elseIf (option == oidCinematicStart)
			int iCineOpts = FlowerGirlsConfig.DX_CINEMATIC.GetValueInt()
			if (iCineOpts == 0)
				iCineOpts = 2
				bVal = True
			elseIf (iCineOpts == 1)
				iCineOpts = 3
			elseIf (iCineOpts == 2)
				iCineOpts = 0
			elseIf (iCineOpts == 3)
				iCineOpts = 1
				bVal = True
			endIf
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(iCineOpts)
			SetToggleOptionValue(oidCinematicStart, bVal)
		elseIf (option == oidCinematicEnd)
			int iCineOpts = FlowerGirlsConfig.DX_CINEMATIC.GetValueInt()
			if (iCineOpts == 0)
				iCineOpts = 3
				bVal = True
			elseIf (iCineOpts == 1)
				iCineOpts = 2
			elseIf (iCineOpts == 2)
				iCineOpts = 1
				bVal = True
			elseIf (iCineOpts == 3)
				iCineOpts = 0
			endIf
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(iCineOpts)
			SetToggleOptionValue(oidCinematicEnd, bVal)
		endIf
	
	elseIf (CurrentPage == Pages[2])	;------------------------------------------ ANIMATION OPTIONS
	
	elseIf (CurrentPage == Pages[3])	;------------------------------------------ HOTKEYS
	
	elseIf (CurrentPage == Pages[4])	;------------------------------------------ MOD OPTIONS
	
		if (option == oidDebugMode)
			bVal = !FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt()
			FlowerGirlsConfig.DX_DEBUG_MODE.SetValueInt(bVal as int)
			SetToggleOptionValue(oidDebugMode, bVal)
		elseIf (option == oidOptionalSpells)
			bVal = !FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.GetValueInt()
			FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.SetValueInt(bVal as int)
			if (bVal)
				FlowerGirlsMod.AddFlowerGirlSpells()
			else
				FlowerGirlsMod.RemoveOptionalSpells()
			endIf
			SetToggleOptionValue(oidOptionalSpells, bVal)
		elseIf (option == oidRestartFG)
			SetTextOptionValue(oidRestartFG, "$FG is restarting..")
			FlowerGirlsMod.RestartFlowerGirls()
		elseIf (option == oidUninstallFG)
			SetTextOptionValue(oidUninstallFG, "$Un-installing FG..")
			FlowerGirlsMod.UninstallFlowerGirls()
		endIf
	endIf
	
endEvent

event OnOptionDefault(int option)
	if (option == oidEnableAnimations)
		FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.SetValueInt(1)
		SetToggleOptionValue(oidEnableAnimations, True)
	elseIf (option == oidCharging)
		FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.SetValueInt(1)
		SetToggleOptionValue(oidCharging, True)
	elseIf (option == oidLoversComfort)
		FlowerGirlsConfig.DX_USE_COMFORT.SetValueInt(1)
		SetToggleOptionValue(oidLoversComfort, True)
	elseIf (option == oidArrest)
		FlowerGirlsConfig.DX_USE_ARREST.SetValueInt(1)
		SetTextOptionValue(oidArrest, True)
	elseIf (option == oidBeggars)
		FlowerGirlsConfig.DX_USE_BEGGARS.SetValueInt(1)
		SetTextOptionValue(oidBeggars, True)
	elseIf (option == oidSeduction)
		FlowerGirlsConfig.DX_IMMERSION_OPTIONS.SetValueInt(1)
		SetToggleOptionValue(oidSeduction, True)
	elseIf (option == oidMoreKissing)
		FlowerGirlsConfig.DX_MORE_KISSING.SetValueInt(0)
		SetToggleOptionValue(oidMoreKissing, False)
	elseIf (option == oidHellos)
		FlowerGirlsConfig.DX_USE_HELLOS.SetValueInt(1)
		SetToggleOptionValue(oidHellos, True)
	elseIf (option == oidUseKissing)
		FlowerGirlsConfig.DX_USE_KISSES.SetValueInt(1)
		SetToggleOptionValue(oidUseKissing, True)
	elseIf (option == oidScaling)
		FlowerGirlsConfig.DX_USE_SCALING.SetValueInt(1)
		SetToggleOptionValue(oidScaling, True)
	elseIf (option == oidStripPlayer)
		FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(1)
		SetToggleOptionValue(oidStripPlayer, True)
	elseIf (option == oidStripNpcs)
		SetToggleOptionValue(oidStripNpcs, True)
	endIf
endEvent

event OnOptionMenuOpen(int option)
	if (option == oidSexualPreference)
		SetMenuDialogStartIndex(FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.GetValueInt())
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(sSexualPreference)
	elseIf (option == oidUseStrapOnCBBE)
		int iStrapOn = FlowerGirlsConfig.DX_USE_STRAPON.GetValueInt()
		int iStrapOnMdl = 0
		if (iStrapOn == 1)
			iStrapOnMdl = 1
		elseIf (iStrapOn == 2)
			iStrapOnMdl = 0
		endIf
		SetMenuDialogStartIndex(iStrapOnMdl)
		SetMenuDialogOptions(sStrapOnModels)
		SetMenuDialogDefaultIndex(0)
	elseIf (option == oidDuration)
		SetMenuDialogStartIndex(FlowerGirlsConfig.DX_SCENE_DURATION.GetValueInt())
		SetMenuDialogDefaultIndex(2)
		SetMenuDialogOptions(sSceneDuration)
	endIf
endEvent

event OnOptionMenuAccept(int option, int index)
	if (option == oidSexualPreference)
		FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.SetValueInt(index)
		SetMenuOptionValue(oidSexualPreference, sSexualPreference[index])
	elseIf (option == oidUseStrapOnCBBE)
		if (index == 0)
			FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(2)
		else
			FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(1)
		endIf
		SetMenuOptionValue(oidUseStrapOnCBBE, sStrapOnModels[index])
	elseIf (option == oidDuration)
		FlowerGirlsConfig.DX_SCENE_DURATION.SetValueInt(index)
		SetMenuOptionValue(oidDuration, sSceneDuration[index])
	endIf
endEvent

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if (option == oidToggleFreecam)
		if (CheckKey(conflictControl, conflictName))
			FlowerGirlsConfig.KeycodeToggleFreecam = keyCode
			SetKeyMapOptionValue(oidToggleFreecam, keyCode)
		endIf
	elseIf (option == oidAdvanceStage)
		if (CheckKey(conflictControl, conflictName))
			FlowerGirlsConfig.KeycodeAdvanceStage = keyCode
			SetKeyMapOptionValue(oidAdvanceStage, keyCode)
		endIf
	elseIf (option == oidEndScene)
		if (CheckKey(conflictControl, conflictName))
			FlowerGirlsConfig.KeycodeEndScene = keyCode
			SetKeyMapOptionValue(oidEndScene, keyCode)
		endIf
	endIf
endEvent

event OnOptionSliderOpen(int option)
	if (option == oidToggleFreecamSpd)
		SetSliderDialogRange(1.0, 20.0)
		SetSliderDialogInterval(0.5)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogStartValue(FlowerGirlsConfig.FreecamSpeed)
	endIf
endEvent

event OnOptionSliderAccept(int option, float value)
	if (option == oidToggleFreecamSpd)
		FlowerGirlsConfig.FreecamSpeed = value
		SetSliderOptionValue(oidToggleFreecamSpd, value, "{1}")
	endIf
endEvent

string function GetCustomControl(int keyCode)
	if (keyCode == FlowerGirlsConfig.KeycodeToggleFreecam)
		return "FlowerGirls: Toggle Freecam Key"
	elseIf (keyCode == FlowerGirlsConfig.KeycodeAdvanceStage)
		return "FlowerGirls: Advance Stage Key"
	elseIf (keyCode == FlowerGirlsConfig.KeycodeEndScene)
		return "FlowerGirls: End Scene Key"
	else
		return ""
	endIf
endFunction

bool Function CheckKey(string conflictControl, string conflictName)
	if (conflictControl != "")
		string msg
		if (conflictName != "")
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
		else
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
		endIf
		return ShowMessage(msg, true, "$Yes", "$No")
	endIf
	return True
endFunction

event OnOptionHighlight(int option)
	if (CurrentPage == Pages[0])	;------------------------------------------ Main Options
	
		if (option == oidEnableAnimations)
			SetInfoText("$FG_INFO_Anims")
		elseIf (option == oidCharging)
			SetInfoText("$FG_INFO_Charging")
		elseIf (option == oidLoversComfort)
			SetInfoText("$FG_INFO_Lovers")
		elseIf (option == oidArrest)
			SetInfoText("$FG_INFO_Crime")
		elseIf (option == oidBeggars)
			SetInfoText("$FG_INFO_Beggars")
		elseIf (option == oidSeduction)
			SetInfoText("$FG_INFO_Seduction")
		elseIf (option == oidMoreKissing)
			SetInfoText("$FG_INFO_MoreKissing")
		elseIf (option == oidHellos)
			SetInfoText("$FG_INFO_Hellos")
		elseIf (option == oidSexualPreference)
			SetInfoText("$FG_INFO_SexualPreference")
		elseIf (option == oidFemaleInMaleRole)
			SetInfoText("$FG_INFO_FemaleInMaleRole")
		elseIf (option == oidLesbianAnimations)
			SetInfoText("$FG_INFO_LesbianAnims")
		elseIf (option == oidUseStrapOn)
			SetInfoText("$FG_INFO_StrapOn")
		elseIf (option == oidUseStrapOnCBBE)
			SetInfoText("$FG_INFO_StrapOnCBBE")
		endIf
	
	elseIf (CurrentPage == Pages[1])	;------------------------------------------ Scene Options
	
		if (option == oidUseKissing)
			SetInfoText("$FG_INFO_Kissing")
		elseIf (option == oidScaling)
			SetInfoText("$FG_INFO_Scaling")
		elseIf (option == oidDuration)
			SetInfoText("$FG_INFO_Duration")
		elseIf (option == oidStripPlayer)
			SetInfoText("$FG_INFO_StripPlayer")
		elseIf (option == oidStripNpcs)
			SetInfoText("$FG_INFO_StripNpc")
		elseIf (option == oidSound)
			SetInfoText("$FG_INFO_Sound")
		elseIf (option == oidSoundMale)
			SetInfoText("$FG_INFO_SoundMale")
		elseIf (option == oidSoundFemale)
			SetInfoText("$FG_INFO_SoundFemale")
		elseIf (option == oidLighting)
			SetInfoText("$FG_INFO_Lighting")
		elseIf (option == oidCinematic)
			SetInfoText("$FG_INFO_Cinematic")
		elseIf (option == oidCinematicStart)
			SetInfoText("$FG_INFO_FadeStart")
		elseIf (option == oidCinematicEnd)
			SetInfoText("$FG_INFO_FadeEnd")
		endIf
	
	elseIf (CurrentPage == Pages[2])	;------------------------------------------ Animation Options
		
	elseIf (CurrentPage == Pages[3])	;------------------------------------------ Hotkeys
		
	if (option == oidToggleFreecam)
		SetInfoText("$FG_INFO_Freecam")
	elseIf (option == oidToggleFreecamSpd)
		SetInfoText("$FG_INFO_FreecamSpeed")
	elseIf (option == oidAdvanceStage)
		SetInfoText("$FG_INFO_AdvanceStage")
	elseIf (option == oidEndScene)
		SetInfoText("$FG_INFO_EndScene")
	endIf	
	
	elseIf (CurrentPage == Pages[4])	;------------------------------------------ Mod Options
	
		if (option == oidDebugMode)
			SetInfoText("$FG_INFO_Debug")
		elseIf (option == oidOptionalSpells)
			SetInfoText("$FG_INFO_OptionalSpells")
		elseIf (option == oidRestartFG)
			SetInfoText("$FG_INFO_Restart")
		elseIf (option == oidUninstallFG)
			SetInfoText("$FG_INFO_Uninstall")
		endIf
	endIf
endEvent

;----------------------------------------------------------------------------
; OID's for SkyUI
;----------------------------------------------------------------------------

int oidEnableAnimations = 0
int oidUseKissing = 0
int oidCharging = 0
int oidLoversComfort = 0
int oidArrest = 0
int oidBeggars = 0
int oidSeduction = 0
int oidHellos = 0
int oidMoreKissing = 0
int oidSexualPreference = 0
int oidFemaleInMaleRole = 0
int oidLesbianAnimations = 0
int oidUseStrapOn = 0
int oidUseStrapOnCBBE = 0

int oidScaling = 0
int oidCinematic = 0
int oidCinematicStart = 0
int oidCinematicEnd = 0
int oidSound = 0
int oidSoundMale = 0
int oidSoundFemale = 0
int oidDuration = 0
int oidStripPlayer = 0
int oidStripNpcs = 0
int oidLighting = 0

int oidToggleFreecam = 0
int oidToggleFreecamSpd = 0
int oidAdvanceStage = 0
int oidEndScene = 0

int oidDebugMode = 0
int oidOptionalSpells = 0
int oidRestartFG = 0
int oidUninstallFG = 0