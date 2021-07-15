;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_BaboEncounter04_08517B71 Extends Quest Hidden

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nord03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nord03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterBanditCamp01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterBanditCamp01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Soldier02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Soldier02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Soldier01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Soldier01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nord01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nord01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Nord02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Nord02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterSandboxVillageRef01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterSandboxVillageRef01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
BaboEncounter04Scene02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
(Alias_Soldier02.getRef() as Actor).EvaluatePackage()
kmyQuest.RecoverControl()
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
(BaboSexController as BaboSexControllerManager).EncounterEvent04Messagebox(1)
kmyQuest.ExaminePussyPlayer(Alias_Nord01)
BRMQuest.SexCount(1)
kmyQuest.CorruptionExp(1.0)
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
(BaboSexController as BaboSexControllerManager).EncounterEvent04Messagebox(2)
kmyQuest.Rapegangbang4(Alias_PlayerRef, Alias_Nord01, Alias_Nord02, Alias_Nord03)
BRMQuest.SexCountgangbang(3)
kmyQuest.CorruptionExp(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;debug.trace(making bandits aggressive and attack player")
kmyquest.ChallengeStart(Alias_Nord01)
kmyquest.ChallengeStart(Alias_Nord02)
kmyquest.ChallengeStart(Alias_Nord03)
(BaboSexController as BaboSexControllerManager).EncounterEvent04Messagebox(3)
kmyQuest.CorruptionExpLoss(1.0)
kmyQuest.TraumaExpLoss(1.0)
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
(Alias_Nord01.getRef() as Actor).EvaluatePackage()
(Alias_Nord02.getRef() as Actor).EvaluatePackage()
(Alias_Nord03.getRef() as Actor).EvaluatePackage()
(Alias_soldier02.getRef() as Actor).EvaluatePackage()
Utility.wait(2.0)
kmyQuest.LosingControl()
BaboEncounter04Scene03.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;debug.notification("Encounter 4 Started")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()

alias_Soldier01.GetReference().DeleteWhenAble()
alias_Soldier02.GetReference().DeleteWhenAble()
alias_Nord01.GetReference().DeleteWhenAble()
alias_Nord02.GetReference().DeleteWhenAble()
alias_Nord03.GetReference().DeleteWhenAble()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property BaboEncounter04Scene02  Auto  

Scene Property BaboEncounter04Scene03  Auto  

BaboReputationMasterScript Property BRMQuest  Auto  

Quest Property BaboSexController  Auto  
