;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04090880 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
Init.GuardWarnedOutcome = 4
Util.DoGuardWarningOutcome(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Init Property Init Auto
SLS_Utility Property Util Auto