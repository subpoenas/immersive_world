Scriptname dxFlowerGirlsMod extends Quest Conditional
{Contains the maintainence code for the FG mod.}

dxFlowerGirlsScript Property FlowerGirls Auto
{Accessor for the main FG script.}

Actor Property PlayerRef Auto
{Specifc reference to the Player actor.}

Actor Property FlowerGirlActor Auto
{This is used as part of the work around for a SE bug in assigning empty factions as NONE.}

Quest Property MainFlowerGirlsQuest  Auto
Quest Property ThreadManagerQuest Auto
Quest Property FlowerGirlsFavorJobsBeggars Auto
Quest Property SeductionQuest Auto
Quest Property FlowerGirlsArrestQuest Auto
Quest Property FlowerGirlsPostSexQuest Auto
Quest Property FlowerGirlsNpcSceneQuest Auto
Quest Property FlowerGirlsSexCommentsQuest Auto
Quest Property FlowerGirlsMCM Auto

Faction Property ThreewayFaction Auto
{Faction used for setting up threesome participants.}
Faction Property SeductionFaction Auto
{Faction used for the seduction mechanism in Flower Girls.}
Faction Property AmorousFaction  Auto  
{Faction used to hold actors used by Amorous Adventures.}
Faction Property AnimatingFaction Auto
{Faction added for compatibility to SL based mods to offer equivalence.}
Faction Property FollowMeFaction Auto
{Faction used to have NPC's follow the player.}

Spell Property FlowerGirlsOptionsSpell Auto
{The spell for setting Options for the Flower Girls mod.}
Spell Property BewitchedSpell Auto
{Fun spell for temporarily turning an NPC into a working girl.}
Spell Property FornicateSpell Auto
{Fun spell to pair actors to trigger a randomized scene.}
Spell Property SeductionSpell Auto
{Spell to make a targeted actor a member of the seduction faction.}
Spell Property SoloSelfSpell Auto
{Spell to make the Player actor masturbate.}

Message Property MsgInstalled Auto
Message Property MsgRestart Auto
Message Property MsgUninstallSuccess Auto
Message Property MsgVrDetected Auto

ReferenceAlias Property AliasLoveInterest Auto
ReferenceAlias Property MarriedLover Auto

dxAmorousInstallScript Property AmorousInstallScript Auto 

Quest[] Property RestartQuests Auto
{Used in maintenance code to cycle these quests to ensure no problems occur in an existing save game.}

bool Property AmorousAdventuresInstalled = False Auto Conditional Hidden
bool Property OsaInstalled = False Auto Hidden Conditional
bool Property PapyrusUtilsInstalled = False Auto Hidden

string Property Version = "3.0.2" AutoReadOnly Hidden

bool amorousActorsInstalled = false
float _version						; Stored version.

; Fires once rather than the Event
Function OnInit()
	
	Debug.Trace(Self + " FlowerGirls Mod initializing")
	AddFlowerGirlSpells()
	MsgInstalled.Show()
	
	RegisterForSingleUpdate(10.0)
	
endFunction

Event OnUpdate()
	UnregisterForUpdate()

	; Add the player to the factions
	if !(PlayerREF.IsInFaction(FollowMeFaction))
		PlayerREF.AddToFaction(FollowMeFaction)
	endIf
	if !(PlayerREF.IsInFaction(ThreewayFaction))
		PlayerREF.AddToFaction(ThreewayFaction)
	endIf	
	
	; Remove player from factions to prevent stealing bug.
	if (PlayerREF.IsInFaction(SeductionFaction))
		PlayerREF.RemoveFromFaction(SeductionFaction)
	endIf
	if (PlayerREF.IsInFaction(AmorousFaction))
		PlayerREF.RemoveFromFaction(AmorousFaction)
	endIf
	
	; Hack to solve bug with SE making Factions NONE.
	if (FlowerGirlActor.IsInFaction(FollowMeFaction))
		FlowerGirlActor.RemoveFromFaction(FollowMeFaction)
	endIf
	
	if (FlowerGirlActor.IsInFaction(ThreewayFaction))
		FlowerGirlActor.RemoveFromFaction(ThreewayFaction)
	endIf
	
	if (FlowerGirlActor.IsInFaction(SeductionFaction))
		FlowerGirlActor.RemoveFromFaction(SeductionFaction)
	endIf
	
	if (FlowerGirlActor.IsInFaction(AmorousFaction))
		FlowerGirlActor.RemoveFromFaction(AmorousFaction)
	endIf
	
	if (FlowerGirlActor.IsInFaction(AnimatingFaction))
		FlowerGirlActor.RemoveFromFaction(AnimatingFaction)
	endIf
	
endEvent

;---------------------------------------------------------------------------------
; CheckUpdate(): Called from the PlayerRef Alias OnPlayerLoadGame().
; 	Checks our stored version against the current version and if they do
;	not match executes the restart code.
;---------------------------------------------------------------------------------
Function CheckUpdate()
	if (_version < 3.02)
		RestartFlowerGirls()
		_version = 3.02
	else
		RunCompatabilityCheck()
	endIf	
endFunction

Function AddFlowerGirlSpells()
	
	if (FlowerGirls.FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.GetValueInt())
		if !(PlayerREF.HasSpell(BewitchedSpell))
			PlayerREF.AddSpell(BewitchedSpell, True)
		endIf
		if !(PlayerREF.HasSpell(FornicateSpell))
			PlayerREF.AddSpell(FornicateSpell, True)
		endIf
		if !(PlayerREF.HasSpell(SeductionSpell))
			PlayerREF.AddSpell(SeductionSpell, True)
		endIf
		if !(PlayerRef.HasSpell(SoloSelfSpell))
			PlayerRef.AddSpell(SoloSelfSpell, True)
		endIf
	endIf
	
endFunction

Function RemoveFlowerGirlSpells()

	if (PlayerREF.HasSpell(FlowerGirlsOptionsSpell))
		PlayerREF.RemoveSpell(FlowerGirlsOptionsSpell)
	endIf
	if (PlayerREF.HasSpell(BewitchedSpell))
		PlayerREF.RemoveSpell(BewitchedSpell)
	endIf
	if (PlayerREF.HasSpell(FornicateSpell))
		PlayerREF.RemoveSpell(FornicateSpell)
	endIf
	if (PlayerREF.HasSpell(SeductionSpell))
		PlayerREF.RemoveSpell(SeductionSpell)
	endIf
	if (PlayerRef.HasSpell(SoloSelfSpell))
		PlayerRef.RemoveSpell(SoloSelfSpell)
	endIf
	
endFunction

Function RemoveOptionalSpells()
	if (PlayerREF.HasSpell(BewitchedSpell))
		PlayerREF.RemoveSpell(BewitchedSpell)
	endIf
	if (PlayerRef.HasSpell(FornicateSpell))
		PlayerREF.RemoveSpell(FornicateSpell)
	endIf
	if (PlayerREF.HasSpell(SeductionSpell))
		PlayerREF.RemoveSpell(SeductionSpell)
	endIf
	if (PlayerRef.HasSpell(SoloSelfSpell))
		PlayerRef.RemoveSpell(SoloSelfSpell)
	endIf
	Debug.Notification("$FG_NOTI_RemovedOptional")
endFunction

Function RestartFlowerGirls()

	MsgRestart.Show()

	if (FlowerGirlsFavorJobsBeggars.IsRunning())
		FlowerGirlsFavorJobsBeggars.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsArrestQuest.IsRunning())
		FlowerGirlsArrestQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsPostSexQuest.IsRunning())
		FlowerGirlsPostSexQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (SeductionQuest.IsRunning())
		SeductionQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsNpcSceneQuest.IsRunning())
		FlowerGirlsNpcSceneQuest.Reset()
		FlowerGirlsNpcSceneQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsSexCommentsQuest.IsRunning())
		FlowerGirlsSexCommentsQuest.Reset()
		FlowerGirlsSexCommentsQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (ThreadManagerQuest.IsRunning())
		ThreadManagerQuest.Reset()
		ThreadManagerQuest.Stop()
		Utility.Wait(2.0)
	endIf
	
	if (MainFlowerGirlsQuest.IsRunning())
		MainFlowerGirlsQuest.Stop()
		Utility.Wait(2.0)
	endIf	
	
	if (PlayerREF.IsInFaction(ThreewayFaction))
		PlayerREF.SetFactionRank(ThreewayFaction, 0)
	endIf
	
	if (PlayerREF.IsInFaction(FollowMeFaction))
		PlayerREF.SetFactionRank(FollowMeFaction, 0)
	endIf
	
	ThreadManagerQuest.Start()
	MainFlowerGirlsQuest.Start()
	FlowerGirlsFavorJobsBeggars.Start()
	FlowerGirlsSexCommentsQuest.Start()
	SeductionQuest.Start()
	SeductionQuest.SetStage(0)
		
	Utility.Wait(1.0)
	
	if (version < 2.00)
		int i = RestartQuests.Length
		while (i > 0)
			i -= 1
			RestartQuests[i].Stop()
			Utility.Wait(1.0)
			RestartQuests[i].Start()
			Debug.Trace(Self + " Maintainence: Restarted quest: " + RestartQuests[i])
			Utility.Wait(1.0)
		endWhile
	endIf
	
	; Check if player is married yet our local alias is empty.
	if (AliasLoveInterest.GetActorReference() == NONE)
		if (MarriedLover.GetActorReference())
			AliasLoveInterest.ForceRefTo(MarriedLover.GetActorReference())
		else
			Debug.Trace(Self + " Maintainence: Player is unmarried.")
		endIf
	endIf
	
	amorousActorsInstalled = false
	RunCompatabilityCheck()
	
