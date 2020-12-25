Scriptname SSLV_ConfigScr extends ski_configbase  

;..
;set variables

bool SD_Installed
bool QAYL_Installed
bool DevCidhna_Installed
bool WClub_Installed
bool SoT_Installed
bool ME_Installed
bool CD_Installed
bool HiD_Installed
bool SLUTS_Installed
bool Submissive_Installed
bool Slaverun_Installed
bool Lola_Installed
bool Isle_Installed
bool DCUR_Installed
bool Raven_Installed
bool Mia_Installed
bool Stories_Installed
bool Things_Installed
bool DFollowers_Installed
bool WWBBrothel_Installed

bool property SD_Enabled = false auto hidden
bool property QAYL_Enabled = false auto hidden
bool property DevCidhna_Enabled = false auto hidden
bool property WClub_Enabled = false auto hidden
bool property SoT_Enabled = false auto hidden
bool property ME_Enabled = false auto hidden
bool property CD_Enabled = false auto hidden
bool property HiD_Enabled = false auto hidden
bool property SLUTS_Enabled = false auto hidden
bool property Submissive_Enabled = false auto hidden
bool property Slaverun_Enabled = false auto hidden
bool property Lola_Enabled = false auto hidden
bool property Isle_Enabled = false auto hidden
bool property DCUR_Bondage_Enabled = false auto hidden
bool property DCUR_Damsel_Enabled = false auto hidden
bool property DCUR_Doll_Enabled = false auto hidden
bool property DCUR_Collar_Enabled = false auto hidden
bool property Raven_Enabled = false auto hidden
bool property Mia_Enabled = false auto hidden
bool property DCUR_Leon_Enabled = false auto hidden
bool property DCUR_Leah_Enabled = false auto hidden
bool property Stories_Enabled = false auto hidden
bool property Things_Enabled = false auto hidden
bool property DFollowers_Enabled = false auto hidden
bool property WWBBrothel_Enabled = false auto hidden

; 0: Never (Always Blackout)
; 1: In City (When the player is actually in Riften)
; 2: Nearby (When Riften is the nearest City)
; 3: Distant (Riverwood to Windhelm)
; 4: Always (even from Markarth)
int property iWalkToLocations = 3 auto hidden

int iSD_Enabled
int iQAYL_Enabled
int iDevCidhna_Enabled
int iWClub_Enabled
int iSoT_Enabled
int iME_Enabled
int iCD_Enabled
int iHiD_Enabled
int iSLUTS_Enabled
int iSubmissive_Enabled
int iSlaverun_Enabled
int iLola_Enabled
int iIsle_Enabled
int iDCUR_Bondage_Enabled
int iDCUR_Damsel_Enabled
int iDCUR_Doll_Enabled
int iDCUR_Collar_Enabled
int iDCUR_Leon_Enabled
int iDCUR_Leah_Enabled
int iRaven_Enabled
int iMia_Enabled
int iStories_Enabled
int iThings_Enabled
int iDFollowers_Enabled
int iWWBBrothel_Enabled

int function GetVersion()
	return 5
endfunction

event OnVersionUpdate(int a_version)
	if(a_version > 1)
		Debug.Notification("Simple Slavery Update version: " + a_version)
		OnConfigInit()
	endif
endevent

event OnGameReload()
	parent.OnGameReload()
	VerifyInstallation()
	SSLV_MainScr qMainQuest = (Quest.GetQuest("SimpleSlavery") As SSLV_MainScr)
	if (qMainQuest)
		qMainQuest.CheckScriptUpdate()
	endif
endevent

event OnConfigInit()
	Pages = new string[1]
	Pages[0] = "Settings"
	VerifyInstallation()
endevent

