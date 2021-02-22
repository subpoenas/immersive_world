Scriptname Yam_UnfetchTeammates extends ActiveMagicEffect

; -------------------------- Properties
Faction Property Yam_TmpTeammates Auto

; -------------------------- Code
Event OnEffectStart(Actor akTarget, Actor akCaster)
  If(akTarget.IsInFaction(Yam_TmpTeammates))
    akTarget.SetPlayerTeammate(true)
    akTarget.RemoveFromFaction(Yam_TmpTeammates)
  endIf
EndEvent
