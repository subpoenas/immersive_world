Scriptname YamActor extends ReferenceAlias

; -------------------------- Properties
YamCore Property Core Auto
YamMCM Property MCM Auto
YamScan Property Scan Auto
SexLabFramework Property SL Auto

Actor Property PlayerRef Auto
Faction Property CurrentFollowerFaction Auto

Message Property Yam_Scan_AssaultMenu Auto
Spell Property CloakSpell Auto
Spell Property Yam_Scan_FleeMark Auto

; -------------------------- Variables
Actor mySelf
;0 - Male, 1 - Female, 2 - Futa, 3 - Male Creature, 4 - Female Creature
int myGender
string myID

bool bLock = false ; Restricting how often onHit fires
bool firstCall = true ; Defining myself & myID on the first onHit Call
bool bMsgLock = false ; Avoiding firing OnStateEnter to fire multiple times
bool bAsked = false ; Only allow Player to assault a Victim once

Actor Aggressor

; -------------------------- Code
Function Initialize()
  mySelf = GetReference() as Actor
  myID = GetName()
  bAsked = false
  firstCall = true
  ; Debug.Notification("Added Actor: " + myID)
  ; Debug.Trace("Added Actor: " + myID)
endFunction

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
  If(!akAggressor || bLock)
    return
  EndIf
  If(MCM.bNPCVicMaster)
    bLock = true
    Actor myAggr = akAggressor as Actor
    ;Conditions for an Actor to be knocked down
    If(ValidInteraction(myAggr))
      ; Debug.Trace("Yamete: " + (akAggressor as Actor).GetLeveledActorBase().GetName() + " got past check for Actor: " + myID)
      If(mySelf.GetActorValuePercentage("Health") <= ((MCM.iWkHpThreshNPC as float)/100) && mySelf.GetAV("Health") >= 1)
        If(MCM.bWkBlockNPC && !abHitBlocked)
          If(MCM.bWkMeleeNPC && akProjectile == none)
            Aggressor = myAggr
            Defeated()
          ElseIf(!MCM.bWkMeleeNPC)
            Aggressor = myAggr
            Defeated()
          EndIf
        ElseIf(!MCM.bWkBlockNPC)
          If(MCM.bWkMeleeNPC && akProjectile == none)
            Aggressor = myAggr
            Defeated()
          ElseIf(!MCM.bWkMeleeNPC)
            Aggressor = myAggr
            Defeated()
          EndIf
        EndIf
      ;Next Condition
      EndIf
    EndIf
    Utility.Wait(0.1)
    bLock = false
  EndIf
EndEvent

