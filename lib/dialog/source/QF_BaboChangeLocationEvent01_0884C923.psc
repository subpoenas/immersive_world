;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 26
Scriptname QF_BaboChangeLocationEvent01_0884C923 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StartCity
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_StartCity Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CityCenter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CityCenter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_OldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChallengerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChallengerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), False, None, None)
BaboChangeLocationEvent01Scene05.Stop()
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
;Another Round Start
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(3)
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_ChallengerRef, None, None, None, Defeated, Rape, Necro, True, AfterSexS3, AfterSexScene3, true)
BRMQuest.SexCount(1)
kmyQuest.CorruptionExp(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;He plays with my Pussy
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), True, BaboEmbarrassment01F, BaboEmbarrassment01MPussy)
BaboChangeLocationEvent01Scene06.Start()
BRMQuest.DecreaseReputation(10, 0)
kmyQuest.CorruptionExp(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), False, None, None)
BaboChangeLocationEvent01Scene05.Stop()
BaboChangeLocationEvent01Scene06.Stop()
;gotoslaverycontents not yet
setstage(46)
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
;Need help!
;kmyQuest.EquipRestraints((Alias_PlayerRef.getref() as actor)) Already done in the scene
kmyQuest.RecoverControl()
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
BDQuest.DisableEssential()
(Alias_ChallengerRef.getref() as actor).EvaluatePackage()
(Alias_ChallengerRef.getref() as actor).DeleteWhenAble()
;stop()
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
;The challenger Died
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(8)
BRMQuest.IncreaseReputation(20, 10)
kmyQuest.CorruptionExpLoss(2.0)
kmyQuest.TraumaExpLoss(1.0)
Utility.Wait(30)
setstage(250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Debug.Trace("End of the Quest")
;Debug.messagebox("stage 250")
BDQuest.CompatiblityCheck(False)
;kmyQuest.RecoverControl()
kmyQuest.SpectatorChangeStatus(250)
Utility.wait(5.0)
setstage(251)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;The challenger freed me
BRMQuest.DecreaseReputation(10, 0)
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(5)
kmyQuest.UnEquipRestraints((Alias_PlayerRef.getref() as actor))
kmyQuest.UnEquipCumItem((Alias_PlayerRef.getref() as actor))
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
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), False, None, None)
BaboChangeLocationEvent01Scene04.Stop()
BRMQuest.AddingTitletoPlayerRef(BaboFactionChallengerFucktoyTitle)
BRMQuest.SetTitleGlobal(BaboGlobalChallengerFucktoyTitle, 1)
BRMQuest.DecreaseReputation(30, 00)

If FalkreathLocation == (Alias_PlayerRef.getref() as actor).getcurrentlocation()
BRMQuest.AddingTitletoPlayerRef(BaboFactionChallengerFalkreath)
BRMQuest.SetTitleGlobal(BaboGlobalChallengerFalkreath, 1)

ElseIf RiftenLocation == (Alias_PlayerRef.getref() as actor).getcurrentlocation()
BRMQuest.AddingTitletoPlayerRef(BaboFactionChallengerRiften)
BRMQuest.SetTitleGlobal(BaboGlobalChallengerRiften, 1)

