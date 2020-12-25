Scriptname _BS_BodySearch extends Quest Conditional

_BS_MCM Property MCM Auto
Actor Property PlayerRef Auto
ReferenceAlias Property GuardRA Auto
ReferenceAlias Property PlayerMarkerRA Auto
ReferenceAlias Property FollowerMarkerRA Auto
ReferenceAlias Property EvidenceChestRA Auto
ReferenceAlias[] Property GuardRAs Auto
ReferenceAlias[] Property FollowerRAs Auto
CrimeGuardsScript Property DialogueCrimeGuards Auto
GlobalVariable Property _BS_SpeechCheck Auto
GlobalVariable Property _BS_SpeechCheckEasy Auto
GlobalVariable Property _BS_SpeechCheckHard Auto
GlobalVariable Property _BS_NextAllowed Auto
GlobalVariable Property _BS_NumLockpickThreshold Auto
Scene Property _BS_BodySearchScene Auto
Scene Property _BS_InspectionScene Auto
Faction Property _BS_CrimeFaction Auto
ObjectReference Property _BS_EvidenceChestStolenGoodsREF Auto
ObjectReference Property _BS_HiddenPocketChestREF Auto
ObjectReference Property _BS_UnownedChestREF Auto
ObjectReference Property _BS_FollowersChestREF Auto
Quest Property _BS_FindFollowersQuest Auto
MiscObject Property Gold001 Auto
MiscObject Property Lockpick Auto
Potion Property Skooma Auto
Keyword Property ArmorCuirass Auto
Keyword Property ClothingBody Auto
int Property NumStolenGoods Auto Conditional Hidden
int Property NumSkooma Auto Conditional Hidden
int Property NumLockpick Auto Conditional Hidden
int Property NumFollowerStolenGoods Auto Conditional Hidden
int Property NumFollowerSkooma Auto Conditional Hidden
int Property NumFollowerLockpick Auto Conditional Hidden
int Property NumFollower Auto Conditional Hidden
bool Property IsFollowerFemale Auto Conditional Hidden
bool Property NakedBodySearch Auto Conditional Hidden
bool Property HiddenPocketSearch Auto Conditional Hidden
bool Property HiddenPocketHasItems Auto Conditional Hidden
bool Property FollowerAliasesFilled Auto Hidden

; Dialogue options
bool Property DonePersuade Auto Conditional Hidden
bool Property DoneThane Auto Conditional Hidden

; Thane
bool Property IsThane Auto Conditional Hidden
FavorJarlsMakeFriendsScript Property FavorJarlsMakeFriends Auto
Faction Property CWSonsFaction Auto
Faction Property CWImperialFaction Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionRift Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionHjaalmarch Auto
Faction Property CrimeFactionPale Auto
Faction Property CrimeFactionWinterhold Auto
Faction Property CrimeFactionFalkreath Auto

; Thieves Guild Quest Items
ReferenceAlias[] Property TGRStolenGoodsRA Auto

float Property WAIT_REMOVEITEMS = 0.2 AutoReadOnly
float Property WAIT_PAYCRIME = 1.0 AutoReadOnly

int fillCount
Actor guard
ObjectReference playerMarker
ObjectReference guardMarker
ObjectReference followerMarker
float totalBounty
float totalBountyFollower
bool totalBountyFollowerAdded
bool isThaneCalculated

SexLabFramework SexLab
sslThreadSlots ThreadSlots
sslAnimationSlots AnimSlots

