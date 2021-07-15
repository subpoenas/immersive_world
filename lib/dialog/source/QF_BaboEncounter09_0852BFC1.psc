;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_BaboEncounter09_0852BFC1 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Central_Marker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Central_Marker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Scene_Marker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldImperial
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldImperial Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldSons
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldSons Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldContested
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldContested Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY myHoldLocation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_myHoldLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Scene_Marker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterSnadBoxRef01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterSnadBoxRef01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Falmer02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Falmer02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Scene_Marker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Scene_Marker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Falmer01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Falmer01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Falmer03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Falmer03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Victim
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Victim Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TRIGGER
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TRIGGER Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PostEncounterSnadBoxRef02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PostEncounterSnadBoxRef02 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE WEScript
Quest __temp = self as Quest
WEScript kmyQuest = __temp as WEScript
;END AUTOCAST
;BEGIN CODE
; debug.trace(self + "stage 255, calling ReArmTrigger() on trigger" + Alias_Trigger.GetReference())
(Alias_Trigger.GetReference() as WETriggerScript).ReArmTrigger()

Alias_Falmer01.GetReference().DeleteWhenAble()
Alias_Falmer02.GetReference().DeleteWhenAble()
Alias_Falmer03.GetReference().DeleteWhenAble()
Alias_Victim.GetReference().DeleteWhenAble()
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
;debug.notification("Encounter 9 Started")
(Alias_Falmer01.getRef() as Actor).EvaluatePackage()
(Alias_Falmer02.getRef() as Actor).EvaluatePackage()
(Alias_Falmer03.getRef() as Actor).EvaluatePackage()
(Alias_Victim.getRef() as Actor).EvaluatePackage()
Utility.wait(5.0)
kmyQuest.RapeCustom(Alias_Victim, Alias_Falmer01, None, None, None, Creature, none, none, false, none, none, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(Alias_Victim.getRef() as Actor).EvaluatePackage()
Utility.Wait(10.0)
BaboSlaveRescueCount.SetValue(RescueCount.GetValue() + 1)
BaboSlaveRescueCountStore.Setvalue(BaboSlaveRescueCountStore.getvalue() + 1)
Setstage(255)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property RescueCount  Auto  

GlobalVariable Property BaboSlaveRescueCountStore  Auto  

GlobalVariable Property BaboSlaveRescueCount  Auto  

String Property Creature  Auto  
