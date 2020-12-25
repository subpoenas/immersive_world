Scriptname SSLV_MainScr extends Quest

Import StringUtil
;...
; Df Version
;***********************************************************************************************
;***                                       PROPERTIES                                        ***
;***********************************************************************************************
SSLV_ConfigScr property Config auto
ImageSpaceModifier property BlackFade auto
ImageSpaceModifier property LightFade auto
Scene property SimpleSlavery_Market auto
Scene property SimpleSlavery_Scene2 auto
Scene property SimpleSlavery_Scene3 auto
Scene property SimpleSlavery_Scene4 auto
Scene property SimpleSlavery_Scene5 auto
Scene property SimpleSlavery_Scene6 auto
Scene property SimpleSlavery_Scene7 auto
ObjectReference property SSLV_SlaveMark2 auto
ObjectReference property SSLV_SlaveMark3 auto
ObjectReference property SSLV_SlaveMark4 auto
ObjectReference property SSLV_SlaveMark33 auto
ObjectReference property SSLV_SlaveMark44 auto
ObjectReference property SSLV_SlaveMark55 auto
ObjectReference property SSLV_SlaveMark66 auto
ObjectReference property SSLV_SlaveMark77 auto
actor property PlayerRef auto
actor property HarrietteJackobs auto
actor property SSLV_Master1 auto
actor property SSLV_Master2 auto
actor property SSLV_Master3 auto
actor property SSLV_Master4 auto
actor property SSLV_Master5 auto
actor property SSLV_Master6 auto
actor property SSLV_Master7 auto
Outfit Property SSLV_SlaveOutfit3  Auto  
Outfit Property SSLV_SlaveOutfit4  Auto  
Outfit Property SSLV_SlaveOutfit5  Auto  
ObjectReference Property SSLV_HoldMark1 auto
ObjectReference Property SSLV_SubMark  Auto  
ObjectReference Property SSLV_FarmMark2  Auto  
Outfit Property SSLV_SlaveOutfit2  Auto  
ObjectReference Property SSLV_HaelgaMarker  Auto  
Quest Property StrongHandQuest Auto
Quest Property MQ Auto 
ObjectReference Property SSLV_CageMark2  Auto  
ObjectReference Property SSLV_MiaMark  Auto
Scene Property SSLV_Mia_Scene  Auto
Scene Property SSLV_HiD_Scene  Auto
Scene Property SimpleSlavery_SDScene  Auto  
Scene Property SSLV_Pirates_Scene  Auto
Actor Property SSLV_Master1b  Auto  
Actor Property SSLV_Master2b  Auto
Actor Property SSLV_Master3b  Auto
Actor Property SSLV_Master4b  Auto
Actor Property SSLV_Master5b  Auto
Actor Property SSLV_Master6b Auto
ObjectReference Property SSLV_NewMasterMark  Auto
ObjectReference Property SSLV_SDPlayerMove  Auto  
ObjectReference Property SSLV_SDOwnerMove  Auto  
Faction Property CrimeFactionWinterhold  Auto  
Faction Property CrimeFactionHjaalmarch  Auto  
Idle Property ZazAPCAO301  Auto  
Scene Property SSLV_Mara_Scene  Auto  
Scene Property SSLV_SD_Scene  Auto  
Int roll = 0




;========Lozeak Added stuff
Idle property BleedOutStart auto
Idle property BleedOutStop auto
KeyWord BG 
KeyWord QD 
KeyWord HB 

Scene property SimpleSlaveryDeviceRemovalStart auto

Scene property SimpleSlaveryDeviceRemovalBelt auto

Scene property SimpleSlaveryDeviceRemovalDevices auto
	Faction Property zbfFactionSlave Auto
	Int property PEnslaved Auto
;***********************************************************************************************
;***                                      CONSTANTS                                          ***
;***********************************************************************************************
; Debug Class (DC_) constants.
Int DC_GENERAL     =  0

; Debug Level (DL_) constants.
Int DL_NONE   = 0
Int DL_CRIT   = 1   ; Critical messages
Int DL_ERROR  = 2   ; Error messages
Int DL_INFO   = 3   ; Information messages
Int DL_DEBUG  = 4   ; Debug messages
Int DL_TRACE  = 5   ; Trace of everything that is happenning

;***********************************************************************************************
;***                                      VARIABLES                                          ***
;***********************************************************************************************
; Version control for this script.
; Note: This is versioning control for the script.  It is unrelated to the mod version.
Float _fCurrVer = 0.00

; The amount of logging that should be sent to the file.  This should be configurable from the
; MCM menu but for now it is just set here in this file.
Int _iMcmLogLevel

; A reference to the Devious Framework quest's main script.
dfwDeviousFramework _qDfwFramework

; Any situations that must be monitored during the update polls.
Bool _bPlayerTransportActive

; Lists of different Simple Slavery slave auction sites.
Location[] _aoAuctionRegion
Location[] _aoAuctionLocation
ObjectReference[] _aoAuctionEntranceObject

; Internal objects in the simple slavery auction house.
ObjectReference _oAuctionInternalDoor
Actor _aAuctionJailer

; Keep track of any restraints added to the player so they can be removed.
Armor _oArmRestraint
Armor _oGag

; Keep track of the NPC leading the player to the auction house for monitoring purposes.
Actor _aCaptor

; In order to avoid friends of the player's captor attacking the player we must add the player
; to the faction of her captor.  We must also remove the player from these factions afterward.  
; This is a list of all factions that may be used to pacify aggressors and the faction the
; player has been added to if any.
Faction _oFactionPlayer
Faction[] _aoFactionPacify
Faction _oFactionPacified
Int _iPreviousReaction
Float _fPreviousAggression

; If we create furniture for the player's turn keep track of it so it can be deleted after.
ObjectReference _oAuctionFurniture

int MastersToUse = 6
bool Master3Used = false
bool Master2Used = false
bool Master1Used = false
bool Master6Used = false
bool Master4Used = false
bool Master7Used = false
int AuctionSceneRnd
Scene CurrentScene
bool AuctionSceneCompleted
float fStartTime


;***********************************************************************************************
;***                                    INITIALIZATION                                       ***
;***********************************************************************************************
Function CheckScriptUpdate()
   ; Deviously Helpless becomes unsuspended on game load.  Re-enable it if needed.
   If (_bPlayerTransportActive)
      SendModEvent("dhlp-Suspend")
   EndIf

   ; Update all quest variables upon loading each game.
   ; There are too many things that can cause them to become invalid.
   _qDfwFramework = (Quest.GetQuest("_dfwDeviousFramework") As dfwDeviousFramework)
   If (_qDfwFramework)
      Log("Devious Framework Detected.", DL_INFO, DC_GENERAL)
   EndIf

; For now always update the pacify faction list as it will change often.
_aoFactionPacify = New Faction[7]
_aoFactionPacify[0] = (Game.GetFormFromFile(0x0001BCC0, "Skyrim.esm") As Faction) ; BanditFaction
_aoFactionPacify[1] = (Game.GetFormFromFile(0x00043599, "Skyrim.esm") As Faction) ; ForswornFaction
_aoFactionPacify[2] = (Game.GetFormFromFile(0x00034B74, "Skyrim.esm") As Faction) ; NecromancerFaction
_aoFactionPacify[3] = (Game.GetFormFromFile(0x000AA0A4, "Skyrim.esm") As Faction) ; SilverHandFaction
_aoFactionPacify[4] = (Game.GetFormFromFile(0x00039F26, "Skyrim.esm") As Faction) ; ThalmorFaction
_aoFactionPacify[5] = (Game.GetFormFromFile(0x000AA0A4, "Skyrim.esm") As Faction) ; VampireFaction
_aoFactionPacify[6] = (Game.GetFormFromFile(0x00026724, "Skyrim.esm") As Faction) ; WarlockFaction
_oFactionPlayer     = (Game.GetFormFromFile(0x00000DB1, "Skyrim.esm") As Faction) ; PlayerFaction

   Float fScriptVer = 1.04
   If (_fCurrVer >= fScriptVer)
      Return
   EndIf

   Debug.Notification("[SS] Updating main script " + _fCurrVer + " => " + fScriptVer)

   If (1.00 > _fCurrVer)
      Utility.Wait(20)

      RegisterForModEvent("SSLV Entry Extended", "on_new_slave_extended")
      RegisterForModEvent("DFW_MovementDone",     "MovementDone")
   EndIf

   If (1.01 > _fCurrVer)
      InitAuctionLocations()

      _aoFactionPacify = New Faction[7]
      _aoFactionPacify[0] = (Game.GetFormFromFile(0x0001BCC0, "Skyrim.esm") As Faction) ; BanditFaction
      _aoFactionPacify[1] = (Game.GetFormFromFile(0x00043599, "Skyrim.esm") As Faction) ; ForswornFaction
      _aoFactionPacify[2] = (Game.GetFormFromFile(0x00034B74, "Skyrim.esm") As Faction) ; NecromancerFaction
      _aoFactionPacify[3] = (Game.GetFormFromFile(0x000AA0A4, "Skyrim.esm") As Faction) ; SilverHandFaction
      _aoFactionPacify[4] = (Game.GetFormFromFile(0x00039F26, "Skyrim.esm") As Faction) ; ThalmorFaction
      _aoFactionPacify[5] = (Game.GetFormFromFile(0x000AA0A4, "Skyrim.esm") As Faction) ; VampireFaction
      _aoFactionPacify[6] = (Game.GetFormFromFile(0x00026724, "Skyrim.esm") As Faction) ; WarlockFaction
      _oFactionPlayer     = (Game.GetFormFromFile(0x00000DB1, "Skyrim.esm") As Faction) ; PlayerFaction
   EndIf

   If (1.02 > _fCurrVer)
      Utility.Wait(20)

      RegisterForModEvent("ZapSlaveActionDone", "OnSlaveActionDone")
   EndIf

   If (1.03 > _fCurrVer)
      InitAuctionLocations()
   EndIf

   If (1.04 > _fCurrVer)
      _iMcmLogLevel = DL_INFO
   EndIf

   _fCurrVer = fScriptVer
