Scriptname SLApproachBaseQuestScript extends Quest

Int Property index = -1 Auto
Int Property maxTime = 60 Auto
bool Property approachEnding = false Auto
bool Property isSkipMode = false Auto
Globalvariable Property SLAFactorScore Auto
slapp_util Property slappUtil Auto

Function register()
	index = -1
	while(index == -1)
		Utility.Wait(1.0)
		index = SLApproachMain.RegisterQuest(ApproachQuest, self, ApproachName)
	endwhile
EndFunction

Event OnUpdate()
if SLApproachMain.debugLogFlag
	Debug.notification("Parent: Onupdate")
endif
	endApproach()
endEvent

Function ready()
	self.Reset()
	self.SetStage(10)
EndFunction

Function startApproach(Actor akRef)
	;Debug.notification("Start Approach Base")
	RegisterForSingleUpdate(maxTime)
EndFunction

bool Function isSituationValid(Actor akRef, Actor player);Check if the situation is valid for a npc approach
ActorBase akRefbase = akRef.GetLeveledActorBase()
	if (!isSkipMode && !player.IsInCombat()  && !akRef.IsInCombat() && !akRef.IsWeaponDrawn() && !player.IsBleedingOut() && !akRef.IsBleedingOut() && SexLab.IsValidActor(akRef) && !SexLab.IsActorActive(akRef) && !player.IsOnMount() && !player.IsSwimming() && !player.IsSneaking())

		Race akRace = akRef.GetRace()

;#########################
;########Blocking#########
;#########################
		
		If (Player.isinfaction(SexLabAnimatingFaction)) || (akRef.isinfaction(SexLabAnimatingFaction))
			return false
		Elseif 	akref.isinfaction(banditfaction) || akref.isinfaction(JobJarlFaction) || akref.isinfaction(WINeverFillAliasesFaction) || akref.isinfaction(PlayerMarriedFaction)
			return false
		endif

;#########################
;######Unique Actor#######
;#########################
		
		if (SLApproachMain.SLAUniqueActor == true)
			if (akRefbase.isUnique());Check if the actor happens to be unique.
				if SLApproachMain.enableBDFlag
					if !(akref.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
						return false
					endif
				else
					return false
				endif
			endif
		EndIf
		
;#########################
;#Humanoid identification#
;#########################
		if !SLApproachMain.enableChildFlag && akRef.ischild()
			return false		
		elseif !SLApproachMain.enableElderRaceFlag && (akRace == ElderRace)
			return false
		elseif (SLApproachMain.enableGuardFlag == false) && (akRef.isinfaction(isguardfaction))
			return false
		elseif (SLApproachMain.enableDremoraFlag == false) && (akRace == DremoraRace)
			return false
		elseif (akRef.isinfaction(ThalmorFaction))
			return false
		elseif (SLApproachMain.enableVisitorFlag == false) && (akRef.isinfaction(slapp_VisitingFaction))
			return false
		elseif (akRace == ManakinRace)
			return false
		endif
		
;#########################
;##########Add-on#########
;#########################

		if SLApproachMain.enableSexlabSurvivalFlag
			SLApproachMain.SLSurvivalLicenseClothes()
			SLApproachMain.SLSurvivalLicenseBikini()
			SLApproachMain.SLSurvivalLicenseWeapon()
			SLApproachMain.SLSurvivalLicenseArmor()
			SLApproachMain.SLSurvivalLicenseMagic()
			SLApproachMain.SLSurvivalLicenseNotice()
			if  (akRef.isinfaction(SLApproachMain.SLTollCollectorFaction) || akRef.isinfaction(SLApproachMain.SLKennelKeeperFaction) || akRef.isinfaction(SLApproachMain.SLLicenseQuarterMasterFaction))
				return false
			endif
		endif

		if SLApproachMain.enableBDFlag
		
			if (SLApproachMain.enableHirelingFlag == false)
				if  (akRef.isinfaction(SLApproachMain.BaboPotentialHireling))
					return false
				endif
			endif
			
			if akRef.isinfaction(SLApproachMain.BaboWasHireling)
				akRef.addtofaction(slapp_washiringfaction)
				BaboDialogueMercenaryCall(akRef)
				return false
			elseif !akRef.isinfaction(SLApproachMain.BaboWasHireling) && akRef.isinfaction(slapp_washiringfaction)
				akRef.removefromfaction(slapp_washiringfaction)
				return false
			endif

			if akRef.isinfaction(SLApproachMain.BaboDialogueFaction)
				if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction)) && (akRef.getactorvalue("Variable06") == 5)
					return true
				else
					return false
				endif
			endif
			
			if SLApproachMain.enableFollowerFlag == false
				if (akRef.isinfaction(SLApproachMain.BaboCurrentHireling))
					return false
				endif
			endif
			
		endif
		
		if (SLApproachMain.enableHirelingFlag == false)
			if (akRef.isinfaction(CurrentHireling)) || (akRef.isinfaction(PotentialHireling))
				return false
			endif
		endif
		
		if SLApproachMain.enableFollowerFlag == false
			if (akref.isinfaction(CurrentFollowerFaction)) || (akRef.isinfaction(CurrentHireling)) || (akref.IsPlayerTeammate())
				return false
			endif
		endif

