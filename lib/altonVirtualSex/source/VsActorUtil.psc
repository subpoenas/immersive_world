scriptname VsActorUtil extends Quest

function ClearEffects(Actor _actorRef, bool _isPlayer)
	if _isPlayer && GetState() != "Animating"
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endIf
	endIf
	if _actorRef.IsInCombat()
		_actorRef.StopCombat()
	endIf
	if _actorRef.IsWeaponDrawn()
		_actorRef.SheatheWeapon()
	endIf
	if _actorRef.IsSneaking()
		_actorRef.StartSneaking()
	endIf
	_actorRef.ClearKeepOffsetFromActor()
endFunction

;------------------------------------------------------
; Scene Actor Functions
;------------------------------------------------------

Function InsertActorToScene(actor _actorRef, bool _isPlayer)
	
	if (_isPlayer)
		Game.ForceThirdPerson()
		Game.DisablePlayerControls(true, true, true, false, true, true, true, false, 0)
	else
		_actorRef.SetRestrained(True)
		_actorRef.SetDontMove(True)		; Prevent any NPC's from being pushed. Do not use on Player.
		_actorRef.SetAlert(False)			; Clears any alerts from the npc.
	endIf
	
	_actorRef.EvaluatePackage()
	_actorRef.ClearKeepOffsetFromActor()
	_actorRef.SetHeadTracking(False)
	
	; ScaleActor()
	
	; Apply scene lighting
endFunction

Function RemoveActorFromScene(actor _actorRef, bool _isPlayer)

	_actorRef.StopTranslation()
	_actorRef.SetVehicle(NONE)
	Utility.Wait(1.0)		; Delay to allow SetVehicle to rescale the actor.
	
	Debug.SendAnimationEvent(_actorRef, "SOSFlaccid")
	
	; Adding a temporary expression override here to reset face manually to neutral.
	_actorRef.SetExpressionOverride(7, 100)		
	
	if (_isPlayer)
		Game.EnablePlayerControls()
	else	
		_actorRef.SetRestrained(False)
		_actorRef.SetDontMove(False)	
		_actorRef.SetHeadTracking(True)
	endIf	
	
	_actorRef.ClearExpressionOverride()
	_actorRef.EvaluatePackage()		
endFunction

;------------------------------------------------------
; Positioning Functions
;------------------------------------------------------

Function SetPosition(actor _actorRef, objectReference _centerRef, float PosXOffset=0.0, float PosYOffset=0.0, float PosZOffset=0.0)
	; Create new marker for this actor
	objectReference ActorPositionRef = _actorRef.PlaceAtMe(_centerRef, 1, false, false)
	
	; Re-assign angles
	ActorPositionRef.SetAngle(_actorRef.GetAngleX(), _actorRef.GetAngleY(), _actorRef.GetAngleZ())
	
	if (PosXOffset != 0.0 || PosYOffset != 0.0 || PosZOffset != 0.0)
		ActorPositionRef.SetPosition(ActorPositionRef.GetPositionX() + PosXOffset, ActorPositionRef.GetPositionY() + PosYOffset, ActorPositionRef.GetPositionZ() + PosZOffset)
	endIf
	
	_actorRef.MoveTo(ActorPositionRef, 0.0, 0.0, 0.0, True)	
	_actorRef.SetVehicle(ActorPositionRef)
	_actorRef.TranslateTo(ActorPositionRef.GetPositionX(), ActorPositionRef.GetPositionY(), ActorPositionRef.GetPositionZ(), \
								ActorPositionRef.GetAngleX(), ActorPositionRef.GetAngleY(), ActorPositionRef.GetAngleZ()+0.01, 500.0, 0.0001)
endFunction

;------------------------------------------------------
; Strip/Unstrip Functions
;------------------------------------------------------

function EquipStrapon(actor _actorRef, Form _strapon)
	if _strapon && !_actorRef.IsEquipped(_strapon)
		_actorRef.EquipItem(_strapon, true, true)
	endIf
endFunction

function UnequipStrapon(actor _actorRef, Form _strapon)
	if _strapon && _actorRef.IsEquipped(_strapon)
		_actorRef.UnequipItem(_strapon, true, true)
	endIf
endFunction

Form[] function Strip(actor _actorRef, Form[] _equipment)
	if _actorRef == None
		return None
	endIf

	; Stripped storage
	Form ItemRef
	Form[] Stripped = new Form[34]

	; Right hand
	ItemRef = _actorRef.GetEquippedObject(1)
	Stripped[33] = ItemRef
	_actorRef.UnequipItemEX(ItemRef, 1, false)
	
	; Left hand
	ItemRef = _actorRef.GetEquippedObject(0)
	Stripped[32] = ItemRef
	_actorRef.UnequipItemEX(ItemRef, 2, false)
	; Strip armor slots
	int i = 31
	while i >= 0
		ItemRef = _actorRef.GetWornForm(Armor.GetMaskForSlot(i + 30))		
		_actorRef.UnequipItemEX(ItemRef, 0, false)
		Stripped[i] = ItemRef		

		i -= 1
	endWhile

	; Store stripped items
	; _equipment = PapyrusUtil.MergeFormArray(_equipment, PapyrusUtil.ClearNone(Stripped), true)

	return _equipment