EndFunction

event oninit()
	debug.trace("registering for mod event 'SSLV Entry'")
	RegisterForModEvent("SSLV Entry", "on_new_slave")
	RegisterForModEvent("SSLV Entry Extended", "on_new_slave_extended")
	RegisterForModEvent("DFW_MovementDone",     "MovementDone")

	RegisterForModEvent("PlayerRefEnslaved", "PEnslave")
	RegisterForModEvent("PlayerRefFreed", "PUnEnslave")
	RegisterForModEvent("PlayerRefIsFree", "PEnslaveCheck")

	InitAuctionLocations()
	RegisterForSingleUpdate(1.0)
endevent


Event PEnslave(string eventName, string strArg, float numArg, Form sender)
	Int SlaveFactionRank = Game.GetPlayer().GetFactionRank(zbfFactionSlave)

	If SlaveFactionRank < 0
		 Game.GetPlayer().SetFactionRank(zbfFactionSlave, 0)
	EndIf
endevent

Event PUnEnslave(string eventName, string strArg, float numArg, Form sender)
	
	Int SlaveFactionRank = Game.GetPlayer().GetFactionRank(zbfFactionSlave)
	
	If SlaveFactionRank >= 0
		 Game.GetPlayer().SetFactionRank(zbfFactionSlave, -1)
	EndIf
endevent

Event PEnslaveCheck(string eventName, string strArg, float numArg, Form sender)
	Int SlaveFactionRank = Game.GetPlayer().GetFactionRank(zbfFactionSlave)

	if SlaveFactionRank >= 0
		SendModEvent("PlayerRefEnslaved")
	Else
		SendModEvent("PlayerRefFreed")
	endif
endevent

Event OnUpdate()
   Bool bKeepMonitoring
   If (_bPlayerTransportActive)
      MonitorTransport()
      bKeepMonitoring = True
   EndIf

   ; If at least one monitoring condition is still active request another update.
   If (bKeepMonitoring)
      RegisterForSingleUpdate(0.5)
   EndIf
   
   ;if GetStage() >= 20 && Getstage() < 120
	   ;Game.DisablePlayerControls(True, False, False, False, False, False, False)
	   ;RegisterForSingleUpdate(0.3)
	;endif
	if Getstage() == 25 && !PlayerRef.WornHasKeyword(BG) && !PlayerRef.WornHasKeyword(QD)
		BG = Keyword.GetKeyword("zad_BlockGeneric")
		QD = Keyword.GetKeyword("zad_QuestItem")
		HB = Keyword.GetKeyword("zad_DeviousHeavyBondage")
	    Utility.wait(5)
		Debug.Notification("Since you removed your devices your skin has been tingling.")
		Utility.wait(5)
		Debug.Notification("Your skin feels like it's on fire! What's happening")	
		PlayerRef.PlayIdle(BleedOutStart)
		Utility.wait(3)
		if !PlayerRef.WornHasKeyword(BG) && !PlayerRef.WornHasKeyword(QD)
			Reset()
			Debug.MessageBox("You blackout for a second.\n You vision clears, you realize your back at the auction house!\nYou were free no... how?... those spells they used on you.\n They must of enchanted you to teleport back here once you removed those devices.")
			SendModEvent("SSLV Entry")
			PlayerRef.PlayIdle(BleedOutStop)
			SetObjectiveFailed(25)
		else
			RegisterForSingleUpdate(20.0)
			PlayerRef.PlayIdle(BleedOutStop)
			Debug.Notification("It seems that device has stopped your skin feeling like it's on fire.")
		endif
	Elseif Getstage() == 25 
		RegisterForSingleUpdate(20.0)
	endif
EndEvent


Function Outfit()
		KeyWord ZL = Keyword.GetKeyword("zad_Lockable")
		if !Game.GetPlayer().WornHasKeyword(ZL)
			Game.GetPlayer().UnequipAll()
			Roll = Utility.RandomInt(2,5)
			If Roll == 2
				game.getplayer().setoutfit(sslv_slaveoutfit2)
			Elseif Roll == 3
				game.getplayer().setoutfit(sslv_slaveoutfit3)
			ElseIf Roll== 4
				game.getplayer().setoutfit(sslv_slaveoutfit4)
			Elseif Roll== 5
				game.getplayer().setoutfit(sslv_slaveoutfit5)
			endIf
		endif
endfunction

Scene Function SceneSelector()
	
	Roll = Utility.RandomInt(0,10)
	if Roll == 1
	   Return SSLV_Pirates_Scene 
	Elseif Roll == 2
		Return SimpleSlavery_Market
	Elseif Roll == 3
		Return SimpleSlavery_Scene2
	Elseif Roll == 4
		Return SimpleSlavery_Scene3
	Elseif Roll == 5
		Return SimpleSlavery_Scene4
	Elseif Roll == 6
		Return SimpleSlavery_Scene5
	Elseif Roll == 7
		Return SimpleSlavery_Scene6
	Elseif Roll == 8
		Return SimpleSlavery_Scene7
	Elseif Roll == 9
		Return SSLV_Mara_Scene
	Elseif Roll == 10
		Return SSLV_SD_Scene
	endif

EndFunction

Function InitAuctionLocations()
   Log("Initializing Auction Locations.", DL_INFO, DC_GENERAL)

   ; Setup auction house internal markers.
   _oAuctionInternalDoor = (Game.GetFormFromFile(0x00025108, "SimpleSlavery.esp") As ObjectReference)
   _aAuctionJailer       = (Game.GetFormFromFile(0x0002530A, "SimpleSlavery.esp") As Actor)

   ; Then make sure the region/location variables are set.
   _aoAuctionRegion         = New Location[6]
   _aoAuctionLocation       = New Location[6]
   _aoAuctionEntranceObject = New ObjectReference[6]

   Int iRiftenOuterDoorId = 0x0004D7D0

   ; Riften
   _aoAuctionEntranceObject[0] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[0])
      _aoAuctionRegion[0] = (Game.GetFormFromFile(0x00018A58, "Skyrim.esm") As Location) ; RiftenLocation
      _aoAuctionLocation[0] = _aoAuctionRegion[0]
   EndIf

   ; High Hrothgar (moves to Riften)
   _aoAuctionEntranceObject[1] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[1])
      _aoAuctionRegion[1] = (Game.GetFormFromFile(0x00018E34, "Skyrim.esm") As Location) ; HighHrothgarLocation
      _aoAuctionLocation[1] = _aoAuctionRegion[0]
   EndIf

   ; Ivarstead (moves to Riften)
   _aoAuctionEntranceObject[2] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[2])
      _aoAuctionRegion[2] = (Game.GetFormFromFile(0x00018A4B, "Skyrim.esm") As Location) ; IvarsteadLocation
      _aoAuctionLocation[2] = _aoAuctionRegion[0]
   EndIf

   ; Riverwood (moves to Riften)
   _aoAuctionEntranceObject[3] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[3])
      _aoAuctionRegion[3] = (Game.GetFormFromFile(0x00013163, "Skyrim.esm") As Location) ; RiverwoodLocation
      _aoAuctionLocation[3] = _aoAuctionRegion[0]
   EndIf

   ; Shors Stone (moves to Riften)
   _aoAuctionEntranceObject[4] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[4])
      _aoAuctionRegion[4] = (Game.GetFormFromFile(0x00018A4C, "Skyrim.esm") As Location) ; ShorsStoneLocation
      _aoAuctionLocation[4] = _aoAuctionRegion[0]
   EndIf

   ; Windhelm (moves to Riften)
   _aoAuctionEntranceObject[5] = (Game.GetFormFromFile(iRiftenOuterDoorId, "SimpleSlavery.esp") As ObjectReference)
   If (_aoAuctionEntranceObject[5])
      _aoAuctionRegion[5] = (Game.GetFormFromFile(0x00018A57, "Skyrim.esm") As Location) ; WindhelmLocation
      _aoAuctionLocation[5] = _aoAuctionRegion[0]
   EndIf
EndFunction


;***********************************************************************************************
;***                                    EVENTS/FUNCTIONS                                     ***
;***********************************************************************************************
event on_new_slave(string eventName, string arg_s, float argNum, form sender)
	Log("received new slave Mod Event", DL_INFO, DC_GENERAL)

	; Try a Devious Framework forced save.  Most likely the calling mod won't have done so.
	If (_qDfwFramework)
		_qDfwFramework.ForceSave()
	EndIf

	StartCagePlayer()