;#########################		
;########Creature######### WIP
;#########################

;		if (SLApproachMain.enablePetsFlag && akRef.IsPlayerTeammate()) ; WIP disabled
;			return true
;		elseif (akRace == HorseRace)
;			if (SLApproachMain.enablePlayerHorseFlag && slappUtil.ValidateHorse(akRef))
;				return true
;			else
;				return false
;			endif
;		endif

		if (akRace.AllowPickpocket()) ; Not for creatures
			return true
		else
			return false
		endif
	else
		return false
	endif
	
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier)
	return false
EndFunction

bool Function isPrecheckValid(Actor akRef, Actor akRef2, bool isplayer = false)
	if (!slappUtil.ValidatePromise(akRef, akRef2) || !slappUtil.ValidateShyness(akRef, akRef2))
		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
		slappUtil.log(ApproachName + " blocked by Promise or Shyness: " + debugstr)
		return false
	elseif !(slappUtil.ValidateGender(akRef, akRef2, isplayer))
		string debugstr = akRef.GetActorBase().GetName() + " => " + akRef2.GetActorBase().GetName()
		slappUtil.log(ApproachName + " blocked by Gender check: " + debugstr)
		return false
	endif
	
	return true
EndFunction

bool Function isSceneValid(Actor akRef)
	Scene aks = akRef.GetCurrentScene()
	
	if (aks)
		string akscene = aks.GetOwningQuest().GetId()
		string log = ApproachName + ": blocked by another Scene: "
		slappUtil.log(log + akRef.GetActorBase().GetName() + " : " + akscene)
		return false
	endif
	
	return true
EndFunction

int Function GetResult(int chance, int extpoint, float baseChanceMultiplier)
	int result = slappUtil.ValidateChance((chance + baseChanceMultiplier) as Int)
	result += extpoint
	return result
EndFunction

int Function GetDiceRoll()
	return Utility.RandomInt(0, 100)
EndFunction

Function endApproach(bool force = false)
	if SLApproachMain.debugLogFlag
		Debug.notification("Parent: endApproach")
	endif
	;approachEnding = false;deleted because it's duplicated.
	;ApproachQuest.SetStage(100)
	;UnregisterForUpdate()
	SLApproachMain.EndtInitOfQuestByIndex(index)
EndFunction

Function endApproachForce(ReferenceAlias akRef = None) ; for debug and Sex To PC's follow Scene
	slappUtil.log(ApproachName + ": endApproachForce!!")
	if (akRef)
		Actor fordebugact = akRef.GetActorRef()
		if (fordebugact)
			ActorBase fordebugname = fordebugact.GetActorBase()
			if (fordebugname)
				slappUtil.log(ApproachName + " Force Stop: " + fordebugname.GetName())
			endif
		endif
	endif
	
	self.endApproach(true)
EndFunction

Function sexRelationshipDown(Actor akRef, Actor PlayerRef, int Possibility)
int relationship = akRef.GetRelationshipRank(PlayerRef) - 1
Int DiceRoll = Self.GetDiceRoll()
; debug.notification("[slapp] " + relationship)
	If DiceRoll <= possibility
		if (relationship < -2)
			relationship = -2
		endif
		akRef.SetRelationshipRank(PlayerRef, relationship)
	EndIf
EndFunction

Function sexRelationshipUp(Actor akRef, Actor PlayerRef, int Possibility)
int relationship = akRef.GetRelationshipRank(PlayerRef) + 1
Int DiceRoll = Self.GetDiceRoll()
	If DiceRoll <= possibility
		if (relationship > 4)
			relationship = 4
		endif
		akRef.SetRelationshipRank(PlayerRef, relationship)
	endif
