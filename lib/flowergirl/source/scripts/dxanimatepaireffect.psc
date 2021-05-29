Scriptname dxAnimatePairEffect extends activemagiceffect  
{Animates two targeted actors. This effect is used to set-up the pairing.}

Quest Property FlowerGirlsNpcScene  Auto  

ReferenceAlias Property NpcActor1  Auto  
ReferenceAlias Property NpcActor2  Auto  

Message Property MsgFornicateActor1  Auto  
Message Property MsgFornicateActor2  Auto  
Message Property MsgFornicateDeny  Auto
Message Property MsgFornicateRemove Auto 

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if (akTarget == None)
		Debug.Trace(Self + " akTarget is NONE. Skipping..")
		return
	endIf
	if (!FlowerGirlsNpcScene.IsRunning())	
		if (NpcActor1.GetActorReference() == NONE)
			NpcActor1.ForceRefTo(akTarget)
			MsgFornicateActor1.Show()
		else
			if (NpcActor1.GetActorReference() == akTarget)
				; Actor already added as a reference. So clear it.
				NpcActor1.Clear()
				MsgFornicateRemove.Show()
			else
				if (NpcActor2.GetActorReference() != NONE)
					NpcActor2.Clear()					
				endIf
				NpcActor2.ForceRefTo(akTarget)
				MsgFornicateActor2.Show()				
				FlowerGirlsNpcScene.Start()
			endIf
		endIf
	else
		MsgFornicateDeny.Show()
	endIf
endEvent
