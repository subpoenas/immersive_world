Scriptname SLApproachMainScript extends Quest Conditional

SLAppPCSexQuestScript Property SLAppPCSex Auto

Quest Property zadquest Auto

Faction Property slapp_AquaintedFaction Auto
Faction Property slapp_DislikeFaction Auto
Faction Property slapp_RapeFailFaction Auto
Faction Property slapp_ReconciliationFaction Auto


Faction Property BaboAggressiveBoyFriend Auto
Faction Property BaboDialogueFaction Auto
Faction Property BaboViceGuardCaptainFaction Auto
Faction Property BaboWasHireling Auto
Faction Property BaboPotentialHireling Auto
Faction Property BaboCurrentHireling Auto

Faction Property SLTollCollectorFaction Auto
Faction Property SLKennelKeeperFaction Auto
Faction Property SLLicenseQuarterMasterFaction Auto

ObjectReference Property BaboChestWhiterunRef Auto
Keyword Property SLHHScriptEventKeyword Auto

Actor Property PlayerRef Auto
Spell Property ApproachCloak Auto
Spell Property SLApproachCloakAbility Auto
int Property SLApproachTimelimit = 30 Auto
int Property cloakFrequency = 13 Auto
float Property baseChanceMultiplier = 0.7 Auto
int Property totalAwarnessRange = 256 Auto ; no longer used

float Property ProstitutionAcceptChance = 0.0 Auto Conditional

bool Property enableSLHHFlag = false Auto Conditional
bool Property enableBDFlag = false Auto Conditional
bool Property enableSexlabSurvivalFlag = false Auto Conditional
bool Property enableDDIFlag = false Auto Conditional

bool Property debugLogFlag = false Auto
bool Property enablePromiseFlag = false Auto 
bool Property enableRapeFlag = true Auto
bool Property enableForceThirdPersonHug = true Auto
bool Property enableRelationChangeFlag = false Auto ; no longer used
bool Property enableElderRaceFlag = false Auto
bool Property enableFollowerFlag = false Auto
bool Property enableHirelingFlag = false Auto
bool Property enableGuardFlag = false Auto
bool Property enableDremoraFlag = false Auto
bool Property enableChildFlag = false Auto
bool Property enableThalmorFlag = false Auto
bool Property enableVisitorFlag = false Auto
bool Property enablePetsFlag = false Auto ; Temporarily locked
bool Property enablePlayerHorseFlag = false Auto ; Temporarily locked

GlobalVariable Property SLAStandardLevelMaximumNPCGlobal Auto
GlobalVariable Property SLAStandardLevelMinimumNPCGlobal Auto

bool property SLALowerLevelNPC = false Auto
bool property SLAHigherLevelNPC = false Auto
bool property SLAStandardLevelNPC = false Auto

int property SLANPCUniqueCharacterMin = 0 Auto
int property SLANPCUniqueCharacterMax = 2 Auto
int property SLANPCCharacterMin = 0 Auto Conditional
int property SLANPCCharacterMax = 3 Auto Conditional

int property SLAHouseVisitChance = 5 Auto

int property SLARelationshipChance = 40 Auto
int property SLAAquaintanceChance = 80 Auto
int property SLADislikeChance = 50 Auto

int property SLADeviationLevel = 5 Auto

int property SLAPCAppearance = 50 Auto
int property SLAPCBreasts = 50 Auto
int property SLAPCButts = 50 Auto

bool Property SLANakedArmor = false Auto

bool Property SLAUniqueActor = false Auto

bool Property SLAProstitution = false Auto Conditional
bool Property SLAProstitutionFollow = false Auto Conditional

int Property SLAProstitutionpayway Auto Conditional; 0 means prepaid and 1 means postpaid

int Property lowestArousalPC = 0 Auto
int Property lowestArousalNPC = 10 Auto

int Property userAddingPointPc = -20 Auto;-150~100
int Property userAddingPointNpc = -10 Auto

int Property userAddingRapePointPc = 0 Auto
int Property userAddingRapePointNpc = 0 Auto

int Property userAddingHugPointPc = 0 Auto
int Property userAddingHugPointNpc = 0 Auto

int Property userAddingaskingnamePointPc = -20 Auto
int Property userAddingKissPointPc = -10 Auto
int Property userAddingKissPointNpc = -10 Auto

bool property hasfoundtheactor = false Auto
bool property isDuringCloakPulse = false Auto
int Property actorsEffectStarted = 0 Auto
int Property actorsEffectFinished = 0 Auto

bool Property isSkipUpdateMode = false Auto
bool Property SLALocktheDoor = false Auto

slapp_util Property slappUtil Auto

