;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BaboDiaHirelingD17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
String tag01 = "Cowgirl"
String tag02 = "Missionary"
String tag03 = "CF"
(Getowningquest() as BaboDialogueHirelingsQuest).CreatureSexCustom(Game.getplayer(), akspeaker, None, None, None, false, tag01, tag02, tag03, none, none, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