endFunction

function UnStrip(actor _actorRef, Form[] _equipment)
 	if _actorRef == None
 		return
 	endIf
 	; Equip Stripped
 	int i = _equipment.Length

	if i == 34
		; Right hand
		if _equipment[33]
			_actorRef.EquipItemEx(_equipment[33], 1, false)
		endif 

		; Left hand
		if _equipment[32]
			_actorRef.EquipItemEx(_equipment[32], 2, false)
		endif

		i = 31
		while i
			i -= 1
			if _equipment[i]				
				_actorRef.EquipItemEx(_equipment[i], 0, false)
			endIf
		endWhile
	endif
endFunction

;------------------------------------------------------
; movePos Functions
;------------------------------------------------------
; 엑터 중심위치로 이동
function movePos (actor[] _actorsRef, actor _playerRef)
	; 엑터 대상 locking
	int idx = 0
	while idx < _actorsRef.length 
		LockActor(_actorsRef[idx], _playerRef)
		idx += 1
	endwhile

	; 엑터 씬 중심위치로 모든 엑터 이동
	ObjectReference bedRef = FindBed(_actorsRef[0], IgnoreUsed = false)

	if _actorsRef.length > 1
		idx = 1
	else 
		idx = 0
	endif

	if bedRef
		; bed 위치로 나머지 엑터 이동		
		while idx < _actorsRef.length 
			SetPosition(_actorsRef[idx], bedRef)
			idx += 1
		endwhile		
	else 
		; 첫번째 엑터 위치로 나머지 엑터 이동
		while idx < _actorsRef.length 
			SetPosition(_actorsRef[idx], _actorsRef[0])
			idx += 1
		endwhile
	endif
endFunction

;------------------------------------------------------
; Bed Functions
;------------------------------------------------------
ObjectReference function FindBed(ObjectReference CenterRef, float Radius = 1000.0, bool IgnoreUsed = true)	
	FormList BedsList = loadBedList()

	if !CenterRef || Radius < 1.0
		return none ; Invalid args
	endIf
	; Current elevation to determine bed being on same floor
	float Z = CenterRef.GetPositionZ()
	; Search a couple times for a nearby bed on the same elevation first before looking for random
	ObjectReference NearRef = Game.FindClosestReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
	if !NearRef || (SameFloor(NearRef, Z) && CheckBed(NearRef, IgnoreUsed))
		return NearRef
	endIf
	NearRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
	if !NearRef || (SameFloor(NearRef, Z) && CheckBed(NearRef, IgnoreUsed))
		return NearRef
	endIf
	NearRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
	if !NearRef || (SameFloor(NearRef, Z) && CheckBed(NearRef, IgnoreUsed))
		return NearRef
	endIf
	; Failover to any random useable bed
	form[] Suppressed = new Form[10]
	Suppressed[9] = NearRef
	int i = 7
	while i
		i -= 1
		ObjectReference BedRef = Game.FindRandomReferenceOfAnyTypeInListFromRef(BedsList, CenterRef, Radius)
		if !BedRef || (Suppressed.Find(BedRef) == -1 && CheckBed(BedRef, IgnoreUsed))
			return BedRef ; Found valid bed or none nearby and we should give up
		else
			Suppressed[i] = BedRef ; Add to suppression list
		endIf
	endWhile
	return none ; Nothing found in search loop
endFunction

bool function SameFloor(ObjectReference BedRef, float Z, float Tolerance = 5.0)
	return Math.Abs(Z - BedRef.GetPositionZ()) <= Tolerance
endFunction

bool function CheckBed(ObjectReference BedRef, bool IgnoreUsed = true)
	return BedRef && BedRef.IsEnabled() && BedRef.Is3DLoaded() && (!IgnoreUsed || (IgnoreUsed && IsBedAvailable(BedRef)))
endFunction

bool function IsBedAvailable(ObjectReference BedRef)
	; Check furniture use
	if !BedRef || BedRef.IsFurnitureInUse(true)
		return false
	endIf
	return true
endFunction