endFunction

Function UninstallFlowerGirls()

	RemoveFlowerGirlSpells()
	
	if (FlowerGirlsFavorJobsBeggars.IsRunning())
		FlowerGirlsFavorJobsBeggars.Reset()
		FlowerGirlsFavorJobsBeggars.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsArrestQuest.IsRunning())
		FlowerGirlsArrestQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsPostSexQuest.IsRunning())
		FlowerGirlsPostSexQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (FlowerGirlsNpcSceneQuest.IsRunning())
		FlowerGirlsNpcSceneQuest.Reset()
		FlowerGirlsNpcSceneQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (ThreadManagerQuest.IsRunning())
		ThreadManagerQuest.Reset()
		ThreadManagerQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (MainFlowerGirlsQuest.IsRunning())
		MainFlowerGirlsQuest.Reset()
		MainFlowerGirlsQuest.Stop()
		Utility.Wait(1.0)
	endIf
	
	if (SeductionQuest.IsRunning())
		SeductionQuest.Reset()
		SeductionQuest.Stop()
		Utility.Wait(1.0)
	endIf
		
	MsgUninstallSuccess.Show()
	Debug.Trace(Self + " UninstallFlowerGirls() successfully completed")
endFunction

Function RunCompatabilityCheck()
	
	; Check if SKSE64 is available
	if (0 < SKSE.GetVersion())
		Debug.Trace(Self + " SKSE64 is available.")
		if (0 < PapyrusUtil.GetVersion())
			Debug.Trace(Self + " PapyrusUtils is available.")
			PapyrusUtilsInstalled = True
		endIf
		
		SKI_ConfigBase skyUI = Game.GetFormFromFile(0x000820, "SkyUI_SE.esp") as SKI_ConfigBase
		if (0 < skyUI.GetVersion())
			Debug.Trace(Self + " SkyUI is available. Launching MCM")
			FlowerGirls.FlowerGirlsConfig.DX_SKSE_AVAILABLE.SetValueInt(1)
			if (FlowerGirlsMCM.IsRunning() == False)
				FlowerGirlsMCM.Start()
				if (PlayerREF.HasSpell(FlowerGirlsOptionsSpell))
					PlayerREF.RemoveSpell(FlowerGirlsOptionsSpell)
				endIf
			endIf
		else
			Debug.Trace(Self + " SkyUI is not available.")
			FlowerGirls.FlowerGirlsConfig.DX_SKSE_AVAILABLE.SetValueInt(0)
			if (FlowerGirlsMCM.IsRunning())
				Debug.Trace(Self + " Stopping FlowerGirlsMCM Menu.")
				FlowerGirlsMCM.Stop()
				if !(PlayerREF.HasSpell(FlowerGirlsOptionsSpell))
					PlayerREF.AddSpell(FlowerGirlsOptionsSpell, True)
				endIf
			endIf
		endIf
	else
		Debug.Trace(Self + " SKSE64 is not available.")
		FlowerGirls.FlowerGirlsConfig.DX_SKSE_AVAILABLE.SetValueInt(0)
		if (FlowerGirlsMCM.IsRunning())
			Debug.Trace(Self + " Stopping FlowerGirlsMCM Menu.")
			FlowerGirlsMCM.Stop()
		endIf
		if !(PlayerREF.HasSpell(FlowerGirlsOptionsSpell))
			PlayerREF.AddSpell(FlowerGirlsOptionsSpell, True)
		endIf
	endIf
	
	; Amorous Adventures
	bool b = Game.GetFormFromFile(0x014B6A, "SexLab-AmorousAdventures.esp")
	AmorousAdventuresInstalled = b
	AmorousInstallScript.Start()
	Utility.Wait(1.0)
	if ( b )
		if (amorousActorsInstalled == False)
			AmorousInstallScript.ApplyFGFaction()
			amorousActorsInstalled = True
		endIf
	else
		if (amorousActorsInstalled)
			AmorousInstallScript.RemoveFGFaction()
			amorousActorsInstalled = False
		endIf
	endIf
	
	; Lake Haven
	Form frm = Game.GetFormFromFile(0x0764FC, "LakeHaven.esp")
	if ( frm )
		FlowerGirls.FlowerGirlsConfig.PermittedFurnitureBeds.AddForm(frm)
		Debug.Trace(Self + " Compatible Mod Detected: LakeHaven.esp")
	endIf
	
	; VR Mode detection
	if (FlowerGirls.FlowerGirlsConfig.DX_VR_Mode.GetValueInt() == 0)
		frm = Game.GetFormFromFile(0x0008F3, "SkyrimVR.esm")
		if ( frm )
			FlowerGirls.FlowerGirlsConfig.DX_VR_Mode.SetValueInt(1)
			MsgVrDetected.Show()
		endIf
	endIf
	
	; OSA Detection
	OsaInstalled = False
	if (OSA.moduleExists("0Sex"))
		OsaInstalled  = True
		Debug.Trace(Self + " Compatible Mod Detected: OSex")
	else
		Debug.Trace(Self + " OSex not detected.")
	endIf
	
