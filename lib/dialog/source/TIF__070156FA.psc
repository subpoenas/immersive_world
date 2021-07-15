;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__070156FA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[2]
sexActors[0] = VictimFemale.GetRef() as Actor
sexActors[1] = TrollRaper.GetRef() as Actor
sslBaseAnimation[] anims
anims = SexLab.GetAnimationsByTag(2, "Troll", "Vaginal")
SexLab.StartSex(sexActors, anims, victim=sexActors[0])
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab  Auto
ReferenceAlias Property VictimFemale Auto
ReferenceAlias Property TrollRaper Auto
