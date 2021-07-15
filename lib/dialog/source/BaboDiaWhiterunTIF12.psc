;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BaboDiaWhiterunTIF12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;akspeaker.Setactorvalue("Variable06", 6)
BaboBoyFriendVariable.BoyFriendVariableChange(akspeaker, 1, 6)
BaboBoyFriendVariable.BoyFriendTriggerEnd(akspeaker, 1)
BaboBoyFriendVariable.CheckHouseGold(akspeaker, PlayerChestRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboDiaMonitorScript Property BDMScript Auto
BaboBoyFriendVariableScript Property BaboBoyFriendVariable Auto

ObjectReference Property PlayerChestRef  Auto  