endFunction

Function AddFlowerGirlsBed(Furniture bed)
	AddFurnitureToList(bed, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureBeds)
endFunction

Function AddFlowerGirlsBeds(Furniture[] beds)
	AddFurnituresToList(beds, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureBeds)
endFunction

Function AddFlowerGirlsChair(Furniture chair)
	AddFurnitureToList(chair, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureChairs)
endFunction

Function AddFlowerGirlsChairs(Furniture[] chairs)
	AddFurnituresToList(chairs, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureChairs)
endFunction

Function AddFlowerGirlsTable(Furniture table)
	AddFurnitureToList(table, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureTables)
endFunction

Function AddFlowerGirlsTables(Furniture[] tables)
	AddFurnituresToList(tables, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureTables)
endFunction

Function AddFlowerGirlsThrone(Furniture throne)
	AddFurnitureToList(throne, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureThrones)
endFunction

Function AddFlowerGirlsThrones(Furniture[] thrones)
	AddFurnituresToList(thrones, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureThrones)
endFunction

Function AddFlowerGirlsWorkbench(Furniture workbench)
	AddFurnitureToList(workbench, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureWorkbenches)
endFunction

Function AddFlowerGirlsWorkbenches(Furniture[] workbenches)
	AddFurnituresToList(workbenches, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureWorkbenches)
