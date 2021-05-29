Scriptname dxSeductionFarmingScript extends FavorJobsGatherWheatScript

Actor Property PlayerRef Auto
dxFlowerGirlsScript Property FlowerGirls Auto
Message Property MsgCabbage Auto
Message Property MsgNirnroot Auto
Message Property MsgWheat Auto
Message Property MsgPotato Auto
Message Property MsgGourd Auto
Message Property MsgLeakF Auto
Message Property MsgLeakM Auto

bool Function RaiseSeduction(Actor who, int iCropCount)
	if (who.GetRelationshipRank(PlayerRef) == 0)
		who.SetRelationshipRank(PlayerRef, 1)
	else
		if (FlowerGirls.FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt() > 0)
			int rank = iCropCount / 5
			if (rank < 1 )
				rank = 1
			endIf
			return FlowerGirls.Seduction.IncreaseSeductionRank(who, rank, True)
		endIf
	endIf
	return false
endFunction

Function SellWheat(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(Wheat)
		
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (Wheat.GetGoldValue()))
		
	PlayerRef.RemoveItem(Wheat, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)
	
	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		MsgWheat.Show()
	endIf
	
EndFunction

Function SellPotato(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(FoodPotato)
	
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (FoodPotato.GetGoldValue()))
	
	PlayerRef.RemoveItem(FoodPotato, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)
	
	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		MsgPotato.Show()
	endIf
	
EndFunction

Function SellLeek(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(FoodLeek)
	
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (FoodLeek.GetGoldValue()))
	
	PlayerRef.RemoveItem(FoodLeek, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)
	
	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		if (Foreman.GetActorBase().GetSex() == 1)
			MsgLeakF.Show()
		else
			MsgLeakM.Show()
		endIf
	endIf
	
EndFunction

Function SellGourd(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(Gourd)
	
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (Gourd.GetGoldValue()))
	
	PlayerRef.RemoveItem(Gourd, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)

	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		MsgGourd.Show()
	endIf
	
EndFunction

Function SellCabbage(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(FoodCabbage)
	
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (FoodCabbage.GetGoldValue()))
	
	PlayerRef.RemoveItem(FoodCabbage, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)

	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		MsgCabbage.Show()
	endIf
	
EndFunction

Function SellNirnroot(Actor Foreman)

	;Count the amount of wheat the player has
	PlayerCropCount = PlayerRef.GetItemCount(Nirnroot)
	
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerCropCount * (Nirnroot.GetGoldValue()))
	
	PlayerRef.RemoveItem(Nirnroot, PlayerCropCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)
	
	;Make the Foreman the player's friend
	if (RaiseSeduction(Foreman, PlayerCropCount))
		MsgNirnroot.Show()
	endIf
	
EndFunction