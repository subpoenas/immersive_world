;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SF_BaboDialogueWhiterunScene_09B8627C Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
getOwningQuest().setStage(21)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(OrcVisitorRef01.getactorref()).moveto(BaboEventWhiterunOrcVisitorA1Xmarker)
(OrcVisitorRef02.getactorref()).moveto(BaboEventWhiterunOrcVisitorA2Xmarker)
(OrcVisitorRef03.getactorref()).moveto(BaboEventWhiterunOrcVisitorA3Xmarker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property OrcVisitorRef01  Auto  

ReferenceAlias Property OrcVisitorRef02  Auto  

ReferenceAlias Property OrcVisitorRef03  Auto  

ObjectReference Property BaboEventWhiterunOrcVisitorA2Xmarker  Auto  

ObjectReference Property BaboEventWhiterunOrcVisitorA3Xmarker  Auto  

ObjectReference Property BaboEventWhiterunOrcVisitorA1Xmarker  Auto  
