Scriptname BaboBadEndQuest extends Quest Conditional

formlist property BaboSpawnRoads auto
formlist property BaboSpawnTrees auto
formlist property BaboSpawnAspenTrees auto
int HowFarToLook
int Property NoLess Auto

ReferenceAlias Property Alias_PlayerRef auto
ReferenceAlias Property Alias_Centermarker auto
ReferenceAlias Property Alias_Raper auto
ReferenceAlias Property Alias_Raper2 auto
ReferenceAlias Property Alias_Creature auto
ReferenceAlias Property Alias_Helper auto
GlobalVariable Property BaboBadEndVariable auto

ActorBase Property BaboBadEndHelper  Auto  
ActorBase Property BaboBadEndThug  Auto  
ActorBase Property BaboBadEndThug02  Auto  
ActorBase Property BaboBadEndThief  Auto  
ActorBase Property BaboBadEndLvlAnimalTroll  Auto


Furniture Property zbfTorturePoleCustom03StdWood  Auto  
ImageSpaceModifier Property FadeToBlackImod  Auto  
ImageSpaceModifier Property FadeToBlackHoldImod  Auto  
ImageSpaceModifier Property FadeToBlackBackImod  Auto  
GlobalVariable Property GameHour  Auto  
Scene Property BaboBadEndBrigandScene  Auto  
Scene Property BaboBadEndHelperScene  Auto  
String Property MMF  Auto  
String Property Aggressive  Auto  
String Property AfterSexS  Auto  
String Property AfterSexScene  Auto  
Scene Property BaboBadEndBrigandAfterSexScene  Auto  
Scene Property BaboBadEndTrollAfterSexScene Auto  
Scene Property BaboBadEndThiefScene  Auto  
Scene Property BaboBadEndTrollScene  Auto  

Idle Property BaboBadEnding01 Auto
Idle Property BaboBadEnding02 Auto
Idle Property BaboBadEnding03 Auto
Idle Property BaboDefeatedPanting01 Auto

Quest Property BaboSexController Auto

BaboDiaMonitorScript property BDMScript Auto
BaboStealingArmorScript Property BSAS Auto
BaboDialogueConfigMenu Property BDCM Auto
BaboReputationMasterScript Property BRMQuest  Auto  

GlobalVariable Property BaboSimpleSlavery Auto
GlobalVariable Property BaboSimpleSlaveryChance Auto

Function PlayBaboBadEnding()
int chance = Utility.randomint(1,3)
Actor PlayerRef = Alias_PlayerRef.getactorreference()
if chance == 1
	PlayerRef.playidle(BaboBadEnding01)
elseif chance == 2
	PlayerRef.playidle(BaboBadEnding02)
else
	PlayerRef.playidle(BaboBadEnding03)
endif
EndFunction

Function ResetAnimation()
	Debug.SendAnimationEvent(Alias_PlayerRef.getactorreference(), "IdleForceDefaultState")
EndFunction

Function SpawnVariable(int num)
	if num == 1
		SpawnNPCs(BaboBadEndHelper, none)
		Alias_PlayerRef.Getowningquest().setstage(15)
	elseif num == 2
		SpawnNPCs(BaboBadEndThug, BaboBadEndThug02)
		Alias_PlayerRef.Getowningquest().setstage(15)
	elseif num == 3
		SpawnNPCs(BaboBadEndThief, None)
		Alias_PlayerRef.Getowningquest().setstage(15)
	elseif num == 4
		SpawnNPCs(BaboBadEndLvlAnimalTroll, None)
		Alias_PlayerRef.Getowningquest().setstage(15)
	endif
EndFunction

Function RevertQuest(int num)
Actor PlayerRef = Alias_PlayerRef.getactorreference()
	if num == 1
		(BaboSexController as BaboSexControllerManager).UnEquipRestraints(PlayerRef)
		Utility.wait(1.0)
		(BaboSexController as BaboSexControllerManager).UnEquipCumItem(PlayerRef)
		(BaboSexController as BaboSexControllerManager).RecoverControl()
		BDCM.RecoverEquipments()
	elseif num == 2
		(BaboSexController as BaboSexControllerManager).BadEndMessagebox(1)
		BRMQuest.DecreaseReputation(20, 0)
		FadeToBlackImod.Apply()
		utility.wait(2)
		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
		FadeToBlackImod.PopTo(FadeToBlackHoldImod)
		Alias_Raper.getactorreference().delete()
		Alias_Raper2.getactorreference().delete()
		Alias_Raper.clear()
		Alias_Raper2.clear()
		utility.wait(2)
		PlayBaboBadEnding()
		FadeToBlackHoldImod.Remove()

		MiscUtil.SetFreeCameraState(true)
		MiscUtil.SetFreeCameraSpeed(2)
		utility.wait(2)
		MiscUtil.SetFreeCameraState(false)

		BaboBadEndVariable.setvalue(Utility.Randomint(1, 4))
		if BaboBadEndVariable.getvalue() == 2;Only helper for now
			BaboBadEndVariable.setvalue(1)
		endif
		
		Alias_PlayerRef.Getowningquest().setstage(5)
	elseif num == 3
		BRMQuest.DecreaseReputation(10, 0)
		Alias_Raper.getactorreference().delete()
		Alias_Raper.clear()
		BaboBadEndVariable.setvalue(Utility.Randomint(1, 4))
		if BaboBadEndVariable.getvalue() == 3;Only helper for now
			BaboBadEndVariable.setvalue(1)
		endif
		Alias_PlayerRef.Getowningquest().setstage(5)
	elseif num == 4
		Alias_Creature.getactorreference().delete()
		Alias_Creature.clear()
		(BaboSexController as BaboSexControllerManager).UnEquipRestraints(PlayerRef)
		Utility.wait(1.0)
		(BaboSexController as BaboSexControllerManager).UnEquipCumItem(PlayerRef)
		(BaboSexController as BaboSexControllerManager).RecoverControl()
		BDCM.RecoverEquipments()
		Alias_PlayerRef.Getowningquest().setstage(100)
		Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	endif