bool Function ValidInteraction(Actor me)
  ;I hate doing so many checks here but I still get some Errors about stuff not existing ... zzz. Apparently things that dont exist get hits registerd by aggressors that dont exist but arent none. Someone, explain me this game
  If(!GetReference())
    CleanUp()
    return false
  elseIf(firstCall)
    mySelf = GetReference() as Actor
    myID = GetName()
    firstCall = false
  EndIf
  If(!me || !myself)
    ; Debug.Trace("Yamete: Me or Myself doesnt exist")
    return false
  endIf
  If(me.IsDead() || mySelf.IsDead()  || me == mySelf)
    return false
  EndIf
  If(SL.IsActorActive(me) || SL.IsActorActive(mySelf))
    ; Debug.Trace("Yamete: Me or Myself is Animating")
    return false
  EndIf
  ;0 - Male, 1 - Female, 2 - Futa, 3 - Male Creature, 4 - Female Creature
  myGender = GetActorType(mySelf)
  If(me == PlayerRef && !Core.bPlayerAggr)
    return false
  ElseIf(me == PlayerRef && !bAsked)
    If(myGender == 0 && MCM.bAssPlMale)
      return true
    ElseIf(myGender == 1 && MCM.bAssPlFemale)
      return true
    ElseIf(myGender == 2 && MCM.bAssPlFuta)
      return true
    ElseIf(myGender == 3 && MCM.bAssPlMaleCreat)
      return true
    ElseIf(myGender == 4 && MCM.bAssPlFemCreat)
      return true
    EndIf
  ElseIf(me.IsInFaction(CurrentFollowerFaction) && (Utility.RandomInt(1, 100) <= MCM.iAssFolNPC))
    int mesGender = GetActorType(me)
    If(mesGender == 0 && MCM.bAssFolGenMal)
      If(myGender == 0 && MCM.bAssFolMale)
        return true
      ElseIf(myGender == 1 && MCM.bAssFolFemale)
        return true
      ElseIf(myGender == 2 && MCM.bAssFolFuta)
        return true
      ElseIf(myGender == 3 && MCM.bAssFolMaleCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFolFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 1 && MCM.bAssFolGenFem)
      If(myGender == 0 && MCM.bAssFolMale)
        return true
      ElseIf(myGender == 1 && MCM.bAssFolFemale)
        return true
      ElseIf(myGender == 2 && MCM.bAssFolFuta)
        return true
      ElseIf(myGender == 3 && MCM.bAssFolMaleCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFolFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 2 && MCM.bAssFolGenFut)
      If(myGender == 0 && MCM.bAssFolMale)
        return true
      ElseIf(myGender == 1 && MCM.bAssFolFemale)
        return true
      ElseIf(myGender == 2 && MCM.bAssFolFuta)
        return true
      ElseIf(myGender == 3 && MCM.bAssFolMaleCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFolFemCreat)
        return true
      EndIf
    ElseIf(mesGender > 2 && MCM.bAssFolGenPet)
      If(myGender == 0 && MCM.bAssFolMale)
        return true
      ElseIf(myGender == 1 && MCM.bAssFolFemale)
        return true
      ElseIf(myGender == 2 && MCM.bAssFolFuta)
        return true
      ElseIf(myGender == 3 && MCM.bAssFolMaleCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFolFemCreat)
        return true
      EndIf
    EndIf
  ElseIf(me != PlayerRef && (Utility.RandomInt(1, 100) <= MCM.iAssNPCNPC))
    int mesGender = GetActorType(me)
    If(mesGender == 0)
      If(myGender == 0 && MCM.bAssMalMal)
        return true
      ElseIf(myGender == 1 && MCM.bAssMalFem)
        return true
      ElseIf(myGender == 2 && MCM.bAssMalFut)
        return true
      ElseIf(myGender == 3 && MCM.bAssMalCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssMalFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 1)
      If(myGender == 0 && MCM.bAssFemMal)
        return true
      ElseIf(myGender == 1 && MCM.bAssFemFem)
        return true
      ElseIf(myGender == 2 && MCM.bAssFemFut)
        return true
      ElseIf(myGender == 3 && MCM.bAssFemCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFemFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 2)
      If(myGender == 0 && MCM.bAssFutMal)
        return true
      ElseIf(myGender == 1 && MCM.bAssFutFem)
        return true
      ElseIf(myGender == 2 && MCM.bAssFutFut)
        return true
      ElseIf(myGender == 3 && MCM.bAssFutCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFutFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 3)
      If(myGender == 0 && MCM.bAssMalCrMal)
        return true
      ElseIf(myGender == 1 && MCM.bAssMalCrFem)
        return true
      ElseIf(myGender == 2 && MCM.bAssMalCrFut)
        return true
      ElseIf(myGender == 3 && MCM.bAssMalCrCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssMalCrFemCreat)
        return true
      EndIf
    ElseIf(mesGender == 4)
      If(myGender == 0 && MCM.bAssFemCrMal)
        return true
      ElseIf(myGender == 1 && MCM.bAssFemCrFem)
        return true
      ElseIf(myGender == 2 && MCM.bAssFemCrFut)
        return true
      ElseIf(myGender == 3 && MCM.bAssFemCrCreat)
        return true
      ElseIf(myGender == 4 && MCM.bAssFemCrFemCreat)
        return true
      EndIf
    EndIf
  EndIf
  return false
endFunction

;GoToState() splitted here because it otherwise fires multiple times which causes issues with the Player as Aggressor Feature
Function Defeated()
  If(bMsgLock == false)
    bMsgLock = true
    ; A final check to ensure the Aggressor isnt already attacking someone else and the Victim isnt already part of a Scenario
    If(!Scan.IsReservedAggr(Aggressor))
      Scan.SceneEntry(myID, Aggressor)
      GoToState(MCM.ActorScenarioList[MCM.iActorScenario])
    EndIf
  EndIf
  Utility.Wait(0.5)
  bMsgLock = false
EndFunction

Event OnDeath(Actor akKiller)
  If(mySelf && myID != "Combatant0")
    Clear()
  EndIf
EndEvent

Event OnUnload()
  If(mySelf && myID != "Combatant0")
    Clear()
  EndIf
EndEvent

