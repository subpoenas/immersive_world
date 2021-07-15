Scriptname BaboOnHitStripScript extends ReferenceAlias  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
Attacker = akAggressor as actor
If Attacker.haskeyword(BaboStripper)
	If !abHitBlocked
		BSAS.StealingArmorRandom(Player, Attacker, True)
	EndIf
EndIf

EndEvent

Actor Attacker
Keyword Property BaboStripper Auto
BaboStealingArmorScript Property BSAS Auto
Actor Property Player Auto