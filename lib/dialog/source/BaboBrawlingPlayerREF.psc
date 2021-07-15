Scriptname BaboBrawlingPlayerREF extends ReferenceAlias  

Idle property Knockout auto
Idle property Knockout02 auto
Int Property StartStage auto
Int Property NextStage01 auto
Int Property LastStage auto
bool Property RotatedAnimationFixEnabled = false Auto Hidden
Function ResetThirdPersonCamera() Native Global

Scene Property NextScene01 Auto
Scene Property NextScene02 Auto

Bool Property NexStage01Switch Auto
Bool Property NextScene01Switch Auto

Bool Property BleedOutMechanism = False Auto
Bool Property HitMechanism = False Auto

Bool Property FoeSwitch = false Auto
Bool Property BacktoNormal = false Auto

Bool Property Yeskeyword = false Auto
{This toggle needs to be set if you want to designate a certain enemy type with keywords.}

Referencealias property Foe01 Auto
Referencealias property PlayerRefrence Auto

GlobalVariable Property BaboCombatWoundPercentMaximum Auto
GlobalVariable Property BaboCombatWoundPercentMinimum Auto

GlobalVariable Property BaboCombatEssentialSwitch Auto

Quest Property BaboSetEssentialScript Auto
Referencealias Property PlayerEssential Auto

;Bool Property DefeatSwitch Auto
;GlobalVariable Property Defeat Auto
;DefeatConfig Property Ressconfig Auto
Keyword Property BaboStripper  Auto  

Idle Property staggerStart  Auto  

Float MaximumCriterion
Float MinimumCriterion
Float CurrentHealth
Float BaseHealth
Float playersHealth

Actor LastAggressor

Event oninit()

MaximumCriterion = BaboCombatWoundPercentMaximum.getvalue()
MinimumCriterion = BaboCombatWoundPercentMinimum.getvalue()

	If BaboCombatEssentialSwitch.getvalue() == 1
		PlayerEssential.forcerefto(Game.getplayer())
		gotostate("YesEssential")
	else
		gotostate("NoEssential")
	endif
EndEvent

Function Defeated()
	Debug.Notification("No..! I cant be defeated like this..!")
	Game.ForceThirdPerson()
	Game.GetPlayer().RestoreActorValue("health", 100)
	Game.DisablePlayerControls(abmenu =true)
	Utility.Wait(0.5)
	Game.GetPlayer().PlayIdle(Knockout)

		If NexStage01Switch == True
			GetOwningQuest().SetStage(NextStage01)
		EndIf

		If  NextScene01Switch == True
			NextScene01.Start()
		EndIf

		If BacktoNormal
			Utility.Wait(5.0)
;			PlayerEssential.clear()
			Game.EnablePlayerControls(abmenu =true)
		endif
EndFunction

Function DamageCalculation(ObjectReference akAggressor)

	If GetOwningQuest().GetStage() == StartStage
		If akAggressor.haskeyword(BaboStripper) || Yeskeyword == False
			If	FoeSwitch == False || (Foe01.getref() as actor).isdead() == False
				self.Defeated()
			Else
				;Now you can die
				Debug.Notification("No..! I have to stand up! Let's get out of here!")
				Game.ForceThirdPerson()
				Game.GetPlayer().RestoreActorValue("health", 10)
				Game.DisablePlayerControls(abmenu =true)
				Utility.Wait(0.5)
				Game.GetPlayer().PlayIdle(Knockout02)
				Utility.Wait(5.0)
				Game.GetPlayer().RestoreActorValue("health", 5)
				Game.EnablePlayerControls(abmenu =true)
				Game.GetPlayer().PlayIdle(StaggerStart)
			EndIf
		EndIf
	EndIf

EndFunction



state NoEssential

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

CurrentHealth = Game.GetPlayer().GetActorValue("health")
BaseHealth = Game.GetPlayer().GetBaseActorValue("health")
playersHealth = (CurrentHealth / BaseHealth) * 100

If PlayersHealth < 0
PlayersHealth = 0
EndIf

	If ((playersHealth <= MaximumCriterion) && (playersHealth >= MinimumCriterion))
		if akAggressor
			DamageCalculation(akAggressor)
		endif
	Elseif playersHealth <= 0
		if akAggressor
			DamageCalculation(akAggressor)
		endif	
		;Mostly dead if not by other mods that can keep player alive.
	EndIf
EndEvent

Event OnEnterBleedOut()

EndEvent

endstate


State YesEssential

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

if akAggressor
	LastAggressor = akAggressor as actor
endif
EndEvent

Event OnEnterBleedOut()
	DamageCalculation(LastAggressor)
EndEvent

Endstate
