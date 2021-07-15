;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_BaboEncounter11Scene02_085F17D7 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
If BaboEncounter11NoCombat.getvalue() == 0
GetOwningQuest().SetStage(42)
BaboEncounter11Scene02.Stop()
Else
SexLabUtil.GetAPI().StripActor(PlayerRef, DoAnimate = True)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
getowningquest().setstage(45)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property BaboEncounter11NoCombat  Auto  

Scene Property BaboEncounter11Scene02  Auto  

Actor Property PlayerRef  Auto  