endevent

Int Function StartCagePlayer()
	Log("Starting Auction Scene.", DL_INFO, DC_GENERAL)
	SendModEvent("dhlp-Suspend")

	; Register the auction house as the player's Master with DFW to prevent interference.
	if (_qDfwFramework)
		; Clear any previous registration we may have from the player's captor.
		_qDfwFramework.ClearMaster(None, "SS Auction")

		_qDfwFramework.SetMaster(None, "SS Auction", _qDfwFramework.AP_NONE, _qDfwFramework.MD_DISTANT)
	endif

	; If the player is locked in BDSM furniture make sure to release her first.
	Keyword oKeywordZbfFurniture = (Game.GetFormFromFile(0x0000762B, "ZaZAnimationPack.esm") As Keyword)
	if (oKeywordZbfFurniture)
		zbfSlot qZbfPlayerSlot = zbfBondageShell.GetApi().FindPlayer()
		ObjectReference oCurrFurniture = qZbfPlayerSlot.GetFurniture()
		if (oCurrFurniture && oCurrFurniture.hasKeyword(oKeywordZbfFurniture))
			qZbfPlayerSlot.SetFurniture(None)
		endif
	endif

	PlayerRef.MoveTo(SSLV_CageMark2)
	
    Armor a = Game.Getplayer().GetWornForm(0x00000002) as Armor ; Stripping player
    Armor b = Game.Getplayer().GetWornForm(0x00000004) as Armor
    Armor c = Game.Getplayer().GetWornForm(0x00000008) as Armor
    Armor d = Game.Getplayer().GetWornForm(0x00000080) as Armor
	
	Game.GetPlayer().UnequipItem(Game.GetPlayer().GetEquippedWeapon(),false,true)
	Game.GetPlayer().UnequipItem(Game.GetPlayer().GetEquippedWeapon(true),false,true)
	Game.GetPlayer().UnequipSpell(Game.GetPlayer().GetEquippedSpell(0),0)
	Game.GetPlayer().UnequipSpell(Game.GetPlayer().GetEquippedSpell(1),1)
	Game.GetPlayer().UnequipSpell(Game.GetPlayer().GetEquippedSpell(2),2)

	If (a.HasKeywordString("ArmorClothing")||a.HasKeywordString("ArmorHeavy")||a.HasKeywordString("ArmorLight"))&&!a.HasKeywordString("zad_Lockable")
		Game.Getplayer().UnequipItem(a,false,true)
	endif

	If (c.HasKeywordString("ArmorClothing")||c.HasKeywordString("ArmorHeavy")||c.HasKeywordString("ArmorLight"))&&!c.HasKeywordString("zad_Lockable")
		Game.Getplayer().UnequipItem(c,false,true)
	endif

	If (d.HasKeywordString("ArmorClothing")||d.HasKeywordString("ArmorHeavy")||d.HasKeywordString("ArmorLight"))&&!d.HasKeywordString("zad_Lockable")
		Game.Getplayer().UnequipItem(d,false,true)
	endif

	If (b.HasKeywordString("ArmorClothing")||b.HasKeywordString("ArmorHeavy")||b.HasKeywordString("ArmorLight"))&&!b.HasKeywordString("zad_Lockable")
		Game.Getplayer().UnequipItem(b,false,true)
	endif
	; Add a collar, wrist cuffs, and ankle cuffs to the player while she is in the auction.	
	;PlayerRef.SetOutfit(sslv_slaveoutfit2)
	Outfit()
	;Add_SS_Restraints()
EndFunction

; ... Note: I'm not really sure how the parameters of this function are setup. ...
; ... My Mod events don't really look anything like this. ...
Event on_new_slave_extended(Form oMaster)
   Log("received new slave Mod Event (extended)", DL_INFO, DC_GENERAL)
   If (1 == StartWalkToAuction(oMaster As Actor))
      ; The player cannot be walked to the auction house right now.  Teleport her there instead.
      StartCagePlayer()
   EndIf
EndEvent

Int Function StartWalkToAuction(Actor aCaptor=None)
   If (_qDfwFramework)
      ; If no Master was specified find the nearest actor.
      If (!aCaptor)
         aCaptor = _qDfwFramework.GetNearestActor(iIncludeFlags=_qDfwFramework.AF_DOMINANT, iExcludeFlags=_qDfwFramework.AF_GUARDS)
         If (!aCaptor)
            aCaptor = _qDfwFramework.GetNearestActor(iIncludeFlags=_qDfwFramework.AF_DOMINANT)
            If (!aCaptor)
               aCaptor = _qDfwFramework.GetNearestActor()
            EndIf
         EndIf
      EndIf
      String szName = "[Error: No Captor]"
      If (aCaptor)
         szName = aCaptor.GetDisplayName()
      EndIf
      Log("Starting Auction House Walk with " + szName + ".", DL_INFO, DC_GENERAL)

      ; If the player cannot currently be enslaved abort the attempt completely.
      If (!_qDfwFramework.IsAllowed(_qDfwFramework.AP_ENSLAVE))
         Log("Slavery Not Permitted by " + _qDfwFramework.GetMasterMod(_qDfwFramework.MD_ANY), DL_INFO, DC_GENERAL)
         Return -1
      EndIf

      ; If the Walk To Auction House feature has been set to Never use the blackout transition instead.
      If (!Config.iWalkToLocations)
         Log("Walking to auction house disabled.", DL_INFO, DC_GENERAL)
         Return 1
      EndIf

      ; Register the SS mod is controlling the player.
      _qDfwFramework.SetMaster(aCaptor, "SS Auction", _qDfwFramework.AP_NONE, _qDfwFramework.MD_CLOSE, bOverride=True)

      ; Find out if we are close enough to walk to the auction house.
      ; ... Note: MCM options could be checked here as well. ...
      Int iIndex = _aoAuctionRegion.Find(_qDfwFramework.GetNearestRegion())
      If (-1 != iIndex)
         ; Block deviously helpless to reduce the chance of being accosted on the way to the auction.
         SendModEvent("dhlp-Suspend")

         ; If the player's captor is a member of a particular faction add the player to it.
         Int iFactionIndex = _aoFactionPacify.Length - 1
         While (0 <= iFactionIndex)
            If (aCaptor.IsInFaction(_aoFactionPacify[iFactionIndex]) && \
                !PlayerRef.IsInFaction(_aoFactionPacify[iFactionIndex]))
               _oFactionPacified = _aoFactionPacify[iFactionIndex]
               Log("Pacifying Faction: " + _oFactionPacified.GetName(), DL_INFO, DC_GENERAL)
               PlayerRef.AddToFaction(_oFactionPacified)
               _iPreviousReaction = _oFactionPlayer.GetReaction(_oFactionPacified)

               ; Overly aggressive actors can start fights with townspeople.  Under aggressive
               ; actors won't defend against enemies.  Make sure the captor's aggression is 1.
               _fPreviousAggression = aCaptor.GetActorValue("Aggression")
               aCaptor.SetActorValue("Aggression", 1)

               ; Adding the player is not enough.  We must make the faction friendly with the
               ; player's faction and calm any nearby actors who are already in combat.
               ; This needs some improvement.  Normally hostile actors aren't in the DFW nearby
               ; actor list.  Also NPCs who are in combat with other NPCs/animals will turn on
               ; the player once their targets are dead.
               _oFactionPlayer.SetReaction(_oFactionPacified, 3)
               Int iSafety = 10
               Actor aNearbyCombatant = _qDfwFramework.GetPlayerInCombatWith()
               While (aNearbyCombatant && iSafety)
                  aNearbyCombatant.StopCombat()
                  Utility.Wait(0.01)
                  aNearbyCombatant = _qDfwFramework.GetPlayerInCombatWith()
                  iSafety -= 1
               EndWhile
            EndIf
            iFactionIndex -= 1
         EndWhile

         ; Make sure the leash is connected from the player to the Master.
         ; ... Perhaps make the length configurable in the MCM menu. ...
         _qDfwFramework.SetLeashLength(700)
         _qDfwFramework.SetLeashTarget(aCaptor)

         ; Make sure the player is appropriately restrained for the journey.
         ; Make sure the Zaz Animation Pack mod is installed.
         Zadlibs qZadLibs = (Quest.GetQuest("zadQuest") As Zadlibs)
         If (qZadLibs)
            If (!_qDfwFramework.IsPlayerArmLocked())
               ; Use a simple arm binder for now (0x0000D4D6 = zadx_EboniteArmbinderInventory).
               ; ... Note: Some work could be done to make this more immersive. ...
			   debug.messagebox("You're gonna make me a lot of money, bitch. Sit still while I prepare you for travel.")
               _oArmRestraint = (Game.GetFormFromFile(0x0000D4D6, "Devious Devices - Expansion.esm") as Armor)
               If (_oArmRestraint)
                  Armor oItemRendered = qZadLibs.GetRenderedDevice(_oArmRestraint)
                  qZadLibs.EquipDevice(PlayerRef, _oArmRestraint, oItemRendered, qZadLibs.zad_DeviousArmbinder)
               EndIf
            EndIf
            If (!_qDfwFramework.IsPlayerGagged())
               ; Use a simple gag for now (0x0000D4F3 = zadx_GagEbonitePanelInventory).
               ; ... Note: Some work could be done to make this more immersive. ...
               _oGag = (Game.GetFormFromFile(0x0000D4F3, "Devious Devices - Expansion.esm") as Armor)
               If (_oGag)
                  Armor oItemRendered = qZadLibs.GetRenderedDevice(_oGag)
                  qZadLibs.EquipDevice(PlayerRef, _oGag, oItemRendered, qZadLibs.zad_DeviousGag)
               EndIf
            EndIf
            ; ... Perhaps add a collar, or slave boots as well? ...
			;add a pause to give the player a chance to get to their feet
			;utility.wait(10)
         EndIf

         ; Once the player is restrained make sure the actor is not hostile.
         aCaptor.StopCombat()

         ; If the player is locked in BDSM furniture release her first.
         ObjectReference oCurrFurniture = _qDfwFramework.GetBdsmFurniture()
         If (oCurrFurniture)
            zbfSlaveActions qZbfSlaveActions = (Quest.GetQuest("zbfSlaveControl") As zbfSlaveActions)
            If (qZbfSlaveActions)
               qZbfSlaveActions.RestrainInDevice(None, aCaptor, asMessage="SS Furn Release")
            EndIf
         EndIf

         ; Start the bandit/slaver on the journey to the auction house.
         _aCaptor = aCaptor
         _qDfwFramework.MoveToLocation(aCaptor, _aoAuctionLocation[iIndex], "SS To Auction")

         ; Make sure we monitor the progress of the player transportation (for a dead Master and such).
         _bPlayerTransportActive = True
         RegisterForSingleUpdate(0.5)
         _qDfwFramework.YankLeash(0.0, _qDfwFramework.LS_DRAG)
         Return 0
      Else
         Log("Auction House Not Nearby: Caging Player.", DL_INFO, DC_GENERAL)
      EndIf
   Else
      Log("Devious Framework Not Installed: Caging Player.", DL_INFO, DC_GENERAL)
   EndIf
   Return 1
