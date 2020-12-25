Scriptname SLApproachPlayerAliasScript extends ReferenceAlias  

Quest Property SLApproachScanningPlayerHouse Auto
SLAppPCSexQuestScript Property SLApproachPC Auto
SLApproachMainScript Property SLApproachMain Auto
SLApproachBaseQuestScript Property SLApproachBase Auto
Spell Property CloakAbility Auto
Actor player
int Version
int VersionDecimal

Event OnPlayerLoadGame()
	SLApproachMain.Maintenance()
;	SLApproachMain.RegisterForCrosshairRef()
	SLApproachBase.RegisterExternalModEvent()
	UnregisterForUpdate()
	player = Game.GetPlayer()
	player.addperk(SLAPPDoorLockPerk)
	RegisterForSingleUpdate(1)
	Debug.notification("Sexlab Approach Redux Version =" + CheckingVersion() + "." + CheckingVersionDecimal())
EndEvent

Event OnInit()
	player = Game.GetPlayer()
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
;	if SLApproachMain.debugLogFlag
;		Debug.Notification("SexLab Approach: CloakUpdate")
;	Endif
	if (!SLApproachMain.isSkipUpdateMode)
	;SLApproachPC.PCApproachOngoing = false
		int tooSlowBySeconds = 0
		while (SLApproachMain.actorsEffectStarted > SLApproachMain.actorsEffectFinished)
			tooSlowBySeconds = tooSlowBySeconds  + 3
			;debug.notification("SexLab Approach: started: " + SLApproachMain.actorsEffectStarted + " finished: "+ SLApproachMain.actorsEffectFinished)
			Utility.Wait(1.0)
		endwhile
		
		if (tooSlowBySeconds > 0)
			debug.trace("Sexlab Approach: Papyrus too slow for cloak frequency setting by " + tooSlowBySeconds  + " seconds.")
		endif
		
		if (Game.IsActivateControlsEnabled()) && (Game.IsFightingControlsEnabled()) && (Game.IsMovementControlsEnabled()) && (Game.IsSneakingControlsEnabled()) && (SLApproachPC.PCApproachOngoing == false)
			SLApproachMain.actorsEffectStarted = 0
			SLApproachMain.actorsEffectFinished = 0
				if SLApproachMain.debugLogFlag
					Debug.Notification("SexLab Approach: Cloak!")
				endif
			SLApproachMain.isDuringCloakPulse = true
			player.AddSpell(CloakAbility, false)
			player.RemoveSpell(CloakAbility)
			SLApproachMain.isDuringCloakPulse = false
			if SLApproachPC.iGetFormIndex() && (SLApproachPC.PCApproachOngoing == false) && (SLApproachMain.SLAHouseVisitChance > 0) && (SLApproachScanningPlayerHouse.getstage() == 5)
				SLApproachPC.KnockKnock()
				if SLApproachMain.debugLogFlag
					Debug.notification("Knock Knock...")
				endif
			endif
		else
			if SLApproachMain.debugLogFlag
				Debug.Notification("SexLab Approach: Cloak Failed!")
			endif
		endif

	endif
	
	RegisterForSingleUpdate(SLApproachMain.cloakFrequency)
EndEvent

int Function CheckingVersion()
Version = 1
Return Version
EndFunction

int Function CheckingVersionDecimal()
VersionDecimal = 3
Return VersionDecimal
EndFunction

Perk Property SLAPPDoorLockPerk  Auto  
