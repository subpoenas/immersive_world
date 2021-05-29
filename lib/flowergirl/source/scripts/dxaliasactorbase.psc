Scriptname dxAliasActorBase extends ReferenceAlias  

Actor Property PlayerREF Auto
{Added here for performance reasons (so compiler can optimize).}

dxFlowerGirlsScript Property FlowerGirlsScript Auto
dxFlowerGirlsConfig Property FlowerGirlsConfig Auto

bool Property DebugMode = False Auto Hidden
{Sets whether we are using Debug Mode for trace output.}
bool Property UseStrapOn = True Auto Hidden
{Gets whether to use strap-on for female characters.}
bool Property UseStrapOnCbbe = False Auto Hidden
{Gets whether to use CBBE strap-on for female characters.}
bool Property StripPlayer = True Auto Hidden
{Gets whether we should strip the player or not according to user settings.}
bool Property StripNpc = True Auto Hidden
{Gets whether we should strip the npc or not according to user settings.}
Bool Property StripOnly = False Auto  
{Used when just toggling stripping for this reference.}
bool Property IsDomRole = False Auto Hidden
{Sets whether the actor is in the dominant role.}
bool Property	IsVRActor = False Auto Hidden
{This actor is the player and is using or not using the clone for VR mode.}
ObjectReference Property	VRPartnerRef = NONE Auto Hidden

Actor _actorRef = NONE
Actor Property ActorRef Hidden
{Actor reference in this alias.}
	Actor Function Get()
		if (_actorRef == NONE)
			_actorRef = GetActorReference()
		endIf
		return _actorRef
	endFunction
endProperty

int _gender = -1
int Property Gender Hidden 
	int Function Get()
		if (_gender < 0)
			if (GetActorReference() == PlayerRef)
				int overrideGender = FlowerGirlsConfig.DX_OVERRIDE_GENDER.GetValueInt()
				if (overrideGender == 1)
					_gender = 0
				elseIf (overrideGender == 2)
					_gender = 1
				else
					_gender = GetActorReference().GetLeveledActorBase().GetSex()
				endIf
			else
				_gender = GetActorReference().GetLeveledActorBase().GetSex()
			endIf			
		endIf
		return _gender
	endFunction
endProperty

bool _isPlayer = False
int _isPlayerChecked = -1
bool Property IsPlayer Hidden
	bool Function Get()
		if (_isPlayerChecked < 0)
			_isPlayer = (ActorRef == PlayerRef)
			_isPlayerChecked = 1		
		endIf
		return _isPlayer
	endFunction
endProperty

Armor[] ArmorSlots															; Cache for unequiped armor
Weapon[] WeaponSlots													; Cache for unequiped weapons

bool 				 		isMonitoringEquipment = False

;------------------------------------------------------------------
; Options for the scene
;------------------------------------------------------------------
bool Property 		HideStrapOn = False Auto Hidden				; Over-ride the user settings to hide the strap-on.
bool Property 		NoStrip = False Auto Hidden					; Over-ride the user settings to disable stripping.
bool Property		IsRestrained = False Auto Hidden				; Specifies whether the actor is restrained or not.
bool Property		IsEjaculating = False Auto Hidden				; Flag to indicate that the actor is currently ejaculating.

Function JustNakedStrip()
	StartMonitoring()	; Start equipment monitoring for the actor.	
	UndressActor()
endFunction

Function JustNakedRedress()
	RedressActor()
	StopMonitoring()		; Stop monitoring equipment for this actor.
endFunction

Function StopMonitoring()
	isMonitoringEquipment = False		
	ClearEquipmentCache()
	DebugThis("StopMonitoring()", "Stopped monitoring equipment. Cleared armor/clothing cache.")	
endFunction

Function StartMonitoring()
	if (NoStrip)
		return 	; Don't monitor because NoStrip is on.
	endIf
	isMonitoringEquipment = True
	DebugThis("StartMonitoring()", "Started equipment monitoring")
endFunction

Function ClearEquipmentCache()
	ArmorSlots = new Armor[15]
	WeaponSlots = new Weapon[2]
	;SpellSlots = new Spell[2]
endFunction

