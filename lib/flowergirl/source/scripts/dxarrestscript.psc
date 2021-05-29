Scriptname dxArrestScript extends Quest  

dxFlowerGirlsScript Property FlowerGirls  Auto 
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
Actor Property PlayerRef  Auto  
FavorDialogueScript Property FavorScript  Auto

Event OnUpdate()
	SetStage(1)	
endEvent

Function DoPersuadeGuard(Actor guard)
	; use Persuade
	FavorScript.ArrestPersuade(guard)
	; stop alarms
	PlayerRef.StopCombatAlarm()	
endFunction

Function DoSexualFavor(Actor guard)
{The player submits to the guard.}
	PlayerRef.StopCombatAlarm()
	guard.GetCrimeFaction().PlayerPayCrimeGold(false,false)
	FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.SetValueInt(1)
	FlowerGirls.OralScene(guard, PlayerRef)	
endFunction