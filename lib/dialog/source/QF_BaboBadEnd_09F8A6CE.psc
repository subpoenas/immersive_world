;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 31
Scriptname QF_BaboBadEnd_09F8A6CE Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerVoiceStandbyRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerVoiceStandbyRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Creature
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Creature Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Raper2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Raper2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Raper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Raper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerVoiceRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerVoiceRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CenterMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CenterMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Helper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Helper Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
;NoSlavery
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RevertQuest(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RevertQuest(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ForceSceneStart(4)
BSCM.CreatureTraumaExp(1.0)
BSCM.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RapeStart()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SendModEvent("SSLV Entry")
BSCM.TraumaExp(5.0)
BSCM.CorruptionExp(10.0)
Utility.wait(1.0)
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
;Gotoslavery
;After the scene it goes to 199
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
Alias_Helper.getactorreference().evaluatepackage()
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
kmyQuest.UnEquipCumItem(Alias_PlayerRef.getreference() as actor)
kmyQuest.UnEquipRestraints(Alias_PlayerRef.getreference() as actor)

Alias_Creature.getactorreference().deletewhenable()
Alias_Helper.getactorreference().deletewhenable()
Alias_Raper.getactorreference().deletewhenable()
Alias_Raper2.getactorreference().deletewhenable()

Alias_Creature.clear()
Alias_Helper.clear()
Alias_Raper.clear()
Alias_Raper2.clear()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.StripandGetdressed()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ForceSceneStart(2)
BSCM.TraumaExp(2.0)
BSCM.CorruptionExp(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.AfterSex(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ForceSceneStart(3)
BSCM.TraumaExp(1.0)
BSCM.CorruptionExp(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.PastTime()
utility.wait(2.0)
setstage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RevertQuest(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.AfterSex(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.RevertQuest(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.Fadein()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.SpawnVariable(3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.CreatureRapeStart();
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.ForceSceneStart(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.SpawnVariable(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Alias_Helper.getactorreference().evaluatepackage()
Utility.wait(10.0)
setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.SpawnVariable(4)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.SpawnVariable(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN AUTOCAST TYPE BaboBadEndQuest
Quest __temp = self as Quest
BaboBadEndQuest kmyQuest = __temp as BaboBadEndQuest
;END AUTOCAST
;BEGIN CODE
kmyQuest.BaboBadEndVariable.setvalue(Utility.Randomint(1, 3))
kmyQuest.ResetAnimation()
BSCM.TraumaExp(5.0)
BSCM.CorruptionExp(8.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


BaboSexControllerManager Property BSCM Auto