ElseIf MorthalLocation == (Alias_PlayerRef.getref() as actor).getcurrentlocation()
BRMQuest.AddingTitletoPlayerRef(BaboFactionChallengerMorthal)
BRMQuest.SetTitleGlobal(BaboGlobalChallengerMorthal, 1)
EndIf
Setstage(40)
;kmyQuest.RecoverControl()
;kmyQuest.SpectatorChangeStatus(250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
Utility.wait(2.0)
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), True, BaboEmbarrassment01F, BaboEmbarrassment01M)
BaboChangeLocationEvent01Scene04.Start()
kmyQuest.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Guard Helped me...
kmyQuest.UnEquipRestraints((Alias_PlayerRef.getref() as actor))
kmyQuest.UnEquipCumItem((Alias_PlayerRef.getref() as actor))
BRMQuest.DecreaseReputation(0, 20)
setstage(250)
Utility.wait(3.0)
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(6)
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
;Debug.Notification("I ran away 25")
BaboChangeLocationEvent01Scene01.Start()
kmyQuest.LosingControl()
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
Game.GetPlayer().UnequipAll()
Utility.wait(5.0)
kmyQuest.LosingControl()
BaboChangeLocationEvent01Scene03.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Go to slavery
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), False, None, None)
BaboChangeLocationEvent01Scene06.Stop()
BaboChangeLocationEvent01Scene05.Stop()
setstage(250)
kmyQuest.DraggingtoSexMarket()
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
kmyQuest.FadeinMove(Alias_PlayerRef, Alias_CityCenter, 35, true)
kmyQuest.FadeOutMove(Alias_ChallengerRef, Alias_CityCenter, 0, false)
BaboChangeLocationEvent01Scene03.Stop()
kmyQuest.EquipCumItem((Alias_PlayerRef.getref() as actor))
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
;Sex Start
BaboChangeLocationEvent01Scene02.Stop()
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(2)
kmyQuest.RapeCustom(Alias_PlayerRef, Alias_ChallengerRef, None, None, None, Defeated, Rape, Babo, True, AfterSexS3, AfterSexScene3, true)
BRMQuest.SexCount(1)
kmyQuest.CorruptionExp(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;He plays with my boobs
BDMQuest.StruggleAnim((Alias_PlayerRef.getref() as actor), (Alias_ChallengerRef.getref() as actor), True, BaboEmbarrassment01F, BaboEmbarrassment01MChest)
BaboChangeLocationEvent01Scene05.Start()
BRMQuest.DecreaseReputation(10, 0)
kmyQuest.CorruptionExp(1.0)
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
Actor PChallenger = (Alias_CityCenter.getref() as objectreference).PlaceActorAtMe(BaboChallengerLVL, 4)
kmyQuest.ForceReference(Alias_ChallengerRef, PChallenger)
(Alias_ChallengerRef.getref() as actor).EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Persuasive Sex Start, Finding Inn
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
;I lost
kmyQuest.PacifyAlias(Alias_ChallengerRef)
kmyQuest.LosingControl()
Utility.wait(5.0)
kmyQuest.DisableEssential()
;Game.GetPlayer().GetActorBase().SetEssential(false)
BaboChangeLocationEvent01Scene02.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN AUTOCAST TYPE BaboDiaQuest
Quest __temp = self as Quest
BaboDiaQuest kmyQuest = __temp as BaboDiaQuest
;END AUTOCAST
;BEGIN CODE
;Debug.Notification("I gave up the figt 26")
BaboChangeLocationEvent01Scene01.Stop()
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(1)
BRMQuest.DecreaseReputation(10, 0)
kmyQuest.RecoverControl()
kmyQuest.PacifyAlias(Alias_ChallengerRef)
Setstage(250)
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
;Debug.Notification("Fight Start")
BDQuest.CompatiblityCheck(True)
kmyQuest.ChallengeStart(Alias_ChallengerRef)
kmyQuest.SpectatorActivate((Alias_ChallengerRef.getref() as actor), None)
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
;My friend Helped me...
kmyQuest.UnEquipRestraints((Alias_PlayerRef.getref() as actor))
kmyQuest.UnEquipCumItem((Alias_PlayerRef.getref() as actor))
(BaboSexController as BaboSexControllerManager).ChangeLocationEvent01Messagebox(7)
Utility.wait(5.0)
setstage(250)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ActorBase Property BaboChallengerLVL  Auto  

Scene Property BaboChangeLocationEvent01Scene01  Auto  

Scene Property BaboChangeLocationEvent01Scene02  Auto  

String Property Defeated  Auto  

String Property rape  Auto  

String Property Babo  Auto  

String Property AfterSexS3  Auto  

String Property AfterSexScene3  Auto  

String Property Necro  Auto  

Scene Property BaboChangeLocationEvent01Scene03  Auto  

BaboDiaMonitorScript Property BDMQuest  Auto  

BaboReputationMasterScript Property BRMQuest  Auto  

String Property BaboEmbarrassment01M  Auto  

String Property BaboEmbarrassment01F  Auto  

Scene Property BaboChangeLocationEvent01Scene04  Auto  

Faction Property BaboFactionChallengerFucktoyTitle  Auto  

GlobalVariable Property BaboGlobalChallengerFucktoyTitle  Auto  

String Property BaboEmbarrassment01MPussy  Auto  

String Property BaboEmbarrassment01MChest  Auto  

Scene Property BaboChangeLocationEvent01Scene05  Auto  

Scene Property BaboChangeLocationEvent01Scene06  Auto  

Location Property FalkreathLocation  Auto  

Location Property RiftenLocation  Auto  

Faction Property BaboFactionChallengerFalkreath  Auto  

Faction Property BaboFactionChallengerRiften  Auto  

GlobalVariable Property BaboGlobalChallengerFalkreath  Auto  

GlobalVariable Property BaboGlobalChallengerRiften  Auto  

GlobalVariable Property BaboGlobalChallengerSolitude  Auto  

GlobalVariable Property BaboGlobalChallengerWhiterun  Auto  

GlobalVariable Property BaboGlobalChallengerWindhelm  Auto  

GlobalVariable Property BaboGlobalChallengerMarkarth  Auto  

Faction Property BaboFactionChallengerMarkarth  Auto  

Faction Property BaboFactionChallengerSolitude  Auto  

Faction Property BaboFactionChallengerWhiterun  Auto  

Faction Property BaboFactionChallengerWindhelm  Auto  

Location Property MorthalLocation  Auto  

GlobalVariable Property BaboGlobalChallengerMorthal  Auto  

Faction Property BaboFactionChallengerMorthal  Auto  

BaboDiaQuest Property BDQuest  Auto  

Quest Property BaboSexController  Auto  
