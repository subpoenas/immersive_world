Scriptname Yam_FetchTeammates extends ActiveMagicEffect

; -------------------------- Properties
Faction Property Yam_TmpTeammates Auto

; -------------------------- Code
Event OnEffectStart(Actor akTarget, Actor akCaster)
  If(akTarget.IsPlayerTeammate())
    akTarget.AddToFaction(Yam_TmpTeammates)
    akTarget.SetPlayerTeammate(false)
  endIf
EndEvent