endFunction

Function AddFlowerGirlsAlchemyBench(Furniture alchemyBench)
	AddFurnitureToList(alchemyBench, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureWorkbenchesAlch)
endFunction

Function AddFlowerGirlsAlchemyBenches(Furniture[] alchemyBenches)
	AddFurnituresToList(alchemyBenches, FlowerGirls.FlowerGirlsConfig.PermittedFurnitureWorkbenchesAlch)
endFunction

Function AddFurnitureToList(Furniture furnitureForm, FormList list)
	if (furnitureForm && list)
		bool bAdd = True
		int i = list.GetSize()
		while(i > 0 && bAdd)
			i -= 1
			if (list.GetAt(i) == furnitureForm)
				bAdd = False
			endIf
		endWhile
		if (bAdd)
			list.AddForm(furnitureForm)
		else
			Debug.Trace(Self + "AddFurnitureToList(): NOTICE: Furniture item: " + furnitureForm + " is already in the list. No change.")
		endIf
	else
		Debug.Trace(Self + " AddFurnitureToList(): ERROR: The supplied Furniture form or specified FormList is NONE.")
	endIf
endFunction

Function AddFurnituresToList(Furniture[] furnitureForms, FormList list)
	if (furnitureForms && list)
		int i = furnitureForms.Length
		while (i > 0)
			i -= 1
			AddFurnitureToList(furnitureForms[i], list)
		endWhile
	else
		Debug.Trace(Self + " AddFurnituresToList(): ERROR: The supplied Furniture forms or specified FormList is NONE.")
	endIf
endFunction
