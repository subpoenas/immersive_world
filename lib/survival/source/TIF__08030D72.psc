;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08030D72 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If PlayerRef.WornHasKeyword(Devious.zad_DeviousArmbinder)
	Devious.RemoveDevice(PlayerRef, Devious.zad_armBinderHisec_Inventory)
EndIf
PlayerRef.AddItem(Main.StrippedClothes, 1, false)
Actor Host = KnockHost.GetReference() as Actor
SLS_KnockLockDoor LockInScript = Main.LockTheDoor as SLS_KnockLockDoor
LockInScript.RemoveLockdown()
KnockHost.Clear()
Host.EvaluatePackage()
Main.GoToState("")
;StorageUtil.SetFormValue( Game.getPlayer() , "_SD_TempAggressor", akSpeaker)
;SendModEvent("PCSubEnslave")
akSpeaker.SendModEvent("PCSubEnslave")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_InterfaceDevious Property Devious Auto
SLS_Main Property Main Auto
Actor Property PlayerRef Auto
ReferenceAlias Property KnockHost  Auto  
