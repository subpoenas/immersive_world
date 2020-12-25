Scriptname _BS_HiddenPocketPlayer extends ReferenceAlias

Spell Property _BS_AccessHiddenPocketPower Auto
_BS_BodySearch Property _BS_BodySearchQuest Auto
_BS_HiddenPocket Property HiddenPocketRA Auto

Actor player
ObjectReference pocket
SexLabFramework SexLab

Event OnInit()
	OnPlayerLoadGame()
EndEvent

Event OnPlayerLoadGame()
	player = GetReference() as Actor
	player.AddSpell(_BS_AccessHiddenPocketPower)
	HiddenPocketRA.OnInit()
	pocket = HiddenPocketRA.GetReference()
	SexLab = Game.GetFormFromFile(0x00000d62, "SexLab.esm") as SexLabFramework
	RegisterForModEvent("HookOrgasmEnd", "OnOrgasmEnd")
	RegisterForModEvent("_BS_CheckIfPlayerDetected", "OnCheckFinished")
EndEvent

Event OnCheckFinished(bool detected)
	if detected
		Debug.Notification("You can't access your hidden pocket now.")
	else
		pocket.Activate(player)
	endif
EndEvent

Event OnOrgasmEnd(int tid, bool hasPlayer)
	if !hasPlayer
		return
	endif

	sslThreadController controller = SexLab.GetController(tid)
	if controller.Animation.Name == "RohZima Guard Search"
		if controller.Positions[0] != player
			Debug.Trace("[BS] OnOrgasmEnd: player isn't a suspected")
			return
		endif
	else
		if !controller.IsVictim(player)
			Debug.Trace("[BS] OnOrgasmEnd: player isn't victim")
			return
		endif
		if !controller.IsAggressive
			Debug.Trace("[BS] OnOrgasmEnd: not aggressive")
			return
		endif
		if !controller.IsVaginal
			Debug.Trace("[BS] OnOrgasmEnd: not vaginal")
			return
		endif
	endif

	bool hasItem = pocket.GetNumItems() > 0
	_BS_BodySearchQuest.HiddenPocketHasItems = hasItem
	if hasItem
		pocket.RemoveAllItems(player, true, true)
		Debug.Notification("Hidden Pocket discharged items")
	endif
EndEvent

