Scriptname dxFlowerGirlsScript extends dxFlowerGirlsBase Conditional 
{Main script for the mod. This is essentially the API.}

FormList Property RandomTokensMFActor1 Auto
FormList Property RandomTokensMFActor2 Auto
FormList Property RandomTokensFMActor1 Auto
FormList Property RandomTokensFMActor2 Auto
FormList Property RandomTokensFFActor1 Auto
FormList Property RandomTokensFFActor2 Auto
FormList Property RandomTokensMMActor1 Auto
FormList Property RandomTokensMMActor2 Auto
FormList Property RandomTokensFFActor1MaleRole  Auto  
FormList Property RandomTokensFFActor2MaleRole  Auto  
FormList Property RandomTokensFFActor1MaleNoLes  Auto  
FormList Property RandomTokensFFActor2MaleNoLes  Auto  
FormList Property RandomTokensBedMFActor1  Auto  
FormList Property RandomTokensBedMFActor2  Auto  
FormList Property RandomTokensBedFMActor1  Auto  
FormList Property RandomTokensBedFMActor2  Auto
FormList Property RandomAnalActor1  Auto  
FormList Property RandomAnalActor2  Auto  

dxAliasActor Property FirstActorRef Auto
{Reference to the first actor to be animated.}
dxAliasActor Property SecondActorRef Auto
{Reference to the second actor participant.}
dxAliasActor Property ThirdActorRef Auto
{Reference to the third actor participant in threesome.}

dxAliasActorBase[] Property NakedActorRefs  Auto  
{Reference to the actor for strip/redress Function.}

ReferenceAlias Property FollowMeActorRef Auto
ReferenceAlias Property FollowMeActorRef2  Auto  

Message Property MsgFollowingYou  Auto  
Message Property MsgStoppedFollowing  Auto
Message Property MsgThreesome Auto  