EndFunction

Function AddtoReconciliationFaction(actor akRef)
bool infaction = akRef.isinfaction(slapp_ReconciliationFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_ReconciliationFaction)
		If infaction == false
			akRef.addtofaction(slapp_ReconciliationFaction)
			akRef.setfactionrank(slapp_ReconciliationFaction, 0)
		Elseif (Rank == 0)
			akRef.setfactionrank(slapp_ReconciliationFaction, 1)
		ElseIf (Rank == 1)
			akRef.setfactionrank(slapp_ReconciliationFaction, 2)
		Elseif (Rank == 2)
			akRef.setfactionrank(slapp_ReconciliationFaction, 3)
		;Elseif (Rank == 3)
			;akRef.setfactionrank(slapp_ReconciliationFaction, 4)
		Endif
EndFunction

Function RankDownDislikeFaction(actor akRef)
;It will remove the faction from player for now. It needs to be improved.
akRef.removefromfaction(slapp_DislikeFaction)
EndFunction

Function AddtoVisitiedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_VisitedFaction)
Int Rank = akRef.GetfactionRank(slapp_VisitedFaction)
	If infaction == false
		akRef.addtofaction(slapp_VisitedFaction)
		akRef.setfactionrank(slapp_VisitedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_VisitedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoStayedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_StayedFaction)
Int Rank = akRef.GetfactionRank(slapp_StayedFaction)
	If infaction == false
		akRef.addtofaction(slapp_StayedFaction)
		akRef.setfactionrank(slapp_StayedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_StayedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoVisitiedFailedFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_VisitedFailedFaction)
Int Rank = akRef.GetfactionRank(slapp_VisitedFailedFaction)
	If infaction == false
		akRef.addtofaction(slapp_VisitedFailedFaction)
		akRef.setfactionrank(slapp_VisitedFailedFaction, 0);DislikeFaction
	Else
		akRef.setfactionrank(slapp_VisitedFailedFaction, Rank + 1)
	Endif
EndFunction

Function AddtoDislikeFaction(actor akRef, int possibility, bool Uprank = false)

bool infaction = akRef.isinfaction(slapp_DislikeFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_DislikeFaction)

	If DiceRoll <= possibility
	
		If infaction == false
			akRef.addtofaction(slapp_DislikeFaction)
			akRef.setfactionrank(slapp_DislikeFaction, 0);DislikeFaction
		Elseif (Rank >= 0) && (Rank < 2)
			akRef.setfactionrank(slapp_DislikeFaction, 1);HateFaction
		EndIf
		
		If (Rank < 2) && (Uprank == True)
			akRef.setfactionrank(slapp_DislikeFaction, 2);RaperFaction
		Elseif (Rank == 2) && (Uprank == True)
			akRef.setfactionrank(slapp_DislikeFaction, 3);ConstantRaperFaction
		;Elseif (Rank == 3) && (Uprank == True)
			;akRef.setfactionrank(slapp_DislikeFaction, 4);SlaveMasterFaction not yet
		Endif

	EndIf
EndFunction

Function AddtoProstitutionFaction(actor akRef)

bool infaction = akRef.isinfaction(slapp_ProstitutionFaction)

	If infaction == false
		akRef.addtofaction(slapp_ProstitutionFaction)
	else
		akRef.SetfactionRank(slapp_ProstitutionFaction, akRef.Getfactionrank(slapp_ProstitutionFaction) + 1)
	EndIf
	
EndFunction

Function AddtoAquaintanceFactionSimple(actor akRef, int possibility)

bool infaction = akRef.isinfaction(slapp_AquaintedFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_AquaintedFaction)

	If DiceRoll <= possibility
		If infaction == false
			akRef.addtofaction(slapp_AquaintedFaction)
			akRef.setfactionrank(slapp_AquaintedFaction, 0);Aquaintance
		EndIf
	EndIf
	
EndFunction

Function AddtoAquaintanceFaction(actor akRef, int possibility, bool Uprank = false)

