;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SF_BaboDialogueWhiterunScene_09B86291 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Game.EnablePlayerControls()
Game.SetPlayerAIDriven(false)
Game.getplayer().SetRestrained(False)
Game.getplayer().SetDontMove(False)
(Alias_ViceCaptainRef.getref() as actor).SetRestrained(False)
(Alias_ViceCaptainRef.getref() as actor).SetDontMove(False)
Utility.wait(1.0)
getowningquest().setstage(25)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
BDMScript.PairedAnim(Game.getplayer(), (Alias_ViceCaptainRef.getref() as actor), None, False, BaboFaintOrgasm01_A1_S01, BaboFaintOrgasm01_A2_S01)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
BDMScript.PairedAnim(Game.getplayer(), (Alias_ViceCaptainRef.getref() as actor), None, False, BaboFaintOrgasm01_A1_S02, BaboFaintOrgasm01_A2_S02)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

BaboDiaMonitorScript Property BDMScript Auto
Idle Property BaboFaintOrgasm01_A1_S01  Auto  
Idle Property BaboFaintOrgasm01_A2_S01  Auto  
Idle Property BaboFaintOrgasm01_A1_S02  Auto  
Idle Property BaboFaintOrgasm01_A2_S02  Auto  

ReferenceAlias Property Alias_ViceCaptainRef  Auto  
