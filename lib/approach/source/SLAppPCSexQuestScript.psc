Scriptname SLAppPCSexQuestScript extends SLApproachBaseQuestScript Conditional 

Scene selectedScene
bool property willRape Auto Conditional
bool property SLHHwillRape Auto Conditional
bool property PCApproachOngoing Auto Conditional
bool property PCVisitingBefore Auto Conditional
bool property PCVisitingOn Auto Conditional
bool property PCVisitingAfter Auto Conditional
bool Property HasDoorKey Auto conditional
bool Property DoorKeyexist Auto conditional
float Property ProstitutionAcceptChance = 0.0 Auto Conditional


keyword property ClothingPoor Auto
keyword property ClothingRich Auto

Miscobject property gold001 Auto

Function startApproach(Actor akRef)
	PCApproachOngoing = True
	maxTime = SLApproachMain.SLApproachTimelimit
	ProstitutionChance(akref)
	SetCharacter(akRef)
	if akref == StayingActor.getreference() as actor
		if (selectedScene == SLApproachAskForSexQuestScene)
			selectedScene = SLApproachHouseStayScene
			slappUtil.log("Selected scene is sex to pc, roll rape chance.")
		endif
	else
		talkingActor.ForceRefTo(akRef)
			if (selectedScene == SLApproachAskForSexQuestScene) || (selectedScene == SLAppAskingNameToPCScene)
			slappUtil.log("Selected scene is sex to pc, roll rape chance.")
		endif
	endif
	self.rollRapeChance(akRef)
	SLApproachRapeToggle.setvalue(willRape as int)
	selectedScene.Start()
	;approachEnding = True
	parent.startApproach(akRef)
	if SLApproachMain.debugLogFlag
		Debug.notification("StartApproach," + (selectedScene.getname() as string) + "starts from " + (akRef.GetBaseObject().GetName() as string))
	endif
EndFunction

Function SetCharacter(actor akRef)

Int Character

if !akRef.isinfaction(slapp_Characterfaction)
	actorbase akRefbase = akRef.getbaseobject() as actorbase
	
	if akRefbase.isunique()
		Character = Utility.randomint(SLApproachMain.SLANPCUniqueCharacterMin, SLApproachMain.SLANPCUniqueCharacterMax);0Mild,1Timid,2Confident,3Aggressive,4Rapist
	else
		if akRef.getactorvalue("Morality") <= SLApproachMoralGlobal.getvalue()
			Character = Utility.randomint(3,4);0Mild,1Timid,2Confident,3Aggressive,4Rapist
		else
			Character = Utility.randomint(SLApproachMain.SLANPCCharacterMin, SLApproachMain.SLANPCCharacterMax);0Mild,1Timid,2Confident,3Aggressive,4Rapist	
		endif
	endif

	akRef.addtofaction(slapp_Characterfaction)
	akRef.setfactionrank(slapp_Characterfaction, Character)
endif

EndFunction


Function approachEndingSwitch(Bool Switch)
	approachEnding = Switch
EndFunction

int Function ProstitutionNPCMoney(Actor akRef) ; How much NPC has money.

 
Armor HeadArmor = akRef.GetWornForm(0x00000001) as Armor
Armor BodyArmor = akRef.GetWornForm(0x00000004) as Armor
Armor HandsArmor = akRef.GetWornForm(0x00000008) as Armor
Armor AmuletArmor = akRef.GetWornForm(0x00000020) as Armor
Armor RingArmor = akRef.GetWornForm(0x00000040) as Armor
Armor FeetArmor = akRef.GetWornForm(0x00000080) as Armor

int ArmorValue = 0
int RichValue = 0

if HeadArmor
	ArmorValue += HeadArmor.GetGoldValue() as int
endif

if BodyArmor
	ArmorValue += BodyArmor.GetGoldValue() as int
endif

if HandsArmor
	ArmorValue += HandsArmor.GetGoldValue() as int
endif

if AmuletArmor
	ArmorValue += AmuletArmor.GetGoldValue() as int
endif

if RingArmor
	ArmorValue += RingArmor.GetGoldValue() as int
endif

if FeetArmor
	ArmorValue += FeetArmor.GetGoldValue() as int
endif

int LevelValue = akref.getlevel() * 10

if akref.wornhaskeyword(ClothingPoor)
	Richvalue = 5
elseif akref.wornhaskeyword(ClothingRich)
	Richvalue = 1500
else
	Richvalue = 500
endif

Int Totalvalue = Armorvalue + LevelValue + RichValue

Return Totalvalue

EndFunction


int Function ProstitutionPlayerValue(); How much will you offer

int ValueMax = SLApproachProstitutionMax.getvalue() as int
int ValueMin = SLApproachProstitutionMin.getvalue() as int
int extravalue
	extravalue += slappUtil.NudeCalc(PlayerReference.GetActorRef());from0~70
	extravalue += slappUtil.AppearanceCalc();from0~75
int PValue = Utility.randomint(ValueMin, ValueMax)
	extravalue += Pvalue 
