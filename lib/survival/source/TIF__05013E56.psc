;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05013E56 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).DoCreatureSex(akSpeaker = akSpeaker, SexType = "Oral", Victim = None, IsCreatureFondle = true)
Debug.SendAnimationEvent(Game.GetPlayer(), "IdleStop")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
