Scriptname YamCloak extends ActiveMagicEffect

; -------------------------- Properties
YamScan Property Scan Auto
Actor Property PlayerRef Auto
Faction Property CurrentFollowerFaction Auto

Faction Property Yam_FriendFaction Auto
Faction Property Yam_TmpTeammates Auto ;Faction for Ex-Teammates

Spell Property FetchTeammates Auto ;Removes the Teammate Flag
Spell Property FetchExTeammates Auto ;Reapplies the Teammate Flag
; -------------------------- Variables
bool isTeammate = false

; -------------------------- Code
Event OnEffectStart(Actor akTarget, Actor akCaster)
	;	Teammates inherit their Combat behavior from the Player, meaning while they are a Teammate, only Actors that are hostle to the Player will be hostile to them and they are only hostile to Actors that are hostile to the player, thus:
	;	a Teammate Victim has their Teammate Flag removed until Scene end:
	If(akCaster.IsPlayerTeammate())
		akCaster.SetPlayerTeammate(false)
		akCaster.AddToFaction(Yam_TmpTeammates)
		isTeammate = true
	EndIf
	;	if the Player is Victim, remove the Teammate flag from everyone that has them
	If(akCaster == PlayerRef)
		FetchTeammates.Cast(PlayerRef)
	EndIf
	akCaster.AddToFaction(Yam_FriendFaction)
	Utility.Wait(0.05)
	;	Stop Actors that are currently targeting this one from fighting
	akCaster.StopCombat()
	akCaster.StopCombatAlarm()
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;	Resetting Teammate Flags
	If(isTeammate && !PlayerRef.HasMagicEffect(GetBaseObject()))
		;We only remove Flag here if the Player isnt a Victim currently. If they are, this Flag will be set once they are no longer a Victim
		akCaster.SetPlayerTeammate(true)
	EndIf
	If(akCaster == PlayerRef)
		FetchExTeammates.Cast(PlayerRef)
	EndIf
	;	Remove them from the Friend Factions
	akCaster.RemoveFromFaction(Yam_FriendFaction)
EndEvent
