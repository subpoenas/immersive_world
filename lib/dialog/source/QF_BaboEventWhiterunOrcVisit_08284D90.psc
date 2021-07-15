;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 25
Scriptname QF_BaboEventWhiterunOrcVisit_08284D90 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Child02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Child02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Lydia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Lydia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OrcRaper01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OrcRaper01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ViceCaptainRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ViceCaptainRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OrcRaper03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OrcRaper03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Child01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Child01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OrcRaper02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OrcRaper02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
Alias_Lydia.Clear()
Alias_Child01.Clear()
Alias_Child02.Clear()
Alias_OrcRaper01.Clear()
Alias_OrcRaper02.Clear()
Alias_OrcRaper03.Clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.OrcRapeScene01.Stop()

(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper02.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper03.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
;The orcs refused to rape me for I am too ugly.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
(Alias_Lydia.getRef() as Actor).EvaluatePackage()
(Alias_Child01.getRef() as Actor).EvaluatePackage()
(Alias_Child02.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
;Standing by for another spin
BaboEventWhiterunOrcVisitorsTriggerEvent.setvalue(2)
;ChangeLocationEvent will occur. a guard will appear and will try to warn you.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Messagebox(9)
BRMQuest.IncreaseReputation(20, 10)
BaboGlobalWhiterunOrcFuckToyTitle.setvalue(0)
(Alias_Child01.getRef() as Actor).EvaluatePackage()
(Alias_Child02.getRef() as Actor).EvaluatePackage()
(Alias_Lydia.getRef() as Actor).EvaluatePackage()

Alias_Lydia.Clear()
Alias_Child01.Clear()
Alias_Child02.Clear()

Alias_OrcRaper01.GetReference().DeleteWhenAble()
Alias_OrcRaper02.GetReference().DeleteWhenAble()
Alias_OrcRaper03.GetReference().DeleteWhenAble()

kmyQuest.GoState()
kmyQuest.RegisterUpdate(84)
BQuest.CompatiblityCheck(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Messagebox(3)
BRMQuest.DecreaseReputation(-20, 0)
(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper02.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper03.getRef() as Actor).EvaluatePackage()

Utility.Wait(5.0)

kmyQuest.AttackPeople(Alias_OrcRaper01)
kmyQuest.AttackPeople(Alias_OrcRaper02)
kmyQuest.AttackPeople(Alias_OrcRaper03)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
;This goes to BaboDialogueWhiterun stage 19
BaboDialogueWhiterun.setstage(19)
(OrcVisitorRef01).forcerefto(Alias_OrcRaper01.getRef() as Actor)
(OrcVisitorRef02).forcerefto(Alias_OrcRaper02.getRef() as Actor)
(OrcVisitorRef03).forcerefto(Alias_OrcRaper03.getRef() as Actor)
Utility.wait(1.0)
Alias_OrcRaper01.Clear()
Alias_OrcRaper02.Clear()
Alias_OrcRaper03.Clear()
Utility.wait(1.0)
self.setstage(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
BRMQuest.DecreaseReputation(30, 10)
BQuest.CorruptionExp(3.0)
BRMQuest.AddingTitletoPlayerRef(BaboFactionWhiterunOrcFuckToyTitle)
BRMQuest.SetTitleGlobal(BaboGlobalWhiterunOrcFuckToyTitle, 1)
Setstage(67)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper02.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper03.getRef() as Actor).EvaluatePackage()
(Alias_Child01.getRef() as Actor).EvaluatePackage()
(Alias_Child02.getRef() as Actor).EvaluatePackage()
(Alias_Lydia.getRef() as Actor).EvaluatePackage()

Alias_OrcRaper01.GetReference().DeleteWhenAble()
Alias_OrcRaper02.GetReference().DeleteWhenAble()
Alias_OrcRaper03.GetReference().DeleteWhenAble()

kmyQuest.Messagebox(7)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
BQuest.RecoverControl()
kmyQuest.Messagebox(8)
BRMQuest.IncreaseReputation(10, 0)

Alias_Lydia.Clear()
Alias_Child01.Clear()
Alias_Child02.Clear()

Alias_OrcRaper01.GetReference().DeleteWhenAble()
Alias_OrcRaper02.GetReference().DeleteWhenAble()
Alias_OrcRaper03.GetReference().DeleteWhenAble()

kmyQuest.GoState()
kmyQuest.RegisterUpdate(84)
BQuest.CompatiblityCheck(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
;wait for another day.
kmyQuest.GoStateBefore()
kmyQuest.RegisterUpdate(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.OrcRapeScene01.Stop()

(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper02.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper03.getRef() as Actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.GoState()
kmyQuest.RegisterUpdate(48)
BQuest.CompatiblityCheck(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper02.getRef() as Actor).EvaluatePackage()
(Alias_OrcRaper03.getRef() as Actor).EvaluatePackage()
(Alias_Lydia.getRef() as Actor).EvaluatePackage()
(Alias_Child01.getRef() as Actor).EvaluatePackage()
(Alias_Child02.getRef() as Actor).EvaluatePackage()

kmyQuest.GoStateBefore()
kmyQuest.RegisterUpdate(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
;After killing orcs. They are not going to spread the rumor
BaboEventWhiterunOrcVisitorsTriggerEvent.setvalue(1)
kmyQuest.Messagebox(1)
; This means I need to talk to one of the guards to lower their guards. Until then, no more orcs
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
;This goes to BaboDialogueWhiterun. Orcs will be killed.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Scene02.Stop()
Utility.wait(1.0)
kmyQuest.RapeGangbangBE4(Alias_PlayerREF, Alias_OrcRaper01, Alias_OrcRaper02, Alias_OrcRaper03)
kmyQuest.Messagebox(6)
BRMQuest.SexCountgangbang(3)
BQuest.CorruptionExp(5.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.Scene01.Stop()
(Alias_OrcRaper01.getRef() as Actor).EvaluatePackage()
kmyQuest.EquipZazItem()
BQuest.RecoverControl()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.SpawnOrcs()
kmyQuest.Messagebox(2)
BQuest.CompatiblityCheck(True)
Utility.wait(3.0)
kmyQuest.OrcRapeScene01.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
;Extra Scene Start
BaboEventWhiterunOrcVisitiorsSceneExtra.Start()
BQuest.LosingControl()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveWeapons(Alias_OrcRaper01, Alias_OrcRaper02, Alias_OrcRaper03)
Utility.wait(1.0)
BQuest.SexCustom(Alias_PlayerREF, Alias_OrcRaper01, Alias_OrcRaper02, None, None, MMF, Aggressive, None, True, "WOAS01", "WhiterunOrcVisitorsAfterSex01", true)
kmyQuest.Messagebox(5)
BRMQuest.SexCountgangbang(2)
BQuest.CorruptionExp(3.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE BaboEventWhiterunOrcVisitorsScript
Quest __temp = self as Quest
BaboEventWhiterunOrcVisitorsScript kmyQuest = __temp as BaboEventWhiterunOrcVisitorsScript
;END AUTOCAST
;BEGIN CODE
BQuest.RecoverControl()
kmyQuest.Messagebox(4)
kmyQuest.AttackPeople(Alias_OrcRaper01)
kmyQuest.AttackPeople(Alias_OrcRaper02)
kmyQuest.AttackPeople(Alias_OrcRaper03)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
BaboEventWhiterunOrcVisitiorsScene03.stop()
Utility.wait(0.5)
BQuest.SexCustom(Alias_PlayerREF, Alias_OrcRaper03, None, None, None, MF, Aggressive, Necro, True, "WOAS02", "WhiterunOrcVisitorsAfterSex02", true)
BRMQuest.SexCount(1)
BQuest.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


ObjectReference property SpawnPlace auto
BaboSexControllerManager Property BQuest Auto
BaboReputationMasterScript Property BRMQuest Auto

Faction Property BaboFactionWhiterunOrcFuckToyTitle  Auto  

GlobalVariable Property BaboGlobalWhiterunOrcFuckToyTitle  Auto  

Scene Property BaboEventWhiterunOrcVisitiorsSceneExtra  Auto  

GlobalVariable Property BaboEventWhiterunOrcVisitorsTriggerEvent  Auto  

Quest Property BaboDialogueWhiterun  Auto  

ReferenceAlias Property OrcVisitorRef01  Auto  

ReferenceAlias Property OrcVisitorRef02  Auto  

ReferenceAlias Property OrcVisitorRef03  Auto  

String Property MMF  Auto  

String Property Aggressive  Auto  

String Property AfterSexScene  Auto  

String Property AfterSexS  Auto  

String Property MF  Auto  

String Property Necro  Auto  

String Property AfterSexScene2  Auto  

String Property AfterSexS2  Auto  

Scene Property BaboEventWhiterunOrcVisitiorsScene03  Auto  