EndFunction

Function SpawnNPCs(Actorbase SpawnNPC, Actorbase SpawnNPC2)
	actor SpawnActor1
	actor SpawnActor2
	HowFarToLook = 512
	objectreference spawnherolocation
	Int BaboSpawnRoadsList = BaboSpawnRoads.GetSize()
	Int I = 0
		objectreference BaboEndSpawn = game.FindRandomReferenceOfAnyTypeInListFromRef(BaboSpawnRoads, game.GetPlayer() as objectreference, HowFarToLook as Float)
		objectreference BaboEndSpawnTress = game.FindRandomReferenceOfAnyTypeInListFromRef(BaboSpawnTrees, game.GetPlayer() as objectreference, HowFarToLook as Float)
		objectreference BaboEndSpawnAspenTress = game.FindRandomReferenceOfAnyTypeInListFromRef(BaboSpawnAspenTrees, game.GetPlayer() as objectreference, HowFarToLook as Float)
		if BaboEndSpawn != none && game.GetPlayer().GetDistance(BaboEndSpawn) > NoLess as Float
			SpawnActor1 = BaboEndSpawn.PlaceActorAtMe(SpawnNPC, 4, none)
			
			if babobadendvariable.getvalue() == 2

				SpawnActor2 = BaboEndSpawn.PlaceActorAtMe(SpawnNPC2, 4, none)
				self.DesignateAlias(SpawnActor1, SpawnActor2)
				self.StatsSet(SpawnActor1)
				self.StatsSet(SpawnActor2)
			else
				self.DesignateAlias(SpawnActor1, None)
				self.StatsSet(SpawnActor1)
			endif
			
		elseif BaboEndSpawnTress != none && game.GetPlayer().GetDistance(BaboEndSpawnTress) > NoLess as Float
			SpawnActor1 = BaboEndSpawnTress.PlaceActorAtMe(SpawnNPC, 4, none)
			if babobadendvariable.getvalue() == 2

				SpawnActor2 = BaboEndSpawnTress.PlaceActorAtMe(SpawnNPC2, 4, none)
				self.DesignateAlias(SpawnActor1, SpawnActor2)
				self.StatsSet(SpawnActor1)
				self.StatsSet(SpawnActor2)
			else
				self.DesignateAlias(SpawnActor1, None)
				self.StatsSet(SpawnActor1)
			endif
		elseif BaboEndSpawnAspenTress != none && game.GetPlayer().GetDistance(BaboEndSpawnAspenTress) > NoLess as Float
			SpawnActor1 = BaboEndSpawnAspenTress.PlaceActorAtMe(SpawnNPC, 4, none)
			if babobadendvariable.getvalue() == 2

				SpawnActor2 = BaboEndSpawnAspenTress.PlaceActorAtMe(SpawnNPC2, 4, none)
				self.DesignateAlias(SpawnActor1, SpawnActor2)
				self.StatsSet(SpawnActor1)
				self.StatsSet(SpawnActor2)
			else
				self.DesignateAlias(SpawnActor1, None)
				self.StatsSet(SpawnActor1)
			endif
		else
			objectreference Centermarker = Alias_CenterMarker.getreference()
			SpawnActor1 = Centermarker.PlaceActorAtMe(SpawnNPC, 4, none)
			if babobadendvariable.getvalue() == 2

				SpawnActor2 = Centermarker.PlaceActorAtMe(SpawnNPC2, 4, none)
				self.DesignateAlias(SpawnActor1, SpawnActor2)
				self.StatsSet(SpawnActor1)
				self.StatsSet(SpawnActor2)
			else
				self.DesignateAlias(SpawnActor1, None)
				self.StatsSet(SpawnActor1)
			endif
		endIf
EndFunction

Function DesignateAlias(Actor akactor, Actor akactor2)

If BaboBadEndVariable.getvalue() == 1
	Alias_Helper.forcerefto(akactor)
