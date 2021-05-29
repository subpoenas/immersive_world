Scriptname dxSeductionMineOreScript extends FavorJobsMineOreScript

Actor Property PlayerRef Auto
dxFlowerGirlsScript Property FlowerGirls Auto
Message Property MsgMineOreF Auto
Message Property MsgMineOreM Auto

Function SellOre(Actor Foreman, Keyword OreType)

	;Player is selling Corundum
	If (OreType == MinerCorundum)
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreCorundum)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreCorundumValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreCorundum, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)
		
	;Player is selling Ebony
	ElseIf (OreType == MinerEbony)
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreEbony)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreEbonyValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreEbony, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)
	
	;Player is selling Gold
	ElseIf OreType == MinerGold
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreGold)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreGoldValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreGold, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)

	;Player is selling Iron
	ElseIf OreType == MinerIron
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreIron)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreIronValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreIron, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)

	;Player is selling Malachite
	ElseIf OreType == MinerMalachite
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreMalachite)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreMalachiteValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreMalachite, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)	

	;Player is selling Moonstone
	ElseIf OreType == MinerMoonstone
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreMoonstone)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreMoonstoneValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreMoonstone, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)

	;Player is selling Orichalcum
	ElseIf OreType == MinerOrichalcum
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreOrichalcum)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreOrichalcumValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreOrichalcum, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)

	;Player is selling Quicksilver
	ElseIf OreType == MinerQuicksilver
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreQuicksilver)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreQuicksilverValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreQuicksilver, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)

	;Player is selling Silver
	ElseIf OreType == MinerSilver
		;Count the amount of ore the player has
		PlayerOreCount = PlayerRef.GetItemCount(OreSilver)
		
		;Calculate the amount of gold to give the player
		PlayerGoldReward = PlayerOreCount * (JobsOreSilverValue.GetValueInt())
		
		PlayerRef.RemoveItem(OreSilver, PlayerOreCount)
		PlayerRef.AddItem(pGold001, PlayerGoldReward)	
	EndIf
	
	;Make the Foreman the player's friend
	If (Foreman.GetRelationshipRank(PlayerRef) == 0)
		Foreman.SetRelationshipRank(PlayerRef, 1)
	else
		if (FlowerGirls.FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt() > 0)
			int i = PlayerOreCount / 2
			if (i < 1)
				i = 1
			endIf
			if (FlowerGirls.Seduction.IncreaseSeductionRank(Foreman, i, True))
				if (Foreman.GetActorBase().GetSex() == 1)
					MsgMineOreF.Show()
				else
					MsgMineOreM.Show()
				endIf
			endIf
		endIf
	endIf
			
EndFunction
