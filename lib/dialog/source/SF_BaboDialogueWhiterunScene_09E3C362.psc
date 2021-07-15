;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_BaboDialogueWhiterunScene_09E3C362 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Actor ViceCaptainActor = ViceCaptainRef.getreference() as actor
If ViceCaptainActor.getactorvalue("Variable06") == 4
BoyFriendVariablescript.BoyFriendVariableChange(ViceCaptainActor, 1, 4)
else
BoyFriendVariablescript.BoyFriendVariableChange(ViceCaptainActor, 1, 6)
endif
stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboBoyFriendVariableScript Property BoyFriendVariableScript Auto

ReferenceAlias Property ViceCaptainRef  Auto  