bool infaction = akRef.isinfaction(slapp_AquaintedFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_AquaintedFaction)

	If DiceRoll <= possibility
		If infaction == false
			akRef.addtofaction(slapp_AquaintedFaction)
			akRef.setfactionrank(slapp_AquaintedFaction, 0);Aquaintance
		Elseif (Rank == 0)
			akRef.setfactionrank(slapp_AquaintedFaction, 1);AleFriend
		Elseif (Rank == 1)
			akRef.setfactionrank(slapp_AquaintedFaction, 2);Affectionate
		EndIf
		
		If (Rank < 3) && (Uprank == True)
			akRef.setfactionrank(slapp_AquaintedFaction, 3);SexFriend
		Elseif (Rank == 3) && (Uprank == True)
			akRef.setfactionrank(slapp_AquaintedFaction, 4);SexPartner
		;Elseif (Rank == 4) && (Uprank == True)
			;akRef.setfactionrank(slapp_AquaintedFaction, 5);Lover Not Yet
		Endif
		
	Else
	EndIf
EndFunction

Function AddtoRapeFailFaction(actor akRef, int possibility, bool Uprank = false)

bool infaction = akRef.isinfaction(slapp_RapeFailFaction)
Int DiceRoll = Self.GetDiceRoll()
Int Rank = akRef.GetfactionRank(slapp_RapeFailFaction)

	If DiceRoll <= possibility
		If infaction == false
			akRef.addtofaction(slapp_RapeFailFaction)
			akRef.setfactionrank(slapp_RapeFailFaction, 0);RapeFail Once

;			Elseif (Rank >= 0) && (Rank < 2)
;			akRef.setfactionrank(slapp_AquaintedFaction, 1);AleFriend
		EndIf
;		
;		If (Rank < 2) && (Uprank == True)
;			akRef.setfactionrank(slapp_AquaintedFaction, 2);SexFriend
;		Elseif (Rank == 2) && (Uprank == True)
;			akRef.setfactionrank(slapp_AquaintedFaction, 3);SexPartner
;		;Elseif (Rank == 3) && (Uprank == True)
;			;akRef.setfactionrank(slapp_AquaintedFaction, 4);Lover Not Yet
;		Endif
;		
	Else
	EndIf
EndFunction

Function GiftFaction(actor akRef)
Int Rank = akRef.GetfactionRank(slapp_GiftGiverFaction)
	if (Rank == 0)
		akRef.setfactionrank(slapp_GiftGiverFaction, 1)
	Elseif (Rank >= 1)
		akRef.setfactionrank(slapp_GiftGiverFaction, (Rank + 1))
	EndIf
EndFunction

Event OnInit() ; RegisteringModEvent
	RegisterExternalModEvent()
EndEvent


Bool Function KnockKnock()
Return False
EndFunction

Bool Function iGetFormIndex()
Return False
EndFunction

;-----------------External ModEvent---------------------



Function RegisterExternalModEvent()
	RegisterForModEvent("SLAPP_ConsequenceEvent", "SLAPPConsequenceEvent")
	RegisterForModEvent("SLAPP_AcquaintanceEvent", "SLAPPAcquaintanceEvent")
	RegisterForModEvent("SLAPP_HateEvent", "SLAPPHateEvent")
EndFunction

Event SLAPPHateEvent(form akSpeakerform, Bool HadSex = false, string results)
Actor PlayerRef = Game.getplayer()
Actor akspeaker = akspeakerform as actor
int Chance = SLApproachMain.SLADislikeChance + 20
	AddtoDislikeFaction(akSpeaker, Chance, Hadsex)
	sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
EndEvent

Event SLAPPAcquaintanceEvent(Form akSpeakerform, Bool HadSex = false, string results)
Actor akspeaker = akspeakerform as actor
Actor PlayerRef = Game.getplayer()
Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance + 20
Int RelationshipChance = SLApproachMain.SLARelationshipChance + 20
	AddtoAquaintanceFaction(akSpeaker, AcquaintanceChance, Hadsex)
	SexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
EndEvent


Event SLAPPConsequenceEvent(Bool Worse, string results)
if SLApproachMain.debugLogFlag
	Debug.notification(results)
endif
	If Worse
		SLAppPCSex.ExternalTrigger(Worse)
	Else
		SLAppPCSex.ExternalTrigger(Worse)
	Endif
EndEvent

Function BaboDialogueMercenaryCall(actor MercenaryRef); Instead call the function from SLAPP, BaboDialogue will handle a mercenary.
	int handle = ModEvent.Create("Babo_SLAPPMercenaryEvent")
	form MercenaryRefFrom = MercenaryRef as form
	if (handle)
		ModEvent.PushForm(handle, MercenaryRef)
		ModEvent.Send(handle)
	endIf
EndFunction

