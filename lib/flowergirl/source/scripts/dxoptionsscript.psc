Scriptname dxOptionsScript extends activemagiceffect  

Quest Property FlowerGirlsQuest  Auto  
dxSeductionScript Property SeductionScript  Auto  
dxFlowerGirlsConfig Property FlowerGirlsConfig  Auto  

Message Property MainOptionsMessage Auto
Message Property IntimateOptionsMessage Auto
Message Property RestartOptionsMessage  Auto  
Message Property RemoveOptionsMessage  Auto 
Message Property ModOptionsMessage  Auto  
Message Property StripOptionsMessage  Auto 
Message Property ScalingOptionsMessage  Auto  
Message Property RoleOptionsMessage  Auto  
Message Property CinematicOptionsMessage  Auto  
Message Property SoundOptionsMessage  Auto  
Message Property ImmersionOptionsMessage  Auto  
Message Property GenderOptionsMessage Auto
Message Property LightingOptionsMessage Auto
Message Property VRSettingsMessage Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
	DisplayMainOptions()		
endEvent

Function DisplayMainOptions()	
	int response = MainOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.SetValueInt(0)
		DisplayMainOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_ENABLE_ANIMATIONS.SetValueInt(1)
		DisplayMainOptions()
	elseIf (response == 2)
		DisplayIntimateOptions()
	elseIf (response == 3)
		DisplayCinematicOptions()
	elseIf (response == 4)
		DisplayScalingOptions()
	elseIf (response == 5)
		DisplayImmersionOptions()
	elseif (response == 6)
		DisplayModOptions()
	endIf
endFunction

Function DisplayIntimateOptions()
	int response = IntimateOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_USE_KISSES.SetValueInt(0)
		DisplayIntimateOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_USE_KISSES.SetValueInt(1)
		DisplayIntimateOptions()
	elseIf (response == 2)
		FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.SetValueInt(0)
		DisplayIntimateOptions()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_SERVICECHARGE_ENABLE.SetValueInt(1)
		DisplayIntimateOptions()
	elseIf (response == 4)
		FlowerGirlsConfig.DX_USE_COMFORT.SetValueInt(0)
		DisplayIntimateOptions()
	elseIf (response == 5)
		FlowerGirlsConfig.DX_USE_COMFORT.SetValueInt(1)
		DisplayIntimateOptions()
	elseIf (response == 6)
		DisplayStripOptions()
	elseIf (response == 7)
		DisplayRoleOptions()
	else
		DisplayMainOptions()
	endIf	
endFunction

Function DisplayStripOptions()
	int response = StripOptionsMessage.Show()
	int iVal = FlowerGirlsConfig.DX_STRIP_OPTIONS.GetValueInt()
	if (response == 0)
		if (iVal == 1)
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(3)
		else
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(0)
		endIf
		DisplayStripOptions()
	elseIf (response == 1)
		if (iVal == 0)
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(2)
		else
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(1)
		endIf
		DisplayStripOptions()
	elseIf (response == 2)
		if (iVal == 1)
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(2)
		else
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(0)
		endIf
		DisplayStripOptions()
	elseIf (response == 3)
		if (iVal == 0)
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(3)
		else
			FlowerGirlsConfig.DX_STRIP_OPTIONS.SetValueInt(1)
		endIf
		DisplayStripOptions()
	else
		DisplayIntimateOptions()
	endIf	
endFunction

Function DisplayRoleOptions()
	int response = RoleOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.SetValueInt(0)
		DisplayRoleOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_FEMALE_ISMALEROLE.SetValueInt(1)
		DisplayRoleOptions()
	elseIf (response == 2)
		FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(0)
		DisplayRoleOptions()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(1)
		DisplayRoleOptions()
	elseIf (response == 4)
		FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(1)
		DisplayRoleOptions()
	elseIf (response == 5)
		FlowerGirlsConfig.DX_USE_STRAPON.SetValueInt(2)
		DisplayRoleOptions()
	elseIf (response == 6)
		DisplayGenderOptions()
	else
		DisplayIntimateOptions()
	endIf
endFunction

Function DisplayCinematicOptions()
	int response = CinematicOptionsMessage.Show()
	int iVal = FlowerGirlsConfig.DX_CINEMATIC.GetValueInt()
	if (response == 0)
		if (iVal == 1)
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(3)
		else
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(0)
		endIf
		DisplayCinematicOptions()
	elseIf (response == 1)
		if (iVal == 0)
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(2)
		else
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(1)
		endIf
		DisplayCinematicOptions()
	elseIf (response == 2)
		if (iVal == 1)
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(2)
		else
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(0)
		endIf
		DisplayCinematicOptions()
	elseIf (response == 3)
		if (iVal == 0)
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(3)
		else
			FlowerGirlsConfig.DX_CINEMATIC.SetValueInt(1)
		endIf
		DisplayCinematicOptions()
	elseIf (response == 4)
		FlowerGirlsConfig.DX_SCENE_DURATION.SetValueInt(1)
		DisplayCinematicOptions()
	elseIf (response == 5)
		FlowerGirlsConfig.DX_SCENE_DURATION.SetValueInt(2)
		DisplayCinematicOptions()
	elseIf (response == 6)
		FlowerGirlsConfig.DX_SCENE_DURATION.SetValueInt(0)
		DisplayCinematicOptions()
	elseIf (response == 7)
		DisplayLightingOptions()
	elseIf (response == 8)
		DisplaySoundOptions()
	else
		DisplayMainOptions()
	endIf
endFunction

Function DisplayScalingOptions()
	int response = ScalingOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_USE_SCALING.SetValueInt(0)
		DisplayScalingOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_USE_SCALING.SetValueInt(1)
		DisplayScalingOptions()
	else
		DisplayMainOptions()
	endIf