EndFunction

Function WalkToAuctionEnd(Bool bStartAuction=False)
   Log("Ending Auction Walk: " + bStartAuction, DL_INFO, DC_GENERAL)

   ; Disable the captor to stop any aggression he creates when his movement package stops.
   If (bStartAuction)
      _aCaptor.Disable()
   EndIf

   ; If the player has been added to a faction to pacify that faction remove the player now.
   If (_oFactionPacified)
      Log("Clearing Pacify Faction: " + _oFactionPacified.GetName(), DL_INFO, DC_GENERAL)
      PlayerRef.RemoveFromFaction(_oFactionPacified)
      _oFactionPlayer.SetReaction(_oFactionPacified, _iPreviousReaction)
      _aCaptor.SetActorValue("Aggression", _fPreviousAggression)
      _oFactionPacified = None
   EndIf

   If (_qDfwFramework)
      _qDfwFramework.SetLeashTarget(None)
   Endif
   If (bStartAuction)
      ; Try to unrestrain the player's arms before putting her in the cage.
      Zadlibs qZadLibs = (Quest.GetQuest("zadQuest") As Zadlibs)
      If (qZadLibs)
         ; If we added any restraints to the player remove them now.
         If (_oArmRestraint)
            Armor oItemRendered = qZadLibs.GetRenderedDevice(_oArmRestraint)
            qZadLibs.RemoveDevice(PlayerRef, _oArmRestraint, oItemRendered, qZadLibs.zad_DeviousArmbinder)
            PlayerRef.RemoveItem(_oArmRestraint, 1)
         Else
            ; Otherwise try to remove any generic arm binder she might be wearing.
            qZadLibs.ManipulateGenericDeviceByKeyword(PlayerRef, qZadLibs.zad_DeviousArmbinder, False)
         EndIf
         If (_oGag)
            Armor oItemRendered = qZadLibs.GetRenderedDevice(_oGag)
            qZadLibs.RemoveDevice(PlayerRef, _oGag, oItemRendered, qZadLibs.zad_DeviousGag)
            PlayerRef.RemoveItem(_oGag, 1)
         Else
            ; Otherwise try to remove any generic arm binder she might be wearing.
            qZadLibs.ManipulateGenericDeviceByKeyword(PlayerRef, qZadLibs.zad_DeviousGag, False)
         EndIf

         ; The short delay helps the player transfer with the proper equipment.
         Utility.Wait(2)
      EndIf
      ; Move the bandit/slaver to their package location so they are not in the auction house.
      _aCaptor.EvaluatePackage()
      _aCaptor.MoveToMyEditorLocation()
      _aCaptor.MoveToPackageLocation()
      _aCaptor.Enable()
      StartCagePlayer()
   Else
      SendModEvent("dhlp-Resume")
      If (_qDfwFramework)
         _qDfwFramework.ClearMaster(None, "SS Auction")
      EndIf
   EndIf
   _aCaptor = None
   _bPlayerTransportActive = False
EndFunction

; This is the ZAZ Animation Pack (ZBF) event when an animation for approaching/restraining
; the player has completed.
Event OnSlaveActionDone(String szType, String szMessage, Form oMaster, Int iSceneIndex)
   ; We are only interested in animations that we started.
   If ("SS " != StringUtil.Substring(szMessage, 0, 3))
      Return
   EndIf

   If ("SS Furn Auction" == szMessage)
      Log("Player Now Furniture Locked.", DL_INFO, DC_GENERAL)

      ; Lock the player in the furniture.
      If (_qDfwFramework)
         _qDfwFramework.SetBdsmFurnitureLocked()
      EndIf

      ; Re-lock the cell doors.
      Lock_Cell_Doors()

      ; Restore the player's activation now that the doors are safely locked.
      If (_qDfwFramework)
         _qDfwFramework.RestoreActivate()
      EndIf
		DisableControls()
      SetStage(25)
   EndIf
EndEvent

; iType: 1: Approach Player  2: Move To Location  3: Move To Object
Event MovementDone(Int iType, Form oActor, Bool bSucceeded, String szModId)
   ; We are only interested in animations that we started.
   If ("SS " != Substring(szModId, 0, 3))
      Return
   EndIf

   Actor aActor = (oActor As Actor)

   ; Transition the Catch For Auction scene to the Zaz Restrain in Device scene regardless of
   ; whether the approach passed or failed.
   If (1 == iType && ("SS Catch For Auction" == szModId))
      Log("Player Caught for Starting the Auction.", DL_INFO, DC_GENERAL)

      ; Stop the player to ensure the Zaz Animation Pack package catches her.
      ;    DisablePlayerControls(Move,  Fight, Cam,   Look,  Sneak, Menu,  Active, Journ)
      ;Game.DisablePlayerControls(True,  False, False, False, False, False, False,  False)

      ; We advance the quest in the restraining done event (OnSlaveActionDone).
      zbfSlaveActions qZbfSlaveActions = (Quest.GetQuest("zbfSlaveControl") As zbfSlaveActions)
      qZbfSlaveActions.RestrainInDevice(_oAuctionFurniture, aActor, asMessage="SS Furn Auction")
      Debug.MessageBox(aActor.GetDisplayName() + " grabs you roughly and drags you to the auction block.")

      ; Lock the player's furniture here.  If we wait until after the Zad scene has completed sometimes
      ; the controller walks off giving the player time to escape before the end.
      _qDfwFramework.SetBdsmFurnitureLocked()
      Return
   EndIf

   ; If the scene did not succeed, simply end the scene.
   If (!bSucceeded || !_qDfwFramework)
      ; ... What to do on failure?  Abort and release everything or fall back to teleport? ...
      Log("Movement Failed: " + szModId, DL_ERROR, DC_GENERAL)

      ; The actor failed to make it to the auction house.  Perhaps he was killed.  Abort.
      If (_bPlayerTransportActive)
         WalkToAuctionEnd()
      EndIf
      Return
   EndIf

   If ("SS To Auction" == szModId)
      If (2 == iType)
         ; We have arrived at the auction's location/region.  Find where to move to next.
         Location oCurrLocation = _qDfwFramework.GetCurrentLocation()
         Int iIndex = _aoAuctionLocation.Find(oCurrLocation)
         If (-1 != iIndex)
            ; We have arrived at the auction's location.  Move to the entrance door.
            Log("Movement: Arrived in Location.", DL_INFO, DC_GENERAL)
            _qDfwFramework.MoveToObject(aActor, _aoAuctionEntranceObject[iIndex], szModId)
         Else
            iIndex = _aoAuctionRegion.Find(oCurrLocation)
            If (-1 != iIndex)
               ; We have arrived in the region.  Now move to the location.
               Log("Movement: Arrived in Region.", DL_INFO, DC_GENERAL)
               _qDfwFramework.MoveToLocation(aActor, _aoAuctionLocation[iIndex], szModId)
            Else
               Log("Error: Cannot Find Auction House Entrance.", DL_ERROR, DC_GENERAL)
               WalkToAuctionEnd()
            EndIf
         EndIf
      ElseIf (3 == iType)
         If (_oAuctionInternalDoor && _aAuctionJailer)
            Log("Movement: Arrived at Door.", DL_INFO, DC_GENERAL)
            aActor.MoveTo(_oAuctionInternalDoor)
            _qDfwFramework.MoveToObject(aActor, _aAuctionJailer, "SS Move Internal")
         Else
            ; We can't progress the scene inside the auction house.  Start Simple Slavery now.
            Log("Error: Internal Markers Not Configured.", DL_ERROR, DC_GENERAL)
            WalkToAuctionEnd(True)
         EndIf
      EndIf
   ElseIf ("SS Move Internal" == szModId)
      ; We have arrived at the entrance.  For now start the auction from here.
      Log("Movement: Arrived at Jailer.  Starting Auction.", DL_INFO, DC_GENERAL)
      WalkToAuctionEnd(True)
   EndIf
