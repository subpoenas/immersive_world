Scriptname _BS_MCM extends ski_configbase Conditional

Quest Property _BS_BodySearchQuest Auto
Quest Property _BS_KickBodySearchQuest Auto
GlobalVariable Property _BS_EarnestChance Auto
GlobalVariable Property _BS_NakedChance Auto
GlobalVariable Property _BS_HostileChance Auto
GlobalVariable Property _BS_MaleGuardEnabled Auto
GlobalVariable Property _BS_FemaleGuardEnabled Auto
GlobalVariable Property _BS_NumLockpickThreshold Auto

bool Property Enabled Auto Conditional
bool Property DebugOutputEnabled Auto
bool Property SkipClothedSearch Auto
bool Property IsVictim Auto
bool Property SelfConscious Auto
bool Property HiddenPocketAnimation Auto
float Property ForcegreetChance Auto
float Property KickInterval Auto
float Property CoolTimeMin Auto
float Property CoolTimeMax Auto
float Property SpeechSuccessChanceEasy Auto
float Property SpeechSuccessChanceNormal Auto
float Property SpeechSuccessChanceHard Auto
float Property BountyStolenRate Auto
float Property BountySkooma Auto
float Property BountyLockpick Auto

bool prevEnabled

Event OnConfigInit()

EndEvent

int Function GetVersion()
	return 1
EndFunction

Event OnVersionUpdate(int a_version)
	if a_version > 1
		OnConfigInit()
	endif
EndEvent

Event OnConfigOpen()
	prevEnabled = Enabled
EndEvent

Event OnConfigClose()
	if !prevEnabled && Enabled
		_BS_BodySearchQuest.Start()
		_BS_KickBodySearchQuest.Start()
	elseif prevEnabled && !Enabled
		_BS_BodySearchQuest.Stop()
		_BS_KickBodySearchQuest.Stop()
	else
		(_BS_BodySearchQuest as _BS_BodySearch).UpdateSpeechCheck()
	endif
	;if DebugOutputEnabled
	;	Debug.Trace("[BS] ForcegreetChance=" + ForcegreetChance)
	;	Debug.Trace("[BS] KickInterval=" + KickInterval)
	;	Debug.Trace("[BS] CoolTimeMin=" + CoolTimeMin)
	;	Debug.Trace("[BS] CoolTimeMax=" + CoolTimeMax)
	;	Debug.Trace("[BS] SpeechSuccessChanceEasy=" + SpeechSuccessChanceEasy)
	;	Debug.Trace("[BS] SpeechSuccessChanceNormal=" + SpeechSuccessChanceNormal)
	;	Debug.Trace("[BS] SpeechSuccessChanceHard=" + SpeechSuccessChanceHard)
	;	Debug.Trace("[BS] _BS_EarnestChance=" + _BS_EarnestChance.GetValue())
	;	Debug.Trace("[BS] _BS_NakedChance=" + _BS_NakedChance.GetValue())
	;	Debug.Trace("[BS] _BS_HostileChance=" + _BS_HostileChance.GetValue())
	;	Debug.Trace("[BS] _BS_MaleGuardEnabled=" + _BS_MaleGuardEnabled.GetValue())
	;	Debug.Trace("[BS] _BS_FemaleGuardEnabled=" + _BS_FemaleGuardEnabled.GetValue())
	;endif
EndEvent