Book Property _SLS_LicenceClothes Auto
Book Property _SLS_LicenceBikini Auto
Book Property _SLS_LicenceWeapon Auto
Book Property _SLS_LicenceArmor Auto
Book Property _SLS_LicenceMagic Auto
Book Property _SLS_EvictionNotice Auto

ObjectReference Property SLAPPXmarkerFrontDoorWhiterunRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH01Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH02Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorBYOH03Ref Auto
ObjectReference Property SLAPPXmarkerFrontDoorSolitudeRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorMarkarthRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorRiftenRef Auto
ObjectReference Property SLAPPXmarkerFrontDoorWindhelmRef Auto


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

Formlist Property SLApproachDDIList Auto
Formlist Property SLApproachDDIBeltList Auto
Formlist Property SLApproachDDIBraList Auto
Formlist Property SLApproachDDICollarList Auto
Formlist Property SLApproachDDICorsetList Auto
Formlist Property SLApproachDDIGagList Auto
Formlist Property SLApproachDDIPiercingNList Auto
Formlist Property SLApproachDDIPiercingVList Auto
Formlist Property SLApproachDDIPlugAList Auto
Formlist Property SLApproachDDIPlugVList Auto
Formlist Property SLApproachDDIYokeList Auto

Key Property zad_ChastityKey Auto
Key Property zad_PiercingsRemovalTool Auto
Key Property zad_RestraintsKey Auto

int my_cloakRange = 192

int Property cloakRange
	int Function get()
		return my_cloakRange
	EndFunction
	Function set(int value)
		my_cloakRange = value
		ApproachCloak.SetNthEffectMagnitude(0, value as float)
	EndFunction
EndProperty


bool initilized = false

int registeredQuestsAmount
bool[] approachQuestsInitilizationArray
Quest[] approachQuests
string[] approachQuestNames
SLApproachBaseQuestScript[] approachQuestScripts

Event OnInit()
	Maintenance()
EndEvent

Function Maintenance()
	if (!initilized)
		initApproachQuestRegister()
	endif
	
	initilized = true
	PlayerRef.RemoveSpell(SLApproachCloakAbility)

	UnregisterForAllModEvents()
EndFunction

Function initApproachQuestRegister()
	registeredQuestsAmount = 0

	approachQuestsInitilizationArray = New bool[8]
	int counter = 8

	while counter
		counter -= 1
		approachQuestsInitilizationArray[counter] = false
	endwhile

	approachQuests = New Quest[8]
	approachQuestNames = new string[8]
	approachQuestScripts = new SLApproachBaseQuestScript[8]
EndFunction