EndEvent



Function MonitorTransport()
   ; If the captor dies give the player a chance to break away from the leash.
   If (_aCaptor && _aCaptor.IsDead() && (15 >= Utility.RandomInt(1, 100)))
      Log("Monitoring Transport: Captor Dead.", DL_INFO, DC_GENERAL)
      Debug.MessageBox("With " + _aCaptor.GetDisplayName() + " dead you manage to free yourself.")
      WalkToAuctionEnd()
   Endif

   ; If the captor's aggression has been reset, this most likely indicates he has changed areas
   ; and been reset.  If there is another NPC in the new area he has most likely started combat.
   If (1.0 != _aCaptor.GetActorValue("Aggression"))
      _aCaptor.SetActorValue("Aggression", 1)
      Actor aCombatTarget = _aCaptor.GetCombatTarget()
      If (aCombatTarget)
         aCombatTarget.StopCombat()
         _aCaptor.StopCombat()
      EndIf
   EndIf
EndFunction

function Stage_10()
	int ToThePlatformRND	
	;SD+ Release
	PlayerRef.SendModEvent("PCSubFree")
	
	SetObjectiveCompleted(0)
	ToThePlatformRnd=Utility.RandomInt(1, 9)
	
	if(ToThePlatformRND==1)
		debug.MessageBox("Your knees shake uncontrollably as you are led onto the platform.")
	elseif(ToThePlatformRND == 2)
		debug.MessageBox("You struggle as you are led to the platform, but it elicits only laughter.")
	elseif(ToThePlatformRND == 3)
		debug.MessageBox("You hang your head in resignation as you are led to the platform.")
	elseif(ToThePlatformRND == 4)
		debug.MessageBox("You want to fight as you are led to the platform, but your body is just too tired.")
	elseif(ToThePlatformRND == 5)
		debug.MessageBox("You glare your defiance at the audience as you are led to the platform.")
	elseif(ToThePlatformRND == 6)
		debug.MessageBox("As you are led to the platform, you stick your foot out and trip one of the handlers")
		debug.MessageBox("You enjoy the small victory as he curses under his breath, then brace for what is to come.")
	elseif(ToThePlatformRND == 7)
		debug.MessageBox("You ignore everything around you and dream of the wild open fields of your home as you are led to the platform.")
	elseif(ToThePlatformRND == 8)
		debug.MessageBox("You struggle to hold back tears as you are led to the platform.")
	elseif(ToThePlatformRND == 9)
		debug.MessageBox("You silently vow to free yourself and kill everyone associated with this humiliation as you are led to the platform.")
	endif
	;Game.RequestAutoSave()
	SetObjectiveDisplayed(20)
	SetStage(20)
endfunction

function Stage_20()
	
	HB = Keyword.GetKeyword("zad_DeviousHeavyBondage")
	; Select a random furniture to display the player in for the auction.
	Int[] aiFurnitureOptions = New Int[6]
	aiFurnitureOptions[0] = 0x00022782   ; zbfVerticalStocksLuxuryX
	aiFurnitureOptions[1] = 0x00026D33   ; zbfCrossRopedPose01
	aiFurnitureOptions[2] = 0x00026D34   ; zbfCrossRopedPose02
	aiFurnitureOptions[3] = 0x00026D35   ; zbfCrossRopedPose03
	;aiFurnitureOptions[4] = 0x00022780   ; zbfWoodenHorseLuxury
	;aiFurnitureOptions[5] = 0x00026D3E   ; zbfWoodenPony02
	aiFurnitureOptions[6] = 0x000232E7   ; zbfXCross2Comfy
	aiFurnitureOptions[7] = 0x0002277F   ; zbfXCross2Luxury
        Int iFurnitureId = aiFurnitureOptions[Utility.RandomInt(0, aiFurnitureOptions.Length - 1)]

	; Try to create new furniture to lock the player into.
	zbfSlaveActions qZbfSlaveActions = (Quest.GetQuest("zbfSlaveControl") As zbfSlaveActions)
	Form oNewFurnitureBase = Game.GetFormFromFile(iFurnitureId, "ZaZAnimationPack.esm")
	_oAuctionFurniture = None
	if (oNewFurnitureBase && qZbfSlaveActions)
		_oAuctionFurniture = SSLV_SlaveMark2.PlaceAtMe(oNewFurnitureBase, abInitiallyDisabled=True)
		_oAuctionFurniture = SSLV_SlaveMark2.PlaceAtMe(oNewFurnitureBase)
	endif

	; If the new furniture could be created lock the player in it now.
		KeyWord ZL = Keyword.GetKeyword("zad_Lockable")
	if (_oAuctionFurniture)&&!PlayerRef.WornHasKeyword(HB)
				if !Game.GetPlayer().WornHasKeyword(ZL)
							PlayerRef.UnequipAll()
			
				endif
		HarrietteJackobs.disable(true)

		; Stop the player from opening the doors while they are unlocked.
		if (_qDfwFramework)
			; Have the guard approach the player using DFW if possible.
			; The player can evade the Zaz package for a while.
			_qDfwFramework.BlockActivate()
			_qDfwFramework.ApproachPlayer(_aAuctionJailer, 60, 2, "SS Catch For Auction")
		else
			;    DisablePlayerControls(Move,  Fight, Cam,   Look,  Sneak, Menu,  Active, Journ)
			;Game.DisablePlayerControls(False, False, False, False, False, False, True,   False)

			; We advance the quest in the restraining done event (OnSlaveActionDone).
			qZbfSlaveActions.RestrainInDevice(_oAuctionFurniture, _aAuctionJailer, asMessage="SS Furn Auction")
		endif

		; Unlock the cell doors.  The cell guard can't transport the player properly otherwise.
		Lock_Cell_Doors(False)
	else
		; Otherwise just blank the screen and move the player to the auction block.
		SetObjectiveCompleted(10)
		BlackFade.ApplyCrossFade(3)
		utility.wait(10)
		HarrietteJackobs.disable(true)
		PlayerRef.MoveTo(SSLV_SlaveMark2)
	     if !PlayerRef.WornHasKeyword(HB)
		
				if !Game.GetPlayer().WornHasKeyword(ZL)
					PlayerRef.UnequipAll()
			
				endif
				PlayerRef.playidle(ZazAPCAO301)
			
				
		
		endIf
		DisableControls()
		LightFade.ApplyCrossFade(3)
		utility.wait(3)
		LightFade.remove()
		;    DisablePlayerControls(Move,  Fight, Cam,   Look,  Sneak, Menu,  Active, Journ)
		;Game.DisablePlayerControls(True,  True,  True,  False, True,  False, True,   False)
		SetStage(25)
	endif
endfunction

function Stage_25()	; This stage is deicated to dealing with devices
	
		BG = Keyword.GetKeyword("zad_BlockGeneric")
		QD = Keyword.GetKeyword("zad_QuestItem")
		HB = Keyword.GetKeyword("zad_DeviousHeavyBondage")
	
	SetObjectiveCompleted(20)
	if PlayerRef.WornHasKeyword(BG) || PlayerRef.WornHasKeyword(QD)
		SetObjectiveDisplayed(25)
		Debug.MessageBox("They try to remove your restraints casting all kind of spells and enchantments.\nThey give up and tell you \"We can't sell an owned slave get out\".\n It seems they're are gonna let you walk out the front door")
		RegisterForSingleUpdate(1.0)
		SendModEvent("dhlp-Resume")
		EnableControls()
		Debug.SendAnimationEvent(Game.Getplayer(), "IdleForceDefaultState")
				
	Else
		ClearDevices() 
	    SetStage(30)
	endif
	
Endfunction

function Stage_30()
	int FromThePlatformRnd	
	SetObjectiveCompleted(20)
	SetStage(40)
endfunction

function Stage_40()
	SetObjectiveCompleted(30)
	
	Utility.Wait(2)
	ChoosingSlavery()
endfunction

function Lock_Cell_Doors(Bool bLock=True)
	ObjectReference oJailDoorFront = (Game.GetFormFromFile(0x00026C99, "SimpleSlavery.esp") As ObjectReference)
	ObjectReference oJailDoorSide  = (Game.GetFormFromFile(0x00025889, "SimpleSlavery.esp") As ObjectReference)
	oJailDoorFront.Lock(bLock)
	oJailDoorSide.Lock(bLock)
	if (bLock)
		oJailDoorFront.SetOpen(False)
		oJailDoorSide.SetOpen(False)
	endif