Function TakeArmor(Actor Victim, Actor Pervert, Keyword ArmorKeyword)
	Armor ThisArmor = FindArmor(Victim, True, ArmorKeyword)
	;BaboPropertyRegister()
	Victim.removeitem(ThisArmor, 1, SLApproachMain.BaboChestWhiterunRef)
EndFunction

Armor Function FindArmor(Actor target, Bool Keywordswitch = False, Keyword TargetArmor)
Armor[] wornForms = new Armor[30]
int slotsChecked
Bool StripSwitch
slotsChecked += 0x00100000
slotsChecked += 0x00200000 ;ignore reserved slots
slotsChecked += 0x80000000

int thisSlot = 0x01
	while (thisSlot < 0x80000000) && StripSwitch == False
	if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot)
		Armor thisArmor = target.GetWornForm(thisSlot) as Armor
		StripSwitch = false
		if (thisArmor.HasKeyword(TargetArmor))
			return thisarmor
			StripSwitch = True
		Else
			slotsChecked += thisSlot
		EndIf
	endif
		thisSlot *= 2 ;double the number to move on to the next slot
	endWhile
EndFunction

;Function BaboPropertyRegister()
;	BaboChestWhiterunRef = Game.GetFormFromFile(0x00e46567, "BabointeractiveDia.esp") as objectreference
;Endfunction


SexLabFramework Property SexLab  Auto  
SLApproachMainScript Property SLApproachMain auto
SLAppPCSexQuestScript Property SLAppPCSex auto

; overwrite by real approach quests
Quest Property ApproachQuest  Auto
string Property ApproachName Auto
Quest Property HelperQuest  Auto  ;Not sure what it's gonna be filled
ReferenceAlias Property HelperRef  Auto  
ReferenceAlias Property HelpRaperRef  Auto  
;------


Location Property BYOHHouse1LocationInterior Auto
Location Property BYOHHouse2LocationInterior Auto
Location Property BYOHHouse3LocationInterior Auto
Location Property WhiterunBreezehomelocation Auto
Location Property SolitudeProudspireManorLocation Auto
Location Property MarkarthVlindrelHallLocation Auto
Location Property RiftenHoneysideLocation Auto
Location Property WindhelmHjerimLocation Auto

Keyword Property LocTypePlayerHouse Auto
Formlist Property SLApproachPlayerHouse Auto
Formlist Property SLApproachPlayerHouseBYOH01 Auto
Formlist Property SLApproachPlayerHouseBYOH02 Auto
Formlist Property SLApproachPlayerHouseBYOH03 Auto
Formlist Property SLApproachPlayerHouseWhiterun Auto
Formlist Property SLApproachPlayerHouseMarkarth Auto
Formlist Property SLApproachPlayerHouseRiften Auto
Formlist Property SLApproachPlayerHouseSolitude Auto
Formlist Property SLApproachPlayerHouseWindhelm Auto
Formlist Property SLApproachPotentialHouseVisitors Auto

Faction Property isguardfaction  Auto  
Race Property ElderRace  Auto  
Race Property HorseRace  Auto  
Race Property ManakinRace  Auto  
Race Property DremoraRace  Auto  

Armor Property SLAppRingShame  Auto  
Armor Property SLAppRingFamily  Auto  

Faction Property JobJarlFaction  Auto
Faction Property Banditfaction  Auto
Faction Property WINeverFillAliasesFaction  Auto

Faction Property slapp_ProstitutionFaction Auto
Faction Property slapp_Characterfaction Auto
Faction Property slapp_washiringfaction Auto
Faction Property slapp_AquaintedFaction Auto
Faction Property slapp_DislikeFaction Auto
Faction Property slapp_RapeFailFaction Auto
Faction Property slapp_ReconciliationFaction Auto
Faction Property slapp_GiftGiverFaction Auto
Faction Property slapp_VisitedFaction Auto
Faction Property slapp_StayedFaction Auto
Faction Property slapp_VisitedFailedFaction Auto
Faction Property SexLabAnimatingFaction Auto
Faction Property ThalmorFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property PlayerFaction Auto
Faction Property PlayerMarriedFaction Auto
Faction Property CurrentHireling Auto
Faction Property PotentialHireling Auto
Faction Property slapp_VisitingFaction Auto

LeveledItem Property SLAPPAffectionMiscLVL Auto

GlobalVariable Property SLAStandardLevelMaximumNPCGlobal Auto
GlobalVariable Property SLAStandardLevelMinimumNPCGlobal Auto
GlobalVariable Property SLApproachMoralGlobal Auto

