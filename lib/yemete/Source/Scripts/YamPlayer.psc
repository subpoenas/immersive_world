Scriptname YamPlayer extends ReferenceAlias

; -------------------------- Properties
YamCore Property Core Auto
YamMCM Property MCM Auto
YamScan Property Scan Auto
SexLabFramework Property SL Auto

Actor Property PlayerRef Auto
Faction Property CurrentFollowerFaction Auto

Spell Property CloakSpell Auto
Quest Property Yam_Scan Auto

; -------------------------- Variables
bool bLock = false
Actor Aggressor

; -------------------------- Core
Event OnInit()
  Core.Maintenance()
endEvent

Event OnPlayerLoadGame()
  Core.Maintenance()
EndEvent

; -------------------------- System
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
  If(akAggressor == none || bLock)
    return
  EndIf
  If(MCM.bPlVicMaster && !Core.ModPaused)
    bLock = true
    Actor myAggr = akAggressor as Actor
    ;Conditions for an Actor to be knocked down
    If(ValidInteraction(akAggressor as Actor))
      ;Weakened
      If(PlayerRef.GetActorValuePercentage("Health") <= ((MCM.iWkHpThreshPl as float)/100) && PlayerRef.GetAV("Health") >= 1)
        If(MCM.bWkBlockPl && !abHitBlocked)
          If(MCM.bWkMeleePl && akProjectile == none)
            Aggressor = myAggr
            Defeated()
          ElseIf(!MCM.bWkMeleePl)
            Aggressor = myAggr
            Defeated()
          EndIf
        ElseIf(!MCM.bWkBlockPl)
          If(MCM.bWkMeleePl && akProjectile == none)
            Aggressor = myAggr
            Defeated()
          ElseIf(!MCM.bWkMeleePl)
            Aggressor = myAggr
            Defeated()
          EndIf
        EndIf
        ;Next Scenario
      EndIf
    EndIf
    Utility.Wait(0.1)
    bLock = false
  EndIf
EndEvent

bool Function ValidInteraction(Actor me)
  If(!me)
    return false
  ElseIf(me.IsDead() || me == PlayerRef)
    return false
  EndIf
  If(SL.IsActorActive(me) || SL.IsActorActive(PlayerRef))
    return false
  EndIf
  ;0 - Male, 1 - Female, 2 - Futa, 3 - Male Creature, 4 - Female Creature
  If(me.IsInFaction(CurrentFollowerFaction) && MCM.bAssFolPl && Utility.RandomInt(1, 100) <= MCM.iAssFolPl)
    return true
  ElseIf(Utility.RandomInt(1, 100) <= MCM.iAssNpcPl)
    int mesGender = GetActorType(me)
    If(mesGender == 0 && MCM.bAssMalPl)
      return true
    ElseIf(mesGender == 1 && MCM.bAssFemPl)
      return true
    ElseIf(mesGender == 2 && MCM.bAssFutPl)
      return true
    ElseIf(mesGender == 3 && MCM.bAssMalCrPl)
      return true
    ElseIf(mesGender == 4 && MCM.bAssFemCrPl)
      return true
    EndIf
  endIf
  return false
endFunction

Function Defeated()
  ; A final check to ensure the Aggressor isnt already attacking someone. To avoid Aggressors with an AoE Ability to assault multiple Victims at once
  If(!Scan.IsReservedAggr(Aggressor))
    Scan.SceneEntry("Player", Aggressor)
    GoToState(MCM.PlayerScenarioList[MCM.iPlayerScenario])
  endIf
endFunction

; 1) Ghost Flag
; 2) Spell
; 3) Bleedout Anim
; 4) Reset State
Function CleanUp()
  GotoState("")
  PlayerRef.SetGhost(false)
  PlayerRef.RemoveSpell(CloakSpell)
  PlayerRef.SetDontMove(false)
  If(Aggressor)
    Aggressor.SetGhost(false)
    aggressor.RemoveSpell(CloakSpell)
    Aggressor.SetDontMove(false)
  EndIf
endFunction

; -------------------------- Scenarios
; Important Functions:
; SceneClose: Called when State Specific Actions are complete. This lets the mod know that its ok for this Instance to Stop the Quest
; ClearAggr: Allowing the Aggressor to Assault a different Victim again
; OnEndState(): ALL SCENARIO CLEANUP HAS TO BE IN HERE
State Basic
  ; ===================================================================== ;
  ;                           DEFAULT STATE ACTIONS                       ;
  ; ===================================================================== ;
  Event OnBeginState()
    If(MCM.bPlUseGhost)
      PlayerRef.SetGhost()
      Aggressor.SetGhost()
    EndIf
    PlayerRef.AddSpell(CloakSpell, false)
    aggressor.AddSpell(CloakSpell)
    PlayerRef.StopCombat()
    Aggressor.StopCombat()
    Aggressor.SetDontMove()
    StartScene()
  EndEvent

  Function Pseudohook()
    Utility.Wait(2)
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr("Player")
    StateSpecific()
  EndFunction

  Event Aftermath(int tid, bool hasPlayer)
    HealActor()
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr("Player")
    StateSpecific()
    UnregisterForModEvent("HookAnimationEnding_PostUse")
  EndEvent
  ; ===================================================================== ;
  ;                          STATE SPECIFIC ACTIONS                       ;
  ; ===================================================================== ;
  Function StateSpecific()
    Scan.SceneClose("Player")
    GotoState("")
  endFunction

  ; Event OnUpdate()
  ;
  ; EndEvent

  Event OnEndState()
    ;State Specific CleanUp:
    ;Base
    PlayerRef.SetGhost(false)
    PlayerRef.RemoveSpell(CloakSpell)
  EndEvent