Event OnInit()
	if !MCM.Enabled
		Stop()
		return
	endif

	bool debugOutputEnabled = MCM.DebugOutputEnabled

	fillCount = 0
	guard = GuardRA.GetReference() as Actor
	playerMarker = PlayerMarkerRA.GetReference()
	if playerMarker
		guardMarker = PlayerMarker.GetLinkedRef()
	endif
	followerMarker = FollowerMarkerRA.GetReference()
	if debugOutputEnabled
		Debug.Trace("[BS] BodySearch start: guard=" + guard + ": playerMarker=" + playerMarker + ": guardMarker=" + guardMarker + ": followerMarker=" + followerMarker)
	endif
	if !playerMarker || !guardMarker || !followerMarker
		if debugOutputEnabled
			Debug.Trace("[BS] BodySearch stop")
		endif
		Stop()
		return
	endif

	FollowerAliasesFilled = false

	DonePersuade = false
	DoneThane = false

	IsThane = false
	isThaneCalculated = false
	if guard
		CalculateIsThane(guard)
	endif

	SexLab = Game.GetFormFromFile(0x00000d62, "SexLab.esm") as SexLabFramework
	ThreadSlots = Game.GetFormFromFile(0x00000d62, "SexLab.esm") as sslThreadSlots
	AnimSlots = Game.GetFormFromFile(0x000639df, "SexLab.esm") as sslAnimationSlots

	UpdateSpeechCheck()

	NakedBodySearch = false
	HiddenPocketSearch = false
	HiddenPocketHasItems = false

	StartGuardForcegreet()
EndEvent

Event OnStageStart(int tid, bool HasPlayer)
	Debug.Trace("[BS] OnStageStart")
	sslThreadController controller = SexLab.GetController(tid)
	if HiddenPocketSearch && controller.Stage < 3
		controller.GoToStage(3)
	endif
EndEvent

Event OnStageEnd(int tid, bool HasPlayer)
	sslThreadController controller = SexLab.GetController(tid)
	if controller.Stage >= 3
		if !HiddenPocketSearch
			controller.EndAnimation()
		endif
	endif
EndEvent

Event OnAnimationEnding(int tid, bool HasPlayer)
	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] OnAnimationEnding")
	endif
	Utility.Wait(1.0)
	MoveToMarker()
	if !NakedBodySearch
		Finish1stBodySearch()
	elseif !HiddenPocketSearch
		Finish2ndBodySearch()
	else
		Finish3rdBodySearch()
	endif
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven()
EndEvent

Event OnInspection()
	DoInspection()
EndEvent

Function StartGuardForcegreet()
	SetStage(10)
EndFunction

Function Start1stBodySearch(Actor akSpeaker)
	guard = akSpeaker
	SetStage(20)
EndFunction

Function Finish1stBodySearch()
	SetStage(30)
EndFunction

Function Start2ndBodySearch()
	SetStage(40)
EndFunction

Function Finish2ndBodySearch()
	SetStage(50)
EndFunction

Function Start3rdBodySearch()
	SetStage(60)
EndFunction

Function Finish3rdBodySearch()
	SetStage(70)
EndFunction

Function StartInspection()
	SetStage(80)
EndFunction

Function FinishInspection()
	SetStage(90)
EndFunction

Function QuestEndDismissed()
	SetStage(200)
EndFunction

Function QuestEndOverlookLockpick()
	SetStage(250)
EndFunction

Function QuestEndAddCrimeGold()
	SetStage(300)
EndFunction

Function QuestEndResistArrest()
	SetStage(400)
EndFunction

Function UpdateSpeechCheck()
	float speech = PlayerRef.GetActorValue("Speechcraft")
	float easy = MCM.SpeechSuccessChanceEasy
	float normal = MCM.SpeechSuccessChanceNormal
	float hard = MCM.SpeechSuccessChanceHard
	_BS_SpeechCheckEasy.SetValue(speech * easy * 0.005 + easy * 0.5)
	_BS_SpeechCheck.SetValue(speech * normal * 0.005 + normal * 0.5)
	_BS_SpeechCheckHard.SetValue(speech * hard * 0.005 + hard * 0.5)
	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] SpeechCheckEasy=" + _BS_SpeechCheckEasy.GetValue())
		Debug.Trace("[BS] SpeechCheck    =" + _BS_SpeechCheck.GetValue())
		Debug.Trace("[BS] SpeechCheckHard=" + _BS_SpeechCheckHard.GetValue())
		Debug.Trace("[BS] NumLockpickThreshold=" + _BS_NumLockpickThreshold.GetValue())
	endif