;---------------------------------------------------------------------------------
; ValidateThread(): Over-ride the base to add the local aliases if
;	required.
;---------------------------------------------------------------------------------
;	@firstActor: First Actor in the scene.
; 	@secondActor: Second Actor in the scene.
;---------------------------------------------------------------------------------
dxSceneThread Function ValidateThread(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (thread)
		if (firstActor != NONE && secondActor != NONE)
			thread.Participant01.ForceRefTo(firstActor)
			thread.Participant02.ForceRefTo(secondActor)	
		else
			thread.Participant01.ForceRefTo(FirstActorRef.GetActorReference())
			thread.Participant02.ForceRefTo(SecondActorRef.GetActorReference())
		endIf
		; Clean up the local aliases.
		FirstActorRef.Clear()
		SecondActorRef.Clear()
	else
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
	endIf
	return thread
endFunction

;---------------------------------------------------------------------------------
; RandomScene(): Simply adds randomized love token based on the
; 	given actors sex and animates them.
;---------------------------------------------------------------------------------
;	@actor1: Actor to assume the male role in animation
; 	@actor2: Actor to assume the female role.
;	@silent: Will suppress notification if a thread is unavailable when TRUE.
;---------------------------------------------------------------------------------
Function RandomScene(Actor actor1, Actor actor2)

	if (actor1 == NONE || actor2 == NONE)
		Debug.Trace(Self + " RandomScene(): Unable to initiate because one or more of the actors are NONE. Actor1: " + actor1 + " Actor2: " + actor2)
		return
	endIf

	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (thread)		
		thread.Participant01.ForceRefTo(actor1)
		thread.Participant02.ForceRefTo(actor2)
	else
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
		return
	endIf
	
	bool isBedScene = Self.HasAvailableBed()
		
	Form tokenFemale
	Form tokenMale
		
	if (thread.Participant01.Gender == 0) ; Actor1 is Male
		if (isBedScene)
			int rnd = Utility.RandomInt(0, (RandomTokensBedMFActor1.GetSize() - 1))
			tokenFemale = RandomTokensBedMFActor2.GetAt(rnd)
			tokenMale = RandomTokensBedMFActor1.GetAt(rnd)
		else
			if (thread.Participant02.Gender == 0) ; Actor2 is Male
				int rnd = Utility.RandomInt(0, (RandomTokensMMActor1.GetSize() - 1))
				tokenFemale = RandomTokensMMActor2.GetAt(rnd) 
				tokenMale = RandomTokensMMActor1.GetAt(rnd)
			else ; Actor1 is Male and Actor2 is Female
				int rnd = Utility.RandomInt(0, (RandomTokensMFActor1.GetSize() - 1))
				tokenFemale = RandomTokensMFActor2.GetAt(rnd) 
				tokenMale = RandomTokensMFActor1.GetAt(rnd)
			endIf
		endIf
	else ; Actor1 is Female
		thread.Participant01.HideStrapOn = True
		if (thread.Participant02.Gender == 0) ; Actor2 is Male
			if (isBedScene)
				int rnd = Utility.RandomInt(0, (RandomTokensBedFMActor1.GetSize() - 1))
				tokenFemale = RandomTokensBedFMActor2.GetAt(rnd)
				tokenMale = RandomTokensBedFMActor1.GetAt(rnd)
			else
				int rnd = Utility.RandomInt(0, (RandomTokensFMActor1.GetSize() - 1))
				tokenFemale = RandomTokensFMActor2.GetAt(rnd) 
				tokenMale = RandomTokensFMActor1.GetAt(rnd)
			endIf
		else ; Actor1 is Female and Actor2 is Female
			if (isBedScene)
				; Over-ride the usual male role settings
				int rnd = Utility.RandomInt(0, (RandomTokensBedMFActor1.GetSize() - 1))
				tokenFemale = RandomTokensBedMFActor2.GetAt(rnd)
				tokenMale = RandomTokensBedMFActor1.GetAt(rnd)	
				thread.Participant01.HideStrapOn = False
			else
				if (FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt() > 0)
					FormList actor1MaleRole = RandomTokensFFActor1MaleNoLes
					FormList actor2MaleRole = RandomTokensFFActor2MaleNoLes
					if (FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS)
						actor1MaleRole = RandomTokensFFActor1MaleRole
						actor2MaleRole = RandomTokensFFActor2MaleRole
					endIf
					int rnd = Utility.RandomInt(0, (actor1MaleRole.GetSize() - 1))
					tokenFemale = actor2MaleRole.GetAt(rnd) 
					tokenMale = actor1MaleRole.GetAt(rnd)
					
					if (tokenMale == SexPositions.TokenCowgirlMale || tokenMale == SexPositions.TokenDoggyMale \
						|| tokenMale == SexPositions.TokenMissionaryMale || tokenMale == SexPositions.TokenStandingMale)
						thread.Participant01.HideStrapOn = False
					endIf
				else
					int rnd = Utility.RandomInt(0, (RandomTokensFFActor1.GetSize() - 1))
					tokenFemale = RandomTokensFFActor2.GetAt(rnd) 
					tokenMale = RandomTokensFFActor1.GetAt(rnd)
				endIf	
			endIf
		endIf
	endIf
	
	if (!tokenFemale || !tokenMale)
		Debug.Trace(Self + " RandomScene(): Error: one or more of the tokens are NONE. tokenFemale: " + tokenFemale + " tokenMale: " + tokenMale)
		return
	endIf
	
	thread.Participant01.SexType = tokenMale as Ammo
	thread.Participant02.SexType = tokenFemale as Ammo
	
	thread.SceneType = 11
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
	; Clean up the local aliases.
	FirstActorRef.Clear()
	SecondActorRef.Clear()
	
endFunction

;---------------------------------------------------------------------------------
; FlowerGirlsKiss(): Initiates a kissing animation sequence with
;	passed actors.
;---------------------------------------------------------------------------------
;	@actorToKiss: Actor to assume the receiving kiss role.
; 	@actorGiveKiss: Actor to assume the giving role, defaults to player.
;---------------------------------------------------------------------------------
Function FlowerGirlsKiss(Actor actorToKiss, Actor actorGiveKiss = NONE)		
	if (actorGiveKiss == NONE)
		actorGiveKiss = PlayerREF
		Debug.Trace(Self + " actorToKiss is: " + actorToKiss + " actorGiveKiss is: " + actorGiveKiss)
	endIf

	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (thread)		
		thread.Participant01.ForceRefTo(actorGiveKiss)
		thread.Participant02.ForceRefTo(actorToKiss)		
	else
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
		return
	endIf
			
	if (thread.Participant01.Gender == 0) ; Actor is male
		thread.Participant01.SexType = SexPositions.TokenKissingMaleMale
		thread.Participant02.SexType = SexPositions.TokenKissingMaleFemale
	else
		thread.Participant01.SexType = SexPositions.TokenKissingFemale
		thread.Participant02.SexType = SexPositions.TokenKissingMale
	endIf			
	
	thread.Participant01.NoStrip = True
	thread.Participant01.HideStrapOn = True
	thread.Participant02.NoStrip = True
	thread.Participant02.HideStrapOn = True
	
	thread.SceneType = 1
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
		
endFunction

Function CowgirlScene(Actor firstActor = NONE, Actor secondActor = NONE)		
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	
	if (thread.Participant01.Gender == 0) ; First actor is male
		if (thread.Participant02.Gender == 0) ; Second actor is male
			thread.Participant01.SexType = SexPositions.TokenAnalCowMale
			thread.Participant02.SexType = SexPositions.TokenAnalCowFemale
		else
			thread.Participant01.SexType = SexPositions.TokenCowgirlMale
			thread.Participant02.SexType = SexPositions.TokenCowgirlFemale
		endIf
	else
		if (thread.Participant02.Gender == 0) ; Second actor is male
			thread.Participant01.HideStrapOn = True
			thread.Participant01.SexType = SexPositions.TokenMissionaryFemale
			thread.Participant02.SexType = SexPositions.TokenMissionaryMale
		else
			; Check option for F-F relationships to allow F to perform male role.
			if (FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt())
				if (FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt())
					if (Utility.RandomInt(0, 1000) < 500)
						thread.Participant01.SexType = SexPositions.TokenLesbianFemale
						thread.Participant02.SexType = SexPositions.TokenLesbianMale
						thread.Participant01.HideStrapOn = True
					else
						thread.Participant01.SexType = SexPositions.TokenCowgirlMale
						thread.Participant02.SexType = SexPositions.TokenCowgirlFemale
					endIf
				else
					thread.Participant01.SexType = SexPositions.TokenCowgirlMale
					thread.Participant02.SexType = SexPositions.TokenCowgirlFemale
				endIf
			else
				thread.Participant01.SexType = SexPositions.TokenLesbianFemale
				thread.Participant02.SexType = SexPositions.TokenLesbianMale
				thread.Participant01.HideStrapOn = True
			endIf
		endIf
	endIf
	thread.SceneType = 4
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function OralScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	
	if (thread.Participant01.Gender == 0) ; First actor is male
		thread.Participant01.SexType = SexPositions.TokenOralMale
		thread.Participant02.SexType = SexPositions.TokenOralFemale
	else
		thread.Participant01.HideStrapOn = True

		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenCunnilingusFemale
			thread.Participant02.SexType = SexPositions.TokenCunnilingusMale
		else
			thread.Participant01.SexType = SexPositions.TokenLesbianCunnilingusFemale
			thread.Participant02.SexType = SexPositions.TokenLesbianCunnilingusMale
		endIf
	endIf

	thread.SceneType = 2
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function CunnilingusScene(Actor firstActor = NONE, Actor secondActor = NONE, bool silent = False)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	if (thread.Participant01.Gender == 0) ; First Actor is male
		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenOralFemale
			thread.Participant02.SexType = SexPositions.TokenOralMale
		else
			thread.Participant01.SexType = SexPositions.TokenCunnilingusMale
			thread.Participant02.SexType = SexPositions.TokenCunnilingusFemale
		endIf
	else
		thread.Participant01.HideStrapOn = True

		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenOralFemale
			thread.Participant02.SexType = SexPositions.TokenOralMale
		else
			thread.Participant01.SexType = SexPositions.TokenLesbianCunnilingusMale
			thread.Participant02.SexType = SexPositions.TokenLesbianCunnilingusFemale
		endIf
	endIf
	thread.SceneType = 3
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function TittyFuckScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	if (thread.Participant01.Gender == 0) ; First actor is male
		thread.Participant01.SexType = SexPositions.TokenTittyMale
		thread.Participant02.SexType = SexPositions.TokenTittyFemale
	else
		thread.Participant01.HideStrapOn = True
		thread.Participant01.SexType = SexPositions.TokenTittyFemale
		thread.Participant02.SexType = SexPositions.TokenTittyMale
	endIf
	thread.SceneType = 12
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function DoggyScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	if (thread.Participant01.Gender == 0) ; First Actor is male
		thread.Participant01.SexType = SexPositions.TokenDoggyMale
		thread.Participant02.SexType = SexPositions.TokenDoggyFemale
	else
		thread.Participant01.HideStrapOn = True

		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenDoggyFemale
			thread.Participant02.SexType = SexPositions.TokenDoggyMale
		else
			; Check option for F-F relationships to allow F to perform male role.
			if (FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt())
				if (FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt())
					if (Utility.RandomInt(0, 1000) < 500)
						thread.Participant01.SexType = SexPositions.TokenDildoFemale
						thread.Participant02.SexType = SexPositions.TokenDildoMale
					else
						thread.Participant01.SexType = SexPositions.TokenDoggyMale
						thread.Participant02.SexType = SexPositions.TokenDoggyFemale
						thread.Participant01.HideStrapOn = False
					endIf
				else
					thread.Participant01.SexType = SexPositions.TokenDoggyMale
					thread.Participant02.SexType = SexPositions.TokenDoggyFemale
					thread.Participant01.HideStrapOn = False
				endIf
			else
				thread.Participant01.SexType = SexPositions.TokenDildoFemale
				thread.Participant02.SexType = SexPositions.TokenDildoMale
			endIf        
		endIf
	endIf
	thread.SceneType = 5
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function AnalScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf

	; Pick random anal animation sequence
	int i = Utility.RandomInt(0, (RandomAnalActor1.GetSize() - 1))

	if (thread.Participant01.Gender == 0) ; First Actor is male  
		thread.Participant01.SexType = RandomAnalActor1.GetAt(i) as Ammo
		thread.Participant02.SexType = RandomAnalActor2.GetAt(i) as Ammo
	else
		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = RandomAnalActor2.GetAt(i) as Ammo
			thread.Participant02.SexType = RandomAnalActor1.GetAt(i) as Ammo
			thread.Participant01.HideStrapOn = True
		else
			thread.Participant01.SexType = RandomAnalActor1.GetAt(i) as Ammo
			thread.Participant02.SexType = RandomAnalActor2.GetAt(i) as Ammo
		endIf
	endIf
	thread.SceneType = 6
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function MissionaryScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	if (thread.Participant01.Gender == 0) ; First actor is male
		if (thread.Participant02.Gender == 0) ; Second actor is male
			thread.Participant01.SexType = SexPositions.TokenAnalMissionaryMale
			thread.Participant02.SexType = SexPositions.TokenAnalMissionaryFemale
		else
			thread.Participant01.SexType = SexPositions.TokenMissionaryMale
			thread.Participant02.SexType = SexPositions.TokenMissionaryFemale
		endIf
	else
		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.HideStrapOn = True
			thread.Participant01.SexType = SexPositions.TokenCowgirlFemale
			thread.Participant02.SexType = SexPositions.TokenCowgirlMale        
		else
			; Check option for F-F relationships to allow F to perform male role.
			if (FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt())
				if (FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt())
					if (Utility.RandomInt(0, 1000) < 500)
						thread.Participant01.SexType = SexPositions.TokenLesbianMale
						thread.Participant02.SexType = SexPositions.TokenLesbianFemale
						thread.Participant01.HideStrapOn = True
					else
						thread.Participant01.SexType = SexPositions.TokenMissionaryMale
						thread.Participant02.SexType = SexPositions.TokenMissionaryFemale
					endIf
				else
					thread.Participant01.SexType = SexPositions.TokenMissionaryMale
					thread.Participant02.SexType = SexPositions.TokenMissionaryFemale
				endIf
			else
				thread.Participant01.SexType = SexPositions.TokenLesbianMale
				thread.Participant02.SexType = SexPositions.TokenLesbianFemale
				thread.Participant01.HideStrapOn = True
			endIf        
		endIf
	endIf
	thread.SceneType = 7
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

Function MasturbationScene(Actor firstActor = NONE)
	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (!thread)
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
		return
	endIf
	
	if (firstActor != NONE)
		thread.Participant01.ForceRefTo(firstActor)
	else
		if (FirstActorRef.GetActorReference() == NONE)
			Debug.Trace(Self + " AliasFirstActor has not been set. Exiting.")
			return
		else
			thread.Participant01.ForceRefTo(FirstActorRef.GetActorReference())
		endIf
	endIf
			
	
	if (thread.Participant01.Gender == 0) ; First Actor is male
	   thread.Participant01.SexType = SexPositions.TokenSoloMale
	else
		thread.Participant01.HideStrapOn = True
		thread.Participant01.SexType = SexPositions.TokenSoloFemale
	endIf
	thread.SceneType = 8
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
	FirstActorRef.Clear()
	
endFunction

Function StandingScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxSceneThread thread = ValidateThread(firstActor, secondActor)
	if (thread == NONE)
		return
	endIf
	if (thread.Participant01.Gender == 0) ; First Actor is male
		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenAnalStandingMale
			thread.Participant02.SexType = SexPositions.TokenAnalStandingFemale
		else
			thread.Participant01.SexType = SexPositions.TokenStandingMale
			thread.Participant02.SexType = SexPositions.TokenStandingFemale
		endIf
	else
		thread.Participant01.HideStrapOn = True

		if (thread.Participant02.Gender == 0) ; Second Actor is male
			thread.Participant01.SexType = SexPositions.TokenStandingFemale
			thread.Participant02.SexType = SexPositions.TokenStandingMale
		else
			; Check option for F-F relationships to allow F to perform male role.
			if (FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.GetValueInt())
				if (FlowerGirlsConfig.DX_ALLOW_LESBIAN_ANIMS.GetValueInt())
					if (Utility.RandomInt(0, 1000) < 500)
						thread.Participant01.SexType = SexPositions.TokenDildoMale
						thread.Participant02.SexType = SexPositions.TokenDildoFemale
					else
						thread.Participant01.SexType = SexPositions.TokenStandingMale
						thread.Participant02.SexType = SexPositions.TokenStandingFemale
						thread.Participant01.HideStrapOn = False
					endIf
				else
					thread.Participant01.SexType = SexPositions.TokenStandingMale
					thread.Participant02.SexType = SexPositions.TokenStandingFemale
					thread.Participant01.HideStrapOn = False
				endIf
			else
				thread.Participant01.SexType = SexPositions.TokenDildoMale
				thread.Participant02.SexType = SexPositions.TokenDildoFemale
			endIf
		endIf
	endIf
	thread.SceneType = 9
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(thread.SceneType)	
	thread.StartScene()
	
endFunction

;---------------------------------------------------------------------------------
; FollowMe(): Adds the followActor into the alias for the follow package
;---------------------------------------------------------------------------------
Function FollowMe(Actor followActor)

	; If player is not in the follow faction then add to faction.	
	if !(PlayerREF.IsInFaction(FlowerGirlsMod.FollowMeFaction))
		PlayerREF.AddToFaction(FlowerGirlsMod.FollowMeFaction)
	endIf

	int rank = PlayerREF.GetFactionRank(FlowerGirlsMod.FollowMeFaction)
	if (rank == 0)
		; Add the actor into follow faction.
		if !(followActor.IsInFaction(FlowerGirlsMod.FollowMeFaction))
			followActor.AddToFaction(FlowerGirlsMod.FollowMeFaction)
		endIf
		; Add the actor into the alias for the AI package.
		FollowMeActorRef.ForceRefTo(followActor)
		PlayerREF.SetFactionRank(FlowerGirlsMod.FollowMeFaction, 1)
		; Display a message to user
		MsgFollowingYou.Show()
		FollowMeActorRef.GetActorRef().EvaluatePackage()
	elseIf (rank == 1)
		if !(followActor.IsInFaction(FlowerGirlsMod.FollowMeFaction))
			followActor.AddToFaction(FlowerGirlsMod.FollowMeFaction)
		endIf
		FollowMeActorRef2.ForceRefTo(followActor)
		PlayerRef.SetFactionRank(FlowerGirlsMod.FollowMeFaction, 2)
		FollowMeActorRef2.GetActorRef().EvaluatePackage()
	else
		Debug.Trace(Self + " Unable to add another temporary follower, Faction Rank is: " + rank)
		Debug.Notification("You already have a partner following you. Talk to them again.")
	endIf
	
endFunction

;--------------------------------------------------------------------------------------
; StopFollowMe(): Removes the specified actor from the followmeFaction.
;--------------------------------------------------------------------------------------
Function StopFollowMe(Actor followActor)

	int rank = PlayerREF.GetFactionRank(FlowerGirlsMod.FollowMeFaction)
	followActor.RemoveFromFaction(FlowerGirlsMod.FollowMeFaction)
		
	if (FollowMeActorRef.GetRef() == followActor)		
		FollowMeActorRef.Clear()
	elseIf (FollowMeActorRef2.GetRef() == followActor)
		FollowMeActorRef2.Clear()
	endIf
	
	PlayerREF.SetFactionRank(FlowerGirlsMod.FollowMeFaction, (rank - 1))
	
	; Display message to user
	MsgStoppedFollowing.Show()
	
	followActor.EvaluatePackage()

endFunction

;---------------------------------------------------------------------------------
; AddThreesomeParticipant(): Adds the specified actor as a participant
; 	for a threesome scene.
;---------------------------------------------------------------------------------
Function AddThreesomeParticipant(Actor participant)

	; If player is not in the follow faction then add to faction.	
	if !(PlayerREF.IsInFaction(FlowerGirlsMod.ThreewayFaction))
		PlayerREF.AddToFaction(FlowerGirlsMod.ThreewayFaction)
	endIf
	
	int rank = PlayerREF.GetFactionRank(FlowerGirlsMod.ThreewayFaction)
	if (rank == 0)
		; The participant actor will now follow you till you find another partner.
		FollowMeActorRef.ForceRefTo(participant)
		SecondActorRef.ForceRefTo(participant)
		PlayerREF.SetFactionRank(FlowerGirlsMod.ThreewayFaction, 1)
		
		; Add the participant into the threesome faction
		SecondActorRef.GetActorRef().AddToFaction(FlowerGirlsMod.ThreewayFaction)
		
		; Display message to user
		MsgThreesome.Show()
		FollowMeActorRef.GetActorRef().EvaluatePackage()
	elseIf (rank == 1)
		; We already have 1 participant so add the final participant.
		ThirdActorRef.ForceRefTo(participant)
		PlayerREF.SetFactionRank(FlowerGirlsMod.ThreewayFaction, 0)
	endIf

endFunction

Function RemoveThreesomeParticipant(Actor participant)
	
	; Remove the actor from the faction
	if (participant.IsInFaction(FlowerGirlsMod.ThreewayFaction))
		participant.RemoveFromFaction(FlowerGirlsMod.ThreewayFaction)
		FollowMeActorRef.Clear()
		SecondActorRef.Clear()
		
		PlayerREF.SetFactionRank(FlowerGirlsMod.ThreewayFaction, 0)
	else
		Debug.Trace(Self + " RemoveThreesomeParticipant(): Error, the participant actor is not in the Threeway faction")
	endIf

endFunction

;-------------------------------------------------------------------------------------------
; PlayThreesome(): Plays a threesome either using the past in actor arguments 
; 	preferred, or the SecondActorRef and ThirdActorRef aliases.
;-------------------------------------------------------------------------------------------
; 	@participant1: Actor for the main role.
; 	@participant2: Actor for the secondary role.
; 	@participant3: Actor for the tertiary role.
; 	@silent: Will suppress notification if thread is not available if TRUE.
;-------------------------------------------------------------------------------------------
Function PlayThreesome(Actor participant1 = NONE, Actor participant2 = NONE, Actor participant3 = NONE)
	dxSceneThread thread = ThreadManager.GetNextAvailableThread()	
	if (!thread)	
		Debug.Notification("No FlowerGirls threads are available to use at the moment.")
		return
	endIf
	
	if (participant1 == NONE || participant2 == NONE || participant3 == NONE)	
		; Requires all threesome participant aliases to have been set.	
		if (SecondActorRef == NONE || ThirdActorRef == NONE)
			Debug.Trace(Self + " PlayThreesome(): Unable to proceed as one of the actor aliases is NONE. Actor1: " + PlayerREF + " Actor2: " + SecondActorRef + " Actor3: " + ThirdActorRef)
			return
		else
			thread.Participant01.ForceRefTo(PlayerRef)
			thread.Participant02.ForceRefTo(SecondActorRef.GetActorReference())
			thread.Participant03.ForceRefTo(ThirdActorRef.GetActorReference())
		endIf
	else
		thread.Participant01.ForceRefTo(participant1)
		thread.Participant02.ForceRefTo(participant2)
		thread.Participant03.ForceRefTo(participant3)
	endIf	

	if (thread.Participant01.Gender == 0)
		; Player is Male and both participants are female:
		if (thread.Participant02.Gender == 1 && thread.Participant03.Gender == 1)
			thread.Participant03.SexType = SexPositions.TokenFFMActor1
			thread.Participant01.SexType = SexPositions.TokenFFMActor2
			thread.Participant02.SexType = SexPositions.TokenFFMActor3
		else
			if (thread.Participant02.Gender == 1)
				thread.Participant02.SexType = SexPositions.TokenMMFActor1 	; SecondActorRef is female
				thread.Participant01.SexType = SexPositions.TokenMMFActor2		; Player is male
				thread.Participant03.SexType = SexPositions.TokenMMFActor3		; ThirdActorRef is male
			elseIf (thread.Participant03.Gender == 1)
				thread.Participant02.SexType = SexPositions.TokenMMFActor3 	; SecondActorRef is male
				thread.Participant01.SexType = SexPositions.TokenMMFActor2		; Player is male
				thread.Participant03.SexType = SexPositions.TokenMMFActor1		; ThirdActorRef is female
			else
				; All participants are male. Make player assume the female role.
				thread.Participant02.SexType = SexPositions.TokenMMFActor3 	; SecondActorRef is male
				thread.Participant01.SexType = SexPositions.TokenMMFActor1		; Player is male assuming female role.
				thread.Participant03.SexType = SexPositions.TokenMMFActor2		; ThirdActorRef is male
			endIf		
		endIf
	else 
		; Player is female and both participants are female:
		if (thread.Participant02.Gender == 1 && thread.Participant03.Gender == 1)
			if (Utility.RandomInt(0, 100) <= 50)
				thread.Participant01.SexType = SexPositions.TokenFFFActor1
				thread.Participant02.SexType = SexPositions.TokenFFFActor2
				thread.Participant03.SexType = SexPositions.TokenFFFActor3				
				thread.Participant01.HideStrapOn = True
			else
				thread.Participant03.SexType = SexPositions.TokenFFMActor1
				thread.Participant01.SexType = SexPositions.TokenFFMActor2			; Player assumes the male role.
				thread.Participant02.SexType = SexPositions.TokenFFMActor3
				thread.Participant01.HideStrapOn = False
			endIf
		else
			if (thread.Participant02.Gender == 1)
				thread.Participant03.SexType = SexPositions.TokenFFMActor2		; ThirdActorRef is in the male role
				thread.Participant01.SexType = SexPositions.TokenFFMActor1		; Player is female.
				thread.Participant02.SexType = SexPositions.TokenFFMActor3	; SecondActorRef is female.			
			elseIf (thread.Participant03.Gender == 1)
				thread.Participant03.SexType = SexPositions.TokenFFMActor3		; ThirdActorRef is female.
				thread.Participant01.SexType = SexPositions.TokenFFMActor1		; Player is female.
				thread.Participant02.SexType = SexPositions.TokenFFMActor2	; SecondActorRef is male.
			else
				thread.Participant02.SexType = SexPositions.TokenMMFActor3 	; SecondActorRef is male
				thread.Participant01.SexType = SexPositions.TokenMMFActor1		; Player is female.
				thread.Participant03.SexType = SexPositions.TokenMMFActor2		; ThirdActorRef is male
			endIf
			
			; Over-ride the user Strap On option.. flag to turn off.
			thread.Participant01.HideStrapOn = True
		endIf
	endIf
	
	; Remove the temporary follower
	FollowMeActorRef.Clear()
	
	; Clear the faction stuff
	thread.Participant02.GetActorRef().RemoveFromFaction(FlowerGirlsMod.ThreewayFaction)
	
	FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(10)
	thread.StartScene()	
	
	FirstActorRef.Clear()
	SecondActorRef.Clear()
	ThirdActorRef.Clear()
	
endFunction

Function OSexScene(Actor firstActor = NONE, Actor secondActor = NONE)
	dxOsaSceneThread thread = ThreadManager.GetOsaSceneThread()
	if (thread)
		if (firstActor != NONE && secondActor != NONE)
			thread.Participant01.ForceRefTo(firstActor)
			thread.Participant02.ForceRefTo(secondActor)	
		else
			thread.Participant01.ForceRefTo(FirstActorRef.GetActorReference())
			thread.Participant02.ForceRefTo(SecondActorRef.GetActorReference())
		endIf
		; Clean up the local aliases.
		FirstActorRef.Clear()
		SecondActorRef.Clear()
		
		FlowerGirlsConfig.DX_LAST_SCENETYPE.SetValueInt(42)
		thread.StartScene()
	else
		Debug.Notification("No FlowerGirls OSA thread is available to use at the moment.")
	endIf	
	
endFunction

Function UndressActor(Actor undressTarget)

	if (undressTarget == NONE)
		Debug.Trace(Self + " UndressActor(): Invalid actor passed to function: " + undressTarget)
		return
	endIf
	
	; Find next available clear referencealias
	int i = 0
	bool bSearch = True
	while ( i < NakedActorRefs.Length && bSearch )
		if (NakedActorRefs[i].GetActorReference() == NONE)
			NakedActorRefs[i].ForceRefTo(undressTarget)
			int debugging = FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt()
			if (debugging)
				Debug.Trace(Self + " UndressActor(): Placed actor: " + undressTarget + " into array at index: " + i)
			endIf
			NakedActorRefs[i].DebugMode = debugging
			NakedActorRefs[i].JustNakedStrip()	
			bSearch = False
		endIf
		i += 1
		if (i == NakedActorRefs.Length && bSearch)
			Debug.Trace(Self + " UndressActor(): Unable to find a clear alias for actor: " + undressTarget)
			Debug.Notification("Managing as many naked NPC's as able. Please redress some")
		endIf
	endWhile	

endFunction

Function RedressActor(Actor redressTarget)
	if (redressTarget == NONE)
		Debug.Trace(Self + " RedressActor(): Invalid actor passed to function: " + redressTarget)
		return
	endIf
	
	; Locate the actor in the referencealias array
	int i = 0
	bool bSearch = True
	while ( i < NakedActorRefs.Length && bSearch )
		if (NakedActorRefs[i].GetActorReference() == redressTarget)
			DebugThis("RedressActor()", ("Located the actor in the naked actor array: " + redressTarget + " at index: " + i))
			NakedActorRefs[i].DebugMode = FlowerGirlsConfig.DX_DEBUG_MODE.GetValueInt()
			NakedActorRefs[i].JustNakedRedress()	
			Utility.Wait(3.0)
			NakedActorRefs[i].Clear()
			bSearch = False
		endIf
		i += 1
		if (i == NakedActorRefs.Length && bSearch)
			Debug.Trace(Self + " RedressActor(): Unable to locate the actor in the naked actor array: " + redressTarget)
		endIf
	endWhile
endFunction

Event OnReset()
	; Flush aliases	
	FirstActorRef.Clear()
	SecondActorRef.Clear()
	ThirdActorRef.Clear()
	FollowMeActorRef.Clear()
endEvent
