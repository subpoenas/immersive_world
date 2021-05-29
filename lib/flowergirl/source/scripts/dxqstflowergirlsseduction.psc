;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname dxQstFlowerGirlsSeduction Extends Quest Hidden

;BEGIN ALIAS PROPERTY AliasFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasFollower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasForceGreet
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasForceGreet Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasSpeaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasSpeaker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Kiss the player
FlowerGirls.FlowerGirlsKiss(PlayerRef, Alias_AliasSpeaker.GetActorReference())
; Clear the force greet alias
Alias_AliasForceGreet.Clear()
SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Force greet player
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef  Auto  

dxFlowerGirlsScript Property FlowerGirls  Auto  
