;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 42
Scriptname QF__0851CC84 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Scene_Marker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerChest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerChest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Scene_Marker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Noble
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Noble Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ElisifTheFairREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ElisifTheFairREF Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Scene_Marker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BolgeirBearclawREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BolgeirBearclawREF Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FalkFirebeardREF
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FalkFirebeardREF Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Debug.messagebox("I have killed the noble... ")
kmyQuest.ChallengeStart(Alias_Guard01)
kmyQuest.ChallengeStart(Alias_Guard02)
kmyQuest.ChallengeStart(Alias_Guard03)
kmyquest.CorruptionExpLoss(2.0)
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
Utility.wait(1)
(Alias_Noble.getRef() as Actor).EvaluatePackage()
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.pacifyAlias(Alias_Noble)
kmyQuest.pacifyAlias(Alias_Guard01)
kmyQuest.pacifyAlias(Alias_Guard02)
kmyQuest.pacifyAlias(Alias_Guard03)
kmyQuest.CompatiblityCheck(True)
Utility.wait(2.0)
kmyQuest.LosingControl()
Scene00.forceStart()
BDQuest.DisableEssential()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeFaintedFemalePlayer(Alias_Noble)
BRMQuest.SexCount(1)
kmyquest.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
;debug.notification("Encounter 11 Started")
(Alias_Noble.getRef() as Actor).EvaluatePackage()
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
(Alias_Guard02.getRef() as Actor).EvaluatePackage()
(Alias_Guard03.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
BaboEncounter11Scene04.Stop()
kmyQuest.UnEquipRestraints(game.getplayer())
kmyQuest.RecoverControl()
(Alias_ElisifTheFairREF.getRef() as Actor).EvaluatePackage()
(Alias_Noble.getRef() as Actor).EvaluatePackage()
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
BRMQuest.AddingTitletoPlayerRef(BaboFactionDeviousNobleSonFuckToyTitle)
BRMQuest.SetTitleGlobal(BaboGlobalDeviousNobleSonFuckToyTitle, 1)
BRMQuest.DecreaseReputation(40, 20)
(BaboSexController as BaboSexControllerManager).EncounterEvent11Messagebox(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
; debug.trace(self + "stage 255, calling DeleteWhenAble() on created aliases")
if (BaboEncounterQuestmarker.GetStageDone(11))
BaboEncounterQuestmarker.setstage(111)
endif

BDQuest.CompatiblityCheck(false)
Alias_Noble.GetReference().DeleteWhenAble()
Alias_Guard01.GetReference().DeleteWhenAble()
Alias_Guard02.GetReference().DeleteWhenAble()
Alias_Guard03.GetReference().DeleteWhenAble()

; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.LosingControl()
kmyQuest.ForceReference(Alias_FalkFirebeardREF, Falk)
kmyQuest.ForceReference(Alias_BolgeirBearclawREF, Bolgeir)
kmyQuest.ForceReference(Alias_ElisifthefairREF, Elisif)
(Alias_FalkFirebeardREF.getRef() as Actor).moveto(Marker01)
(Alias_ElisifthefairREF.getRef() as Actor).moveto(Marker02)
(Alias_BolgeirBearclawREF.getRef() as Actor).moveto(Marker03)
(BaboSexController as BaboSexControllerManager).EncounterEvent11Messagebox(1)
kmyquest.CorruptionExp(5.0)
kmyquest.TraumaExp(5.0)
BaboEncounter11Scene04.forceStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeFemalePlayer(Alias_Noble)
BRMQuest.SexCount(1)
kmyquest.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
Utility.wait(2.0)
Scene02.forceStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
Scene02.Stop()
SetStage(55)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
;Debug.messagebox("He ran away")
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
BaboEncounterQuestmarker.setstage(111)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.LosingControl()
(Alias_Noble.getRef() as Actor).EvaluatePackage()
(Alias_PlayerRef.getRef() as Actor).EvaluatePackage()
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
(Alias_Guard02.getRef() as Actor).EvaluatePackage()
(Alias_Guard03.getRef() as Actor).EvaluatePackage()
Utility.wait(10)
(Alias_PlayerRef.getRef() as Actor).moveto(SolitudePoint01)
(Alias_Noble.getRef() as Actor).moveto(SolitudePoint02)
(Alias_Guard01.getRef() as Actor).moveto(SolitudePoint03)
Utility.wait(1)
Setstage(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ChallengeStart(Alias_Noble)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
(Alias_Noble.getRef() as Actor).EvaluatePackage()
BDQuest.DisableEssential()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ChallengeStart(Alias_Guard01)
kmyQuest.ChallengeStart(Alias_Guard02)
kmyQuest.ChallengeStart(Alias_Guard03)
(Alias_Noble.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
(Alias_Noble.getRef() as Actor).EvaluatePackage()
(Alias_Guard01.getRef() as Actor).EvaluatePackage()
Setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
;Setobjectivedisplayed(90, 1)
BaboEncounterQuestmarker.setstage(11)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference property SolitudePoint01 Auto
ObjectReference property SolitudePoint02 Auto
ObjectReference property SolitudePoint03 Auto

Scene Property Scene00 Auto

Scene Property Scene02 Auto

Actor Property Falk  Auto  

Actor Property Elisif  Auto  

Actor Property Bolgeir  Auto  

ObjectReference Property Marker01  Auto  

ObjectReference Property Marker02  Auto  

ObjectReference Property Marker03  Auto  

Faction Property BaboFactionDeviousNobleSonFuckToyTitle  Auto  

GlobalVariable Property BaboGlobalDeviousNobleSonFuckToyTitle  Auto  

BaboReputationMasterScript Property BRMQuest Auto

Scene Property BaboEncounter11Scene04  Auto  

BaboDiaQuest Property BDQuest  Auto  

Quest Property BaboEncounterQuestMarker  Auto  

Quest Property BaboSexController  Auto  
