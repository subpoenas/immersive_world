Scriptname dxMarriageScript extends Quest  

ReferenceAlias Property LoveInterest  Auto  
ReferenceAlias Property FlowerGirlsLoveInterest  Auto  
dxSeductionScript Property SeductionScript  Auto 
Message Property FlowerGirlsMarriageCongratulations Auto 

event OnInit()
	RegisterForSingleUpdate(5.0)	
endEvent

Event OnUpdate()
	
	Actor _lover = LoveInterest.GetActorReference()
	if (_lover)
		Debug.Trace(Self + " OnUpdate(): Updating LoveInterest Alias on FlowerGirls Quest")
		FlowerGirlsMarriageCongratulations.Show()
		FlowerGirlsLoveInterest.ForceRefTo(_lover)
		SeductionScript.SetInitialSeductionRank(_lover, 20)
	else
		Debug.Trace(Self + " OnUpdate(): Lover has not been set.")
	endIf
	
	Self.Stop()
endEvent
