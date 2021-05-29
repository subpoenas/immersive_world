Scriptname dxAmorousInstallScript extends Quest  
{Adds the Amorous Adventures NPC's to the FG faction.}

ReferenceAlias[] Property AmorousActorRefs Auto
Faction Property dxNoDefaultDialogueFaction Auto

Function ApplyFGFaction()
	int i = 0
	while (i < AmorousActorRefs.Length)
		Actor a = AmorousActorRefs[i].GetActorReference()
		if (a == NONE)
			Debug.Trace(Self + " ApplyFGFaction(): Actor at index: " + i + " is NONE.")
		else
			if (a.IsInFaction(dxNoDefaultDialogueFaction))
				Debug.Trace(Self + " ApplyFGFaction(): Actor: " + a + " is already in the NoDefaultDialogue Faction.")
			else
				a.AddToFaction(dxNoDefaultDialogueFaction)
				Debug.Trace(Self + " ApplyFGFaction(): Added Actor: " + a + " to NoDefaultDialogue Faction.")
			endIf
		endIf
		i += 1
	endWhile
	Self.Stop()
EndFunction

Function RemoveFGFaction()
	int i = 0
	while (i < AmorousActorRefs.Length)
		Actor a = AmorousActorRefs[i].GetActorReference()
		if (a == NONE)
			Debug.Trace(Self + " RemoveFGFaction(): Actor at index: " + i + " is NONE.")
		else
			if (a.IsInFaction(dxNoDefaultDialogueFaction))
				a.RemoveFromFaction(dxNoDefaultDialogueFaction)
				Debug.Trace(Self + " RemoveFGFaction(): Actor: " + a + " has been removed from the NoDefaultDialogue Faction.")
			endIf
		endIf
		i += 1
	endWhile
	Self.Stop()
EndFunction