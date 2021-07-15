;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_BaboEventWhiterunOrcVisit_09C6033F Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Int Random = Utility.Randomint(0, 1)
If Random == 0
BaboChangeLocationEvent05VisitorGlobal.setvalue(0)
ElseIf Random == 1
BaboChangeLocationEvent05VisitorGlobal.setvalue(1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Getowningquest().setstage(5)
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property BaboChangeLocationEvent05VisitorGlobal  Auto  