event OnPageReset(string a_page)
SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("Installed")
		SetCursorPosition(1)
		AddHeaderOption("Not installed")
		int IStalled = 2
		int Unstalled = 3
		if(SD_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iSD_Enabled = AddToggleOption("SD+", SD_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			SD_Enabled = false
			iSD_Enabled = AddToggleOption("SD+", SD_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(QAYL_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iQAYL_Enabled = AddToggleOption("Quick As You Like", QAYL_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			QAYL_Enabled = false
			iQAYL_Enabled = AddToggleOption("Quick As You Like", QAYL_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(DevCidhna_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iDevCidhna_Enabled = AddToggleOption("Devious Cidhna", DevCidhna_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			DevCidhna_Enabled = false
			iDevCidhna_Enabled = AddToggleOption("Devious Cidhna", DevCidhna_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(WClub_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iWClub_Enabled = AddToggleOption("Wolf Club", WClub_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			WClub_Enabled = false
			iWClub_Enabled = AddToggleOption("Wolf Club", WClub_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(SoT_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iSoT_Enabled = AddToggleOption("Slaves of Tamriel", SoT_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			SoT_Enabled = false
			iSoT_Enabled = AddToggleOption("Slaves of Tamriel", SoT_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(ME_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iME_Enabled = AddToggleOption("Maria Eden", ME_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			ME_Enabled = false
			iME_Enabled = AddToggleOption("Maria Eden", ME_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(CD_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iCD_Enabled = AddToggleOption("Captured Dreams", CD_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			CD_Enabled = false
			iCD_Enabled = AddToggleOption("Captured Dreams", CD_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(HiD_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iHiD_Enabled = AddToggleOption("Heroine in Distress", HiD_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			HiD_Enabled = false
			iHiD_Enabled = AddToggleOption("Heroine in Distress", HiD_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(SLUTS_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iSLUTS_Enabled = AddToggleOption("S.L.U.T.S.", SLUTS_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			SLUTS_Enabled = false
			iSLUTS_Enabled = AddToggleOption("S.L.U.T.S.", SLUTS_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Submissive_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iSubmissive_Enabled = AddToggleOption("Player Submissive (Legacy)", Submissive_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Submissive_Enabled = false
			iSubmissive_Enabled = AddToggleOption("Player Submissive (Legacy)", Submissive_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Slaverun_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iSlaverun_Enabled = AddToggleOption("Slaverun Reloaded", Slaverun_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Slaverun_Enabled = false
			iSlaverun_Enabled = AddToggleOption("Slaverun Reloaded", Slaverun_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Lola_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iLola_Enabled = AddToggleOption("Submissive Lola", Lola_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Lola_Enabled = false
			iLola_Enabled = AddToggleOption("Submissive Lola", Lola_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Isle_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iIsle_Enabled = AddToggleOption("Island of Mara", Isle_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Isle_Enabled = false
			iIsle_Enabled = AddToggleOption("Island of Mara", Isle_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(DCUR_Installed)
			SetCursorPosition(IStalled)
			IStalled += 10
			DCUR_Damsel_Enabled = false
		    iDCUR_Bondage_Enabled = AddToggleOption("Deviously Cursed Loot - Bondage Adventure", DCUR_Bondage_Enabled)
			;iDCUR_Damsel_Enabled = AddToggleOption("Deviously Cursed Loot - Damsel in Distress", DCUR_Damsel_Enabled)
			iDCUR_Doll_Enabled = AddToggleOption("Deviously Cursed Loot - Rubber Doll", DCUR_Doll_Enabled)
			iDCUR_Collar_Enabled = AddToggleOption("Deviously Cursed Loot - Cursed Collar", DCUR_Collar_Enabled)
			iDCUR_Leon_Enabled = AddToggleOption("Deviously Cursed Loot - Leon", DCUR_Leon_Enabled)
			iDCUR_Leah_Enabled = AddToggleOption("Deviously Cursed Loot - Leah", DCUR_Leah_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=10
			DCUR_Bondage_Enabled = false
			DCUR_Damsel_Enabled = false
			DCUR_Doll_Enabled = false
			DCUR_Collar_Enabled = false
			DCUR_Leon_Enabled = false
			DCUR_Leah_Enabled = false
			iDCUR_Bondage_Enabled = AddToggleOption("Deviously Cursed Loot - Bondage Adventure", DCUR_Bondage_Enabled, OPTION_FLAG_DISABLED)
			;iDCUR_Damsel_Enabled = AddToggleOption("Deviously Cursed Loot - Damsel in Distress", DCUR_Damsel_Enabled, OPTION_FLAG_DISABLED)
			iDCUR_Doll_Enabled = AddToggleOption("Deviously Cursed Loot - Rubber Doll", DCUR_Doll_Enabled, OPTION_FLAG_DISABLED)
			iDCUR_Collar_Enabled = AddToggleOption("Deviously Cursed Loot - Cursed Collar", DCUR_Collar_Enabled, OPTION_FLAG_DISABLED)
			iDCUR_Leon_Enabled = AddToggleOption("Deviously Cursed Loot - Leon", DCUR_Leon_Enabled, OPTION_FLAG_DISABLED)
			iDCUR_Leah_Enabled = AddToggleOption("Deviously Cursed Loot - Leah", DCUR_Leah_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Mia_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iMia_Enabled = AddToggleOption("Mia's Lair", Mia_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Mia_Enabled = false
			iMia_Enabled = AddToggleOption("Mia's Lair", Mia_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Raven_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iRaven_Enabled = AddToggleOption("Raven Beak Prison", Raven_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Raven_Enabled = false
			iRaven_Enabled = AddToggleOption("Raven Beak Prison", Raven_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(Things_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iThings_Enabled = AddToggleOption("Things in the Dark", Things_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Things_Enabled = false
			iThings_Enabled = AddToggleOption("Things in the Dark", Things_Enabled, OPTION_FLAG_DISABLED)
		endif		
		if(Stories_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iStories_Enabled = AddToggleOption("Red Wave", Stories_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			Stories_Enabled = false
			iStories_Enabled = AddToggleOption("Red Wave", Stories_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(DFollowers_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iDFollowers_Enabled = AddToggleOption("Devious Followers", DFollowers_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			DFollowers_Enabled = false
			iDFollowers_Enabled = AddToggleOption("Devious Followers", DFollowers_Enabled, OPTION_FLAG_DISABLED)
		endif
		if(WWBBrothel_Installed)
			SetCursorPosition(IStalled)
			IStalled += 2
			iWWBBrothel_Enabled = AddToggleOption("Whiterun Brothel Revamped", WWBBrothel_Enabled)
		else
			SetCursorPosition(Unstalled)
			Unstalled+=2
			WWBBrothel_Enabled = false
			iWWBBrothel_Enabled = AddToggleOption("Whiterun Brothel Revamped", WWBBrothel_Enabled, OPTION_FLAG_DISABLED)
		endif
	SetCursorPosition(IStalled)

	AddHeaderOption("Walk-to Auction House")
	bool bDisabled = False
	if (!iWalkToLocations)
		bDisabled = True
	endif
	AddToggleOptionST("ST_WTA_WHEN", "Disable Feature", bDisabled)
endevent

event OnOptionSelect(int a_option)
	if(a_option == iSD_Enabled)
		SD_Enabled = !SD_Enabled
		SetToggleOptionValue(iSD_Enabled, SD_Enabled)
	elseif(a_option == iQAYL_Enabled)
		QAYL_Enabled = !QAYL_Enabled
		SetToggleOptionValue(iQAYL_Enabled, QAYL_Enabled)
	elseif(a_option == iDevCidhna_Enabled)
		DevCidhna_Enabled = !DevCidhna_Enabled
		SetToggleOptionValue(iDevCidhna_Enabled, DevCidhna_Enabled)
	elseif(a_option == iWClub_Enabled)
		WClub_Enabled = !WClub_Enabled
		SetToggleOptionValue(iWClub_Enabled, WClub_Enabled)
	elseif(a_option == iSoT_Enabled)
		SoT_Enabled = !SoT_Enabled
		SetToggleOptionValue(iSoT_Enabled, SoT_Enabled)
	elseif(a_option == iME_Enabled)
		ME_Enabled = !ME_Enabled
		SetToggleOptionValue(iME_Enabled, ME_Enabled)
	elseif(a_option == iCD_Enabled)
		CD_Enabled = !CD_Enabled
		SetToggleOptionValue(iCD_Enabled, CD_Enabled)
	elseif(a_option == iHiD_Enabled)
		HiD_Enabled = !HiD_Enabled
		SetToggleOptionValue(iHiD_Enabled, HiD_Enabled)
	elseif(a_option == iSLUTS_Enabled)
		SLUTS_Enabled = !SLUTS_Enabled
		SetToggleOptionValue(iSLUTS_Enabled, SLUTS_Enabled)
	elseif(a_option == iSubmissive_Enabled)
		Submissive_Enabled = !Submissive_Enabled
		SetToggleOptionValue(iSubmissive_Enabled, Submissive_Enabled)
	elseif(a_option == iSlaverun_Enabled)
		Slaverun_Enabled = !Slaverun_Enabled
		SetToggleOptionValue(iSlaverun_Enabled, Slaverun_Enabled)
	elseif(a_option == iLola_Enabled)
		Lola_Enabled = !Lola_Enabled
		SetToggleOptionValue(iLola_Enabled, Lola_Enabled)
	elseif(a_option == iIsle_Enabled)
		Isle_Enabled = !Isle_Enabled
		SetToggleOptionValue(iIsle_Enabled, Isle_Enabled)
	elseif(a_option == iDCUR_Bondage_Enabled)
		DCUR_Bondage_Enabled = !DCUR_Bondage_Enabled
		SetToggleOptionValue(iDCUR_Bondage_Enabled, DCUR_Bondage_Enabled)
	elseif(a_option == iDCUR_Damsel_Enabled)
		DCUR_Damsel_Enabled = !DCUR_Damsel_Enabled
		SetToggleOptionValue(iDCUR_Damsel_Enabled, DCUR_Damsel_Enabled)
	elseif(a_option == iDCUR_Doll_Enabled)
		DCUR_Doll_Enabled = !DCUR_Doll_Enabled
		SetToggleOptionValue(iDCUR_Doll_Enabled, DCUR_Doll_Enabled)
	elseif(a_option == iDCUR_Collar_Enabled)
		DCUR_Collar_Enabled = !DCUR_Collar_Enabled
		SetToggleOptionValue(iDCUR_Collar_Enabled, DCUR_Collar_Enabled)
	elseif(a_option == iDCUR_Leon_Enabled)
		DCUR_Leon_Enabled = !DCUR_Leon_Enabled
		SetToggleOptionValue(iDCUR_Leon_Enabled, DCUR_Leon_Enabled)
	elseif(a_option == iDCUR_Leah_Enabled)
		DCUR_Leah_Enabled = !DCUR_Leah_Enabled
		SetToggleOptionValue(iDCUR_Leah_Enabled, DCUR_Leah_Enabled)
	elseif(a_option == iMia_Enabled)
		Mia_Enabled = !Mia_Enabled
		SetToggleOptionValue(iMia_Enabled, Mia_Enabled)		
	elseif(a_option == iRaven_Enabled)
		Raven_Enabled = !Raven_Enabled
		SetToggleOptionValue(iRaven_Enabled, Raven_Enabled)
	elseif(a_option == iThings_Enabled)
		Things_Enabled = !Things_Enabled
		SetToggleOptionValue(iThings_Enabled, Things_Enabled)		
	elseif(a_option == iStories_Enabled)
		Stories_Enabled = !Stories_Enabled
		SetToggleOptionValue(iStories_Enabled, Stories_Enabled)			
	elseif(a_option == iDFollowers_Enabled)
		DFollowers_Enabled = !DFollowers_Enabled
		SetToggleOptionValue(iDFollowers_Enabled, DFollowers_Enabled)				
	elseif(a_option == iWWBBrothel_Enabled)
		WWBBrothel_Enabled = !WWBBrothel_Enabled
		SetToggleOptionValue(iWWBBrothel_Enabled, WWBBrothel_Enabled)		
	endif
endevent

State ST_WTA_WHEN
   Event OnSelectST()
      ; Toggle back and forth between Never (0) and Distant (3).
      Bool bDisabled = False
      If (!iWalkToLocations)
         iWalkToLocations = 3
      Else
         iWalkToLocations = 0
         bDisabled = True
      EndIf
      SetToggleOptionValueST(bDisabled)
   EndEvent

   Event OnDefaultST()
      iWalkToLocations = 3
      Bool bDisabled = False
      SetToggleOptionValueST(bDisabled)
   EndEvent

   Event OnHighlightST()
      SetInfoText("Toggles whether the walking to the auction feature should be disabled.\n" +\
                  "When disabled the mod will be started with the normal blackout scene.\n" +\
                  "When enabled (disabled off) the player will be walked from Riverwood to Windhelm.")
   EndEvent
EndState

function VerifyInstallation()
	SD_Installed = false
	QAYL_Installed = false
	DevCidhna_Installed = false
	WClub_Installed = false
	SoT_Installed = false
	ME_Installed = false
	CD_Installed = false
	HiD_Installed = false
	SLUTS_Installed = false
	Submissive_Installed = false
	Slaverun_Installed = false
	Lola_Installed = false
	Isle_Installed = false
	DCUR_Installed = false
	Mia_Installed = false
	Raven_Installed = false
	Stories_Installed = false
	Things_Installed = false
	DFollowers_Installed = false
	WWBBrothel_Installed = false

	;SD+
	if(Quest.GetQuest("_SD_controller"))
		SD_Installed = true
	endif
	;Quick As You Like
	if(Quest.GetQuest("qayl"))
		QAYL_Installed = true
	endif
	;Devious Cidhna
	if(Quest.GetQuest("DvCidhna_Quest"))
		DevCidhna_Installed = true
	endif
	;Wolf Club
	if(Quest.GetQuest("pchsWolfclub"))
		WClub_Installed = true
	endif
	;Slaves of Tamriel
	if(Quest.GetQuest("SLTMineQuest"))
		SoT_Installed = true
	endif
	;Maria Eden
	if(Quest.GetQuest("MariaEdensSlave"))
		ME_Installed = true
	endif
	;Captured Dreams
	if(Quest.GetQuest("CDxMP03"))
		CD_Installed = true
	endif
	;Heroine in Distress
	if(Quest.GetQuest("hidSpiderQuest"))
		HiD_Installed = true
	endif
	;SLUTS
	if(Quest.GetQuest("sluts_kicker"))
		SLUTS_Installed = true
	endif
	;Player Submissive
	if(Quest.GetQuest("vkj_PlaySubmissiveQuest"))
		Submissive_Installed = true
	endif
	;Slaverun
	if(Quest.GetQuest("slv_mainquest"))
		Slaverun_Installed = true
	endif
	;Submissive Lola
	if(Quest.GetQuest("vkjMQ"))
		Lola_Installed = true
	endif
	;Island of Mara
	if(Quest.GetQuest("melislehookquest"))
		Isle_Installed = true
	endif
	;Deviously Cursed Loot
	if(Quest.GetQuest("dcur_mastercontroller"))
		DCUR_Installed = true
	endif
	;Raven Beak Prison
	if(Quest.GetQuest("RavenBeakWarden"))
		Raven_Installed = true
	endif
	;Mia's Lair
	if(Quest.GetQuest("aqss_miavessinter"))
		Mia_Installed = true	
	endif
	;Things in the Dark
	if(Quest.GetQuest("atid1slave"))
		Things_Installed = true	
	endif	
	;Sexlab Stories
	int var = game.getmodbyname("Sexlab-Stories.esp")
	if (var != 255)
  		debug.trace("found Sexlab Stories",0)
		Stories_Installed = true
	endif
	var = game.getmodbyname("DeviousFollowers.esp")
	if (var != 255)
  		debug.trace("Devious Followers",0)
		DFollowers_Installed = true
	endif
	var = game.getmodbyname("WhiterunBrothel.esp")
	if (var != 255)
  		debug.trace("WWBBrotel esp found",0)
		WWBBrothel_Installed = true
	endif
endfunction
