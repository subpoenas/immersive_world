;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SSLV_TIF__02004934 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveDisplayed(10)
GetOwningQuest().SetStage(10)
Float fTimes = SSLV_TimesEnslaved.GetValue()
SSLV_TimesEnslaved.SetValue(fTimes + 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property SSLV_TimesEnslaved  Auto  
