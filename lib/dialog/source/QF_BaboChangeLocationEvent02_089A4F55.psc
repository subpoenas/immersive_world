;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname QF_BaboChangeLocationEvent02_089A4F55 Extends Quest Hidden

;BEGIN ALIAS PROPERTY CenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CreatureRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CreatureRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;Copulation Start
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, Wolf, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Debug.Messagebox("Change Location Encounter 2 Started")
BDQuest.CompatiblityCheck(True)
(Alias_CreatureRef.getref() as actor).EvaluatePackage()
setstage(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Copulation Start
if BaboHorribleHarassment.getvalue() == 1
kmyQuest.SLHHActivate(Alias_CreatureRef.getactorreference(), None)
else
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, Troll, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
BRMQuest.SexCount(1)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Copulation Ready
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent02Messagebox(1)
Game.DisablePlayerControls(false, false, true, false, false, false, false)
Alias_CreatureRef.trytoremovefromfaction(BaboChangeLocationEvent02FactionBefore)
Alias_CreatureRef.trytoaddtofaction(BaboChangeLocationEvent02FactionAfter)
Utility.wait(1.0)
(Alias_CreatureRef.getref() as actor).StopCombat()
(Alias_CreatureRef.getref() as actor).SetActorValue("Aggression", 1)
Utility.wait(5.0)
setstage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;The end of the quest
BaboTempStolengoodsRef.removeallitems(Game.getplayer(), false, true)
BDQuest.CompatiblityCheck(False)
BDQuest.DisableEssential()
(Alias_CreatureRef.getref() as actor).EvaluatePackage()
(Alias_CreatureRef.getref() as actor).DeleteWhenAble()

; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Utility.wait(10.0)
Alias_CreatureRef.trytoaddtofaction(BaboChangeLocationEvent02FactionBefore)
Alias_CreatureRef.trytoremovefromfaction(BaboChangeLocationEvent02FactionAfter)
Utility.wait(1.0)
(Alias_CreatureRef.getref() as actor).SetActorValue("Aggression", 3)

setstage(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;After the Copulation
utility.wait(30.0)
setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;After the copulation
Utility.wait(2.0)
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent02Messagebox(2)
Utility.wait(2.0)
setstage(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Copulation Start
if BaboHorribleHarassment.getvalue() == 1
kmyQuest.SLHHActivate(Alias_CreatureRef.getactorreference(), None)
else
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, Troll, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
BRMQuest.SexCount(1)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
;Copulation Start
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, Bear, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;Copulation Start
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, SabreCat, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
BRMQuest.SexCount(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Utility.wait(2.0)
Setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;Copulation Start
BDQuest.RapeCustom(Alias_PlayerRef, Alias_CreatureRef, None, None, None, SabreCat, Rough, Vaginal, True, AfterSexS3, AfterSexScene3, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Utility.wait(2.0)
Setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property BaboTempStolenGoodsRef  Auto  

Faction Property BaboChangeLocationEvent02FactionAfter  Auto  

Faction Property BaboChangeLocationEvent02FactionBefore  Auto  

BaboDiaQuest Property BDQuest Auto
String Property Aggressive  Auto  

String Property Bear  Auto  

String Property wolf  Auto  

String Property SabreCat  Auto  

String Property Rough  Auto  

String Property Troll  Auto  

String Property Vaginal  Auto  

String Property AfterSexScene3  Auto  

String Property AfterSexS3  Auto  

BaboReputationMasterScript Property BRMQuest  Auto  

GlobalVariable Property BaboHorribleHarassment  Auto  

Quest Property BaboSexController  Auto  