bool Function StartInitOfQuestByIndex(int index)
	if (approachQuestsInitilizationArray[index])
		return false
	else
		slappUtil.log("START index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = true
		return true
	endif
EndFunction

Function EndtInitOfQuestByIndex(int index)
	if (index >= 0)
		slappUtil.log("END index = " + index + " appQuestInitArray => " + approachQuestsInitilizationArray[index])
		approachQuestsInitilizationArray[index] = false
	endif
EndFunction

Function clearQuestStatus()
	int idx = approachQuestsInitilizationArray.Length
	while (idx > 0)
		idx -= 1
		approachQuestsInitilizationArray[idx] = false
	endwhile
	
	int qidx = getregisteredAmount()
	while (qidx > 0)
		qidx -= 1
		approachQuestScripts[qidx].endApproachForce()
	endwhile
EndFunction

int Function RegisterQuest(Quest newQuest, SLApproachBaseQuestScript newQuestScript, string newQuestName)
	if(!initilized)
		return -1
	endif
	
	int indexCounter = registeredQuestsAmount - 1
	while (indexCounter >= 0)
		if (approachQuestNames[indexCounter] == newQuestName)
			approachQuests[indexCounter] = newQuest
			approachQuestScripts[indexCounter] = newQuestScript
			; debug.notification("Sexlab Approach: Approach named " + newQuestName + " is running.")
			return indexCounter
		endif
		indexCounter = indexCounter - 1
	endwhile
	
	if (registeredQuestsAmount < 8)
		int newIndex = registeredQuestsAmount
		registeredQuestsAmount = registeredQuestsAmount + 1
		
		approachQuests[newIndex] = newQuest
		approachQuestScripts[newIndex] = newQuestScript
		approachQuestNames[newIndex] = newQuestName
		debug.notification("Sexlab Approach: Approach named " + newQuestName + " registered.")

		if(!newQuest.isRunning())
			newQuest.Start()
			debug.notification("SexLab Approach: " + newQuestName + " - Quest Init")
		endif

		return newIndex
	endif
	
	debug.notification("Sexlab Approach: Quest registration failed due to exceeding max approach quest limit.")
	return -1
EndFunction

int Function getregisteredAmount()
	return registeredQuestsAmount
EndFunction

;quest Function getApproachQuest(int index)
;	if (index < registeredQuestsAmount && index >= 0)
;		return approachQuests[index]
;	endif
;	
;	debug.notification("Sexlab Approach: Quest retrival failed - invalid index " + index)
;	debug.trace("Sexlab Approach: Quest retrival failed - invalid index " + index)
;
;	return None
;EndFunction

SLApproachBaseQuestScript Function getApproachQuestScript(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestScripts[index]
	endif
	
	debug.notification("Sexlab Approach: Script retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Script retrival failed - invalid index " + index)
	
	return None
EndFunction

string Function getApproachQuestName(int index)
	if (index < registeredQuestsAmount && index >= 0)
		return approachQuestNames[index]
	endif
	
	debug.notification("Sexlab Approach: Quest Name retrival failed - invalid index " + index)
	debug.trace("Sexlab Approach: Quest Name retrival failed - invalid index " + index)

	return None
EndFunction

Function addActorEffectStarted() ; When the Cloak Effect Starts.
	actorsEffectStarted += 1
EndFunction

Function addActorEffectFinished() ; When the Cloak Effect Finished.
	actorsEffectFinished += 1
EndFunction


Function Openthedoor(ObjectReference ref)
	SLAppPCSex.PreVisitorEntering()
EndFunction

Function Lockthedoor(ObjectReference ref, bool lockdoor) ; No more used
	Key door_key = ref.GetKey()
	if PlayerRef.GetItemCount(door_key) >= 1 && (lockdoor == true)
		ref.lock(true, true)
		debug.notification("I locked the door")
	elseif PlayerRef.GetItemCount(door_key) >= 1 && (lockdoor == false)
		ref.lock(false, true)
		debug.notification("I unlocked the door")
	else
		debug.notification("I don't have the key to lock the door.")
	endif
EndFunction

;####################################################
;###############Sexlab Survival######################
;####################################################

GlobalVariable Property SLA_SLSurvivalLicenseClothes Auto
GlobalVariable Property SLA_SLSurvivalLicenseBikini Auto
GlobalVariable Property SLA_SLSurvivalLicenseWeapon Auto
GlobalVariable Property SLA_SLSurvivalLicenseArmor Auto
GlobalVariable Property SLA_SLSurvivalLicenseMagic Auto
GlobalVariable Property SLA_SLSurvivalLicenseNotice Auto

Function SLSurvivalLicenseCheck()
	SLSurvivalLicenseClothes()
	SLSurvivalLicenseBikini()
	SLSurvivalLicenseWeapon()
	SLSurvivalLicenseArmor()
	SLSurvivalLicenseMagic()
	SLSurvivalLicenseNotice()
EndFunction

Bool Function SLSurvivalLicenseClothes()
if PlayerRef.getitemcount(_SLS_LicenceClothes) > 0
	SLA_SLSurvivalLicenseClothes.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseClothes.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseBikini()
if PlayerRef.getitemcount(_SLS_LicenceBikini) > 0
	SLA_SLSurvivalLicenseBikini.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseBikini.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseWeapon()
if PlayerRef.getitemcount(_SLS_LicenceWeapon) > 0
	SLA_SLSurvivalLicenseWeapon.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseWeapon.setvalue(0)
	return false
endif
Endfunction


Bool Function SLSurvivalLicenseArmor()
if PlayerRef.getitemcount(_SLS_LicenceArmor) > 0
	SLA_SLSurvivalLicenseArmor.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseArmor.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseMagic()
if PlayerRef.getitemcount(_SLS_LicenceMagic) > 0
	SLA_SLSurvivalLicenseMagic.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseMagic.setvalue(0)
	return false
endif
Endfunction

Bool Function SLSurvivalLicenseNotice()
if PlayerRef.getitemcount(_SLS_EvictionNotice) > 0
	SLA_SLSurvivalLicenseNotice.setvalue(1)
	return true
else
	SLA_SLSurvivalLicenseNotice.setvalue(0)
	return false
endif
Endfunction

;#############################################################
;#################Devious Devices Integration#################
;#############################################################


Function SLARemoveDDIDevice(Actor akActor, Armor deviceInventory, Keyword devicekeyword)
	zadlibs libs = zadquest as zadlibs
	libs.RemoveDevice(akActor, deviceInventory, libs.GetRenderedDevice(deviceInventory), devicekeyword, true, false)
EndFunction

Function SLARemoveYoke(Actor akActor)
	SLARemoveDDIDevice(akActor, self.GetWornYoke(akActor) as armor, zad_DeviousYoke)
EndFunction

Function SLAProvideDDIKey(Actor akActor)
	int RI = Utility.randomint(1,99)
	
	If (1 <= RI) && (34 > RI)
		akActor.additem(zad_ChastityKey, 1)
	elseIf (34 <= RI) && (67 > RI)
		akActor.additem(zad_PiercingsRemovalTool, 1)
	elseIf (67 <= RI) && (99 > RI)
		akActor.additem(zad_RestraintsKey, 1)
	else
	endif
	
EndFunction

Form Function GetRenderedDeviceInstance(actor akActor, int Slot, Keyword kwd)
	form f1 = akActor.GetWornForm(Slot) 
	if f1 && f1.HasKeyword(kwd)
		return f1
	Endif
	return none
EndFunction

Function CheckDD(actor akActor)
	GetWornYoke(akActor)
	GetWornBelt(akActor)
	GetWornCorset(akActor)
	GetWornCollar(akActor)
	GetWornBra(akActor)
	GetWornGag(akActor)
	GetWornPlugV(akActor)
	GetWornPlugA(akActor)
	GetWornPiercingV(akActor)
	GetWornPiercingN(akActor)
EndFunction

Form Function GetWornYoke(actor akActor)
	form armb = GetRenderedDeviceInstance(akActor, 0x00010000, zad_DeviousArmbinder)
	if !armb ; Check for yokes
		armb = GetRenderedDeviceInstance(akActor, 0x00010000, zad_DeviousYoke)
	EndIf
	
	if armb
		SLApproachDDIList.addform(armb)
		SLApproachDDIYokeList.addform(armb)
	endif
	
	return armb
EndFunction

Form Function GetWornBelt(actor akActor)
	form belt = GetRenderedDeviceInstance(akActor, 0x00080000, zad_DeviousBelt)
	if !belt ; Check for Harness
		belt = GetRenderedDeviceInstance(akActor, 0x00080000, zad_Lockable)
	EndIf
	
	if belt
		SLApproachDDIBeltList.addform(belt)
		;SLApproachDDIList.addform(belt)
	endif
	return belt
EndFunction

Form Function GetWornCorset(actor akActor)
	form belt = GetRenderedDeviceInstance(akActor, 0x10000000, zad_DeviousCorset)
	if !belt ; Check for Corset
		belt = GetRenderedDeviceInstance(akActor, 0x10000000, zad_Lockable)
	EndIf
	
	if belt
		SLApproachDDICorsetList.addform(belt)
		;SLApproachDDIList.addform(belt)
	endif
	return belt
EndFunction

Form Function GetWornCollar(actor akActor)
	form Collar = GetRenderedDeviceInstance(akActor, 0x00008000, zad_DeviousCollar)
	if !Collar
		Collar = GetRenderedDeviceInstance(akActor, 0x00008000, zad_Lockable)
	EndIf
	
	if Collar
		SLApproachDDIList.addform(Collar)
		SLApproachDDICollarList.addform(Collar)
	endif
	return Collar
EndFunction

Form Function GetWornBra(actor akActor)
	form Bra = GetRenderedDeviceInstance(akActor, 0x04000000, zad_DeviousBra)
	if !Bra
		Bra = GetRenderedDeviceInstance(akActor, 0x04000000, zad_Lockable)
	EndIf
	
	if Bra
		SLApproachDDIBraList.addform(Bra)
	endif
	return Bra
EndFunction

Form Function GetWornGag(actor akActor)
	form Gag = GetRenderedDeviceInstance(akActor, 0x00004000, zad_DeviousGag)
	if !Gag
		Gag = GetRenderedDeviceInstance(akActor, 0x00004000, zad_Lockable)
	EndIf
	
	if Gag
		SLApproachDDIGagList.addform(Gag)
	endif
	return Gag
EndFunction

Form Function GetWornPlugV(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x08000000, zad_DeviousPlugVaginal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x08000000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPlugVList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPlugA(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00040000, zad_DeviousPlugAnal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00040000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPlugAList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPiercingV(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00100000, zad_DeviousPiercingsVaginal)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00100000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPiercingVList.addform(plug)
	endif
	return plug
EndFunction

Form Function GetWornPiercingN(actor akActor)
	form plug = GetRenderedDeviceInstance(akActor, 0x00200000, zad_DeviousPiercingsNipple)
	if !plug
		plug = GetRenderedDeviceInstance(akActor, 0x00200000, zad_Lockable)
	EndIf
	
	if plug
		SLApproachDDIPiercingNList.addform(plug)
	endif
	return plug
EndFunction