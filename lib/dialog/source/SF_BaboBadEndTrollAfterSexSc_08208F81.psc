;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_BaboBadEndTrollAfterSexSc_08208F81 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
GetOwningQuest().setstage(60)
Xmarkermover.PlayerVoiceMoveOut()
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Xmarkermover.PlayerVoiceMovein()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboXMarkerMoverGeneric Property XmarkerMover Auto
