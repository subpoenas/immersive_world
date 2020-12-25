Scriptname _BS_FindFollowers extends Quest

ReferenceAlias[] Property FollowerRAs Auto
_BS_BodySearch Property _BS_BodySearchQuest Auto

Event OnInit()
	bool debugOutputEnabled = _BS_BodySearchQuest.MCM.DebugOutputEnabled
	int n = FollowerRAs.Length
	int i = 0
	while i < n
		Actor follower = FollowerRAs[i].GetReference() as Actor
		if follower
			_BS_BodySearchQuest.FollowerRAs[i].ForceRefTo(follower)
			if debugOutputEnabled
				Debug.Trace("[BS] follower" + i + "=" + follower)
			endif
		endif
		i += 1
	endWhile
	_BS_BodySearchQuest.FollowerAliasesFilled = true
	Stop()
EndEvent

