;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 52
Scriptname dxDialogueQuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY AliasPlayer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasPlayer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasLoveInterest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasLoveInterest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasFollowMe1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasFollowMe1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasNakedTarget5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasNakedTarget5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasThirdActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasThirdActor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasSecondActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasSecondActor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasNakedTarget4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasNakedTarget4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasNakedTarget2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasNakedTarget2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasFollowMe2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasFollowMe2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasSpeaker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasSpeaker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasNakedTarget3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasNakedTarget3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasNakedTarget
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasNakedTarget Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AliasFirstActor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AliasFirstActor Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
;-------------------------------------------------------------
; Solo Masturbation - Actor FlowerGirl
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(20 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())
SetStage(97)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
;-------------------------------------------------------------
; Anal Positions with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(60 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(96)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
;-------------------------------------------------------------
; Cunnilingus Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(25 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())
SetStage(95)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
;-------------------------------------------------------------
; Oral Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.OralScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
;-------------------------------------------------------------
; Doggy Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(40 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(91)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
;-------------------------------------------------------------
; Standing Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.StandingScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
;-------------------------------------------------------------
; Missionary Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.MissionaryScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
; -------------------------------------------------
; Stop the actor in the alias from following.
;--------------------------------------------------
FlowerGirlsScript.StopFollowMe(Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
;-------------------------------------------------------------
; Cowgirl Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(30 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
;-------------------------------------------------------------
; Cowgirl Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.CowgirlScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
;-------------------------------------------------------------
; Standing Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(50 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(94)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; --------------------------------------------------
; Sets speaker into the follow alias package.
;---------------------------------------------------
FlowerGirlsScript.FollowMe(Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
; ----------------------------------------------------------------
; Play Random Sex Scene with the speaker and player.
;-----------------------------------------------------------------
FlowerGirlsScript.RandomScene(PlayerREF, Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
;-------------------------------------------------------------
; Anal Positions - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.AnalScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_50
Function Fragment_50()
;BEGIN CODE
;-------------------------------------------------------------
; Osex with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(50 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
;-------------------------------------------------------------
; Just Strip Naked
;-------------------------------------------------------------
FlowerGirlsScript.UndressActor(Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;------------------------------------------------------
; Plays Threesome Scene with the aliases set.
;------------------------------------------------------
FlowerGirlsScript.AddThreesomeParticipant(Alias_AliasSpeaker.GetActorRef())

FlowerGirlsScript.PlayThreesome()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_51
Function Fragment_51()
;BEGIN CODE
;-------------------------------------------------------------
; OSEX - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.OsexScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
;-------------------------------------------------------------
; Cunnilingus Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.CunnilingusScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47()
;BEGIN CODE
;-------------------------------------------------------------
; Titty Fuck with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(35 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(101)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
;-------------------------------------------------------------
; Oral Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(25 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())

SetStage(93)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
; --------------------------------------------------------
; Play Random Sex Scene with the two aliases.
;---------------------------------------------------------
FlowerGirlsScript.RandomScene(Alias_AliasFirstActor.GetActorRef(), Alias_AliasSecondActor.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
; -----------------------------------------------
; Play Kissing Scene with the two aliases.
;------------------------------------------------
FlowerGirlsScript.FlowerGirlsKiss(Alias_AliasSecondActor.GetActorRef(), Alias_AliasFirstActor.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48()
;BEGIN CODE
;-------------------------------------------------------------
; Titty Fuck Positions - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.TittyFuckScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;------------------------------------------------
; Threesome - Add participant
;------------------------------------------------
FlowerGirlsScript.AddThreesomeParticipant(Alias_AliasSpeaker.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
;-------------------------------------------------------------
; Doggy Position - 2 Actors
;-------------------------------------------------------------
FlowerGirlsScript.DoggyScene()
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
;-------------------------------------------------------------
; Solo Masturbation - Single Actor
;-------------------------------------------------------------
FlowerGirlsScript.MasturbationScene(NONE)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
;-------------------------------------------------------------
; Missionary Position with Player
;-------------------------------------------------------------
if (ServiceCharge.GetValue())
    int iCharge = Math.Floor(50 * ServiceChargeMultiplier.GetValue())
    PlayerRef.RemoveItem(Gold, iCharge)
    Alias_AliasSpeaker.GetActorRef().AddItem(Gold, iCharge)
endIf
Alias_AliasFirstActor.ForceRefTo(PlayerRef)
Alias_AliasSecondActor.ForceRefTo(Alias_AliasSpeaker.GetActorRef())
SetStage(92)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
;------------------------------------------------
; Threesome - Remove Participant.
;------------------------------------------------
FlowerGirlsScript.RemoveThreesomeParticipant(Alias_AliasSpeaker.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; ------------------------------------------
; Play Kissing Scene with the speaker
;-------------------------------------------
FlowerGirlsScript.FlowerGirlsKiss(Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
;-------------------------------------------------------------
; Just Strip Naked
;-------------------------------------------------------------
FlowerGirlsScript.RedressActor(Alias_AliasSpeaker.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerREF Auto
dxFlowerGirlsScript Property FlowerGirlsScript  Auto  
MiscObject Property Gold  Auto
GlobalVariable Property ServiceCharge  Auto  


GlobalVariable Property ServiceChargeMultiplier  Auto  
