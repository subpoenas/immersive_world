;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_BaboDialogueWhiterunScene_09EBACC1 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
If Getowningquest().getstage() == 52
Getowningquest().setstage(75)
elseif Getowningquest().getstage() == 54
Getowningquest().setstage(56)
endif
BFVS.PrepDuelwithBF(1, none, none, none, none, 0, true)
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboBoyFriendVariableScript Property BFVS Auto
