Scriptname BaboEvent01OrcRefScript extends ReferenceAlias  


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

if  (akAggressor == Game.GetPlayer()) && MakeAggressiveAndAttackPlayerIfAttacked
	If GetOwningQuest().GetStage() < 40
		Self.GetOwningQuest().SetStage(45)
	Else
		Return
	EndIf
;(GetOwningQuest() as BaboEventWhiterunOrcVisitorsScript).AttackPeople(Self)
EndIf
EndEvent

Event OnDeath(Actor akKiller)
If (OrcRaper01.getref() as Actor).isdead() && (OrcRaper02.getref() as Actor).isdead() && (OrcRaper03.getref() as Actor).isdead()
	Self.GetOwningQuest().SetStage(70)
EndIF
EndEvent

bool Property MakeAggressiveAndAttackPlayerIfAttacked = False Auto
Referencealias Property OrcRaper01 Auto
Referencealias Property OrcRaper02 Auto
Referencealias Property OrcRaper03 Auto