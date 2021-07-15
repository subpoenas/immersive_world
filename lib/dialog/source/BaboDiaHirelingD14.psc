;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BaboDiaHirelingD14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;String tag01 = "Aggressive"
;String tag02 = "Rape"
;String tag03 = "MF"
;String AfterSexS = "AfterSexS"
;String AfterSexScene = "AfterSexScene"
;(Getowningquest() as BaboDiaQuest).Rapecustom(PlayerRef, Alias_MercenaryRef, none, none, none, tag01, tag02, tag03, True, AfterSexS, AfterSexScene, true)
;(Getowningquest() as BaboDialogueHirelingsQuest).BaboNPCRaperList.addform(akspeaker)
;(Getowningquest() as BaboDialogueHirelingsQuest).DismissFollower(2)
(Getowningquest() as BaboDialogueHirelingsQuest).Havesex(true, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property PlayerRef  Auto  

ReferenceAlias Property Alias_MercenaryRef  Auto  
