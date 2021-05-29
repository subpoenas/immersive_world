Scriptname dxSeductionWitnessDragonKill extends Quest  

dxSeductionScript Property SeductionScript  Auto  
Faction Property SeductionFaction Auto
ReferenceAlias Property Follower Auto
Keyword Property WitnessDragonKillKW Auto

Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
	Debug.Trace(Self + " Caught OnStoryScript event with keyword: " + akKeyword)
	if (akKeyword == WitnessDragonKillKW)
		Actor _actor = Follower.GetActorReference()
		if (_actor != NONE)
			Location _playerLocation = Game.GetPlayer().GetCurrentLocation()
			if(_playerLocation == _actor.GetCurrentLocation())
				if (_actor.IsInFaction(SeductionFaction))
					if (_actor.GetFactionRank(SeductionFaction) > 0)
						Debug.Trace(Self + " Follower witnessed dragon kill, so increasing seduction")
						SeductionScript.WitnessDragonKill(_actor)
					endIf
				endIf
			else
				Debug.Trace(Self + " The follower is not in same location: " + _playerLocation + " Follower location: " + _actor.GetCurrentLocation())
			endIf
		else
			Debug.Trace(Self + " Actor in the follower alias is NONE")
		endIf
	else
		Debug.Trace(Self + " StoryEvent keyword not applicable: " + akKeyword)
	endIf
	
	Stop()
	
endEvent
