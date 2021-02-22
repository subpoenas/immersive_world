Scriptname YamCore extends Quest
{Scanning here in periodic intervalls. Gonna allow customisation to how and when those Scans fire.. Gonna be a mess to differ between a failed and a succeeded Scan I assume}

; -------------------------- Properties
YamMCM Property MCM Auto
SexLabFramework Property SL Auto

Actor Property PlayerRef Auto
Quest Property Yam_Scan Auto
Spell Property Yam_Core_AuraOfTheAggressor Auto
SPELL Property DoNothingMark Auto

Faction Property Yam_FriendFaction Auto
FormList Property Yam_FriendList Auto

; -------------------------- Variables
bool Property ModPaused = false Auto Hidden
bool Property bPlayerAggr = false Auto Hidden

; -------------------------- Code
Function Maintenance()
  If(!ModPaused)
    RegisterForSingleUpdate(MCM.iTickIntDefault)
  EndIf
  RegisterForKey(MCM.iPlAggrKey)
  RegisterForKey(MCM.iPauseKey)
  int Count = Yam_FriendList.GetSize()
  While(Count)
    Count -= 1
    Faction tmpFac = Yam_FriendList.GetAt(Count) as Faction
    tmpFac.SetAlly(Yam_FriendFaction, true, true)
  EndWhile
EndFunction