EndFunction

Function DisablePlayerControls()
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven()
EndFunction

Function SetCoolTime()
	float coolTime = Utility.RandomFloat(MCM.CoolTimeMin, MCM.CoolTimeMax)
	float nextAllowed = Utility.GetCurrentGameTime() + coolTime
	_BS_NextAllowed.SetValue(nextAllowed)
EndFunction

Function AddCrimeGold(int bounty = 25)
	Faction guardFaction = guard.GetCrimeFaction()
	guardFaction.ModCrimeGold(bounty)
	if bounty > 0
		Debug.Notification("" + bounty +  " bounty added to " + guardFaction.GetName())
	elseif bounty < 0
		Debug.Notification("" + (-bounty) + " bounty removed from " + guardFaction.GetName())
	endif
	DialogueCrimeGuards.GuildDiscount(guard)
EndFunction

Function ResistArrest()
	guard.SetPlayerResistingArrest()
EndFunction

Function Shutdown()
	Game.EnablePlayerControls()
	Game.SetPlayerAIDriven(false)
	SetCoolTime()
	Stop()
EndFunction

Function MoveToMarker(bool moveFollower=false)
	PlayerRef.MoveTo(playerMarker)
	guard.MoveTo(guardMarker)
	if moveFollower
		int n = FollowerRAs.Length
		int i = 0
		while i < n
			Actor follower = FollowerRAs[i].GetReference() as Actor
			if follower
				follower.MoveTo(followerMarker)
			endif
			i += 1
		endWhile
	endif
EndFunction

Function ResetAlias()
	GuardRA.Clear()
	int n = GuardRAs.Length
	int i = 0
	while i < n
		GuardRAs[i].Clear()
		i += 1
	endWhile
	GuardRA.ForceRefTo(guard)
EndFunction

Function StartBodySearchScene()
	ResetAlias()
	float waitTime = 5.0
	if PlayerRef.IsSneaking()
		PlayerRef.StartSneaking()
		Utility.Wait(0.5)
		waitTime -= 0.5
	endif
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven()
	if PlayerRef.IsWeaponDrawn()
		PlayerRef.SheatheWeapon()
		Utility.Wait(2.0)
		waitTime -= 2.0
	endif
	SetCoolTime()
	Utility.Wait(waitTime)

	int i = 0
	while !FollowerAliasesFilled && i < 100
		Utility.Wait(0.1)
		i += 1
	endWhile

	MoveToMarker(true)
	Utility.Wait(0.5)
	MoveToMarker(true)
	_BS_BodySearchScene.Start()
EndFunction

Function StartInspectionScene()
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven()
	_BS_InspectionScene.Start()
EndFunction

Function StartBodySearch(bool strip=false, bool hiddenPocket=false)
	if strip || MCM.SkipClothedSearch || (!PlayerRef.WornHasKeyword(ArmorCuirass) && !PlayerRef.WornHasKeyword(ClothingBody))
		NakedBodySearch = true
	endif
	if hiddenPocket
		HiddenPocketSearch = true
	endif

	int tid = StartBodySearchAnimation(NakedBodySearch, HiddenPocketSearch)
	if tid < 0
		; SexLabアニメを省略して真面目な所持品検査に以降
		StartInspection()
		return
	endif
EndFunction