EndState

State Bleedout1
  ; ===================================================================== ;
  ;                           DEFAULT STATE ACTIONS                       ;
  ; ===================================================================== ;
  Event OnBeginState()
    If(MCM.bPlUseGhost)
      PlayerRef.SetGhost()
      Aggressor.SetGhost()
    EndIf
    PlayerRef.AddSpell(CloakSpell, false)
    aggressor.AddSpell(CloakSpell)
    PlayerRef.StopCombat()
    Aggressor.StopCombat()
    Aggressor.SetDontMove()
    StartScene()
  EndEvent

  Function Pseudohook()
    Utility.Wait(2)
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr("Player")
    StateSpecific()
  EndFunction

  Event Aftermath(int tid, bool hasPlayer)
    HealActor()
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr("Player")
    StateSpecific()
    UnregisterForModEvent("HookAnimationEnding_PostUse")
  EndEvent
  ; ===================================================================== ;
  ;                          STATE SPECIFIC ACTIONS                       ;
  ; ===================================================================== ;
  Function StateSpecific()
    If(!MCM.bPlBleedKeepGhost)
      PlayerRef.SetGhost(false)
    EndIf
    Utility.Wait(1) ;Waiting to not have SL Close cancel out Bleedout Anim
    Core.BleedOut(PlayerRef)
    ;How long we stay in Bleedout:
    If(MCM.iPlBleedDur > 0)
      RegisterForSingleUpdate(MCM.iPlBleedDur)
    else
      ; If Bleedout should last til Combat End, we tell the System that we're ready to leave Combat. OnEndState will do the rest
      Scan.SceneClose("Player")
    EndIf
  endFunction

  Event OnUpdate()
    Scan.SceneClose("Player")
    GotoState("")
  EndEvent

  Event OnEndState()
    ;State Specific CleanUp:
    Core.BleedOutExit(PlayerRef)
    Utility.Wait(5)
    ;Base
    PlayerRef.SetGhost(false)
    PlayerRef.RemoveSpell(CloakSpell)
  EndEvent
EndState

; ------------------------------ State Utility
Function StateSpecific()
  ;Each State will execute its Unique Characteristics by calling and overwriting this Function.
EndFunction

Function StartScene()
  If(MCM.bShowNotifyColor)
    Scan.UILib.ShowNotification(Aggressor.GetLeveledActorBase().GetName() + " attempts to assault " + PlayerRef.GetLeveledActorBase().GetName(), "#d91e34")
  ElseIf(MCM.bShowNotify)
    Debug.Notification(Aggressor.GetLeveledActorBase().GetName() + " attempts to assault " + PlayerRef.GetLeveledActorBase().GetName())
  EndIf
  If(!MCM.bSLScenes)
    Debug.Notification("Imagine a Scene to start here")
    PseudoHook()
    HealActor()
  else
    Actor[] Acteurs = new Actor[2]
    If(MCM.bFemaleFirst && GetActorType(Aggressor) == 1)
      Acteurs[0] = Aggressor
      Acteurs[1] = PlayerRef
    else
      Acteurs[0] = PlayerRef
      Acteurs[1] = Aggressor
    EndIf
    sslBaseAnimation[] Anims = SL.PickAnimationsByActors(Acteurs)
    If(MCM.bTreatAsVictim)
      If(SL.StartSex(Acteurs, Anims, PlayerRef, none, true, "PostUse") == -1)
        PseudoHook()
      else
        RegisterForModEvent("HookAnimationEnding_PostUse", "Aftermath")
      EndIf
    else
      If(SL.StartSex(Acteurs, Anims, none, none, true, "PostUse") == -1)
        PseudoHook()
      else
        RegisterForModEvent("HookAnimationEnding_PostUse", "Aftermath")
      EndIf
    EndIf
  EndIf
  Aggressor.SetDontMove(false)
EndFunction

Event Aftermath(int tid, bool hasPlayer)
  ;SL Hook
  ;A Victim is always located inside a State, so leaving this empty
EndEvent

Function Pseudohook()
  ;Pseudo Hook
  ;Same as Aftermath, used when a Scene doesnt start
EndFunction

; ------------------------------ Misc
int Function GetActorType(Actor me)
  int mySLGender = SL.GetGender(me)
  If(mySLGender == 3) ;Female Creature
    return 4
  ElseIf(mySLGender == 2) ;Male Creature
    return 3
  Else ;Humanoid
    int myVanillaGender = me.GetLeveledActorBase().GetSex()
    If(myVanillaGender == mySLGender) ;Either male or female
      return myVanillaGender
    Else ;Futa
      return 2
    EndIf
  EndIf
endFunction

Function HealActor()
  Float BaseValue = PlayerRef.GetBaseActorValue("Health")
  Float CurrentMaxValue = Math.Ceiling(PlayerRef.GetActorValue("Health") / PlayerRef.GetActorValuePercentage("Health"))
  if BaseValue < CurrentMaxValue
      PlayerRef.RestoreActorValue("Health", (BaseValue*(MCM.iHealPlayer as float)/100))
  else
      PlayerRef.RestoreActorValue("Health", (CurrentMaxValue*(MCM.iHealPlayer as float)/100))
  endif
EndFunction
