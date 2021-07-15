;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SF_BaboEventMarkarthGuardSce_09C0F25B Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
GetOwningQuest().setStage(12)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
BDQuest.FadeinMove(PlayerRef, BaboEventMarkarthGuardXmarker01, 10, False)
BDQuest.FadeOutMove(DStrictGuard, BaboEventMarkarthGuardXmarker02, 10, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
armor CurrentGloves = (DStrictGuard.getref() as actor).GetWornForm(0x00000008) as armor
armor CurrentHead = (DStrictGuard.getref() as actor).GetWornForm(0x00000001) as armor
(DStrictGuard.getref() as actor).unequipitem(CurrentGloves)
(DStrictGuard.getref() as actor).unequipitem(CurrentHead)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboDiaQuest Property BDQuest Auto

ReferenceAlias Property PlayerRef  Auto  

ReferenceAlias Property BaboEventMarkarthGuardXmarker01  Auto  

ReferenceAlias Property DStrictGuard  Auto  

ReferenceAlias Property BaboEventMarkarthGuardXmarker02  Auto  