int Function StartBodySearchAnimation(bool strip, bool hiddenPocket)
	if !SexLab || !ThreadSlots || !AnimSlots
		Debug.Trace("[BS] SexLab not found")
		return -1
	endif

	sslBaseAnimation anim = AnimSlots.GetByName("RohZima Guard Search")
	if !anim
		Debug.Trace("[BS] RohZima Guard Search is not found")
		return -1
	endif
	anim.SetStageSoundFX(1, none)
	anim.SetStageSoundFX(2, none)

	sslThreadModel thread = SexLab.NewThread()
	if !thread
		Debug.Trace("[BS] thread not found")
		return -1
	endif

	Actor[] positions = SexLabUtil.MakeActorArray(PlayerRef, guard)
	if !thread.AddActors(positions)
		Debug.Trace("[BS] AddActors failed")
		return -1
	endif

	sslBaseAnimation[] anims = new sslBaseAnimation[1]
	anims[0] = anim
	thread.SetAnimations(anims)

	thread.SetHook("BodySearch")
	RegisterForModEvent("HookStageEnd_BodySearch", "OnStageEnd")
	RegisterForModEvent("HookAnimationEnding_BodySearch", "OnAnimationEnding")
	if hiddenPocket
		RegisterForModEvent("HookStageStart_BodySearch", "OnStageStart")
	endif

	bool[] stripOverridePlayer = new bool[33]
	bool[] stripOverrideGuard = new bool[33]
	int i = 0
	while i < 33
		stripOverridePlayer[i] = strip
		stripOverrideGuard[i] = false
		i += 1
	endWhile

	thread.SetStrip(PlayerRef, stripOverridePlayer)
	thread.SetStrip(guard, stripOverrideGuard)
	thread.DisableRedress()
	thread.DisableBedUse(true)
	thread.DisableRagdollEnd()
	thread.DisableLeadIn()
	thread.ActorAlias(guard).SetVoice(ForceSilence=true)
	if MCM.IsVictim
		thread.SetVictim(PlayerRef)
	endif

	if !thread.StartThread()
		Debug.Trace("[BS] thread failed to start")
		return -1
	endif

	return thread.tid
EndFunction

Function RaiseInspectionEvent()
	RegisterForModEvent("_BS_Inspection", "OnInspection")
	int handle = ModEvent.Create("_BS_Inspection")
	if handle
		ModEvent.Send(handle)
	else
		Debug.Trace("[BS] failed to send _BS_Inspection event")
		QuestEndDismissed()
	endif
EndFunction

Function DoInspection()
	bool debugOutputEnabled = MCM.DebugOutputEnabled

	Debug.SendAnimationEvent(guard, "IdleKneeling")
	Utility.Wait(2.0)

	Game.FadeOutGame(true, true, 0.1, 0.5)
	Utility.Wait(0.4)
	Game.FadeOutGame(false, true, 50.0, 0.5)

	float startTime = Utility.GetCurrentRealTime()

	NumStolenGoods = 0
	NumSkooma = PlayerRef.GetItemCount(Skooma)
	NumLockpick = PlayerRef.GetItemCount(Lockpick)
	_BS_CrimeFaction.PlayerPayCrimeGold(true, false)
	Utility.Wait(WAIT_PAYCRIME)

	totalBounty = 0.0
	totalBounty += NumSkooma * MCM.BountySkooma
	totalBounty += NumLockpick * MCM.BountyLockpick

	NumStolenGoods = CountStolenGoodsAndBounty(false)

	ObjectReference stolenGoodsContainer = EvidenceChestRA.GetReference()
	if !stolenGoodsContainer
		stolenGoodsContainer = PlayerRef
	endif
	_BS_EvidenceChestStolenGoodsREF.RemoveAllItems(stolenGoodsContainer, true, true)
	Utility.Wait(WAIT_REMOVEITEMS)

	DoInspectionFollowers()

	float elapsed = Utility.GetCurrentRealTime() - startTime
	if debugOutputEnabled
		Debug.Trace("[BS] DoInspection: " + elapsed + "secs")
	endif

	if elapsed < 6.0
		Utility.Wait(6.0 - elapsed)
	endif

	Game.FadeOutGame(false, true, 0.5, 0.5)
	Utility.Wait(2.0)

	AddCrimeGoldIfGuilty()
	FinishInspection()
EndFunction