Event OnPageReset(string page)
	SetCursorFillMode(TOP_TO_BOTTOM)

	SexLabFramework SexLab = Game.GetFormFromFile(0x00000d62, "SexLab.esm") as SexLabFramework

	AddToggleOptionST("ST_ENABLE", "Mod Enabled", Enabled)
	AddToggleOptionST("ST_ENABLE_DEBUG", "Debug Output Enabled", DebugOutputEnabled)
	AddSliderOptionST("ST_FORCEGREET_CHANCE", "Forcegreet Chance", ForcegreetChance, "{0}%")
	AddSliderOptionST("ST_KICK_INTERVAL", "Quest Kick Interval", KickInterval, "{0}secs")
	AddSliderOptionST("ST_COOL_TIME_MIN", "Cool Time Min", CoolTimeMin, "{1}days")
	AddSliderOptionST("ST_COOL_TIME_MAX", "Cool Time Max", CoolTimeMax, "{1}days")
	if SexLab
		AddSliderOptionST("ST_EARNEST_CHANCE", "Earnest Chance", _BS_EarnestChance.GetValue(), "{0}%")
		AddSliderOptionST("ST_NAKED_CHANCE", "Naked Chance", _BS_NakedChance.GetValue(), "{0}%")
	endif
	AddSliderOptionST("ST_HOSTILE_CHANCE", "Hostile Chance", _BS_HostileChance.GetValue(), "{0}%")
	AddSliderOptionST("ST_SPEECH_EASY", "Speech Success Chance Easy", SpeechSuccessChanceEasy, "{0}%")
	AddSliderOptionST("ST_SPEECH_NORMAL", "Speech Success Chance Normal", SpeechSuccessChanceNormal, "{0}%")
	AddSliderOptionST("ST_SPEECH_HARD", "Speech Success Chance Hard", SpeechSuccessChanceHard, "{0}%")

	SetCursorPosition(1)
	AddToggleOptionST("ST_SELF_CONSCIOUS", "Self-Conscious About Public Eye", SelfConscious)
	AddToggleOptionST("ST_HIDDEN_POCKET_ANIMATION", "Hidden Pocket Animation", HiddenPocketAnimation)
	AddToggleOptionST("ST_SKIP_CLOTHED_SEARCH", "Skip Clothed Search", SkipClothedSearch)
	AddToggleOptionST("ST_IS_VICTIM", "Player is Victim", IsVictim)
	AddToggleOptionST("ST_ENABLE_MALE", "Male Guard Enabled", _BS_MaleGuardEnabled.GetValue() as bool)
	AddToggleOptionST("ST_ENABLE_FEMALE", "Female Guard Enabled", _BS_FemaleGuardEnabled.GetValue() as bool)
	AddSliderOptionST("ST_BOUNTY_STOLEN_RATE", "Bounty Stolen Rate", BountyStolenRate, "{2}x")
	AddSliderOptionST("ST_BOUNTY_SKOOMA", "Bounty Skooma", BountySkooma, "{0}septims")
	AddSliderOptionST("ST_BOUNTY_LOCKPICK", "Bounty Lockpick", BountyLockpick, "{0}septims")
	AddSliderOptionST("ST_LOCKPICK_THRESHOLD", "Num Lockpick Threshold", _BS_NumLockpickThreshold.GetValue(), "{0}")
EndEvent

state ST_ENABLE
	event OnSelectST()
		Enabled = !Enabled
		SetToggleOptionValueST(Enabled)
	endEvent
endState

state ST_ENABLE_DEBUG
	event OnSelectST()
		DebugOutputEnabled = !DebugOutputEnabled
		SetToggleOptionValueST(DebugOutputEnabled)
	endEvent
endState

state ST_SELF_CONSCIOUS
	event OnSelectST()
		SelfConscious = !SelfConscious
		SetToggleOptionValueST(SelfConscious)
	endEvent

	event OnHighlightST()
		SetInfoText("If checked, you can't access your hidden pocket when you are detected.")
	endEvent
endState

state ST_HIDDEN_POCKET_ANIMATION
	event OnSelectST()
		HiddenPocketAnimation = !HiddenPocketAnimation
		SetToggleOptionValueST(HiddenPocketAnimation)
	endEvent

	event OnHighlightST()
		SetInfoText("If checked, animation will be played when accessing Hidden Pocket.")
	endEvent
endState

state ST_SKIP_CLOTHED_SEARCH
	event OnSelectST()
		SkipClothedSearch = !SkipClothedSearch
		SetToggleOptionValueST(SkipClothedSearch)
	endEvent
endState

state ST_IS_VICTIM
	event OnSelectST()
		IsVictim = !IsVictim
		SetToggleOptionValueST(IsVictim)
	endEvent
endState

state ST_ENABLE_MALE
	event OnSelectST()
		bool value = !(_BS_MaleGuardEnabled.GetValue() as bool)
		_BS_MaleGuardEnabled.SetValue(value as float)
		SetToggleOptionValueST(value)
	endEvent
endState

state ST_ENABLE_FEMALE
	event OnSelectST()
		bool value = !(_BS_FemaleGuardEnabled.GetValue() as bool)
		_BS_FemaleGuardEnabled.SetValue(value as float)
		SetToggleOptionValueST(value)
	endEvent
endState

state ST_FORCEGREET_CHANCE
	event OnSliderOpenST()
		SetSliderDialogStartValue(ForcegreetChance)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		ForcegreetChance = value
		SetSliderOptionValueST(value, "{0}%")
	endEvent
endState