; 1) Ghost Flag
; 2) Factions
; 3) Spell
; 4) Bleedout Anim
; 5) Clear Alias
Function CleanUp()
  If(mySelf)
    mySelf.SetGhost(false)
    mySelf.RemoveSpell(CloakSpell)
    mySelf.SetDontMove(false)
    Utility.Wait(1)
    If(myID != "Combatant0")
      TryToClear()
    EndIf
  EndIf
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
    If(MCM.bNPCUseGhost)
      mySelf.SetGhost()
      Aggressor.SetGhost()
    EndIf
    mySelf.AddSpell(CloakSpell)
    aggressor.AddSpell(CloakSpell, false)
    mySelf.StopCombat()
    Aggressor.StopCombat()
    mySelf.SetDontMove()
    Aggressor.SetDontMove()
    StartScene()
  EndEvent

  Function Pseudohook()
    Utility.Wait(2)
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
  EndFunction

  Event Aftermath(int tid, bool hasPlayer)
    HealActor()
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
    UnregisterForModEvent("HookAnimationEnding_PostUse")
  EndEvent
  ; ===================================================================== ;
  ;                          STATE SPECIFIC ACTIONS                       ;
  ; ===================================================================== ;
  Function StateSpecific()
    Scan.SceneClose(myID)
    GotoState("")
  endFunction

  ; Event OnUpdate()
  ;
  ; endEvent

  Event OnEndState()
    ;State Specific CleanUp:
    ;Base
    mySelf.SetGhost(false)
    mySelf.RemoveSpell(CloakSpell)
  EndEvent
  ; ===================================================================== ;
  ;                                 CLEAN UP                              ;
  ; ===================================================================== ;
  Event OnUnload()
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent

  Event OnDeath(Actor akKiller)
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent
EndState

State Flee
  ; ===================================================================== ;
  ;                           DEFAULT STATE ACTIONS                       ;
  ; ===================================================================== ;
  Event OnBeginState()
    If(MCM.bNPCUseGhost)
      mySelf.SetGhost()
      Aggressor.SetGhost()
    EndIf
    mySelf.AddSpell(CloakSpell)
    aggressor.AddSpell(CloakSpell, false)
    mySelf.StopCombat()
    Aggressor.StopCombat()
    mySelf.SetDontMove()
    Aggressor.SetDontMove()
    StartScene()
  EndEvent

  Function Pseudohook()
    Utility.Wait(2)
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
  EndFunction

  Event Aftermath(int tid, bool hasPlayer)
    HealActor()
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
    UnregisterForModEvent("HookAnimationEnding_PostUse")
  EndEvent
  ; ===================================================================== ;
  ;                          STATE SPECIFIC ACTIONS                       ;
  ; ===================================================================== ;
  Function StateSpecific()
    mySelf.SetGhost(false)
    ;State Specifics:
    mySelf.AddSpell(Yam_Scan_FleeMark, false)
    mySelf.EvaluatePackage()
    ;Update or Empty State:
    RegisterForSingleUpdate(MCM.iFolFleeDur)
  endFunction

  Event OnUpdate()
    Scan.SceneClose(myID)
    GotoState("")
  endEvent

  Event OnEndState()
    ;State Specific CleanUp:
    mySelf.RemoveSpell(Yam_Scan_FleeMark)
    mySelf.EvaluatePackage()
    ;Base
    ; mySelf.SetGhost(false) <- Doing that in StateSpecific()
    mySelf.RemoveSpell(CloakSpell)
  EndEvent
  ; ===================================================================== ;
  ;                                 CLEAN UP                              ;
  ; ===================================================================== ;
  Event OnUnload()
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent

  Event OnDeath(Actor akKiller)
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent
EndState

State Bleedout1
  ; ===================================================================== ;
  ;                           DEFAULT STATE ACTIONS                       ;
  ; ===================================================================== ;
  Event OnBeginState()
    If(MCM.bNPCUseGhost)
      mySelf.SetGhost()
      Aggressor.SetGhost()
    EndIf
    mySelf.AddSpell(CloakSpell)
    aggressor.AddSpell(CloakSpell, false)
    mySelf.StopCombat()
    Aggressor.StopCombat()
    mySelf.SetDontMove()
    Aggressor.SetDontMove()
    StartScene()
  EndEvent

  Function Pseudohook()
    Utility.Wait(2)
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
  EndFunction

  Event Aftermath(int tid, bool hasPlayer)
    HealActor()
    Aggressor.SetGhost(false)
    Aggressor.RemoveSpell(CloakSpell)
    Scan.ClearAggr(myID)
    StateSpecific()
    UnregisterForModEvent("HookAnimationEnding_PostUse")
  EndEvent
  ; ===================================================================== ;
  ;                          STATE SPECIFIC ACTIONS                       ;
  ; ===================================================================== ;
  Function StateSpecific()
    If(MCM.bNPCBleedKeepGhost == false)
      mySelf.SetGhost(false)
    EndIf
    Utility.Wait(1) ;Waiting to not have SL Close cancel out Bleedout Anim
    Core.BleedOut(mySelf)
    ;How long we stay in Bleedout:
    If(MCM.iNPCBleedoutDur > 0)
      RegisterForSingleUpdate(MCM.iNPCBleedoutDur)
    else
      Scan.SceneClose(myID)
    EndIf
  endFunction

  Event OnUpdate()
    Scan.SceneClose(myID)
    GotoState("")
  endEvent

  Event OnEndState()
    ;State Specific CleanUp:
    Core.BleedOutExit(mySelf)
    Utility.Wait(5)
    ;Base
    mySelf.SetGhost(false)
    mySelf.RemoveSpell(CloakSpell)
  EndEvent
  ; ===================================================================== ;
  ;                                 CLEAN UP                              ;
  ; ===================================================================== ;
  Event OnUnload()
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent

  Event OnDeath(Actor akKiller)
    CleanUp()
    Scan.SceneClose(myID)
    GotoState("")
  EndEvent
