Scriptname dxSeductionEffectScript extends activemagiceffect Conditional

Actor Property PlayerRef Auto

Faction Property SeductionFaction  Auto  

FormList Property BlockedRaces  Auto  
FormList Property PermittedRaces Auto
{Deprecated as of 1.8.3: Now uses black list instead.}

Message Property MsgSeduced Auto

Keyword Property FlowerGirlsBlocker  Auto  
Faction Property CurrentFollowerFaction  Auto  
Faction Property PotentialFollowerFaction  Auto  
Faction Property PlayerMarriedFaction  Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
	
	if (!akTarget)
		return
	endIf
	
	Debug.Trace(Self + " OnEffectStart(): akTarget is: " + akTarget + "  akCaster is: " + akCaster)

	bool seduce = True
	
	Race targetRace = akTarget.GetRace()
	bool isBlockedRace = False
	int i = BlockedRaces.GetSize()
	while ( i  && !isBlockedRace)
		i -= 1
		if ( targetRace == BlockedRaces.GetAt(i))
			isBlockedRace = True
		endIf
	endWhile
	
	if (isBlockedRace)
		Debug.Notification("Members of the target's race are immune to your sorcery!")
		seduce = False
	elseIf (akTarget.IsInFaction(CurrentFollowerFaction) || akTarget.IsInFaction(PotentialFollowerFaction))
		Debug.Notification("The target already has dialogue available.")
		seduce = False
	elseIf (akTarget.IsInFaction(PlayerMarriedFaction))
		int isex = akTarget.GetLeveledActorBase().GetSex()
		if (isex)
			Debug.Notification("Your wife has already been naturally seduced.")
		else
			Debug.Notification("Your husband has already been naturally seduced.")
		endIf
		seduce = False
	elseIf (akTarget.IsPlayerTeammate())
		Debug.Notification("The target requires no extra coercion!")
		seduce = False
	elseIf (akTarget.HasKeyword(FlowerGirlsBlocker))
		Debug.Notification("The target has been cock blocked by an external influence.")
		seduce = False
	endIf
	
	if (seduce)
		akTarget.SetRelationshipRank(PlayerRef, 1)
		akTarget.AddToFaction(SeductionFaction)
		akTarget.SetFactionRank(SeductionFaction, 1)
		MsgSeduced.Show()
	else
		Self.Dispel()
	endIf
	
endFunction


