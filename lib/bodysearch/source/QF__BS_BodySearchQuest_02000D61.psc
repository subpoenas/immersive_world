;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 18
Scriptname QF__BS_BodySearchQuest_02000D61 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef0
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef0 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerRef1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerRef1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerRef3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerRef3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerRef2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerRef2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerRef0
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerRef0 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef7
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef7 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY EvidenceChestStolenGoodsRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_EvidenceChestStolenGoodsRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerMarkerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerMarkerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardRef6
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardRef6 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FollowerMarkerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FollowerMarkerRef Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; add bounty end
kmyQuest.AddCrimeGold()
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; guard walks to player
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; resist arrest end
kmyQuest.AddCrimeGold()
kmyQuest.ResistArrest()
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; 3rd body search
kmyQuest.StartBodySearch(true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
; after inspection
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; after 1st body search
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; after 2nd body search
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; 1st body search
kmyQuest.StartBodySearchScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; 2nd body search (naked)
kmyQuest.StartBodySearch(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; after 2nd body search
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; inspect player belongings
kmyQuest.StartInspectionScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; normal end
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN AUTOCAST TYPE _BS_BodySearch
Quest __temp = self as Quest
_BS_BodySearch kmyQuest = __temp as _BS_BodySearch
;END AUTOCAST
;BEGIN CODE
; overlook lockpick end
kmyQuest.OverlookLockpick()
kmyQuest.Shutdown()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
