;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04050A36 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Game.GetFormFromFile(0x0420BB, "SL Survival.esp") as _SLS_LicenceUtil).EquipMandatoryRestaints()
(Game.GetFormFromFile(0x0550CD, "SL Survival.esp") as _SLS_TollDodgeWalkAway).WalkAwayState = 5
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
