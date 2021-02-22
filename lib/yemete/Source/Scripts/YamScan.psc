Scriptname YamScan extends Quest
{Script to Monitor in-Combat behavior}

; -------------------------- Imports
import StringUtil

; -------------------------- Properties
YamMCM Property MCM Auto
UILib_1 Property UILib Auto Hidden

Quest Property Yam_Reload Auto
Keyword Property Yam_Scan_InUse Auto

YamPlayer Property Player Auto
ReferenceAlias[] Property myActors Auto
ReferenceAlias[] Property myFollowers Auto
ReferenceAlias[] Property myBullets Auto ;Actors that joined the fight after this Quest already started

; -------------------------- Variables
;To avoid the Quest to stop while a Scene is still ongoing
bool sceneRunning = false
int activeScenes = 0

;0~15: Combatant0~15, 16~19: Follower, 20: Player
bool[] activVic
Actor[] aggrList

; -------------------------- Code
Event OnInit()
  If(MCM.bCheckForNewActors)
    RegisterForSingleUpdate(MCM.iTickIntCombat)
  EndIf
  activVic = new bool[21]
  aggrList = new Actor[21]
  UiLib = (Self as Form) as UiLib_1
EndEvent

Function SceneEntry(string ID, Actor myAggr)
  sceneRunning = true
  activeScenes += 1
  If(ID == "Player")
    aggrList[20] = myAggr
    activVic[20] = true
  ElseIf(GetNthChar(ID, 0) == "F") ;Follower
    int IDv = (GetNthChar(ID, 8)) as int
    aggrList[16 + IDv] = myAggr
    activVic[16 + IDv] = true
  else
    int IDv = (GetNthChar(ID, 9) + GetNthChar(ID, 10)) as int
    aggrList[IDv] = myAggr
    activVic[IDv] = true
  EndIf
EndFunction

Function SceneClose(string ID)
  activeScenes -= 1
  If(activeScenes <= 0)
    sceneRunning = false
  EndIf
  If(ID == "Player")
    activVic[20] = false
  ElseIf(GetNthChar(ID, 0) == "F") ;Follower
    int IDv = (GetNthChar(ID, 8)) as int
    activVic[16 + IDv] = false
  else
    int IDv = (GetNthChar(ID, 9) + GetNthChar(ID, 10)) as int
    activVic[IDv] = false
  EndIf
endFunction

bool Function IsReservedAggr(Actor me)
  If(me == none || aggrList.Find(me) >= 0)
    return true
  EndIf
  return false
endFunction

Function ClearAggr(string ID)
  If(ID == "Player")
    aggrList[20] = none
  ElseIf(GetNthChar(ID, 0) == "F") ;Follower
    int IDv = (GetNthChar(ID, 8)) as int
    aggrList[16 + IDv] = none
  else
    int IDv = (GetNthChar(ID, 9) + GetNthChar(ID, 10)) as int
    aggrList[IDv] = none
  EndIf
endFunction

Event OnUpdate()
  If(Yam_Reload.Start())
    int Count = 0
    While(Count < 6)
      Actor newBullet = myBullets[Count].GetReference() as Actor
      If(newBullet)
        If(!newBullet.HasKeyword(Yam_Scan_InUse))
          int freeSlot = GetFreeSlot()
          If(freeSlot != 777)
            myActors[freeSlot].ForceRefTo(newBullet)
            Utility.Wait(0.5)
            (myActors[freeSlot] as YamActor).Initialize()
          EndIf
        EndIf
      EndIf
      Count += 1
    EndWhile
    Utility.Wait(0.1)
    Yam_Reload.Stop()
  elseIf(sceneRunning)
    ; No fight but there are still Scenes or Scenarios running. We consider this Combat end and pull Actors that are locked in a Scenario until Combat End out of their misery :p
    ; ..but can't stop the Quest just yet as that would prevent the Scenario of the currently animating Actor(s) to execute, potentially glitching them out
    CloseQuest()
  else
    ; No fight, no Scenarios andalso no Actors are currently animating, so we can savly Stop the Quest
    Stop()
  EndIf
  RegisterForSingleUpdate(MCM.iTickIntCombat)
EndEvent

int Function GetFreeSlot()
  int Count = myActors.Length
  While(Count > 1)
    Count -= 1
    If(!myActors[Count].GetReference())
      return Count
    EndIf
  EndWhile
  return 777
endFunction

Function CloseQuest()
  If(!activVic[20])
    Player.GoToState("")
  EndIf
  int Count = myActors.Length
  While(Count)
    Count -= 1
    If(myActors[Count] && !activVic[Count])
      (myActors[Count] as YamActor).GoToState("")
    EndIf
  EndWhile
  Count = myFollowers.Length
  While(Count)
    Count -= 1
    If(myFollowers[Count] && !activVic[16 + Count])
      (myFollowers[Count] as YamFollower).GoToState("")
    EndIf
  EndWhile
endFunction

Function StopQuest()
  Player.CleanUp()
  int Count = myActors.Length
  While(Count)
    Count -= 1
    If(myActors[Count])
      (myActors[Count] as YamActor).CleanUp()
    EndIf
  EndWhile
  Count = myFollowers.Length
  While(Count)
    Count -= 1
    If(myFollowers[Count])
      (myFollowers[Count] as YamFollower).CleanUp()
    EndIf
  EndWhile
endFunction
