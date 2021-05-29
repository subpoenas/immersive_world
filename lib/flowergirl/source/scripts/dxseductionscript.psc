Scriptname dxSeductionScript extends Quest conditional

dxFlowerGirlsScript Property FlowerGirls Auto

Faction Property CurrentFollowerFaction  Auto  

Actor Property PlayerRef Auto
Actor Property SpeakerActor Auto Hidden
ReferenceAlias Property AliasFollower  Auto 
ReferenceAlias Property CurrentFollower  Auto  
ReferenceAlias Property AliasSpeaker  Auto  
ReferenceAlias Property AliasForceGreet  Auto  

FormList Property DefaultGiftFilter Auto

Message Property GiftMessage  Auto 
Message Property GiftTimerMessage Auto
Message Property DragonMessage  Auto  
Message Property TimeMessage  Auto  
Message Property LoverMessage  Auto  
Message Property QuestMessage Auto

Actor aFollower
int iHourCount = 0
int iDayCount = 0
bool Property GiftTimer = false Auto Conditional Hidden
bool Property AmorousInstalled Auto Conditional Hidden
float updateTick = 1.0
int iGiftTimerCount = 0

;--------------------------------------------------------------------
; Timer Functions
;--------------------------------------------------------------------

Function EnableSeduction()
	Debug.Trace(Self + " EnableSeduction(): Seduction Enabled")
	RegisterForSingleUpdateGameTime(updateTick)	; Approximately 1 in game hours
endFunction

Function DisableSeduction()
	Debug.Trace(Self + " DisableSeduction(): Seduction Disabled")
	UnregisterForUpdateGameTime()
endFunction

Event OnInit()
	EnableSeduction()
endEvent

Event OnUpdateGameTime()
		
	if (FlowerGirls.FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt() == 0)
		return
	endIf
	
	; Do we have a current follower?
	Actor _follower = AliasFollower.GetActorReference()		
	if (_follower != NONE)
		; Is the alias still valid?
		if (_follower.IsInFaction(CurrentFollowerFaction))			
			if (aFollower == NONE)
				aFollower = _follower
				Debug.Trace(Self + " OnUpdateGameTime(): Caching follower: " + aFollower)
			else
				; Is it the same follower as last update?
				if (_follower == aFollower)
					iHourCount += 1
					if (iHourCount > 11)
						iHourCount = 0
						SpendTime(_follower)
					endIf
				else
					aFollower = _follower
					Debug.Trace(Self + " OnUpdateGameTime(): Changed follower: " + aFollower)
					iHourCount = 0
				endIf
			endIf
		else
			Debug.Trace(Self + " OnUpdateGameTime(): Follower is no longer in CurrentFollowerFaction.")
			; The alias is currently not valid so refresh the alias.
			_follower = CurrentFollower.GetActorReference()
			if (_follower)
				AliasFollower.ForceRefTo(_follower)
			else
				AliasFollower.Clear()
			endIf
			iHourCount = 0
		endIf
	else
		;  No follower so clear any cached follower.
		aFollower = NONE
		iHourCount = 0
		
		; Periodically check if we have a CurrentFollower?
		Actor _currentFollower = CurrentFollower.GetActorReference()
		if (_currentFollower != NONE)
			Debug.Trace(Self + " OnUpdateGameTime(): We have a current follower so caching locally: " + _currentFollower)
			AliasFollower.ForceRefTo(_currentFollower)
		endIf	
	endIf
	
	; Reset giftTimer
	if (giftTimer)
		iGiftTimerCount += 1
		if (iGiftTimerCount >= 3)
			giftTimer = False
			iGiftTimerCount = 0
		endIf
	endIf
	
	RegisterForSingleUpdateGameTime(updateTick)
	
endEvent

;--------------------------------------------------------------------
; Faction Functions
;--------------------------------------------------------------------

Function AddToSeductionFaction(Actor who)
	Debug.Trace(Self + " Adding actor: " + who + " to SeductionFaction.")
	who.AddToFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
	who.SetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction, 1)
endFunction

Function RemoveFromSeductionFaction(Actor who)
	if (who.IsInFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction))
		who.RemoveFromFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
	endIf
endFunction

