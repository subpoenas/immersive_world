;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 18
Scriptname QF_BaboChangeLocationEvent06_08040CE3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY NewLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_NewLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_OldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RapistRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RapistRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CityEventSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CityEventSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
Alias_RapistRef.getactorreference().EvaluatePackage()
BRMQuest.DecreaseReputation(-10, 0)
setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;Standby
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.FadeOutMove(Alias_RapistRef, Alias_CityEventSpot, 14, true)
setstage(14)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
BaboChangeLocationEvent06Scene02.forcestart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
BaboChangeLocationEvent06Scene01.stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_RapistRef, None, None, None, "Aggressive", "MF", "Rape", True, "AfterSexS2", "AfterSexScene2", true)
;Not gonna use
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
;BaboChangeLocationEvent06Scene01.forcestart()
Alias_RapistRef.getactorreference().evaluatepackage()
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent06Messagebox(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_RapistRef, None, None, None, "Aggressive", "MF", "Rape", True, "AfterSexScene01S", "AfterSexScene01", true)
BRMQuest.SexCount(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.FadeinMove(None, None, 0, false)
Utility.wait(5.0)
(Alias_RapistRef.getref() as actor).Delete()
kmyQuest.FadeOutMove(None, None, 0, false)
Float CurrentTime = GameHour.GetValue()
GameHour.SetValue(CurrentTime + Utility.randomfloat(1, 3))
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent06Messagebox(2)
kmyQuest.TraumaExp(1.0)
kmyQuest.CorruptionExp(1.0)
kmyQuest.LewdnessExp(1.0)
setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;SLHH 
BaboChangeLocationEvent06Scene01.stop()
kmyQuest.SLHHActivate(Alias_RapistRef.getactorreference())
BaboChangeLocation06AssaultCount.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;leave
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
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_RapistRef, None, None, None, "Aggressive", "MF", "Rape", True, "AfterSexS2", "AfterSexScene2", true)
BRMQuest.SexCount(1)
kmyQuest.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(Alias_RapistRef.getref() as actor).Deletewhenable()
stop()
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
kmyQuest.FadeinMove(Alias_PlayerRef, Alias_CityEventSpot, 13, True)
setstage(13)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;SLHHBC Fainted, now it's gonna be a long night
BaboChangeLocationEvent06Scene01.stop()
kmyQuest.SLHHChokeActivate(Alias_RapistRef.getreference() as actor)
BaboChangeLocation06AssaultCount.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetStage(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_RapistRef, None, None, None, "Aggressive", "MF", "Rape", True, "AfterSexS", "AfterSexScene", true)
kmyQuest.CorruptionExp(1.0)
BRMQuest.SexCount(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property BaboChangeLocationEvent06Scene01  Auto  

Scene Property BaboChangeLocationEvent06Scene02  Auto  

GlobalVariable Property GameHour  Auto  

BaboDiaMonitorScript Property BDMScript Auto

BaboReputationMasterScript Property BRMQuest Auto

Quest Property BaboSexController  Auto  

GlobalVariable Property BaboChangeLocation06AssaultCount  Auto  