endfunction

function Add_SS_Restraints(Bool bAdd=True)
	Armor oCollar     = (Game.GetFormFromFile(0x0000500C, "ZaZAnimationPack.esm") As Armor)
	Armor oAnkleChain = (Game.GetFormFromFile(0x00004009, "ZaZAnimationPack.esm") As Armor)
	Armor oWristCuffs = (Game.GetFormFromFile(0x00001008, "ZaZAnimationPack.esm") As Armor)
	zbfSlot qZbfPlayerSlot = zbfBondageShell.GetApi().FindPlayer()
	if (bAdd)
		qZbfPlayerSlot.SetBinding(oCollar)
		qZbfPlayerSlot.SetBinding(oAnkleChain)
		qZbfPlayerSlot.SetBinding(oWristCuffs)
	else
		qZbfPlayerSlot.RemoveBinding(oCollar)
		qZbfPlayerSlot.RemoveBinding(oAnkleChain)
		qZbfPlayerSlot.RemoveBinding(oWristCuffs)
		PlayerRef.RemoveItem(oCollar, 999, True)
		PlayerRef.RemoveItem(oAnkleChain, 999, True)
		PlayerRef.RemoveItem(oWristCuffs, 999, True)
	endif
endfunction

function Post_Auction_Cleanup()
	Log("Auction Completed.  Cleaning Up.", DL_INFO, DC_GENERAL)

	; Re-enable Harriette who can now return to auction block.
	HarrietteJackobs.enable(true)

	; Move the guard back to his starting spot in case he ended up in the cell.
	_aAuctionJailer.MoveToMyEditorLocation()

	; Make sure the doors are closed (again).  We need to make sure they are closed
	; for the player's next visit.
	Lock_Cell_Doors()

	; If we created temporary furniture to lock the player in remove it now.
	if (_oAuctionFurniture)
		if (_qDfwFramework)
			_qDfwFramework.SetBdsmFurnitureLocked(False)
		endif
		zbfSlot qZbfPlayerSlot = zbfBondageShell.GetApi().FindPlayer()
		qZbfPlayerSlot.SetFurniture(None)
		_oAuctionFurniture.Delete()
		_oAuctionFurniture = None
	endif

	if (_qDfwFramework)
		_qDfwFramework.ForceSave()

		; Clear any DFW registration we have of being the player's Master.
		_qDfwFramework.ClearMaster(None, "SS Auction")
	endif

	; Resume attacks from the deviously helpless mod.  For some outcomes this might not be
	; desireable.  We should figure out which ones leave it suspended for those.
	SendModEvent("dhlp-Resume")

	; Remove the Simple Slavery auction house restraints from the player.
	Add_SS_Restraints(False)
endfunction

function QAYL_Slavery()								; Quick As You Like

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	;here and in functions beneath we do not need to check for quest presence
	;because it done at game load in Config script (SSLV_ConfigScr)
	Quest theQuest = Quest.GetQuest("qayl")
	theQuest.SetStage(1)
	Config.QAYL_enabled=false
endfunction

function DevCidhna_Slavery()						; Devious Cidhna pirates prize

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	SendModEvent("dvcidhna_startpirates")
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(5)
	Config.DevCidhna_enabled=false
endfunction

function WClub_Slavery()							;Wolf Club

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	int handle = ModEvent.Create("WolfClubEnslavePlayer")
	if(handle)
		ModEvent.Send(handle)
	endif

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()

	Config.WClub_enabled=false
endfunction

function SoT_Slavery()								;Slaves of Tamriel

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	Quest theQuest = Quest.GetQuest("SLTMineQuest")
	theQuest.start()
	LightFade.ApplyCrossFade(3)
	;utility.wait(3)
	LightFade.Remove()
	utility.wait(5)
	Config.SoT_enabled=false

endfunction

function ME_Slavery()								;Maria Eden

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()
	PlayerRef.MoveTo(SSLV_SlaveMark55)
	actor newMaster = SSLV_Master5
	newMaster.enable(true)
	int handle = ModEvent.Create("MariaPlayerEnslaveBy")
	if(handle)
		ModEvent.PushForm(handle, newMaster as Form)
		ModEvent.Send(handle)
	else
		debug.trace(self + " for Maria Eden failed to create handle")
	endif
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(5)
	Config.ME_enabled=false
endfunction

function CD_Slavery()								;Captured Dreams

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You struggle to hold back tears as you are led away from the platform.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	Quest CDQuest
	GlobalVariable CDGlobal
	
	utility.wait(3)
	CDQuest = Game.GetFormFromFile( 0x04E321, "Captured Dreams.esp" ) as Quest
	CDGlobal = Game.GetFormFromFile( 0x04FED4, "Captured Dreams.esp" ) as GlobalVariable
	
	CDGlobal.SetValue(14)
	CDQuest.SetStage(50)
	
	utility.wait(2)
	Game.DisablePlayerControls()
	Game.ForceThirdPerson()
	Game.SetPlayerAIDriven(true)
	Config.CD_enabled=false
endfunction

function HiD_Slavery()								;Heroine in Distress

	CurrentScene = SSLV_HiD_Scene
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You feel numb all over as you are led away in thicker chains than ever before.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	Quest theQuest = Quest.GetQuest("hidSpiderQuest")
	if(theQuest)
		debug.notification("Heroine in Disress found")
		debug.MessageBox("You are blindfolded and carted off to...somewhere.")
		debug.MessageBox("After an undetermined amount of time, you are shoved into a cool, damp place and the blindfold is removed.")
		theQuest.SetStage(61)
		LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	debug.MessageBox("It is a cave! A voice from a quickly retreating person tells you that if you can get out, you are free.")
		
		Config.HiD_enabled=false
	endif
endfunction

function SD_Slavery()								;Sanguine with variations

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	;debug.MessageBox("You fight tooth and nail - literally, since you have nothing else with which to fight - as you are led away, but to no avail.")

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	int Variant
	actor Master
	bool MasterChosen = false

	while(MasterChosen == false)
		Variant = utility.RandomInt(1, 6)

		if(Variant == 1 && Master3Used == false)							; SD slavery Whiterun Imperial Camp
			SSLV_Master1.enable(true)
			Master = SSLV_Master1
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 1)
			PlayerRef.MoveTo(SSLV_SlaveMark2)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark2)
		elseif(Variant == 2 && Master2Used == false)						; SD slavery Eastmarch Imperial Camp
			SSLV_Master2.enable(true)
			Master = SSLV_Master2
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 2)
			PlayerRef.MoveTo(SSLV_SlaveMark3)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark3)
		elseif(Variant == 3 && Master1Used == false)						; SD slavery Winterhold Stormcloak Camp
			SSLV_Master3.enable(true)
			Master = SSLV_Master3
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 3)
			PlayerRef.MoveTo(SSLV_SlaveMark33)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark33)		
		elseif(Variant == 4 && Master6Used == false)						; SD slavery Near Fort Greymoor
			SSLV_Master4.enable(true)
			Master = SSLV_Master4
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 4)
			PlayerRef.MoveTo(SSLV_SlaveMark4)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark4)
		elseif(Variant == 5 && Master4Used == false)						; SD slavery Reach Stormcloak Camp
			SSLV_Master5.enable(true)
			Master = SSLV_Master5
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 6)
			PlayerRef.MoveTo(SSLV_SlaveMark44)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark44)		
		elseif(Variant == 6 && Master7Used == false)						; SD slavery Near Fort Amol
			SSLV_Master6.enable(true)
			Master = SSLV_Master6
			StorageUtil.SetIntValue(Master, "_SD_iPersonalityProfile", 7)
			PlayerRef.MoveTo(SSLV_SlaveMark55)				
			MastersToUse -= 1
			Master3Used = true
			MasterChosen = true
			Master.MoveTo(SSLV_SlaveMark55)		
		endif
	endwhile

	if(MastersToUse == 0)
		Config.SD_Enabled = false
	endif

	debug.messagebox("We've got a long way to travel. Don't give me any trouble.")
	Master.enable(true)
	Master.SendModEvent("PCSubEnslave")
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	utility.wait(3)
	;master.moveto(SSLV_SlaveMark1)
	;PlayerRef.MoveTo(SSLV_SlaveMark2)
endfunction

function SLUTS_Slavery()								;S.L.U.T.S.

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("sluts ss debug: sending modevent")
	sendmodevent("S.L.U.T.S. Enslavement")
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(10)	
endfunction

function Submissive_Slavery()								;Submissive

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("Player Submissive")
	PlayerRef.MoveTo(SSLV_SubMark)

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(10)	
endfunction

function Slaverun_Slavery()								;Slaverun Reloaded

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("slaverun ss debug: sending modevent")
	sendmodevent("SlaverunReloaded_ForceEnslavement")
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
		
endfunction