bool Function IncreaseSeductionRank(Actor who, int iIncrease = 1, bool bAllowForceGreet = True)
	if (who.IsInFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction))
		int i = who.GetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
		if (i != 0 && i < 20)
			i += iIncrease
			
			if (bAllowForceGreet)
				if (i >= 10)
					; Force greet with a kiss.
					if (30 <= Utility.RandomInt(0, 100))
						AliasForceGreet.ForceRefTo(who)
						Self.SetStage(10)
						AliasForceGreet.TryToEvaluatePackage()
					endIf
				endIf
			endIf
			
			if (i > 20)
				i = 20
			endIf
			who.SetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction, i)
			Debug.Trace(Self + " IncreaseSeductionRank(): Increased Rank for actor: " + who + " new rank: " + i)
			if (i == 20)
				if (who != AliasSpeaker.GetActorReference())
					AliasSpeaker.ForceRefTo(who)
				endIf
				LoverMessage.Show()
				return False
			endIf
			return True
		endIf
	endIf
	return False
endFunction

Function DecreaseSeductionRank(Actor who)
	int i = who.GetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
	if (i > 1)
		who.SetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction, (i - 1))
	endIf
endFunction

Function SetInitialSeductionRank(Actor who, int rank)
	if !(who.IsInFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction))
		who.AddToFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
	endIf
	
	if (who.GetRelationshipRank(PlayerRef) < 1)
		who.SetRelationshipRank(PlayerRef, 1)
	endIf
	
	who.SetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction, rank)
	Debug.Trace(Self + " SetInitialSeductionRank(): Set Initial Rank for actor: " + who + " new rank: " + rank)
	if (rank == 20)
		if (who != AliasSpeaker.GetActorReference())
			AliasSpeaker.ForceRefTo(who)
		endIf
		LoverMessage.Show()
	endIf
endFunction

;--------------------------------------------------------------------
; DisableSeductionForActor(): Places the specified actor into
;	the Seduction faction with a rank of 0. Will be disabled
;	for seduction purposes.
;--------------------------------------------------------------------
Function DisableSeductionForActor(Actor who)
	if (who.IsInFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction))
		who.SetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction, 0)
	else
		who.AddToFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
	endIf
endFunction

;--------------------------------------------------------------------
; GetSeductionRank(): Helper function.
;--------------------------------------------------------------------
int Function GetSeductionRank(Actor who)
	return who.GetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction)
endFunction

;--------------------------------------------------------------------
; Seduction Influence Functions
;--------------------------------------------------------------------
Function GiveGift(Actor who, bool bAllowForceGreet = True)
	if (giftTimer)
		GiftTimerMessage.Show()
		Debug.Trace(Self + " GiveGift(): No increase because giftTimer.")
		return
	endIf
	int iPoints = who.ShowGiftMenu(True, DefaultGiftFilter, False, True)
	int iRank = 1
	if (iPoints >= 200 && iPoints <= 300)
		iRank = 2
	elseif (iPoints > 300 && iPoints <= 400)
		iRank = 3
	elseif (iPoints > 400)
		iRank = 4
	endif	
	Debug.Trace(Self + " GiveGift(): iPoints from gifting: " + iPoints + " rank increase: " + iRank)

	if (iPoints > 30)
		if (IncreaseSeductionRank(who, iRank, bAllowForceGreet))
			GiftMessage.Show()
		endIf
		giftTimer = True
	else
		Debug.Trace(Self + " GiveGift(): No increase because value too low: " + iPoints)
	endIf
endFunction

Function QuestComplete(Actor who, int iIncrease, bool bAllowForceGreet = True)
	if (who.GetRelationshipRank(PlayerRef) == 0)
		who.SetRelationshipRank(PlayerRef, 1)
	else
	
		int playerSex = PlayerRef.GetActorBase().GetSex()
		int actorSex = who.GetActorBase().GetSex()
		bool bProceed = true
		if (playerSex == actorSex)
			int sexualPreference = FlowerGirls.FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.GetValueInt()
			if (sexualPreference == 0 || sexualPreference == 2)
				bProceed = True
			else
				bProceed = False
			endIf
		endIf
		
		if (bProceed)
			if (who.IsInFaction(FlowerGirls.FlowerGirlsConfig.SeductionFaction))
				if (who.GetFactionRank(FlowerGirls.FlowerGirlsConfig.SeductionFaction) > 0)
					if (who != AliasSpeaker.GetActorReference())
						AliasSpeaker.ForceRefTo(who)
					endIf
					if (IncreaseSeductionRank(who, iIncrease, bAllowForceGreet))
						QuestMessage.Show()
					endIf
				endIf
			endIf
		endIf
	endIf	
endFunction

Function SpendTime(Actor who, bool bAllowForceGreet = True)
	if (IncreaseSeductionRank(who, 2, bAllowForceGreet))
		TimeMessage.Show()
	endIf
endFunction

Function WitnessDragonKill(Actor who, bool bAllowForceGreet = True)
	if (IncreaseSeductionRank(who, 1, bAllowForceGreet))
		DragonMessage.Show()
	endIf
endFunction