Function UndressActor()
	if (NoStrip)
		DebugThis("UndressActor()", "NoStrip is TRUE.")
		return ; Skip the function because stripping off for this scene.
	endIf
	if (IsPlayer)
		if (StripPlayer)
			DebugThis("UndressActor()", "Unequipping Player actor.")
			ActorRef.UnequipAll()
			
			if (CheckUseStrapOn())		
				if (UseStrapOnCbbe)
					ActorRef.AddItem(FlowerGirlsConfig.StrapOnArmorCBBE, 1, True)
					ActorRef.EquipItem(FlowerGirlsConfig.StrapOnArmorCBBE, False, True)
				else
					ActorRef.AddItem(FlowerGirlsConfig.StrapOnArmor, 1, True)
					ActorRef.EquipItem(FlowerGirlsConfig.StrapOnArmor, False, True)
				endIf
			endIf
			
			if (IsRestrained)
				ActorRef.AddItem(FlowerGirlsConfig.PrisonerCuffs, 1, True)
				ActorRef.EquipItem(FlowerGirlsConfig.PrisonerCuffs, False, True)
			endIf			
		endIf
	else
		if (StripNpc)
			DebugThis("UndressActor()", "Unequipping NPC actor.")
			ActorRef.UnequipAll()
			Utility.Wait(0.1)
			ActorRef.UnequipAll()
			
			bool strapOn = CheckUseStrapOn()
			if (strapOn || IsRestrained)
				isMonitoringEquipment = False
				
				if (strapOn)
					; Equip the Strap-On
					if (UseStrapOnCbbe)
						ActorRef.AddItem(FlowerGirlsConfig.StrapOnArmorCBBE, 1, True)
						ActorRef.EquipItem(FlowerGirlsConfig.StrapOnArmorCBBE, True, True)
					else
						ActorRef.AddItem(FlowerGirlsConfig.StrapOnArmor, 1, True)
						ActorRef.EquipItem(FlowerGirlsConfig.StrapOnArmor, True, True)
					endIf
				endIf
				
				if (IsRestrained)
					ActorRef.AddItem(FlowerGirlsConfig.PrisonerCuffs, 1, True)
					ActorRef.EquipItem(FlowerGirlsConfig.PrisonerCuffs, False, True)
				endIf				
			endIf			
		endIf		
	endIf
	
	if (StripPlayer || StripNpc)
		
		if (ArmorSlots.Length > 0)
			int idx = 0
			while (idx < ArmorSlots.Length)
				Armor _armor = ArmorSlots[idx]
				if (_armor != NONE)							
					if (_armor.HasKeyword(FlowerGirlsConfig.WearWhenStrippedKeyword))
						DebugThis("UndressActor()", "Armor has WearWhenStrippedKeyword: " + _armor + ": Not unequiped.")
						if (ActorRef.IsEquipped(_armor) == False)
							isMonitoringEquipment = False
							ActorRef.EquipItem(_armor, True, True)
						endIf
					else
						DebugThis("UndressActor()", "Unequipping armor item: " + _armor)
						ActorRef.UnEquipItem(_armor, 1, true)
					endIf
				endIf
				idx += 1
			endWhile
		endIf				
		
		if (WeaponSlots.Length > 0)
			int idx = 0
			while (idx < WeaponSlots.Length)
				Weapon _weapon = WeaponSlots[idx]
				if (_weapon != NONE)
					DebugThis("UndressActor()", "Unequipping weapon item: " + _weapon)
					ActorRef.UnEquipItem(_weapon, 1, true)
				endIf
				idx += 1
			endWhile
		endIf
	endIf

endFunction

