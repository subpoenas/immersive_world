;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname dxTopicEndSeductionScript Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
AliasSpeaker.ForceRefTo(akSpeaker)
int response = ConfirmMessage.Show()
if (response == 0)
    (GetOwningQuest() as dxSeductionScript).DisableSeductionForActor(akSpeaker)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property AliasSpeaker  Auto  

Message Property ConfirmMessage  Auto  
