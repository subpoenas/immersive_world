;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname dxTopicHelloScript Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if (ServiceChargeEnable.GetValueInt() == 1)
	ServiceCharge.SetValue(1)
else
	ServiceCharge.SetValue(0)
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property ServiceChargeEnable  Auto  

GlobalVariable Property ServiceCharge  Auto  