endFunction

Function DisplayImmersionOptions()
	int response = ImmersionOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_IMMERSION_OPTIONS.SetValueInt(0)
		SeductionScript.DisableSeduction()
		DisplayImmersionOptions()		
	elseIf (response == 1)
		FlowerGirlsConfig.DX_IMMERSION_OPTIONS.SetValueInt(1)
		SeductionScript.EnableSeduction()
		DisplayImmersionOptions()	
	elseIf (response == 2)
		FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.SetValueInt(1)
		DisplayImmersionOptions()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.SetValueInt(2)
		DisplayImmersionOptions()
	elseIf (response == 4)
		FlowerGirlsConfig.DX_SEXUAL_PREFERENCE.SetValueInt(0)
		DisplayImmersionOptions()
	elseIf (response == 5)
		FlowerGirlsConfig.DX_MORE_KISSING.SetValueInt(0)
		DisplayImmersionOptions()
	elseIf (response == 6)
		FlowerGirlsConfig.DX_MORE_KISSING.SetValueInt(1)
		DisplayImmersionOptions()
	elseIf (response == 7)
		FlowerGirlsConfig.DX_USE_HELLOS.SetValueInt(0)
		DisplayImmersionOptions()
	elseIf (response == 8)
		FlowerGirlsConfig.DX_USE_HELLOS.SetValueInt(1)
		DisplayImmersionOptions()
	else
		DisplayMainOptions()
	endIf
endFunction

Function DisplayLightingOptions()
	int response = LightingOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_SCENE_LIGHTING.SetValueInt(0)
		DisplayLightingOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_SCENE_LIGHTING.SetValueInt(1)
		DisplayLightingOptions()
	else
		DisplayCinematicOptions()
	endIf	
endFunction

Function DisplaySoundOptions()
	int response = SoundOptionsMessage.Show()
	int iVal = FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.GetValueInt()
	
	if(response == 0)
		FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.SetValueInt(0)
		DisplaySoundOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_USE_SOUNDEFFECTS.SetValueInt(1)
		DisplaySoundOptions()
	elseIf (response == 2)	; Turn off Male voice
		if (iVal == 0)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(1)
		elseIf (iVal == 2)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(3)
		endIf
		DisplaySoundOptions()
	elseIf (response == 3)	; Enable Male Voice
		if (iVal == 1)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(0)
		elseIf (iVal == 3)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(2)
		endIf
		DisplaySoundOptions()
	elseIf (response == 4)	; Turn off Female voice
		if (iVal == 0)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(2)
		elseIf (iVal == 1)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(3)
		endIf
		DisplaySoundOptions()
	elseIf (response == 5)	; Enable Female voice
		if (iVal == 2)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(0)
		elseIf (iVal == 3)
			FlowerGirlsConfig.DX_USE_SOUND_OPTIONS.SetValueInt(1)
		endIf
		DisplaySoundOptions()
	else
		DisplayCinematicOptions()
	endIf
	
endFunction

Function DisplayGenderOptions()
	int response = GenderOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_OVERRIDE_GENDER.SetValueInt(0)
		DisplayGenderOptions()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_OVERRIDE_GENDER.SetValueInt(1)
		DisplayGenderOptions()
	elseIf (response == 2)
		FlowerGirlsConfig.DX_OVERRIDE_GENDER.SetValueInt(2)
		DisplayGenderOptions()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_OVERRIDE_GENDER.SetValueInt(1)	
		DisplayGenderOptions()
	else
		DisplayRoleOptions()
	endIf
endFunction

Function DisplayRemoveOptions()
	int response = RemoveOptionsMessage.Show()
	if (response == 0)
		(FlowerGirlsQuest as dxFlowerGirlsMod).UninstallFlowerGirls()
	else
		DisplayModOptions()
	endIf
endFunction

Function DisplayModOptions()
	int response = ModOptionsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.SetValueInt(0)
		(FlowerGirlsQuest as dxFlowerGirlsMod).RemoveOptionalSpells()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_USE_OPTIONAL_SPELLS.SetValueInt(1)
		(FlowerGirlsQuest as dxFlowerGirlsMod).AddFlowerGirlSpells()
	elseIf (response == 2)
		FlowerGirlsConfig.DX_DEBUG_MODE.SetValueInt(0)
		DisplayModOptions()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_DEBUG_MODE.SetValueInt(1)
		DisplayModOptions()
	elseIf (response == 4)
		DisplayVRSettings()
	elseif (response == 5)
		DisplayRestartOptions()
	elseIf (response == 6)
		DisplayRemoveOptions()
	else
		DisplayMainOptions()	
	endIf	
endFunction

Function DisplayVRSettings()
	int response = VRSettingsMessage.Show()
	if (response == 0)
		FlowerGirlsConfig.DX_VR_MODE.SetValueInt(0)
		DisplayVRSettings()
	elseIf (response == 1)
		FlowerGirlsConfig.DX_VR_MODE.SetValueInt(1)
		DisplayVRSettings()
	elseIf (response == 2)
		FlowerGirlsConfig.DX_VR_MODE.SetValueInt(2)
		DisplayVRSettings()
	elseIf (response == 3)
		FlowerGirlsConfig.DX_VR_MODE.SetValueInt(1)
		DisplayVRSettings()
	else
		DisplayModOptions()
	endIf	
endFunction

Function DisplayRestartOptions()
	int response = RestartOptionsMessage.Show()
	if (response == 0)
		(FlowerGirlsQuest as dxFlowerGirlsMod).RestartFlowerGirls()
	else
		DisplayModOptions()
	endIf
endFunction

