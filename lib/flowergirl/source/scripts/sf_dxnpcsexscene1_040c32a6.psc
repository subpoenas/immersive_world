;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SF_dxNpcSexScene1_040C32A6 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
Actor actor1 = NpcActor1.GetActorRef()
Actor actor2 = NpcActor2.GetActorRef()
FlowerGirls.RandomScene(actor1, actor2)
Utility.Wait(1.0)
NpcActor1.Clear()
NpcActor2.Clear()
Actor1.EvaluatePackage()
Actor2.EvaluatePackage()
GetOwningQuest().Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

dxFlowerGirlsScript Property FlowerGirls  Auto  

ReferenceAlias Property NpcActor1  Auto  

ReferenceAlias Property NpcActor2  Auto  