SLApproachProstitutionValue.setvalue(extravalue)
UpdateCurrentInstanceGlobal(SLApproachProstitutionValue)
if SLApproachMain.debugLogFlag
	Debug.notification("Your prostitution value is: " + extravalue)
endif
Return Pvalue

EndFunction

Function ProstitutionChance(Actor akref)

int NPCMoney = ProstitutionNPCMoney(akref)
int PlayerValue = ProstitutionPlayerValue()

float AcceptChance = ((NPCMoney / PlayerValue) * 100) as float

if AcceptChance >= 100
	ProstitutionAcceptChance = 100
Else
	ProstitutionAcceptChance = AcceptChance
EndIf

If PlayerValue >= NPCMoney
	SLApproachMain.SLAProstitution = false
;	SLApproachProstitutionFraudChance.setvalue();WIP
else
	SLApproachMain.SLAProstitution = true
endif

Endfunction

Function rollRapeChance(Actor akRef)
	if (SLApproachMain.enableRapeFlag)
		if (SLApproachMain.enableSLHHFlag)
			SLHHwillRape = true
		else
			SLHHwillRape = false
		endif
		if (akRef.IsEquipped(SLAppRingBeast))
			willRape = true
			return
		endif
		
		int chance = akRef.GetFactionRank(arousalFaction)
		chance += slappUtil.HomeAlone();from-50~50
		chance += slappUtil.CharacterCalc(akRef);from-25~25
		chance += slappUtil.LightLevelCalc(akRef);from-50~25
		chance += slappUtil.TimeCalc();from-25~25
		chance += slappUtil.NudeCalc(PlayerReference.GetActorRef());from0~70
		chance += slappUtil.AppearanceCalc();from0~75
;		chance += 5;50+145+5 = 200
		chance = chance / 10
		chance = slappUtil.ValidateChance(chance);From 0 to 150
		chance += SLApproachMain.userAddingRapePointPc;Range(-100, 100)

		int roll = Utility.RandomInt(0, 150)
		SLAFactorScore.value = chance; Why did I do this? Never know.. Perhaps I'll need this to sort npcs some other time.
		if (roll < chance)
			willRape  = true
		else
			willRape  = false
		endif
	else
		willRape = false
	endif
EndFunction

