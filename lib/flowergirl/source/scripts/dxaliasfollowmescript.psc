Scriptname dxAliasFollowMeScript extends ReferenceAlias  

; Clears the alias on the actors death
Event OnDeath(Actor akKiller)
	(GetOwningQuest() as dxFlowerGirlsScript).StopFollowMe(Self.GetActorReference())
endEvent
