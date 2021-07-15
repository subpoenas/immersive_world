;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF__08205F47 Extends Quest Hidden

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Soldier1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Soldier1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Soldier3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Soldier3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Soldier2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Soldier2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterSandboxRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterSandboxRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.DraggingtoSexMarketWithPossibility()
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
BaboEncounter02Scene02.Stop()
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), False, None, None)
(BaboSexController as BaboSexControllerManager).EncounterEvent02Messagebox(3)
SendModEvent("SSLV Entry")
kmyQuest.TraumaExp(3.0)
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Utility.wait(3.0)
Debug.SendAnimationEvent(Alias_Player.getref() as actor, "IdleForceDefaultState")
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), True, BaboEmbarrassment01F, BaboEmbarrassment01MPussy)
BaboEncounter02Scene02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
;No slavery
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
;Yes Slavery
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
; debug.trace(making bandits aggressive and attack player")

kmyQuest.ChallengeStart(Alias_Bandit1)
kmyQuest.ChallengeStart(Alias_Bandit2)
kmyQuest.ChallengeStart(Alias_Bandit3)
kmyQuest.TraumaExpLoss(1.0)
kmyQuest.CorruptionExpLoss(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;debug.notification("Encounter 2 Started")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
BaboEncounter02Scene02.Stop()
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), False, None, None)
Utility.wait(1.0)
(Alias_bandit1.getRef() as Actor).EvaluatePackage()
(Alias_bandit2.getRef() as Actor).EvaluatePackage()
(Alias_bandit3.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), False, None, None)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;Judgement Scene Start
(BaboSexController as BaboSexControllerManager).EncounterEvent02Messagebox(1)
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), True, BaboEmbarrassment01F, BaboEmbarrassment01MChest)
BMSQuest.RandomPainMenu(Game.getplayer())
Self.BaboEncounter02Scene01.start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
BMSQuest.StruggleAnim((Alias_Player.getref() as actor), (Alias_bandit1.getref() as actor), False, None, None)
Utility.wait(1.0)
(BaboSexController as BaboSexControllerManager).EncounterEvent02Messagebox(2)
kmyQuest.Rapegangbang4(Alias_Player, Alias_Bandit1, Alias_Bandit2, Alias_Bandit3)
BRMQuest.SexCountgangbang(3)
kmyQuest.CorruptionExp(3.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()

alias_Soldier1.GetReference().DeleteWhenAble()
alias_Soldier2.GetReference().DeleteWhenAble()
alias_Soldier3.GetReference().DeleteWhenAble()
alias_Bandit1.GetReference().DeleteWhenAble()
alias_Bandit2.GetReference().DeleteWhenAble()
alias_Bandit3.GetReference().DeleteWhenAble()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property BaboEncounter02Scene01  Auto  

Scene Property BaboEncounter02Scene02  Auto  

BaboDiaMonitorScript Property BMSQuest  Auto  

String Property BaboEmbarrassment01F  Auto  

String Property BaboEmbarrassment01MPussy  Auto  

String Property BaboEmbarrassment01MChest  Auto  

BaboReputationMasterScript Property BRMQuest  Auto 

Quest Property BaboSexController  Auto  