int Function CountStolenGoodsAndBounty(bool follower)
	bool debugOutputEnabled = MCM.DebugOutputEnabled
	float bounty = 0.0
	int stolenCount = 0
	float rate = MCM.BountyStolenRate
	Form[] items = _BS_EvidenceChestStolenGoodsREF.GetContainerForms()
	int n = items.Length
	int i = 0
	while i < n
		if items[i] != Gold001
			int count = _BS_EvidenceChestStolenGoodsREF.GetItemCount(items[i])
			int value = items[i].GetGoldValue()
			bounty += value * count * rate
			if debugOutputEnabled
				Debug.Trace("[BS] items[" + i + "]=" + items[i] + ": value=" + value + ": count=" + count)
			endif
			stolenCount += count
		endif
		i += 1
	endWhile
	if follower
		totalBountyFollower += bounty
	else
		totalBounty += bounty
	endif
	return stolenCount
EndFunction

Function DoInspectionFollowers()
	totalBountyFollowerAdded = false
	totalBountyFollower = 0.0
	NumFollowerStolenGoods = 0
	NumFollowerSkooma = 0
	NumFollowerLockpick = 0
	NumFollower = 0

	; フォロワーがいない場合はすぐ戻る
	if !(FollowerRAs[0].GetReference() as Actor)
		return
	endif

	; PCが装備中のアイテムを覚えておく
	Form[] wornForms = GetWornForms(PlayerRef)
	Form leftItem = PlayerRef.GetEquippedObject(0)
	Form rightItem = PlayerRef.GetEquippedObject(1)

	; PCのアイテムを別コンテナへ移す
	PlayerRef.RemoveAllItems(_BS_UnownedChestREF, true, true)
	Utility.Wait(WAIT_REMOVEITEMS)

	; フォロワーごとに検査
	int n = FollowerRAs.Length
	int i = 0
	while i < n
		Actor follower = FollowerRAs[i].GetReference() as Actor
		if follower
			DoInspectionFollower(follower)
			if i == 0
				IsFollowerFemale = follower.GetLeveledActorBase().GetSex() == 1
			endif
			NumFollower += 1
		endif
		i += 1
	endWhile

	; 別コンテナに退避したアイテムをPCに戻す
	_BS_UnownedChestREF.RemoveAllItems(PlayerRef, true, true)
	Utility.Wait(WAIT_REMOVEITEMS)

	; PCの装備を設定する
	n = wornForms.Length
	i = 0
	while i < n
		PlayerRef.EquipItemEx(wornForms[i], 0, false, true)
		i += 1
	endWhile
	if leftItem
		PlayerRef.EquipItemEx(leftItem, 2, false, true)
	endif
	if rightItem
		PlayerRef.EquipItemEx(rightItem, 1, false, true)
	endif

	NumFollowerSkooma = _BS_FollowersChestREF.GetItemCount(Skooma)
	NumFollowerLockpick = _BS_FollowersChestREF.GetItemCount(Lockpick)
	totalBountyFollower += NumFollowerSkooma * MCM.BountySkooma
	totalBountyFollower += NumFollowerLockpick * MCM.BountyLockpick

	NumFollowerStolenGoods = CountStolenGoodsAndBounty(true)

	ObjectReference stolenGoodsContainer = EvidenceChestRA.GetReference()
	if !stolenGoodsContainer
		stolenGoodsContainer = PlayerRef
	endif
	_BS_EvidenceChestStolenGoodsREF.RemoveAllItems(stolenGoodsContainer, true, true)
	Utility.Wait(WAIT_REMOVEITEMS)
EndFunction