function Lola_Slavery()								;Submissive Lola

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("Submissive Lola")
	;PlayerRef.MoveTo(SSLV_SubMark)
	Quest theQuest = Quest.GetQuest("vkjStrongHand")
	if !theQuest.IsRunning() && !MQ.IsRunning() 
		theQuest.Reset()
		theQuest.Start()
		theQuest.SetStage(0)
	else
		Debug.Notification("Submissive Lola is already running")
	endIf 

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(10)	
endfunction

function Isle_Slavery()								; Island of Mara

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	Quest theQuest = Quest.GetQuest("melislehookquest")
	theQuest.SetStage(10)
	Config.Isle_enabled=false
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	;utility.wait(10)
	Config.Isle_enabled=false
endfunction

function Raven_Slavery()								; Raven Beak Prison

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	;Set bounty amount
	;CrimeFactionHjaalmarch.SetCrimeGold(1000)
	;Start Raven Beak
	Quest theQuest = Quest.GetQuest("RavenBeakWarden")
	theQuest.SetStage(0)
	;Turn off Raven Beak in the MCM
	;Config.Raven_enabled=false
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
endfunction

function DCUR_Bondage_Slavery()								;Deviously Cursed Loot Bondage Adventure

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	PlayerRef.MoveTo(SSLV_SlaveMark33)
	debug.trace("DCUR Bondage debug: sending modevent")
	debug.messagebox("You are blindfolded and forced into what feels like a cart.")
	debug.messagebox("After an indeterminate period, the cart stops and you are shoved out.")
	debug.messagebox("I have a bet with some of my friends on how long it will take. Don't let me down!")
	debug.messagebox("A rough voice speaks into your ear.")
	debug.messagebox("You are free! If you can find your way out of these bindings.")
	sendmodevent("dcur-triggerbondageadventure")
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	
endfunction

function DCUR_Damsel_Slavery()								;Deviously Cursed Loot Damsel Adventure

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("DCUR Damsel debug: sending modevent")
	debug.messagebox("You are blindfolded and forced into what feels like a cart.")
	debug.messagebox("After an indeterminate period, the cart stops and you are shoved out.")
	debug.messagebox("I have a bet with some of my friends on how long it will take. Don't let me down!")
	debug.messagebox("A rough voice speaks into your ear.")
	debug.messagebox("You are free! If you can find your way out of these bindings.")
	sendmodevent("dcur-triggerdamselindistress")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
endfunction

function DCUR_Doll_Slavery()								;Deviously Cursed Loot Rubber Doll

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	PlayerRef.MoveTo(SSLV_SlaveMark66)
	debug.trace("DCUR Doll debug: sending modevent")
	debug.messagebox("You are blindfolded and forced into what feels like a cart.")
	debug.messagebox("After an indeterminate period, the cart stops and you are shoved out.")
	debug.messagebox("I have a bet with some of my friends on how long it will take. Don't let me down!")
	debug.messagebox("A rough voice speaks into your ear.")
	debug.messagebox("You are free! If you can find your way out of these bindings.")
	sendmodevent("dcur-triggerrubberdoll")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
		
endfunction

function DCUR_Collar_Slavery()								;Deviously Cursed Loot Cursed Collar

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	PlayerRef.MoveTo(SSLV_SlaveMark3)
	debug.trace("DCUR Collar debug: sending modevent")
	debug.messagebox("You are blindfolded and forced into what feels like a cart.")
	debug.messagebox("After an indeterminate period, the cart stops and you are shoved out.")
	debug.messagebox("I have a bet with some of my friends on how long it will take. Don't let me down!")
	debug.messagebox("A rough voice speaks into your ear.")
	debug.messagebox("You are free! But this collar will not come off until you have serviced enough people for its liking.")

	sendmodevent("dcur-triggercursedcollar")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()

endfunction

function DCUR_Leon_Slavery()								;Deviously Cursed Loot Leon

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()
	debug.trace("DCUR Leon debug: sending modevent")
	sendmodevent("dcur_TriggerLeonSlavery")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
endfunction

function DCUR_Leah_Slavery()								;Deviously Cursed Loot Leah

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("DCUR Leon debug: sending modevent")

	sendmodevent("dcur_TriggerLeahSlavery")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()

endfunction

function Mia_Slavery()								;Mia's Lair

	CurrentScene = SSLV_Mia_Scene
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	debug.trace("Mia's Lair")
	PlayerRef.MoveTo(SSLV_MiaMark)
	Quest theQuest = Quest.GetQuest("aqss_miavessinter")
	theQuest.SetStage(45)
	debug.messagebox("On the way to your new masters, you manage to free yourself from most of your chains.")
	debug.messagebox("Fortunately, your gear is stored in a bag nearby. You pick up your stuff.")
	debug.messagebox("Not a moment too soon. The slavers have spotted you and are attacking!")

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
	theQuest.SetStage(50)
	Config.Mia_enabled=false
endfunction

function RedWave_Slavery()								; Red Wave

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	;here and in functions beneath we do not need to check for quest presence
	;because it done at game load in Config script (SSLV_ConfigScr)
	SendModEvent("_SLS_PCStartRedWave")
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
endfunction

function TitD_Slavery()								; Things in the Dark

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

	;Start Things in the Dark
	Quest theQuest = Quest.GetQuest("atid0starter")
	theQuest.SetStage(30)
	Config.Things_Enabled=false
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()
endfunction

function DFollowers_Slavery()								;Devious Follower simple slavery outcome

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()

     sendmodevent("DFEnslave")
	
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()

endfunction

function WWBBrothel_Slavery()								;WWBBrothel simple slavery outcome

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	Debug.SendAnimationEvent(Game.Getplayer(), "IdleForceDefaultState")
	BlackFade.ApplyCrossFade(3)
	utility.wait(3)
	HarrietteJackobs.enable(true)
	SendModEvent("dhlp-Resume")

	debug.trace("WWBB debug: sending modevent")
	sendmodevent("WWBBrothelEnslave")
	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	LightFade.Remove()

endfunction
	
;simple stub
;move to farm
function NoMod_Slavery()

	CurrentScene = SceneSelector()
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 200)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile

	LightFade.ApplyCrossFade(3)
	utility.wait(3)
	Post_Auction_Cleanup()
	;PlayerRef.MoveTo(SSLV_FarmMark2)
	PlayerRef.MoveTo(SSLV_SlaveMark55)
	LightFade.Remove()
	utility.wait(5)
	debug.messagebox("You were bought by a group who despises slavery. They have returned your items and set you free.")

endfunction

int function GetNumEnabledMods()
	int iCount = 0
	if(Config.SD_Enabled)
		iCount += 1
	endif
	if(Config.QAYL_Enabled)
		iCount += 1
	endif
	if(Config.DevCidhna_Enabled)
		iCount += 1
	endif
	if(Config.WClub_Enabled)
		iCount += 1
	endif
	if(Config.SoT_Enabled)
		iCount += 1
	endif
	if(Config.ME_Enabled)
		iCount += 1
	endif
	if(Config.CD_Enabled)
		iCount += 1
	endif
	if(Config.HiD_Enabled)
		iCount += 1
	endif
	if(Config.SLUTS_Enabled)
		iCount += 1
	endif
	if(Config.Submissive_Enabled)
		iCount += 1
	endif
	if(Config.Slaverun_Enabled)
		iCount += 1
	endif
	if(Config.Lola_Enabled)
		iCount += 1
	endif
	if(Config.Isle_Enabled)
		iCount += 1
	endif
	if(Config.DCUR_Bondage_Enabled)
		iCount += 1
	endif
	if(Config.DCUR_Damsel_Enabled)
		iCount += 1
	endif
		if(Config.DCUR_Doll_Enabled)
		iCount += 1
	endif
	if(Config.DCUR_Collar_Enabled)
		iCount += 1
	endif
	if(Config.DCUR_Leon_Enabled)
		iCount += 1
	endif
	if(Config.DCUR_Leah_Enabled)
		iCount += 1
	endif
	if(Config.Raven_Enabled)
		iCount += 1
	endif
	if(Config.Mia_Enabled)
		iCount += 1
	endif	
		if(Config.Stories_Enabled)
		iCount += 1
	endif
		if(Config.Things_Enabled)
		iCount += 1
	endif	
		if(Config.DFollowers_Enabled)
		iCount += 1
	endif
		if(Config.WWBBrothel_Enabled)
		iCount += 1
	endif
	return iCount
endfunction