; -------------------------- Knockout Animations
Function BleedOut(Actor me)
  If(me == PlayerRef)
    Me.SetDontMove()
  else
    me.AddSpell(DoNothingMark)
    me.EvaluatePackage()
  EndIf
  ;Making sure the Player isnt wearing an Armbinder from DD..
  ;Cant use WornHasKeyword() without a Keyword to use, so falling back to checking if the Item on Slot46 or 59 (Im confused which one is used for Heavy Bondage) is a DD Item with their own custom Bleedout Animation
  Form device59 = me.GetWornForm(0x20000000)
  Form device46 = me.GetWornForm(0x00010000)
  If(device59 != none)
    If(device59.HasKeyWordString("zad_deviousYoke"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_yoke")
    ElseIf(device59.HasKeyWordString("zad_deviousYokeBB"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_bbyoke")
    ElseIf(device59.HasKeyWordString("zad_DeviousArmbinderElbow"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_elbowbinder")
    ElseIf(device59.HasKeyWordString("zad_DeviousArmbinder"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_armbinder")
    ElseIf(device59.HasKeyWordString("zad_DeviousCuffsFront"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_frontcuffs")
    else
      If(MCM.bCustomBleed)
        Debug.SendAnimationEvent(me, "YamBleedout"+Utility.RandomInt(0, 5))
      else
        Debug.SendAnimationEvent(me, "BleedoutStart")
      EndIf
    EndIf
  ElseIf(device46 != none)
    If(device46.HasKeyWordString("zad_deviousYoke"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_yoke")
    ElseIf(device46.HasKeyWordString("zad_deviousYokeBB"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_bbyoke")
    ElseIf(device46.HasKeyWordString("zad_DeviousArmbinderElbow"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_elbowbinder")
    ElseIf(device46.HasKeyWordString("zad_DeviousArmbinder"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_armbinder")
    ElseIf(device46.HasKeyWordString("zad_DeviousCuffsFront"))
      Debug.SendAnimationEvent(me, "ft_bleedout_transin_frontcuffs")
    else
      If(MCM.bCustomBleed)
        Debug.SendAnimationEvent(me, "YamBleedout"+Utility.RandomInt(0, 5))
      else
        Debug.SendAnimationEvent(me, "BleedoutStart")
      EndIf
    EndIf
  else
    If(MCM.bCustomBleed)
      Debug.SendAnimationEvent(me, "YamBleedout"+Utility.RandomInt(0, 5))
    else
      Debug.SendAnimationEvent(me, "BleedoutStart")
    EndIf
  EndIf
endFunction

Function BleedOutExit(Actor me)
  If(me.Is3DLoaded() && me.HasSpell(DoNothingMark) || me == PlayerRef)
    Form device59 = me.GetWornForm(0x20000000)
    Form device46 = me.GetWornForm(0x00010000)
    If(device59 != none)
      If(device59.HasKeyWordString("zad_deviousYoke"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_yoke")
      ElseIf(device59.HasKeyWordString("zad_deviousYokeBB"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_bbyoke")
      ElseIf(device59.HasKeyWordString("zad_DeviousArmbinderElbow"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_elbowbinder")
      ElseIf(device59.HasKeyWordString("zad_DeviousArmbinder"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_armbinder")
      ElseIf(device59.HasKeyWordString("zad_DeviousCuffsFront"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_frontcuffs")
      else
        If(MCM.bCustomBleed)
          Debug.SendAnimationEvent(me, "SexLabSequenceExit1")
          Debug.SendAnimationEvent(me, "IdleForceDefaultState")
        else
          Debug.SendAnimationEvent(me, "BleedoutStop")
        EndIf
      endIf
    ElseIf(device46 != none)
      If(device46.HasKeyWordString("zad_deviousYoke"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_yoke")
      ElseIf(device46.HasKeyWordString("zad_deviousYokeBB"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_bbyoke")
      ElseIf(device46.HasKeyWordString("zad_DeviousArmbinderElbow"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_elbowbinder")
      ElseIf(device46.HasKeyWordString("zad_DeviousArmbinder"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_armbinder")
      ElseIf(device46.HasKeyWordString("zad_DeviousCuffsFront"))
        Debug.SendAnimationEvent(me, "ft_bleedout_transout_frontcuffs")
      else
        If(MCM.bCustomBleed)
          Debug.SendAnimationEvent(me, "SexLabSequenceExit1")
          Debug.SendAnimationEvent(me, "IdleForceDefaultState")
        else
          Debug.SendAnimationEvent(me, "BleedoutStop")
        EndIf
      EndIf
    else
      If(MCM.bCustomBleed)
        Debug.SendAnimationEvent(me, "SexLabSequenceExit1")
        Debug.SendAnimationEvent(me, "IdleForceDefaultState")
      else
        Debug.SendAnimationEvent(me, "BleedoutStop")
      EndIf
    EndIf
    If(me == Game.GetPlayer())
      Me.SetDontMove(false)
    else
      me.RemoveSpell(DoNothingMark)
      me.EvaluatePackage()
    EndIf
  EndIf
endFunction

; -------------------------- Scan & Combat Internals
Event OnUpdate()
  If(DoScan())
    If(!Yam_Scan.Start())
      RegisterForSingleUpdate(MCM.iTickIntDefault)
    endIf
  EndIf
EndEvent

bool Function DoScan()
  If(ModPaused)
    return false
  EndIf
  return true
endFunction

Event OnKeyDown(int KeyCode)
  If(KeyCode == MCM.iPlAggrKey)
    ManageAura()
  ElseIf(ModPaused) ;Mod currently paused, resume it
    ModPaused = false
    RegisterForSingleUpdate(MCM.iTickIntDefault)
    Debug.Notification("Yamete! unpaused")
  else ;Mod active, pause it
    ModPaused = true
    If(Yam_Scan.IsRunning())
      Yam_Scan.Stop()
    else
      UnregisterForUpdate()
    EndIf
    Debug.Notification("Yamete! paused")
  EndIf
EndEvent

Function ManageAura()
  bPlayerAggr = !bPlayerAggr
  If(!bPlayerAggr)
    PlayerRef.RemoveSpell(Yam_Core_AuraOfTheAggressor)
    Debug.Notification("Aura of the Aggressor removed")
  else
    PlayerRef.AddSpell(Yam_Core_AuraOfTheAggressor)
  EndIf
endFunction
