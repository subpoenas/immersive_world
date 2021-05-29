Scriptname dxBewitchScript extends activemagiceffect  

Faction Property DibellianFaction Auto
Message Property MsgBewitched  Auto  

Keyword Property FlowerGirlsBlocker  Auto  
Faction Property CurrentFollowerFaction  Auto  
Faction Property PotentialFollowerFaction  Auto  
Faction Property PlayerMarriedFaction  Auto

FormList Property BlockedRaces  Auto  
FormList Property PermittedRaces Auto
{Deprecated as of 1.8.3: Now uses Blacklist to filter.}

bool isBewitched = False

Function OnEffectStart(Actor akTarget, Actor akCaster)
	
	if (!akTarget)
		return
	endIf
	
	Debug.Trace(Self + " OnEffectStart(): akTarget is: " + akTarget + "  akCaster is: " + akCaster)

	bool bewitch = True
	
	Race targetRace = akTarget.GetRace()
	bool isBlockedRace = False
	int i = BlockedRaces.GetSize()
	while ( i  && !isBlockedRace)
		i -= 1
		if (targetRace == BlockedRaces.GetAt(i))
			isBlockedRace = True
		endIf
	endWhile
	
	if (isBlockedRace)
		Debug.Notification("Members of the target's race are immune to your sorcery!")
		bewitch = False
	elseIf (akTarget.IsInFaction(CurrentFollowerFaction) || akTarget.IsInFaction(PotentialFollowerFaction))
		Debug.Notification("The target already has dialogue available.")
		bewitch = False
	elseIf (akTarget.IsInFaction(PlayerMarriedFaction))
		int isex = akTarget.GetLeveledActorBase().GetSex()
		if (isex)
			Debug.Notification("You would attempt to pimp your poor wife? Have you no shame?!")
		else
			Debug.Notification("You would attempt to pimp your poor husband? Have you no shame?!")
		endIf
		bewitch = False
	elseIf (akTarget.IsPlayerTeammate())
		Debug.Notification("The target requires no extra coercion!")
		bewitch = False
	elseIf (akTarget.HasKeyword(FlowerGirlsBlocker))
		Debug.Notification("The target has been cock blocked by an external influence.")
		bewitch = False
	endIf
	
	if (bewitch)
		akTarget.AddToFaction(DibellianFaction)
		MsgBewitched.Show()
		isBewitched = True
	else
		Self.Dispel()
	endIf
	
endFunction

Function OnEffectFinish(Actor akTarget, Actor akCaster)

	Debug.Trace(Self + " OnEffectFinish(): akTarget is: " + akTarget + "  akCaster is: " + akCaster)

	if (akTarget && isBewitched)
		akTarget.RemoveFromFaction(DibellianFaction)
	endIf

endFunction