state ST_KICK_INTERVAL
	event OnSliderOpenST()
		SetSliderDialogStartValue(KickInterval)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(10.0, 120.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		KickInterval = value
		SetSliderOptionValueST(value, "{0}secs")
	endEvent
endState

state ST_COOL_TIME_MIN
	event OnSliderOpenST()
		SetSliderDialogStartValue(CoolTimeMin)
		SetSliderDialogDefaultValue(0.1)
		SetSliderDialogRange(0.0, 1.0)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		CoolTimeMin = value
		SetSliderOptionValueST(value, "{1}days")
	endEvent
endState

state ST_COOL_TIME_MAX
	event OnSliderOpenST()
		SetSliderDialogStartValue(CoolTimeMax)
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(1.0, 10.0)
		SetSliderDialogInterval(0.1)
	endEvent

	event OnSliderAcceptST(float value)
		CoolTimeMax = value
		SetSliderOptionValueST(value, "{1}days")
	endEvent
endState

state ST_EARNEST_CHANCE
	event OnSliderOpenST()
		SetSliderDialogStartValue(_BS_EarnestChance.GetValue())
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		_BS_EarnestChance.SetValue(value)
		SetSliderOptionValueST(value, "{0}%")
	endEvent

	event OnHighlightST()
		SetInfoText("After groping, guards do a real body search at InputValue % chance.\nIf you have bad goods, bounty will be added to you.")
	endEvent
endState

state ST_NAKED_CHANCE
	event OnSliderOpenST()
		SetSliderDialogStartValue(_BS_NakedChance.GetValue())
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		_BS_NakedChance.SetValue(value)
		SetSliderOptionValueST(value, "{0}%")
	endEvent

	event OnHighlightST()
		SetInfoText("Guards require you to be naked when body search at InputValue % chance.\nIf you are already naked, they require you the hidden pocket search.")
	endEvent
endState

state ST_HOSTILE_CHANCE
	event OnSliderOpenST()
		SetSliderDialogStartValue(_BS_HostileChance.GetValue())
		SetSliderDialogDefaultValue(90.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		_BS_HostileChance.SetValue(value)
		SetSliderOptionValueST(value, "{0}%")
	endEvent

	event OnHighlightST()
		SetInfoText("When you walk away from conversation, guards become hostile at InputValue % chance.")
	endEvent
endState

state ST_SPEECH_EASY
	event OnSliderOpenST()
		SetSliderDialogStartValue(SpeechSuccessChanceEasy)
		SetSliderDialogDefaultValue(80.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		SpeechSuccessChanceEasy = value
		SetSliderOptionValueST(value, "{0}%")
	endEvent
endState

state ST_SPEECH_NORMAL
	event OnSliderOpenST()
		SetSliderDialogStartValue(SpeechSuccessChanceNormal)
		SetSliderDialogDefaultValue(40.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		SpeechSuccessChanceNormal = value
		SetSliderOptionValueST(value, "{0}%")
	endEvent
endState

state ST_SPEECH_HARD
	event OnSliderOpenST()
		SetSliderDialogStartValue(SpeechSuccessChanceHard)
		SetSliderDialogDefaultValue(20.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		SpeechSuccessChanceHard = value
		SetSliderOptionValueST(value, "{0}%")
	endEvent
endState

state ST_BOUNTY_STOLEN_RATE
	event OnSliderOpenST()
		SetSliderDialogStartValue(BountyStolenRate)
		SetSliderDialogDefaultValue(1.00)
		SetSliderDialogRange(0.50, 3.00)
		SetSliderDialogInterval(0.01)
	endEvent

	event OnSliderAcceptST(float value)
		BountyStolenRate = value
		SetSliderOptionValueST(value, "{2}x")
	endEvent
endState

state ST_BOUNTY_SKOOMA
	event OnSliderOpenST()
		SetSliderDialogStartValue(BountySkooma)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		BountySkooma = value
		SetSliderOptionValueST(value, "{0}septims")
	endEvent
endState

state ST_BOUNTY_Lockpick
	event OnSliderOpenST()
		SetSliderDialogStartValue(BountyLockpick)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		BountyLockpick = value
		SetSliderOptionValueST(value, "{0}septims")
	endEvent
endState

state ST_LOCKPICK_THRESHOLD
	event OnSliderOpenST()
		SetSliderDialogStartValue(_BS_NumLockpickThreshold.GetValue())
		SetSliderDialogDefaultValue(2.0)
		SetSliderDialogRange(0.0, 10.0)
		SetSliderDialogInterval(1.0)
	endEvent

	event OnSliderAcceptST(float value)
		_BS_NumLockpickThreshold.SetValue(value)
		SetSliderOptionValueST(value, "{0}")
	endEvent

	event OnHighlightST()
		SetInfoText("If the number of lockpicks you have is less than or equal to InputValue, persuasion becomes easier.")
	endEvent
endState