Function DoInspectionFollower(Actor follower)
	; フォロワーが同じセルにいないとRemoveAllItems()でフリーズするようなので移動
	follower.MoveTo(PlayerRef)

	; フォロワーがスクゥーマ・ロックピックを持っていたら没収
	follower.RemoveItem(Skooma, 32767, true, _BS_FollowersChestREF)
	follower.RemoveItem(Lockpick, 32767, true, _BS_FollowersChestREF)

	; フォロワーのアイテムをPCに移す
	; abKeepOwnership=true	だとフォロワーの所持品が盗品扱いされるのでfalseにする
	; abKeepOwnership=false	としても盗品は盗品のままになるようだ
	follower.RemoveAllItems(PlayerRef, false, true)
	Utility.Wait(WAIT_REMOVEITEMS)

	; フォロワーのOutfitが再生成されるのであとで削除するために所持品を取得
	Form[] items = follower.GetContainerForms()

	; PlayerPayCrimeGold()で盗品を没収
	_BS_CrimeFaction.PlayerPayCrimeGold(true, false)
	Utility.Wait(WAIT_PAYCRIME)

	; PCのアイテムをフォロワーに戻す
	; abKeepOwnership=false	でPCに移したので戻すときも同様にする
	PlayerRef.RemoveAllItems(follower, false, true)
	Utility.Wait(WAIT_REMOVEITEMS)

	; 再生成されたOutfitを削除
	int n = items.Length
	int i = 0
	while i < n
		follower.RemoveItem(items[i], 1, true)
		i += 1
	endWhile

	; フォロワーをマーカー位置に戻す
	Follower.MoveTo(followerMarker)
EndFunction

Function AddCrimeGoldIfGuilty()
	PlayerRef.RemoveItem(Skooma, NumSkooma, false, guard)
	PlayerRef.RemoveItem(Lockpick, NumLockpick, false, guard)
	_BS_FollowersChestREF.RemoveItem(Skooma, NumFollowerSkooma, false, guard)
	_BS_FollowersChestREF.RemoveItem(Lockpick, NumFollowerLockpick, false, guard)

	RemoveTGQuestItems()

	if totalBounty > 0.0
		float bounty = totalBounty
		if NumStolenGoods > 0 || NumSkooma > 0
			totalBountyFollowerAdded = true
			bounty += totalBountyFollower
		endif
		AddCrimeGold(bounty as int)
		guard.DrawWeapon()
	endif

	if MCM.DebugOutputEnabled
		Debug.Trace("[BS] NumSkooma=" + NumSkooma)
		Debug.Trace("[BS] NumLockpick=" + NumLockpick)
		Debug.Trace("[BS] NumStolenGoods=" + NumStolenGoods)
		Debug.Trace("[BS] totalBounty=" + totalBounty)
		Debug.Trace("[BS] NumFollowerSkooma=" + NumFollowerSkooma)
		Debug.Trace("[BS] NumFollowerLockpick=" + NumFollowerLockpick)
		Debug.Trace("[BS] NumFollowerStolenGoods=" + NumFollowerStolenGoods)
		Debug.Trace("[BS] totalBountyFollower=" + totalBountyFollower)
	endif
EndFunction

Function AddCrimeGoldIfGuiltyFollower()
	if totalBountyFollowerAdded
		return
	endif
	totalBountyFollowerAdded = true

	if totalBountyFollower > 0.0
		AddCrimeGold(totalBountyFollower as int)
		guard.DrawWeapon()
	endif
EndFunction

Function RemoveTGQuestItems()
	bool debugOutputEnabled = MCM.DebugOutputEnabled
	ObjectReference stolenGoodsContainer = EvidenceChestRA.GetReference()
	float rate = MCM.BountyStolenRate

	int n = TGRStolenGoodsRA.Length
	int i = 0
	while i < n
		ObjectReference obj = TGRStolenGoodsRA[i].GetReference()
		if obj && PlayerRef.GetItemCount(obj) > 0
			NumStolenGoods += 1
			if stolenGoodsContainer
				PlayerRef.RemoveItem(obj, 1, false, stolenGoodsContainer)
			endif
			int value = obj.GetBaseObject().GetGoldValue()
			totalBounty += value * rate
			if debugOutputEnabled
				Debug.Trace("[BS] player has obj[" + i + "]=" + obj + ": value=" + value)
			endif
		endif
		i += 1
	endWhile
EndFunction