Function RedressActor()	
	if (NoStrip)
		return ; Skip the function because stripping off for this scene.
	endIf
	
	DebugThis("RedressActor()", "RedressActor started...")
	
	isMonitoringEquipment = False	
	bool bLock = false
	
	if (IsPlayer)	
		if (CheckUseStrapOn())
			DebugThis("RedressActor()", "Strap On used so removing")
			if (UseStrapOnCbbe)
				int iCount = PlayerRef.GetItemCount(FlowerGirlsConfig.StrapOnArmorCBBE)
				if (iCount > 0)
					PlayerRef.RemoveItem(FlowerGirlsConfig.StrapOnArmorCBBE, iCount, True)
				endIf
			else
				int iCount = PlayerRef.GetItemCount(FlowerGirlsConfig.StrapOnArmor)
				if (iCount > 0)
					PlayerRef.RemoveItem(FlowerGirlsConfig.StrapOnArmor, iCount, True)
				endIf
			endIf
		endIf
	else
		if (StripNpc)
			if (CheckUseStrapOn())
				DebugThis("RedressActor()", "Strap On used so removing")
				if (UseStrapOnCbbe)
					ActorRef.RemoveItem(FlowerGirlsConfig.StrapOnArmorCBBE, 1, True)
				else
					ActorRef.RemoveItem(FlowerGirlsConfig.StrapOnArmor, 1, True)
				endIf
			endIf			
			bLock = True
		else
			return	; No need to equip as strip is off for npc's
		endIf
	endIf
	
	StopEjaculating()
		
	if (IsRestrained)
		ActorRef.RemoveItem(FlowerGirlsConfig.PrisonerCuffs, 1, True)
	endIf
	
	DebugThis("RedressActor()", "Equiping from cache...")
	
	if (ArmorSlots.Length > 0)
		int idx = 0
		while (idx < ArmorSlots.Length)
			Armor _armor = ArmorSlots[idx]
			if (_armor != NONE)
				ActorRef.EquipItem(_armor, bLock, true)
				DebugThis("RedressActor()", "Equiping item: " + _armor)
			endIf
			idx += 1
		endWhile
	endIf	
	if (WeaponSlots.Length > 0)
		int idx = 0
		while (idx < WeaponSlots.Length)
			Weapon _weapon = WeaponSlots[idx]
			if (_weapon != NONE)
				ActorRef.EquipItem(_weapon, bLock, true)
				DebugThis("RedressActor()", "Equiping item: " + _weapon)
			endIf
			idx += 1
		endWhile
	endIf
	
	if (StripOnly)
		ActorRef.AddItem(FlowerGirlsConfig.StripOnlyArmor, 1, true)
		Utility.Wait(1.0)
		ActorRef.RemoveItem(FlowerGirlsConfig.StripOnlyArmor)
		DebugThis("RedressActor()", "StripOnly is true so executing Skyrim bug fix for default outfits.")
	endIf
	
	DebugThis("RedressActor()", "Equipped from cache.")
endFunction

bool Function CheckUseStrapOn()
	if (Gender == 1)
		return (UseStrapOn && HideStrapOn == False && IsDomRole && StripOnly == False)	
	endIf
	return False
endFunction

Function StopEjaculating()
	if (IsEjaculating)
		int iCount = ActorRef.GetItemCount(FlowerGirlsConfig.EjaculationEffect)
		if (iCount > 0)
			isMonitoringEquipment = False
			ActorRef.RemoveItem(FlowerGirlsConfig.EjaculationEffect, iCount, True)
		endIf
		IsEjaculating = False
	endIf
endFunction

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if (isMonitoringEquipment == False)
		DebugThis("OnObjectUnequipped()", "isMonitoringEquipment is FALSE.")
		return
	endIf
		
	DebugThis("OnObjectUnequipped()", "Monitoring unequiped item: " + akBaseObject)
	if (akBaseObject as Armor)		
		AddArmorToCache(akBaseObject as Armor)	
	elseIf (akBaseObject as Weapon)
		AddWeaponToCache(akBaseObject as Weapon)			
	endIf		
endEvent

Function AddArmorToCache(Armor armorItem)
	bool search = True
	int idx = 0
	while (idx < ArmorSlots.Length && search)
		if (ArmorSlots[idx] == NONE)
			ArmorSlots[idx] = armorItem
			search = False
		endIf
		idx += 1
	endWhile
endFunction

Function AddWeaponToCache(Weapon weaponItem)
	bool search = True
	int idx = 0
	while (idx < WeaponSlots.Length && search)
		if (WeaponSlots[idx] == NONE)
			WeaponSlots[idx] = weaponItem
			search = False
		endIf
		idx += 1
	endWhile
endFunction

Function DebugThis(string sCaller, string sOutput)
	if (DebugMode)
		Debug.Trace(Self + " Actor: " + ActorRef + " " + sCaller + ":" + " Output: " + sOutput)
	endIf
endFunction

Function Clear()
	_actorRef = NONE
	_gender = -1
	_isPlayerChecked = -1
	isMonitoringEquipment = False
	VRPartnerRef = NONE
	HideStrapOn = False
	NoStrip = False
	IsRestrained = False
	IsEjaculating = False
	
	Parent.Clear()
endFunction