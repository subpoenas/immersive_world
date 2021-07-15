Scriptname PlayerRefaliasMasterScript extends ReferenceAlias  

Event OnInit()
	debug.Notification("$BaboDialogueOnint")
	CheckingVersion()
	Maintenance()
	if BaboDialogueMCMRestart.isrunning() == true
		BaboDialogueMCMRestart.Stop()
	endif
	debug.Notification("$BaboDialogueOnCleaning")
	Utility.wait(1.0)
	if BaboDialogueMCMRestart.isrunning() == false
		BaboDialogueMCMRestart.Start()
	endif
	BSRScript.RegisterEvent()
	BRMQuest.RegisterEvent()
	StringSetup()
	StartEventListener()
EndEvent

Function UpdateVersion()
	(BaboDialogueMCMRestart as BaboMCMRestart).Updatetofour()
	Debug.notification("$BaboDialogueOnLoadUpdate")
EndFunction

Function Maintenance()
		
If version < 3
CheckingVersionDecimal()
CheckingVersion()
UpdateVersion()
ElseIf version == 3
	if versiondecimal <= 60
		CheckingVersionDecimal()
		BaboBoyFriendVariableSetting.stop()
		BaboBoyFriendVariableSetting.start()
	endif
CheckingVersionDecimal()
CheckingVersion()
UpdateVersion()
elseif version == 4
Debug.notification("$BaboDialogueOnLoad")
endif
EndFunction


Function FixThisTime()
	BaboEventCornerClubStageTriggerBox.enable()
	(BaboEventCornerClubStageTriggerBox as BaboDefaultOnEnterTriggerScript).Rearmtrigger()
EndFunction

Event OnPlayerLoadGame()
	Maintenance()
	ReregisterFrozenQuests()
	BSRScript.RegisterEvent()
	BRMQuest.RegisterEvent()
	BDHQuest.RegisterEvent()
	BMSQuest.RegisterFunction()
	StartEventListener()
	BaboDialogueConfigMCM.CheckCompatibility()
	BaboDialogueConfigMCM.CheckStats()
	BaboDialogueConfigMCM.OrganizeFaction()
	BaboDialogueConfigMCM.RegisterUpdate(24)
	(BaboSexController as BaboSexControllerManager).RegisterSexlabHooks()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as BaboDiaMonitorScript).PlayerChangeLocation(akOldLoc, akNewLoc)
EndEvent

int Function CheckingVersion()
	Version = 4
	Return Version
EndFunction

int Function CheckingVersionDecimal()
	VersionDecimal = 0
	Return VersionDecimal
EndFunction

Function Update255()
	BaboDialogueRiverwood.Stop()
	Utility.wait(1.0)
	BaboDialogueRiverwood.Start()
EndFunction

Function ReregisterFrozenQuests()
	(BaboEventWhiterunOrcVisitiors as BaboEventWhiterunOrcVisitorsScript).RegisterUpdateOnLoad(6)
	(BaboEventWindhelmNewgnisis as BaboEventNewgnisisMasterScript).RegisterUpdateOnLoad(6)
Endfunction

;;--------------------------------------------------------------------------------;;
;; Utility Functions
;;--------------------------------------------------------------------------------;;

Event OnMenuOpen(string sMenuName)
	int iIndex = MenuEventStrings.Find(sMenuName)
	GoToState(StateStrings[iIndex])
EndEvent

Event OnMenuClose(string sMenuName)
	SetEmptyState()
EndEvent

Function StartEventListener()
	RegisterForMenu("BarterMenu")
EndFunction

Function StringSetup()
	MenuEventStrings = new string[1]
	StateStrings = new string[1]
	MenuEventStrings[0] = "BarterMenu"
	StateStrings[0] = "BarterMenu"
EndFunction

Function SetEmptyState()
	GoToState("Empty")
EndFunction

Auto State Empty
EndState
;=============================================================;
;BarterMenu
;=============================================================;
State BarterMenu
Event OnBeginState()
	BaboSellBuyValue.setvalue(0)
	_GOLD_AMOUNT_ = PlayerREF.GetItemCount(Gold001) as Int
	_BUY_RECORD_ = 0
	_SELL_RECORD_ = 0
EndEvent

Event OnItemAdded( Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer )
	if ( akBaseItem == None )
		return
	endif
	if ( aiItemCount <= 0 )
		return
	endif
	
	if ( akBaseItem == Gold001 as Form )
		return
	endif
	int i_last = _GOLD_AMOUNT_
	int i_current = PlayerREF.GetItemCount(Gold001) as Int
	int i_sub = i_last - i_current
	if ( i_sub > 0 )
		IncreaseBuyRecord( i_sub )
		_GOLD_AMOUNT_ = i_current
	endif
EndEvent

Event OnItemRemoved( Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer )
	if ( akBaseItem == Gold001 as Form )
		return
	endif

	int i_last = _GOLD_AMOUNT_
	int i_current = PlayerREF.GetItemCount(Gold001) as Int
	int i_sub = i_current - i_last
		
	if ( i_sub > 0 )
		IncreaseSellRecord( i_sub )
		_GOLD_AMOUNT_ = i_current
	endif
EndEvent

Event OnEndState()
	if _BUY_RECORD_ > 0
		BaboSellBuyValue.setvalue(BaboSellBuyValue.getvalue() + _BUY_RECORD_)
	endif
	
	if _SELL_RECORD_ > 0
		BaboSellBuyValue.setvalue(BaboSellBuyValue.getvalue() + _SELL_RECORD_)
	endif
EndEvent
EndState

;;--------------------------------------------------------------------------------;;
;; Barter Functions
;;--------------------------------------------------------------------------------;;
Function IncreaseBuyRecord( int n )
	_BUY_RECORD_ += n
EndFunction

Function IncreaseSellRecord( int n )
	_SELL_RECORD_ += n
EndFunction

Quest Property BaboDialogueMCMRestart Auto
BaboDialogueConfigMenu Property BaboDialogueConfigMCM Auto
BaboSlaveRescueScript Property BSRScript Auto
int Version = 3
int VersionDecimal = 90
Bool DebugMessage = True
BaboDialogueHirelingsQuest Property BDHQuest Auto
BaboDiaMonitorScript Property BMSQuest Auto
BaboReputationMasterScript Property BRMQuest Auto
BaboBoyFriendVariableScript Property BFVariableScript Auto
Quest Property BaboDialogueRiverwood  Auto  
Quest Property BaboEventMarkarthGuard Auto
Quest Property BaboSoliloquyOnStart Auto
Quest Property BaboEventWhiterunOrcVisitiors Auto
Quest Property BaboEventWindhelmNewgnisis Auto
Quest Property BaboBoyFriendVariableSetting Auto
ObjectReference Property BaboEventCornerClubStageTriggerBox  Auto  
Quest Property BaboEncounterQuestMarker Auto
Quest Property BaboSexController Auto
Actor Property PlayerREF Auto
MiscObject Property Gold001 Auto

;Barter
int _GOLD_AMOUNT_ = 0
int _BUY_RECORD_ = 0
int _SELL_RECORD_ = 0

;Misc

string[] MenuEventStrings
string[] StateStrings

GlobalVariable Property BaboSellBuyValue  Auto  
