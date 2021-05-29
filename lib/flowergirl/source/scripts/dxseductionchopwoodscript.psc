Scriptname dxSeductionChopWoodScript extends FavorJobsChopWoodScript

Actor Property PlayerRef Auto
dxFlowerGirlsScript Property FlowerGirls Auto
Message Property MsgChopWoodF Auto
Message Property MsgChopWoodM Auto

Function SellWood(Actor Foreman)

	;Count the amount of wood the player has
	PlayerFirewoodCount = PlayerRef.GetItemCount(pFirewood)
		
	;Calculate the amount of gold to give the player
	PlayerGoldReward = (PlayerFirewoodCount * (JobsWoodValue.GetValueInt()))
		
	PlayerRef.RemoveItem(pFirewood, PlayerFirewoodCount)
	PlayerRef.AddItem(pGold, PlayerGoldReward)
	
	;Make the Foreman the player's friend
	If (Foreman.GetRelationshipRank(PlayerRef) == 0)
		Foreman.SetRelationshipRank(PlayerRef, 1)
	else	
		if (FlowerGirls.FlowerGirlsConfig.DX_IMMERSION_OPTIONS.GetValueInt() > 0)
			int i = PlayerFirewoodCount / 2
			if (i < 1)
				i = 1
			endIf
			if (FlowerGirls.Seduction.IncreaseSeductionRank(Foreman, i, True))
				if (Foreman.GetActorBase().GetSex() == 1)
					MsgChopWoodF.Show()
				else
					MsgChopWoodM.Show()
				endIf
			endIf
		endIf
	endIf
	
EndFunction