FormList function loadBedList()
	FormList BedsList
	if Game.GetModByName("Dawnguard.esm") != 255
		Form DLC1BedrollGroundF = Game.GetFormFromFile(0xC651, "Dawnguard.esm")
		if DLC1BedrollGroundF && !BedsList.HasForm(DLC1BedrollGroundF)
			BedsList.AddForm(DLC1BedrollGroundF)
		endIf
	endIf

	; Dragonborn additions
	if Game.GetModByName("Dragonborn.esm") != 255 && !BedsList.HasForm(Game.GetFormFromFile(0x21749, "Dragonborn.esm"))
		; Single Bed
		Form DLC2DarkElfBed01             = Game.GetFormFromFile(0x21749, "Dragonborn.esm")
		Form DLC2DarkElfBed01R            = Game.GetFormFromFile(0x35037, "Dragonborn.esm")
		Form DLC2DarkElfBed01L            = Game.GetFormFromFile(0x35038, "Dragonborn.esm")
		BedsList.AddForm(DLC2DarkElfBed01)
		BedsList.AddForm(DLC2DarkElfBed01R)
		BedsList.AddForm(DLC2DarkElfBed01L)
		; Double Bed
		Form DLC2DarkElfBedDouble01       = Game.GetFormFromFile(0x32802, "Dragonborn.esm")
		Form DLC2DarkElfBedDouble01R      = Game.GetFormFromFile(0x36796, "Dragonborn.esm")
		Form DLC2DarkElfBedDouble01L      = Game.GetFormFromFile(0x36797, "Dragonborn.esm")
		BedsList.AddForm(DLC2DarkElfBedDouble01)
		BedsList.AddForm(DLC2DarkElfBedDouble01R)
		BedsList.AddForm(DLC2DarkElfBedDouble01L)
		; Bedroll
		Form BedRollHay01LDirtSnowPath01F = Game.GetFormFromFile(0x18617, "Dragonborn.esm")
		Form BedRollHay01LDirtSnowPath01R = Game.GetFormFromFile(0x18618, "Dragonborn.esm")
		Form BedRollHay01LDirtSnowPath    = Game.GetFormFromFile(0x1EE28, "Dragonborn.esm")
		Form BedrollHay01IceL             = Game.GetFormFromFile(0x25E51, "Dragonborn.esm")
		Form BedrollHay01IceR             = Game.GetFormFromFile(0x25E52, "Dragonborn.esm")
		Form BedrollHay01R_Ash            = Game.GetFormFromFile(0x28A68, "Dragonborn.esm")
		Form BedrollHay01L_Ash            = Game.GetFormFromFile(0x28AA9, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01L     = Game.GetFormFromFile(0x2C0B2, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01F     = Game.GetFormFromFile(0x2C0B3, "Dragonborn.esm")
		Form BedrollHay01LDirtPath01R     = Game.GetFormFromFile(0x2C0B4, "Dragonborn.esm")
		Form BedrollHay01GlacierL         = Game.GetFormFromFile(0x3D131, "Dragonborn.esm")
		Form BedrollHay01GlacierR         = Game.GetFormFromFile(0x3D132, "Dragonborn.esm")
		BedsList.AddForm(BedRollHay01LDirtSnowPath01F)
		BedsList.AddForm(BedRollHay01LDirtSnowPath01R)
		BedsList.AddForm(BedRollHay01LDirtSnowPath)
		BedsList.AddForm(BedrollHay01IceL)
		BedsList.AddForm(BedrollHay01IceR)
		BedsList.AddForm(BedrollHay01R_Ash)
		BedsList.AddForm(BedrollHay01L_Ash)
		BedsList.AddForm(BedrollHay01LDirtPath01L)
		BedsList.AddForm(BedrollHay01LDirtPath01F)
		BedsList.AddForm(BedrollHay01LDirtPath01R)
		BedsList.AddForm(BedrollHay01GlacierL)
		BedsList.AddForm(BedrollHay01GlacierR)
	endIf

	return BedsList
endFunction

;------------------------------------------------------
; Lock/Unlock Functions
;------------------------------------------------------
function LockActor(Actor _actorRef, Actor _playerRef)

	if (_actorRef == _playerRef)
		Game.ForceThirdPerson()
		Game.DisablePlayerControls(true, true, true, false, true, true, true, false, 0)
	else
		_actorRef.SetRestrained(True)
		_actorRef.SetDontMove(True)		; Prevent any NPC's from being pushed. Do not use on Player.
		_actorRef.SetAlert(False)		; Clears any alerts from the npc.
	endIf
	
	_actorRef.EvaluatePackage()
	_actorRef.ClearKeepOffsetFromActor()
	_actorRef.SetHeadTracking(False)
endFunction

function UnlockActor(Actor _actorRef, Actor _playerRef)
		
	_actorRef.StopTranslation()
	_actorRef.SetVehicle(NONE)
	Utility.Wait(1.0)		; Delay to allow SetVehicle to rescale the actor.

	; Adding a temporary expression override here to reset face manually to neutral.
	_actorRef.SetExpressionOverride(7, 100)

	if (_actorRef == _playerRef)
		Game.EnablePlayerControls()
	else	
		_actorRef.SetRestrained(False)
		_actorRef.SetDontMove(False)	
		_actorRef.SetHeadTracking(True)
	endIf
	
	_actorRef.EvaluatePackage()
	
	; Now clear the expression override applied earlier.
	_actorRef.ClearExpressionOverride()
endFunction