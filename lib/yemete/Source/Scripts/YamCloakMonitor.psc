Scriptname YamCloakMonitor extends ActiveMagicEffect

; -------------------------- Property
Spell Property CalmCloak Auto

; -------------------------- Code
Event OnEffectStart(Actor akTarget, Actor akCaster)
  If(akTarget.GetCombatTarget() == akCaster && akCaster.HasSpell(CalmCloak))
    akTarget.StopCombat()
    akCaster.StopCombatAlarm()
  endIf
EndEvent