EndState
; ------------------------------ SexLab
Function StateSpecific()
  ;Each State will execute its Unique Characteristics by calling and overwriting this Function.
endFunction

Function StartScene()
  If(MCM.bShowNotifyColor)
    Scan.UILib.ShowNotification(Aggressor.GetLeveledActorBase().GetName() + " attempts to assault " + mySelf.GetLeveledActorBase().GetName(), "#d91e34")
  ElseIf(MCM.bShowNotify)
    Debug.Notification(Aggressor.GetLeveledActorBase().GetName() + " attempts to assault " + mySelf.GetLeveledActorBase().GetName())
  EndIf
  If(Aggressor == PlayerRef)
    bAsked = true
    int choice = Yam_Scan_AssaultMenu.Show()
    ; Assault - Nothing - Disable
    If(choice == 0)
      If(!MCM.bSLScenes)
        Debug.Notification("Imagine a Scene to start here")
        HealActor()
        PseudoHook()
      else
        Actor[] Acteurs = new Actor[2]
        If(MCM.bFemaleFirst && GetActorType(Aggressor) == 1)
          Acteurs[0] = Aggressor
          Acteurs[1] = mySelf
        else
          Acteurs[0] = mySelf
          Acteurs[1] = Aggressor
        EndIf
        sslBaseAnimation[] Anims = SL.PickAnimationsByActors(Acteurs)
        If(MCM.bTreatAsVictim)
          If(SL.StartSex(Acteurs, Anims, mySelf, none, true, myID) == -1)
            PseudoHook()
          else
            RegisterForModEvent("HookAnimationEnding_"+myID, "Aftermath")
          EndIf
        else
          If(SL.StartSex(Acteurs, Anims, none, none, true, myID) == -1)
            PseudoHook()
          else
            RegisterForModEvent("HookAnimationEnding_"+myID, "Aftermath")
          EndIf
        EndIf
        RegisterForModEvent("HookAnimationEnding_"+myID, "Aftermath")
      EndIf
    ElseIf(choice == 1)
      If(MCM.bKnockdownAnyway)
        PseudoHook()
      else
        GotoState("")
      EndIf
    ElseIf(choice == 2)
      If(MCM.bKnockdownAnyway)
        PseudoHook()
      else
        GotoState("")
      EndIf
      Core.ManageAura()
    EndIf
  Else
    If(!MCM.bSLScenes)
      Debug.Notification("Imagine a Scene to start here")
      HealActor()
      PseudoHook()
    else
      Actor[] Acteurs = new Actor[2]
      If(MCM.bFemaleFirst && GetActorType(Aggressor) == 1)
        Acteurs[0] = Aggressor
        Acteurs[1] = mySelf
      else
        Acteurs[0] = mySelf
        Acteurs[1] = Aggressor
      EndIf
      sslBaseAnimation[] Anims = SL.PickAnimationsByActors(Acteurs)
      If(MCM.bTreatAsVictim)
        If(SL.StartSex(Acteurs, Anims, mySelf, none, true, myID) == -1)
          PseudoHook()
        else
          RegisterForModEvent("HookAnimationEnding_"+myID, "Aftermath")
        EndIf
      else
        If(SL.StartSex(Acteurs, Anims, none, none, true, myID) == -1)
          PseudoHook()
        else
          RegisterForModEvent("HookAnimationEnding_"+myID, "Aftermath")
        EndIf
      EndIf
    EndIf
  EndIf
  mySelf.SetDontMove(false)
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

; ------------------------------ Utility
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
  Float BaseValue = mySelf.GetBaseActorValue("Health")
  Float CurrentMaxValue = Math.Ceiling(mySelf.GetActorValue("Health") / mySelf.GetActorValuePercentage("Health"))
  if BaseValue < CurrentMaxValue
    mySelf.RestoreActorValue("Health", (BaseValue*(MCM.iHealNPC as float)/100))
  else
    mySelf.RestoreActorValue("Health", (CurrentMaxValue*(MCM.iHealNPC as float)/100))
  endif
EndFunction