Elseif BaboBadEndVariable.getvalue() == 2
	Alias_Raper.forcerefto(akactor)
	Alias_Raper2.forcerefto(akactor2)
Elseif BaboBadEndVariable.getvalue() == 3
	Alias_Raper.forcerefto(akactor)
Elseif BaboBadEndVariable.getvalue() == 4
	Alias_Creature.forcerefto(akactor)
Endif

EndFunction

Function StatsSet(Actor Dude)

dude.SetActorValue("Aggression", 1.0)	; ensure is aggressive
dude.SetActorValue("Confidence", 3.0)	; brave
dude.SetActorValue("Energy", 99.0)   ; super energetic
dude.SetActorValue("Mood", 4.0)	; Not angry
dude.SetActorValue("Morality", 1.0)	; violence against enemies
dude.EnableAI(True)
dude.evaluatepackage()

endfunction

Function StripandGetdressed()

BSAS.GetStrippedArmor(Alias_PlayerRef.getactorreference(), None, True)
(BaboSexController as BaboSexControllerManager).EquipRestraints(Alias_PlayerRef.getactorreference(), true)
Utility.wait(1.0)
(BaboSexController as BaboSexControllerManager).EquipCumItem(Alias_PlayerRef.getactorreference())

EndFunction

Function Fadein()

Actor PlayerRef = Alias_PlayerRef.getactorreference()
Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
FadeToBlackImod.Apply()
utility.wait(2)
FadeToBlackImod.PopTo(FadeToBlackHoldImod)
utility.wait(2)
PlayBaboBadEnding()
;BDMScript.FurnitureDisplay(PlayerRef, zbfTorturePoleCustom03StdWood)
;BDMScript.FurnitureActivate(PlayerRef)
utility.wait(2)
FadeToBlackHoldImod.Remove()

MiscUtil.SetFreeCameraState(true)
MiscUtil.SetFreeCameraSpeed(2)
utility.wait(2)
MiscUtil.SetFreeCameraState(false)

EndFunction

Function PastTime()

Float CurrentTime = GameHour.GetValue()
BDMScript.RandomPainMenu(Alias_PlayerRef.getactorreference())
GameHour.SetValue(CurrentTime + Utility.randomfloat(1, 3))
(BaboSexController as BaboSexControllerManager).BadEndMessagebox(2)

EndFunction

Function ForceSceneStart(int num)

if num == 1
	(BaboSexController as BaboSexControllerManager).BadEndMessagebox(3)
	BaboBadEndHelperScene.Forcestart()
elseif num == 2
	(BaboSexController as BaboSexControllerManager).BadEndMessagebox(4)
	BaboBadEndBrigandScene.Forcestart()
elseif num == 3
	(BaboSexController as BaboSexControllerManager).BadEndMessagebox(5)
	BaboBadEndThiefScene.forcestart()
elseif num == 4
	(BaboSexController as BaboSexControllerManager).BadEndMessagebox(6)
	BaboBadEndTrollScene.forcestart()

endif

EndFunction

Function RapeStart()

Actor PlayerRef = Alias_PlayerRef.getactorreference()
;BDMScript.FurnitureDespawn(PlayerRef)
Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
Utility.wait(1.0)
(BaboSexController as BaboSexControllerManager).SexCustom(Alias_PlayerREF, Alias_Raper, Alias_Raper2, None, None, MMF, Aggressive, None, True, "BEAS01", "BadEndAfterSex01", true)

EndFunction

Function CreatureRapeStart()

Actor PlayerRef = Alias_PlayerRef.getactorreference()
Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
Utility.wait(1.0)
(BaboSexController as BaboSexControllerManager).SexCustom(Alias_PlayerREF, Alias_Creature, None, None, None, "CF", "Aggressive", None, True, "BEAS01", "BadEndAfterSex01", true)

EndFunction


Function AfterSex(int scenario)

if scenario == 1

elseif scenario == 2
	Self.DraggingtoSexMarketWithPossibility()
	BaboBadEndBrigandAfterSexScene.forcestart()
elseif scenario == 3

elseif scenario == 4
	BaboBadEndTrollAfterSexScene.forcestart()
endif

EndFunction

Function BEAS01()
	Actor PlayerRef = Alias_PlayerRef.getactorreference()
	Utility.wait(2.0)
	PlayerRef.playidle(BaboDefeatedPanting01)
	Alias_PlayerRef.Getowningquest().setstage(55)
EndFunction

Function DraggingtoSexMarketWithPossibility()
	int random = Utility.RandomInt(0, 99)
	If BaboSimpleSlavery.getvalue() == 1
		If Random < BaboSimpleSlaveryChance.getvalue() as int
			Alias_PlayerRef.Getowningquest().setstage(57)
		Else
			Alias_PlayerRef.Getowningquest().setstage(56)
		EndIf
	Else
		Alias_PlayerRef.Getowningquest().setstage(56)
	EndIf
EndFunction