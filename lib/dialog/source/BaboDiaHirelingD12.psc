;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BaboDiaHirelingD12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;String tag01 = "Cowgirl"
;String tag02 = "Missionary"
;String tag03 = "Doggy"
;(Getowningquest() as BaboDiaQuest).Rapecustom(PlayerRef, Alias_MercenaryRef, none, none, none, tag01, tag02, tag03, false, none, none, false)
;(Getowningquest() as BaboDialogueHirelingsQuest).BaboNPCHadSexList.addform(akspeaker)
(Getowningquest() as BaboDialogueHirelingsQuest).Havesex(false, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_MercenaryRef  Auto  

ReferenceAlias Property PlayerRef  Auto  