bool Function chanceRoll(Actor akRef, Actor PlayerRef, float baseChanceMultiplier);triggered directly from SLApproachApplyEffect

	string akRefName = akRef.GetActorBase().GetName()

	if SLApproachMain.debugLogFlag
		Debug.notification("ChanceRoll started")
	endif
	
	if !(akRef.HasLOS(PlayerRef))
		return false
	elseif (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		return false
	elseif (SexLab.IsActorActive(PlayerRef))
		return false
	elseif ((SexLab.GetGender(akRef) == 2) && (SexLab.GetGender(PlayerRef) == 0)) ; c/m
		return false
	elseif (!(self.isSceneValid(akRef))) || (!(self.isSceneValid(PlayerRef)))
		return false
	elseif !(self.isPrecheckValid(akRef, PlayerRef, true))
		return false
	elseif !(PlayerRef.GetPlayerControls())
		return false
	endif

	int chance = SexUtil.GetArousal(akRef, PlayerRef); get the value of NPC's arousal.
	if (chance < SLApproachMain.lowestArousalNPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by NPC's Arousal: " + chance)
		return false
	elseif (SexUtil.GetArousal(PlayerRef, akRef) < SLApproachMain.lowestArousalPC)
		slappUtil.log(ApproachName + ": " + akRefName + " :Canceled by PC's Arousal: ---")
		return false
	endif
	
	int StandardlevelRangeminimum = (PlayerRef.getlevel() - SLApproachMain.SLADeviationLevel)
	int StandardlevelRangemaximum = (PlayerRef.getlevel() + SLApproachMain.SLADeviationLevel)
	
	If akref.getlevel() < StandardlevelRangeminimum
		if SLApproachMain.SLALowerLevelNPC == false
			Return false
		endif
	Elseif akref.getlevel() > StandardlevelRangemaximum
		if SLApproachMain.SLAhigherLevelNPC == false
			Return false
		endif
	Elseif (akref.getlevel() >= StandardlevelRangeminimum) && (akref.getlevel() <= StandardlevelRangemaximum)
		if SLApproachMain.SLAStandardLevelNPC == false
			Return false
		endif
	EndIf
	
	int pt_gll = slappUtil.LightLevelCalc(akRef)
	int pt_time = slappUtil.TimeCalc()
	int pt_nude = slappUtil.NudeCalc(PlayerRef)
	int pt_Appearance = slappUtil.AppearanceCalc()
	int pt_bed = slappUtil.BedCalc(PlayerRef) / 2

	; Chance Calculation ---------------------------------
	chance += slappUtil.RelationCalc(akRef, PlayerRef);(-60~50)
	chance += pt_gll;from-50~25
	chance += pt_time;from-25~25
	chance += pt_nude;from0~70
	chance += pt_Appearance;from0~75
	chance += pt_bed;-30or20
	chance -= 15


	int roll = self.GetDiceRoll()
	int result
	
	If SLApproachMain.enableBDFlag
		if (akRef.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction))
			selectedScene = SLAppViceGuardCaptainScene
			return true
		elseIf (akRef.isinfaction(SLApproachMain.BaboAggressiveBoyFriend))
			selectedScene = SLAppAggressiveBFPCScene
			;debug.notification("Boyfriend Event")
			return true
		EndIf
	EndIf
	
	if SLA_DDI.getvalue() == 1
		SLApproachMain.CheckDD(PlayerRef)
	endif
	if sla_slsurvival.getvalue() == 1
		SLApproachMain.SLSurvivalLicenseCheck()
	endif
	
	
	If (roll < 50)
	; for asking name ---------------------------------
	
	roll = self.GetDiceRoll()
	result = self.GetResult(chance, SLApproachMain.userAddingKissPointPc, baseChanceMultiplier)
	slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
	SLAFactorScore.value = result

	If (akRef.HasKeyword(ActorTypeNPC))
		if (roll < result)
			selectedScene = SLAppAskingNameToPCScene
			if akref == StayingActor.getreference() as actor
				return false
			endif
			if SLApproachMain.debugLogFlag
				debug.notification("SLAPP Asking name Start")
			endif
			return true ; for asking name
		endif
	Else
		;This means the actor is a creature.
	EndIf
	
	Else
	; for asking Sex ---------------------------------

	if SLA_DDI.getvalue() == 1
		if PlayerRef.IsEquipped(SLApproachDDIYokeList)
			return false
		endif
	endif

	roll = self.GetDiceRoll()
	result = self.GetResult(chance, SLApproachMain.userAddingPointPc, baseChanceMultiplier)
	slappUtil.log(ApproachName + ": " + akRefName + " :Sex: " + roll + " < " + result)
	SLAFactorScore.value = result
	if (roll < result)
		selectedScene = SLApproachAskForSexQuestScene
		if SLApproachMain.debugLogFlag
			debug.notification("SLAPP Asking Sex Start")
		endif
		return true ; for sex
	endif
	
	if !(akRef.HasKeyword(ActorTypeNPC)) ; This prevents creature types from kissing.
		return false
	endif

	
	EndIf
	;debug.notification("Failed")
	return false

	; for kiss ---------------------------------
;	chance -= pt_bed
;
;	roll = self.GetDiceRoll()
;	result = self.GetResult(chance, SLApproachMain.userAddingKissPointPc, baseChanceMultiplier)
;	slappUtil.log(ApproachName + ": " + akRefName + " :Kiss: " + roll + " < " + result)
;
;	if (roll < result)
;		selectedScene = SLAppKissToPCScene
;		return true ; for kiss
;	endif
;
;	; for hug ---------------------------------
;	chance -= pt_time
;
;	roll = self.GetDiceRoll()
;	result = self.GetResult(chance, SLApproachMain.userAddingHugPointPc, baseChanceMultiplier)
;	slappUtil.log(ApproachName + ": " + akRefName + " :Hug: " + roll + " < " + result)
;
;	if (roll < result)
;		selectedScene = SLAppHugToPCScene
;		return true ; for hug
;	endif
;	

EndFunction

Function endApproach(bool force = false)
	if SLApproachMain.debugLogFlag
		Debug.notification("Child: EndApproach")
	endif
	int retryTime = 30
	Actor akRef = talkingActor.GetActorRef()
	
	if (!force && SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		parent.RegisterForSingleUpdate(retryTime)
	elseif (!force && SLAppHousevisitScene.isPlaying())
		slappUtil.log(ApproachName + ": Now following scene is playing, retry.")
		RegisterForSingleUpdate(retryTime)
	elseif (!force && akRef && akRef.IsInDialogueWithPlayer())
		slappUtil.log(ApproachName + ": Now IsInDialogueWithPlayer, retry.")
		RegisterForSingleUpdate(retryTime)
	else
		PCApproachOngoing = false
		approachEnding = false
		selectedScene.Stop()
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
		SLAppHousevisitScene.Stop()
		HelperQuest.Stop()
		talkingActor.clear()
		;parent.endApproach()
		SLApproachAskForSexQuest.SetStage(100)
	endif
EndFunction

Function endApproachForce(ReferenceAlias akRef = None)
;	PCApproachOngoing = false
	UnregisterForUpdate()
	parent.endApproachForce(talkingActor)
	endApproach(true)
EndFunction


Function StartSex(Actor PlayerRef, Actor akSpeaker, bool rape = false)
	If rape
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	else
		SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	endif
	SexUtil.StartSexActors(akSpeaker, PlayerRef, rape)
	;Debug.notification(akSpeaker + "StartSex")
EndFunction


Function ProstitutionStartSex(Actor PlayerRef, Actor akSpeaker)
	SLApproachProstitutionTimes.setvalue(SLApproachProstitutionTimes.getvalue() + 1)
;	ProstitutionPaid(); This will be changed
	SexUtil.StartSexActorsHook(akSpeaker, PlayerRef, false, true, "AfterProst", "AfterProstitute")
EndFunction



Function StartSexMulti(Actor PlayerRef, Actor akSpeaker, Actor Helper, bool rape = false)
	If rape
		SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	else
		SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	endif
	SexUtil.StartSexMultiActors(akSpeaker, PlayerRef, Helper, rape)
EndFunction

Function StopScene()
	self.followSceneStop()
	self.endApproach()
;	PCApproachOngoing = false
EndFunction

Function enjoy()
	Actor PlayerRef = PlayerReference.GetActorRef()
	Actor NPCtalkingActor = talkingActor.getactorref()
	if SLApproachMain.SLAProstitutionFollow
		self.ProstitutionStartSex(PlayerRef, NPCtalkingActor)
		self.ProstitutionPlus(NPCtalkingActor)
	else
		self.StartSex(PlayerRef, NPCtalkingActor)
		self.AcquaintancePlus(NPCtalkingActor, false)
	endif
	Utility.wait(1.0)
	Self.StopScene()
EndFunction

Function Sexforreconciliation(Actor akSpeaker, int Possibility)
	int roll = Utility.RandomInt(0, 100)
	Actor PlayerRef = PlayerReference.GetActorRef()
	If Possibility <= roll
		Self.CoolDown(akSpeaker)
	EndIf
	SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	self.StartSex(PlayerRef, akSpeaker)
EndFunction

Function enjoyMulti(Actor akSpeaker)
	Actor PlayerRef = PlayerReference.GetActorRef()
	SLApproachNormalSexTimes.setvalue(SLApproachNormalSexTimes.getvalue() + 1)
	self.StartSexMulti(talkingActor.GetActorRef(), PlayerRef, akSpeaker)
	Self.StopScene()
EndFunction

Function NothingEnd()
	Self.StopScene()
EndFunction

Function Ignore(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.AddtoDislikeFaction(akSpeaker, Chance)
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	Self.StopScene()
EndFunction

Function GiftGive(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
int Number = Utility.randomint(1, 3)

	PlayerRef.additem(SLAPPAffectionMiscLVL, Number)
	Parent.GiftFaction(akSpeaker)
	Utility.wait(1.0)
	SLApproachGiftTimes.setvalue(SLApproachGiftTimes.getvalue() + 1)
	Self.AcquaintancePlus(akSpeaker, true, false)
EndFunction

Function Acquaintance(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
	Parent.AddtoAquaintanceFaction(akSpeaker, SLApproachMain.SLAAquaintanceChance)
	Parent.sexRelationshipUp(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	Self.StopScene()
EndFunction

Function AcquaintancePlus(Actor akSpeaker, Bool StopQuest = True, Bool HadSex = True)
Actor PlayerRef = PlayerReference.GetActorRef()
Int AcquaintanceChance = SLApproachMain.SLAAquaintanceChance + 20
Int RelationshipChance = SLApproachMain.SLARelationshipChance + 20
	Parent.AddtoAquaintanceFaction(akSpeaker, AcquaintanceChance, Hadsex)
	Parent.sexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
	if StopQuest == true
		Self.StopScene()
	endif	 
EndFunction

Function ProstitutionPlus(Actor akSpeaker)
	Parent.AddtoProstitutionFaction(akSpeaker)
	Self.StopScene()
EndFunction


Function CoolDown(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
Int RelationshipChance = SLApproachMain.SLARelationshipChance + 20
	Parent.AddtoReconciliationFaction(PlayerRef)
	Parent.RankDownDislikeFaction(PlayerRef)
	Parent.sexRelationshipUp(akSpeaker, PlayerRef, RelationshipChance)
	Self.StopScene()	 
EndFunction

Function Visited()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	Parent.AddtoVisitiedFaction(VisitorRef)
	Self.StopScene() 
EndFunction

Function Stayed()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	Parent.AddtoStayedFaction(VisitorRef)
	stayingactor.clear()
	Self.StopScene()
EndFunction

Function VisitedbutFailed()
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = false
	Parent.AddtoVisitiedFailedFaction(VisitorRef)
	Self.StopScene() 
EndFunction

Function disagree(Actor akSpeaker, Bool Prostitution = false)
	Parent.AddtoDislikeFaction(akSpeaker, SLApproachMain.SLADislikeChance)
	if Prostitution
		SLApproachProstitutionTryTimes.setvalue(SLApproachProstitutionTryTimes.getvalue() + 1)
	endif
	Self.StopScene()
EndFunction

Function RefuseVisit(Actor akSpeaker, Bool Prostitution = false)
disagree(akSpeaker, Prostitution)
CleartheHouse()
EndFunction

Function disagreePlus(Actor akSpeaker, Bool Prostitution = false)
Actor PlayerRef = PlayerReference.GetActorRef()
int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.AddtoDislikeFaction(akSpeaker, Chance)
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	if Prostitution
		SLApproachProstitutionTryTimes.setvalue(SLApproachProstitutionTryTimes.getvalue() + 1)
	endif
	Self.StopScene()
	 
EndFunction

Function rapedBy(Actor akSpeaker)

Actor PlayerRef = PlayerReference.GetActorRef()
Actor ActorRaper = talkingActor.GetActorRef()
int Chance = SLApproachMain.SLADislikeChance
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		Utility.wait(1.0)
		SLHHActivate(ActorRaper, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(ActorRaper + "SLHH Activated")
		endif

	Else
		Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetActorRef(), true)
		Self.StopScene()
	EndIf
EndFunction

Function rapedPlusBy(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
Actor ActorRaper = talkingActor.GetActorRef()
int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.sexRelationshipDown(akSpeaker, PlayerRef, SLApproachMain.SLARelationshipChance)
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		Utility.wait(1.0)
		SLHHActivate(ActorRaper, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(ActorRaper + "SLHH Activated")
		endif
	Else
		Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
		self.StartSexMulti(PlayerRef, akSpeaker, HelpRaperRef.GetActorRef(), true)
		Self.StopScene()
	EndIf
EndFunction

Function Baborape(Actor akSpeaker)
Actor PlayerRef = PlayerReference.GetActorRef()
Actor ActorRaper = talkingActor.GetActorRef()
	HelperQuest.Start()
	SLApproachRapedTimes.setvalue(SLApproachRapedTimes.getvalue() + 1)
	If (SLApproachMain.enableSLHHFlag)
		Self.followSceneStop()
		Utility.wait(1.0)
		SLHHActivate(ActorRaper, None)
		if SLApproachMain.debugLogFlag
			Debug.notification(ActorRaper + "SLHH Activated")
		endif
	Else
		self.StartSex(PlayerRef, akSpeaker, true)
		BaboDialogueTrigger(akSpeaker, true)
		Self.StopScene()
	EndIf
EndFunction

Function BaboNothingEnd(Actor akSpeaker)
	BaboDialogueTrigger(akSpeaker, false)
	Self.StopScene()
EndFunction

Function SLHHConsequneceBad(Actor akSpeaker)

if SLApproachMain.enableBDFlag
	iF akSpeaker.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction)
		;Nothing
	else
		int Chance = SLApproachMain.SLADislikeChance + 10
		Parent.AddtoDislikeFaction(akSpeaker, Chance, false)
		Parent.AddtoRapeFailFaction(akSpeaker, Chance, false)
	endif
else
	int Chance = SLApproachMain.SLADislikeChance + 10
	Parent.AddtoDislikeFaction(akSpeaker, Chance, false)
	Parent.AddtoRapeFailFaction(akSpeaker, Chance, false)
endif

	Self.StopScene()
EndFunction

Function SLHHConsequneceWorse(Actor akSpeaker)

if SLApproachMain.enableBDFlag
	iF akSpeaker.isinfaction(SLApproachMain.BaboViceGuardCaptainFaction)
		;Nothing
	else
		int Chance = SLApproachMain.SLADislikeChance + 20
		Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
	endif
else
	int Chance = SLApproachMain.SLADislikeChance + 20
	Parent.AddtoDislikeFaction(akSpeaker, Chance, True)
endif

Self.StopScene()
EndFunction

Function PrePaid(Bool Prepaid)
if Prepaid
	SLApproachMain.SLAProstitutionpayway = 0 ;pre-paid
	ProstitutionPaid()
else
	SLApproachMain.SLAProstitutionpayway = 1 ;post-paid
endif
Endfunction

Function ProstitutionPaid()
	Playerreference.getactorref().additem(gold001, SLApproachProstitutionValue.getvalue() as int)
EndFunction

Function ProstitutionRefund()
	Playerreference.getactorref().removeitem(gold001, SLApproachProstitutionValue.getvalue() as int)
EndFunction

Function travelWith(Actor akSpeaker, Bool Prostitution = false)
	self.SetStage(15)
	SLApproachAskForSexQuestFollowPlayerScene.Start()
if Prostitution
	SLApproachMain.SLAProstitutionFollow = True
else
	SLApproachMain.SLAProstitutionFollow = false
endif
EndFunction

Function travelWithForMulti(Actor akSpeaker); Not available
	self.SetStage(20)
	SLApproachAskForSexQuestFollowPlayerScene.Start()
EndFunction

Function followSceneStop()
	if (SLAppAskingNameToPCScene.isplaying())
		SLAppAskingNameToPCScene.stop()
	endif
	
	if (SLApproachAskForSexQuestScene.isplaying())
		SLApproachAskForSexQuestScene.Stop()
	endif
	
	if (SLApproachAskForSexQuestFollowPlayerScene.isPlaying())
		SLApproachAskForSexQuestFollowPlayerScene.Stop()
	endif
EndFunction

Function playKiss(Actor akRef)
	Actor player = Game.GetPlayer()
	SexUtil.PlayKiss(akRef, player)
EndFunction

Function playHug(Actor akRef)
	Actor player = Game.GetPlayer()
	SexUtil.PlayHug(akRef, player, SLApproachMain.enableForceThirdPersonHug)
EndFunction

;-------------------------SLHH Mod -----------------------

Function ExternalTrigger(Bool Worse)
Actor NPCtalkingActor = talkingActor.getactorref()
	If Worse
		SLHHConsequneceWorse(NPCtalkingActor)
	Else
		SLHHConsequnecebad(NPCtalkingActor)
	Endif
EndFunction

;-----------------Register HouseLocation-----------------

Bool Function iGetFormIndex()

Location CurrentLocation = Playeractor.GetCurrentLocation()
Formlist CurrentFormlist

if CurrentLocation.haskeyword(LocTypePlayerHouse)
	if CurrentLocation == WhiterunBreezehomelocation
		CurrentFormlist = SLApproachPlayerHouseWhiterun
		SLApproachCurrentPlayerHouse.setvalue(1)
	elseif CurrentLocation == BYOHHouse1LocationInterior
		CurrentFormlist = SLApproachPlayerHouseBYOH01
		SLApproachCurrentPlayerHouse.setvalue(2)
	elseif CurrentLocation == BYOHHouse2LocationInterior
		CurrentFormlist = SLApproachPlayerHouseBYOH02
		SLApproachCurrentPlayerHouse.setvalue(3)
	elseif CurrentLocation == BYOHHouse3LocationInterior
		CurrentFormlist = SLApproachPlayerHouseBYOH03
		SLApproachCurrentPlayerHouse.setvalue(4)
	elseif CurrentLocation == SolitudeProudspireManorLocation
		CurrentFormlist = SLApproachPlayerHouseSolitude
		SLApproachCurrentPlayerHouse.setvalue(5)
	elseif CurrentLocation == MarkarthVlindrelHallLocation
		CurrentFormlist = SLApproachPlayerHouseMarkarth
		SLApproachCurrentPlayerHouse.setvalue(6)
	elseif CurrentLocation == RiftenHoneysideLocation
		CurrentFormlist = SLApproachPlayerHouseRiften
		SLApproachCurrentPlayerHouse.setvalue(7)
	elseif CurrentLocation == WindhelmHjerimLocation
		CurrentFormlist = SLApproachPlayerHouseWindhelm
		SLApproachCurrentPlayerHouse.setvalue(8)
	else
		SLApproachCurrentPlayerHouse.setvalue(0)
		return false
	endif
	
	if SLApproachMain.debugLogFlag
		Debug.notification("PlayerHouse " + SLApproachCurrentPlayerHouse.getvalue() as int)
	endif
	
	int DactorNum
	int iindex = CurrentFormlist.getsize()
	If iindex > 0
		DactorNum = Utility.randomint(1, iindex)
		VisitorRef = CurrentFormlist.getat(DactorNum) as actor
		VisitorRefBase = VisitorRef.getactorbase()
		
		if SLApproachMain.debugLogFlag
			String VisitorName = VisitorRefBase.getname()
			Debug.notification("Visitor's name is " + VisitorName + "in " + iindex)
		endif
		
		if VisitorRef == none
			return false
		endif
		
		return true
	else
		if SLApproachMain.debugLogFlag
			Debug.notification("No Index")
		endif
		Return false
		Debug.notification("There's silence in my home.")
	endif
Else
if SLApproachMain.debugLogFlag
	Debug.notification("No Player House")
endif
Return false
Endif
EndFunction

Bool Function KnockKnock()
Location CurrentLocation = player.getcurrentlocation()
Actor player = Game.GetPlayer()

int roll = Utility.RandomInt(1, 100)
	If roll > SLApproachPC.SLAHouseVisitChance
		Return False
	EndIf

	If !SLApproachScanningPlayerHouse.isrunning()
		Return False
	EndIf

	PCApproachOngoing = True

;VisitorRef = SLAPPTestZoneXmarker.placeatme(VisitorRefBase, 4) as actor

VisitorRef.moveto(SLAPPTestZoneXmarker)

PlayerHouseCenterMarker.ForceRefto(ExternalPlayerHouseCenterMarker.getreference())
PlayerHouseDoor.ForceRefto(ExternalPlayerHouseDoor.getreference())
PlayerHouseCOC.ForceRefto(ExternalPlayerHouseCOC.getreference())
FollowerRef.ForceRefto(ExternalFollowerRef.getreference())

talkingActor.ForceRefTo(VisitorRef)

rollRapeChance(VisitorRef)
SLApproachRapeToggle.setvalue(willRape as int)
PCVisitingBefore = true
PCVisitingAfter = false
VisitorKnocking(VisitorRef)

Return True
EndFunction

Function VisitorKnocking(actor visitor)

Alias_VisitorRef.Clear()
Alias_VisitorRef.ForceRefTo(visitor)

SLApproachScanningPlayerHouse.setstage(10)
Self.setstage(50)

;Moving a visitor in front of a door
;Dialogues are required
if SLApproachCurrentPlayerHouse.getvalue() == 1
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorWhiterunRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 2
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH01Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 3
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH02Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 4
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorBYOH03Ref)
elseif SLApproachCurrentPlayerHouse.getvalue() == 5
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorSolitudeRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 6
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorMarkarthRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 7
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorRiftenRef)
elseif SLApproachCurrentPlayerHouse.getvalue() == 8
	visitor.moveto(SLApproachMain.SLAPPXmarkerFrontDoorWindhelmRef)
else
;Nothing
endif

	PCVisitingBefore = false
	PCVisitingon = true
	PCVisitingafter = false


EndFunction

Function VisitorEntering(actor visitor, objectreference entrance)
	PCVisitingBefore = false
	PCVisitingon = false
	PCVisitingafter = true
visitor.moveto(entrance)
selectedScene = SLAppHousevisitScene
selectedScene.forcestart()
maxTime = (SLApproachMain.SLApproachTimelimit) + 30
parent.startApproach(visitor)
EndFunction

Function registerHouse(Location akLocation)
Actor NPCtalkingActor = talkingActor.getactorref()
If aklocation == WhiterunBreezehomeLocation
	SLApproachPlayerHouseWhiterun.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse1LocationInterior
	SLApproachPlayerHouseBYOH01.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse2LocationInterior
	SLApproachPlayerHouseBYOH02.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse3LocationInterior
	SLApproachPlayerHouseBYOH03.addform(NPCtalkingActor)
elseif aklocation == SolitudeProudspireManorLocation
	SLApproachPlayerHouseSolitude.addform(NPCtalkingActor)
elseif aklocation == MarkarthVlindrelHallLocation
	SLApproachPlayerHouseMarkarth.addform(NPCtalkingActor)
elseif aklocation == RiftenHoneysideLocation
	SLApproachPlayerHouseRiften.addform(NPCtalkingActor)
elseif aklocation == WindhelmHjerimLocation
	SLApproachPlayerHouseWindhelm.addform(NPCtalkingActor)
EndIf
EndFunction

Function registerHouseTest(Location akLocation, Actor NPCtalkingActor)
If aklocation == WhiterunBreezehomeLocation
	SLApproachPlayerHouseWhiterun.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse1LocationInterior
	SLApproachPlayerHouseBYOH01.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse2LocationInterior
	SLApproachPlayerHouseBYOH02.addform(NPCtalkingActor)
elseif aklocation == BYOHHouse3LocationInterior
	SLApproachPlayerHouseBYOH03.addform(NPCtalkingActor)
elseif aklocation == SolitudeProudspireManorLocation
	SLApproachPlayerHouseSolitude.addform(NPCtalkingActor)
elseif aklocation == MarkarthVlindrelHallLocation
	SLApproachPlayerHouseMarkarth.addform(NPCtalkingActor)
elseif aklocation == RiftenHoneysideLocation
	SLApproachPlayerHouseRiften.addform(NPCtalkingActor)
elseif aklocation == WindhelmHjerimLocation
	SLApproachPlayerHouseWindhelm.addform(NPCtalkingActor)
EndIf
EndFunction

Function PreVisitorEntering()
;debug.notification("The visitor is entering.")
	ObjectReference PHCOC = PlayerHouseCOC.getreference()
	SLApproachScanningPlayerHouse.setstage(50)
	Self.setstage(60)
	if PHCOC
		VisitorEntering(VisitorRef, PHCOC)
	Else
		VisitorEntering(VisitorRef, Game.getplayer() as objectreference)
	Endif
	SLAKnockCount.setvalue(0)

EndFunction

Function StayingTimeRegister(Bool Rape)
	SLApproachScanningPlayerHouse.setstage(70); This indicates a visitor is gonna stay.
	SLApproachVisitorStaying.setvalue(1)
	stayingactor.getactorreference().addtofaction(slapp_VisitingFaction)
	if rape
		stayingactor.getactorreference().addtofaction(slapp_VisitingRapistFaction)
	endif
	RegisterForSingleUpdateGameTime(SLApproachStayingTime.getvalue() as int)
EndFunction

Event OnUpdateGameTime()
;End of a visiting scenario.
	CleartheHouse()
EndEvent

Function CleartheHouse()
	SLApproachVisitorStaying.setvalue(0)
	stayingactor.getactorreference().removefromfaction(slapp_VisitingFaction)
	if stayingactor.getactorreference().isinfaction(slapp_VisitingRapistFaction)
		stayingactor.getactorreference().removefromfaction(slapp_VisitedRapistFaction)
		stayingactor.getactorreference().removefromfaction(slapp_VisitingRapistFaction)
	endif
	SLApproachScanningPlayerHouse.stop()
	Stayed()
EndFunction


GlobalVariable Property SLApproachStayingTime Auto

;---SLHH---

Function SLHHActivate(Actor pTarget, Actor pTargetFriend = None); Basically you don't need pTargetFriend. pTarget will become a criminal, who will try to rape you.
If SLApproachMain.enableSLHHFlag
    (SLApproachMain.SLHHScriptEventKeyword).SendStoryEvent(akLoc = None, akRef1 = pTarget, akRef2 = None, aiValue1 = 0, aiValue2 = 0)
EndIf
endFunction 

;---BaboDialogue---

;Faction Function BDBaboAggressiveBoyFriend()
;	Faction BaboAggressiveBoyFriend = Game.GetFormFromFile(0x00BA9DDA, "BabointeractiveDia.esp") as Faction
;Return BaboAggressiveBoyFriend
;EndFunction


;Faction Function BDBaboViceGuardCaptainFaction()
;	Faction BaboViceGuardCaptainFaction = Game.GetFormFromFile(0x00B71E3E, "BabointeractiveDia.esp") as Faction
;Return BaboViceGuardCaptainFaction
;EndFunction


Function BaboAggressiveBoyFriendStack(Actor pTarget)
If !(pTarget.isinfaction(slapp_AggressiveBFFaction))
	pTarget.addtofaction(slapp_AggressiveBFFaction)
Endif
EndFunction

Actor VisitorRef
Actor Property Playeractor Auto


Function BaboDialogueTrigger(Actor Raper, Bool Worse = false)
	If Worse
		BaboDialogueEventRegister(Raper, True); SLHHConsequneceWorse, Rape
	Else
		BaboDialogueEventRegister(Raper, False); SLHHConsequneceBad, No Rape
	EndIf
EndFunction

Function BaboDialogueEventRegister(Actor Raper, Bool Worse)
	int handle = ModEvent.Create("BaboDialogue_ConsequenceEvent")
	if (handle)
		ModEvent.Pushform(handle, Raper)
		ModEvent.PushBool(handle, Worse)
		ModEvent.PushString(handle, "SLAPP activated BaboDialogueConsequence")
		ModEvent.Send(handle)
	endIf
EndFunction

;----------------------------Properties----------------------------

SLApproachMainScript Property SLApproachPC auto
Quest property SLApproachScanningPlayerHouse auto
Quest Property SLApproachAskForSexQuest auto
SLAppSexUtil Property SexUtil Auto

Formlist Property SLApproachDDIList Auto
Formlist Property SLApproachDDIYokeList Auto

GlobalVariable Property SLA_DDI Auto
GlobalVariable Property sla_slsurvival Auto

GlobalVariable Property SLAKnockCount Auto
GlobalVariable Property SLApproachRapeToggle Auto

GlobalVariable Property SLApproachRapedTimes Auto
GlobalVariable Property SLApproachAskNameTimes Auto
GlobalVariable Property SLApproachAskSexTimes Auto
GlobalVariable Property SLApproachNormalSexTimes Auto
GlobalVariable Property SLApproachProstitutionTimes Auto
GlobalVariable Property SLApproachProstitutionTryTimes Auto
GlobalVariable Property SLApproachGiftTimes Auto

GlobalVariable Property SLApproachProstitutionMin Auto
GlobalVariable Property SLApproachProstitutionMax Auto
GlobalVariable Property SLApproachProstitutionValue Auto
GlobalVariable Property SLApproachProstitutionFraudChance Auto

GlobalVariable Property SLApproachCurrentPlayerHouse Auto
GlobalVariable Property SLApproachVisitorStaying Auto

Faction Property ArousalFaction  Auto
Faction Property slapp_AggressiveBFFaction  Auto
Faction Property slapp_VisitedRapistFaction  Auto
Faction Property slapp_VisitingRapistFaction  Auto

ReferenceAlias Property Alias_VisitorRef  Auto  ; SLApproachScanningPlayerHouse
ReferenceAlias Property TalkingActor  Auto
ReferenceAlias Property StayingActor  Auto  
ReferenceAlias Property PlayerReference Auto

ReferenceAlias Property FollowerRef  Auto  
ReferenceAlias Property ExternalFollowerRef  Auto  

ReferenceAlias Property PlayerHouseCenterMarker Auto
ReferenceAlias Property ExternalPlayerHouseCenterMarker Auto

ReferenceAlias Property PlayerHouseDoor Auto
ReferenceAlias Property ExternalPlayerHouseDoor Auto

ReferenceAlias Property PlayerHouseCOC Auto
ReferenceAlias Property ExternalPlayerHouseCOC Auto

Scene Property SLAppHousevisitScene  Auto  
Scene Property SLAppAggressiveBFPCScene  Auto  
Scene Property SLAppViceGuardCaptainScene  Auto  
Scene Property SLAppAskingNameToPCScene  Auto  
Scene Property SLApproachAskForSexQuestScene  Auto  
Scene Property SLApproachAskForSexQuestFollowPlayerScene Auto
Scene Property SLApproachHouseStayScene Auto
;Scene Property SLAppHugToPCScene  Auto
;Scene Property SLAppKissToPCScene  Auto  

Armor Property SLAppRingBeast  Auto  

Keyword Property ActorTypeNPC  Auto  
TalkingActivator Property SLAPP_MaleVisitorTalkingActivator  Auto  

Sound Property SLAPPMarker_DoorClose  Auto  
Sound Property SLAPPMarker_DoorKnob  Auto  
Sound Property SLAPPMarker_DoorKnock  Auto  

Message Property SLAPP_KnockingDoorMsg  Auto  


actorbase Property VisitorRefBase Auto
ObjectReference Property SLAPPTestZoneXmarker Auto