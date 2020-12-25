Scriptname _BS_HiddenPocket extends ReferenceAlias

_BS_MCM Property MCM Auto
Keyword Property ClothingRing Auto
Keyword Property ClothingNecklace Auto
Keyword Property VendorItemGem Auto
MiscObject Property Lockpick Auto

float Property MAXCAPACITY = 0.5 AutoReadOnly
int Property MAXCOUNT = 5 AutoReadOnly

ObjectReference pocket
int addCount
int removeCount

Event OnInit()
	pocket = GetReference()
	RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuOpen(String MenuName)
	addCount = 0
	removeCount = 0
EndEvent

Event OnMenuClose(String MenuName)
	if !MCM.HiddenPocketAnimation
		return
	endif
	if addCount == 0 && removeCount == 0
		return
	endif

	if addCount >= removeCount
		Debug.SendAnimationEvent(Game.GetPlayer(), "ExtraPocketPullin")
	else
		Debug.SendAnimationEvent(Game.GetPlayer(), "ExtraPocketPullout")
	endif
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	GoToState("Adding")

	bool back = true
	int backCount = aiItemCount

	if akBaseItem as Key
		back = false
	elseif akBaseItem as Armor
		if akBaseItem.HasKeyword(ClothingRing) || akBaseItem.HasKeyword(ClothingNecklace)
			back = false
		endif
	elseif akBaseItem as MiscObject
		if akBaseItem == Lockpick || akBaseItem.HasKeyword(VendorItemGem)
			back = false
		endif
	endif

	if back
		Debug.Notification(akBaseItem.GetName() + " can't be put in Hidden Pocket")
	endif

	if !back
		if pocket.GetTotalItemWeight() > MAXCAPACITY
			back = true
			Debug.Notification("Hidden Pocket is full")
		endif
	endif

	if !back
		int count = 0
		Form[] items = pocket.GetContainerForms()
		int n = items.Length
		int i = 0
		while i < n
			count += pocket.GetItemCount(items[i])
			i += 1
		endWhile
		if count > MAXCOUNT
			back = true
			backCount = count - MAXCOUNT
			Debug.Notification("Hidden Pocket is full")
		endif
	endif

	if back
		pocket.RemoveItem(akBaseItem, backCount, true, akSourceContainer)
		addCount += aiItemCount - backCount
	else
		addCount += aiItemCount
	endif

	GoToState("")
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	removeCount += aiItemCount
EndEvent

state Adding
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	EndEvent
endState

