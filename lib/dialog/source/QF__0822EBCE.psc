;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF__0822EBCE Extends Quest Hidden

;BEGIN ALIAS PROPERTY Bandit1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterSandboxRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterSandboxRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BanditBoss
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BanditBoss Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneCenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneCenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bandit3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bandit3 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
(Alias_Bandit1.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit2.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit3.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit4.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit1.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit2.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit3.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit4.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit1.getRef() as Actor).PushActorAway((Alias_Bandit1.getRef() as Actor), 1)
(Alias_Bandit2.getRef() as Actor).PushActorAway((Alias_Bandit2.getRef() as Actor), 1)
(Alias_Bandit3.getRef() as Actor).PushActorAway((Alias_Bandit3.getRef() as Actor), 1)
(Alias_Bandit4.getRef() as Actor).PushActorAway((Alias_Bandit4.getRef() as Actor), 1)

kmyQuest.pacifyAlias(Alias_BanditBoss)
kmyQuest.pacifyAlias(Alias_Bandit1)
kmyQuest.pacifyAlias(Alias_Bandit2)
kmyQuest.pacifyAlias(Alias_Bandit3)
kmyQuest.pacifyAlias(Alias_Bandit4)

Utility.Wait(3.0)

(Alias_bandit1.getRef() as Actor).EvaluatePackage()
(Alias_bandit2.getRef() as Actor).EvaluatePackage()
(Alias_bandit3.getRef() as Actor).EvaluatePackage()
(Alias_bandit4.getRef() as Actor).EvaluatePackage()
(BaboSexController as BaboSexControllerManager).EncounterEvent03Messagebox(3)
kmyquest.CorruptionExpLoss(5.0)
kmyquest.TraumaExpLoss(3.0)
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
(Alias_Bandit1.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit2.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit3.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit4.getRef() as Actor).SetUnconscious(false)
(Alias_Bandit1.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit2.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit3.getRef() as Actor).GetActorBase().SetEssential(false)
(Alias_Bandit4.getRef() as Actor).GetActorBase().SetEssential(false)

(Alias_BanditBoss.getRef() as Actor).RemoveFromFaction(AggressiveFaction)
(Alias_Bandit1.getRef() as Actor).RemoveFromFaction(AggressiveFaction)
(Alias_Bandit2.getRef() as Actor).RemoveFromFaction(AggressiveFaction)
(Alias_Bandit3.getRef() as Actor).RemoveFromFaction(AggressiveFaction)
(Alias_Bandit4.getRef() as Actor).RemoveFromFaction(AggressiveFaction)

kmyQuest.pacifyAlias(Alias_BanditBoss)
kmyQuest.pacifyAlias(Alias_Bandit1)
kmyQuest.pacifyAlias(Alias_Bandit2)
kmyQuest.pacifyAlias(Alias_Bandit3)
kmyQuest.pacifyAlias(Alias_Bandit4)

Utility.wait(3.0)

SceneIntro.Start()
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
(BaboSexController as BaboSexControllerManager).EncounterEvent03Messagebox(1)
kmyQuest.Rapegangbang5(Alias_Player, Alias_BanditBoss, Alias_Bandit2, Alias_Bandit3, Alias_Bandit4)
BRMQuest.SexCountgangbang(4)
kmyquest.CorruptionExp(3.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(Alias_BanditBoss.getRef() as Actor).EvaluatePackage()
(Alias_bandit1.getRef() as Actor).EvaluatePackage()
(Alias_bandit2.getRef() as Actor).EvaluatePackage()
(Alias_bandit3.getRef() as Actor).EvaluatePackage()
(Alias_bandit4.getRef() as Actor).EvaluatePackage()

BaboAllureQuest.AllureReturntoBasicValue()
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
kmyQuest.ChallengeStart(Alias_BanditBoss)
kmyQuest.ChallengeStart(Alias_Bandit1)
kmyQuest.ChallengeStart(Alias_Bandit2)
kmyQuest.ChallengeStart(Alias_Bandit3)
kmyQuest.ChallengeStart(Alias_Bandit4)
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
;debug.notification("Encounter 3 Started")
(Alias_BanditBoss.getRef() as Actor).EvaluatePackage()
(Alias_bandit1.getRef() as Actor).EvaluatePackage()
(Alias_bandit2.getRef() as Actor).EvaluatePackage()
(Alias_bandit3.getRef() as Actor).EvaluatePackage()
(Alias_bandit4.getRef() as Actor).EvaluatePackage()
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
(BaboSexController as BaboSexControllerManager).EncounterEvent03Messagebox(2)
kmyQuest.Rape2gangbang5(Alias_Player, Alias_BanditBoss, Alias_Bandit2, Alias_Bandit3, Alias_Bandit4)
BRMQuest.SexCountgangbang(4)
kmyquest.CorruptionExp(3.0)
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
; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()
BDQuest.DisableEssential()

alias_BanditBoss.GetReference().DeleteWhenAble()
alias_Bandit1.GetReference().DeleteWhenAble()
alias_Bandit2.GetReference().DeleteWhenAble()
alias_Bandit3.GetReference().DeleteWhenAble()
alias_Bandit4.GetReference().DeleteWhenAble()

Game.GetPlayer().GetActorBase().SetEssential(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property SceneIntro Auto
Faction Property AggressiveFaction Auto
GlobalVariable Property AllurePoints Auto
GlobalVariable Property AllureTrigger01 Auto
BaboAllureGlobalTrigger Property BaboAllureQuest  Auto  

BaboDiaQuest Property BDQuest  Auto  

BaboReputationMasterScript Property BRMQuest  Auto 

Quest Property BaboSexController Auto