function ChoosingSlavery()
	SetObjectiveCompleted(40)

	int Probability = GetNumEnabledMods()
	if(Probability != 0)
		Probability = utility.RandomInt(1, Probability)
	endif
	
	if(Probability != 0)
		if(Config.SD_Enabled)
			if(Probability == 1)
				Probability = 0
				SD_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.QAYL_Enabled)
			if(Probability == 1)
				Probability = 0
				QAYL_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DevCidhna_Enabled)
			if(Probability == 1)
				Probability = 0
				DevCidhna_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.WClub_Enabled)
			if(Probability == 1)
				Probability = 0
				WClub_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.SoT_Enabled)
			if(Probability == 1)
				Probability = 0
				SoT_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.ME_Enabled)
			if(Probability == 1)
				Probability = 0
				ME_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.CD_Enabled)
			if(Probability == 1)
				Probability = 0
				CD_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.SLUTS_Enabled)
			if(Probability == 1)
				Probability = 0
				SLUTS_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.HiD_Enabled)
			if(Probability == 1)
				Probability = 0
				HiD_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Submissive_Enabled)
			if(Probability == 1)
				Probability = 0
				Submissive_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Slaverun_Enabled)
			if(Probability == 1)
				Probability = 0
				Slaverun_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Lola_Enabled)
			if(Probability == 1)
				Probability = 0
				Lola_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Isle_Enabled)
			if(Probability == 1)
				Probability = 0
				Isle_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DCUR_Bondage_Enabled)
			if(Probability == 1)
				Probability = 0
				DCUR_Bondage_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DCUR_Damsel_Enabled)
			if(Probability == 1)
				Probability = 0
				DCUR_Damsel_Slavery()
			else
				Probability -= 1
			endif
		endif
			if(Config.DCUR_Doll_Enabled)
		if(Probability == 1)
			Probability = 0
			DCUR_Doll_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DCUR_Collar_Enabled)
			if(Probability == 1)
				Probability = 0
				DCUR_Collar_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DCUR_Leon_Enabled)
			if(Probability == 1)
				Probability = 0
				DCUR_Leon_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.DCUR_Leah_Enabled)
			if(Probability == 1)
				Probability = 0
				DCUR_Leah_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Raven_Enabled)
		if(Probability == 1)
			Probability = 0
			Raven_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Mia_Enabled)
			if(Probability == 1)
				Probability = 0
				Mia_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.Stories_Enabled)
			if(Probability == 1)
				Probability = 0
				RedWave_Slavery()
			else
				Probability -= 1
			endif
		endif	
		if(Config.Things_Enabled)
			if(Probability == 1)
				Probability = 0
				TitD_Slavery()
			else
				Probability -= 1
			endif			
		endif
		if(Config.DFollowers_Enabled)
			if(Probability == 1)
				Probability = 0
				DFollowers_Slavery()
			else
				Probability -= 1
			endif
		endif
		if(Config.WWBBrothel_Enabled)
			if(Probability == 1)
				Probability = 0
				WWBBrothel_Slavery()
			else
				Probability -= 1
			endif
		endif
	else
			;start default enslavement
			NoMod_Slavery()
	endif
	
	SetObjectiveDisplayed(120)
	SetStage(120)
	EnableControls()
endfunction

Function Log(String szMessage, Int iLevel=0, Int iClass=0)
   szMessage = "[SS] " + szMessage

   ; Log to the papyrus file.
   If (ilevel <= _iMcmLogLevel)
      Debug.Trace(szMessage)
   EndIf

   ; Also log to the Notification area of the screen.
   ;If (_aiMcmScreenLogLevel && (ilevel <= _aiMcmScreenLogLevel[iClass]))
   ;   Debug.Notification(szMessage)
   ;EndIf
EndFunction

Function ClearDevices(bool destroyDevices = false) 




	Quest theQuest = Quest.GetQuest("zadQuest")
	Zadlibs libs = (theQuest as Zadlibs)
	Armor idevice
	Armor rdevice
	Keyword kw
	Actor a = Playerref
	if !a.WornHasKeyword(libs.zad_Lockable)
		; no DD items equipped, can abort here
		return
	
	else
	
	CurrentScene= SimpleSlaveryDeviceRemovalStart
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 15)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
	endif
	; We remove belts first to force any corsets back to a state when they can be removed.
	if a.WornHasKeyword(libs.zad_DeviousBelt)
	CurrentScene= SimpleSlaveryDeviceRemovalBelt
	CurrentScene.Start()
	while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
		utility.wait(1)
		if(utility.GetCurrentRealTime() - fStartTime == 15)	;200 seconds enough to complete scene but still running so it simply stuck
			debug.trace(self + " Scene Stuck: " + CurrentScene)
			AuctionSceneCompleted = true
			CurrentScene.Stop()
		endif
	endwhile
		idevice = libs.GetWornDevice(a, libs.zad_DeviousBelt)
		if idevice
			rdevice = libs.GetRenderedDevice(idevice)
		Endif			
		If idevice && rdevice				
			
				libs.removeDevice(a, idevice, rdevice, libs.zad_DeviousBelt, destroyDevice = destroyDevices, skipevents = false, skipmutex = true)			
				Utility.Wait(2)
					
		Endif	
	EndIf	
	int i = 1
	int r = 0
	kw = getKeyword(i)
	while (kw != KeyWord.GetKeyword("zad_Lockable"))
		if a.wornhaskeyword(kw)
			idevice = libs.GetWornDevice(a, kw)
			if idevice
				rdevice = libs.GetRenderedDevice(idevice)
			Endif			
			If idevice && rdevice				
						libs.removeDevice(a, idevice, rdevice, kw, destroyDevice = destroyDevices, skipevents = false, skipmutex = true)	
						DisableControls()
						r+=1
						if r==3||r==4||r==6||r==9||r==13||r==1||r==2
							CurrentScene= SimpleSlaveryDeviceRemovalDevices
							CurrentScene.Start()
							while(CurrentScene.IsPlaying() && !AuctionSceneCompleted)
								utility.wait(1)
								if(utility.GetCurrentRealTime() - fStartTime == 15)	;200 seconds enough to complete scene but still running so it simply stuck
										debug.trace(self + " Scene Stuck: " + CurrentScene)
										AuctionSceneCompleted = true
										CurrentScene.Stop()
								endif
							endwhile
						endif
		
			EndIf
		endif
		Utility.Wait(1)
				
			
		
	i += 1
	kw = getKeyword(i)
	endwhile
	Outfit()
	
EndFunction

keyword Function GetKeyword(int a)
	if a == 1
	Return KeyWord.GetKeyword("zad_DeviousPlug")
	ElseIf a == 2
	Return KeyWord.GetKeyword("zad_DeviousHeavyBondage")
	ElseIf a == 3
	Return KeyWord.GetKeyword("zad_DeviousBelt")
	ElseIf a == 4
	Return KeyWord.GetKeyword("zad_DeviousBra")
	ElseIf a == 5
	Return  KeyWord.GetKeyword("zad_DeviousCollar")
	ElseIf a == 6
	Return  KeyWord.GetKeyword("zad_DeviousArmCuffs")
	ElseIf a == 7
	Return KeyWord.GetKeyword("zad_DeviousLegCuffs")
	ElseIf a == 8
	Return KeyWord.GetKeyword("zad_DeviousArmbinder")
	ElseIf a == 9
	Return KeyWord.GetKeyword("zad_DeviousYoke")
	ElseIf a == 10
	Return KeyWord.GetKeyword("zad_DeviousCorset")
	ElseIf a == 11
	Return KeyWord.GetKeyword("zad_DeviousClamps")
	ElseIf a == 12
	Return KeyWord.GetKeyword("zad_DeviousGloves")
	ElseIf a == 13
	Return KeyWord.GetKeyword("zad_DeviousHood")
	ElseIf a == 14
	Return KeyWord.GetKeyword("zad_DeviousSuit")
	ElseIf a == 15
	Return KeyWord.GetKeyword("zad_DeviousGag")
	ElseIf a == 16
	Return KeyWord.GetKeyword("zad_DeviousGagPanel")
	ElseIf a == 17
	return KeyWord.GetKeyword("zad_DeviousPlugVaginal")
	ElseIf a == 18
	Return KeyWord.GetKeyword("zad_DeviousPlugAnal")
	ElseIf a == 19
	Return KeyWord.GetKeyword("zad_DeviousHarness")
	ElseIf a == 20
	Return KeyWord.GetKeyword("zad_DeviousBlindfold")
	ElseIf a == 21
	Return KeyWord.GetKeyword("zad_DeviousBoots")
	ElseIf a == 22
	Return KeyWord.GetKeyword("zad_DeviousPiercingsNipple")
	ElseIf a == 23
	Return KeyWord.GetKeyword("zad_DeviousPiercingsVaginal")
	ElseIf a == 24
	Return KeyWord.GetKeyword("zad_DeviousArmbinderElbow")
	ElseIf a == 25
	Return KeyWord.GetKeyword("zad_DeviousYokeBB")
	ElseIf a == 26
	Return KeyWord.GetKeyword("zad_DeviousCuffsFront")
	ElseIf a == 27
	Return KeyWord.GetKeyword("zad_DeviousStraitJacket")
	ElseIf a == 28
	Return KeyWord.GetKeyword("zad_DeviousBondageMittens")
	ElseIf a == 29
	Return KeyWord.GetKeyword("zad_DeviousHobbleSkirt")
	Else
	Return KeyWord.GetKeyword("zad_Lockable")
	endif
EndFunction

function DisableControls()

    ;game.disablePlayerControls() 
    ;Utility.Wait(1.0)
    ;game.forcethirdperson()
    ;Utility.Wait(1.0)
    game.setplayeraidriven(true); this gets called toward the end during disable, reverse for enable.

EndFunction


 

Function EnableControls()

    game.setplayeraidriven(false); If I remember I think first spot in function is important for this while re-enabling.
    ;Game.EnablePlayerControls()
	
	;Debug.SendAnimationEvent(Game.Getplayer(), "IdleForceDefaultState")

EndFunction


