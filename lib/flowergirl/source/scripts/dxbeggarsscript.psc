Scriptname dxBeggarsScript extends Quest  

dxFlowerGirlsScript Property FlowerGirls  Auto  
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
MiscObject Property Gold  Auto  
Actor Property PlayerRef  Auto  
SPELL Property FavorJobsBeggarsAbility  Auto  
Message Property FavorJobsBeggarMessage  Auto  

Function DoBeggarService(Actor beggar)
{The beggar performs oral sex on the player and is charged accordingly.}

	if (beggar == None)
		Debug.Trace(Self + " Beggar was NONE. Aborting.")
		return
	endIf

	PlayerRef.RemoveItem(Gold, 25)
	beggar.AddItem(Gold, 25)

	FavorJobsBeggarsAbility.Cast(PlayerRef, PlayerRef)
	FavorJobsBeggarMessage.Show()

	if (beggar.GetRelationshipRank(PlayerRef) == 0)
	  beggar.SetRelationshipRank(PlayerRef, 1)
	endIf
	
	FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.SetValueInt(1)
	FlowerGirls.OralScene(PlayerRef, beggar)

endFunction