Function OverlookLockpick()
	int _numLockpick = NumLockpick + NumFollowerLockpick
	float bounty = _numLockpick * MCM.BountyLockpick
	if bounty > 0.0
		AddCrimeGold(-(bounty as int))
		guard.RemoveItem(Lockpick, _numLockpick, false, PlayerRef)
	endif
EndFunction

Function FillAlias(Actor actorRef)
	GoToState("Busy")
	if fillCount < GuardRAs.Length
		CalculateIsThane(actorRef)
		GuardRAs[fillCount].ForceRefTo(actorRef)
		fillCount += 1
		if MCM.DebugOutputEnabled
			Debug.Trace("[BS] FillAlias: fillCount=" + fillCount)
		endif
	endif
	GoToState("")
EndFunction

state Busy
	Function FillAlias(Actor actorRef)
		if MCM.DebugOutputEnabled
			Debug.Trace("[BS] FillAlias: busy")
		endif
	EndFunction
endState

Function FillFollowerAliases()
	_BS_FindFollowersQuest.Start()
EndFunction

Function CalculateIsThane(Actor actorRef)
	if isThaneCalculated
		return
	endif

	isThaneCalculated = true
	Faction crimeFaction = actorRef.GetCrimeFaction()
	if crimeFaction == CrimeFactionReach
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.ReachSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.ReachImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionRift
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.RiftSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.RiftImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionHaafingar
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.HaafingarSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.HaafingarImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionWhiterun
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.WhiterunSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.WhiterunImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionEastmarch
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.EastmarchSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.EastmarchImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionHjaalmarch
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.HjaalmarchSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.HjaalmarchImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionPale
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.PaleSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.PaleImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionWinterhold
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.WinterholdSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.WinterholdImpGetOutofJail > 0
		endif
	elseif crimeFaction == CrimeFactionFalkreath
		if actorRef.IsInFaction(CWSonsFaction)
			IsThane = FavorJarlsMakeFriends.FalkreathSonsGetOutofJail > 0
		else
			IsThane = FavorJarlsMakeFriends.FalkreathImpGetOutofJail > 0
		endif
	else
		IsThane = false
	endif
EndFunction

Function UseAuthorityOfThane(Actor actorRef)
	Faction crimeFaction = actorRef.GetCrimeFaction()
	if crimeFaction == CrimeFactionReach
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.ReachSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.ReachImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionRift
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.RiftSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.RiftImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionHaafingar
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.HaafingarSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.HaafingarImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionWhiterun
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.WhiterunSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.WhiterunImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionEastmarch
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.EastmarchSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.EastmarchImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionHjaalmarch
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.HjaalmarchSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.HjaalmarchImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionPale
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.PaleSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.PaleImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionWinterhold
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.WinterholdSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.WinterholdImpGetOutofJail = 2
		endif
	elseif crimeFaction == CrimeFactionFalkreath
		if actorRef.IsInFaction(CWSonsFaction)
			FavorJarlsMakeFriends.FalkreathSonsGetOutofJail = 2
		else
			FavorJarlsMakeFriends.FalkreathImpGetOutofJail = 2
		endif
	endif
	DoneThane = true
EndFunction

; actorの着ている防具一覧を取得
Form[] Function GetWornForms(Actor actorRef, int slotMask = 0, bool allowNonPlayable = false) global
	Form[] wornForms = new Form[32]
	int count = 0
	int slotsChecked = slotMask

	int thisSlot = 0x01
	while thisSlot < 0x80000000
		if Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot
			Armor wa = actorRef.GetWornForm(thisSlot) as Armor
			if wa
				if allowNonPlayable || wa.IsPlayable()
					wornForms[count] = wa
					count += 1
				endif
				slotsChecked += wa.GetSlotMask()
			else
				slotsChecked += thisSlot
			endif
		endif
		thisSlot *= 2
	endWhile

	return Utility.ResizeFormArray(wornForms, count)
EndFunction

