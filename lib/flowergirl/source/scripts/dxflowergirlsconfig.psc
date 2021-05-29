Scriptname dxFlowerGirlsConfig extends Quest 

Actor Property PlayerREF Auto
{Deprecated: 2.10 - Inefficient, instead use local property on scripts to avoid a function call.}
 
GlobalVariable Property DX_CINEMATIC Auto
{Gets whether fade-out is enabled on scene beginning.}
GlobalVariable Property DX_DEBUG_MODE Auto
{Gets the value of the Global DebugMode flag, toggles off tracing.}
GlobalVariable Property DX_LAST_SCENETYPE Auto
{Allows us to determine which was the last scene type played.} 
GlobalVariable Property DX_LAST_SEQUENCE Auto
{Gets or sets the last played sequence of animations within the category.}
GlobalVariable Property DX_PREVIOUS_SCENETYPE Auto
{Gets or sets the previous scene type played.}
GlobalVariable Property DX_FEMALE_ISMALEROLE Auto
GlobalVariable Property DX_ALLOW_LESBIAN_ANIMS Auto
GlobalVariable Property DX_SEXUAL_PREFERENCE Auto		; 0 - Bi-Sexual  / 1 - Straight /  2 - Gay
GlobalVariable Property DX_USE_OPTIONAL_SPELLS Auto
GlobalVariable Property DX_SCENE_DURATION Auto
GlobalVariable Property DX_SCENE_LIGHTING Auto
GlobalVariable Property DX_SERVICECHARGE_ENABLE  Auto 
GlobalVariable Property DX_USE_KISSES	Auto
GlobalVariable Property DX_USE_COMFORT Auto
GlobalVariable Property DX_USE_ARREST Auto
GlobalVariable Property DX_USE_BEGGARS Auto
GlobalVariable Property DX_USE_SCALING Auto
{Allows user setting whether to enable/disable NPC scaling.}
GlobalVariable Property DX_USE_STRAPON Auto		; 0 - Off / 1 - UNP / 2 - CBBE
{Gets whether to use strap-on for female characters.}
GlobalVariable Property DX_USE_SOUNDEFFECTS Auto
GlobalVariable Property DX_USE_SOUND_OPTIONS Auto
GlobalVariable Property DX_USE_KISSES_OVERRIDE Auto
{Gets whether we are overriding the user setting for this scene.}
GlobalVariable Property DX_STRIP_OPTIONS Auto		; 0 - Both Off / 1 - Both On / 2 - Player On, NPC Off / 3 - Player Off, NPC On
{Gets whether we should strip the player/npc or not according to user settings.}
GlobalVariable Property DX_IMMERSION_OPTIONS  Auto
GlobalVariable Property DX_MORE_KISSING Auto
GlobalVariable Property DX_OVERRIDE_GENDER Auto
GlobalVariable Property DX_USE_HELLOS Auto
{Toggles on/off the FG added Hellos for Seduction.}
GlobalVariable Property DX_VR_MODE Auto
{True if using Virtual Reality mode.}
GlobalVariable Property DX_DEBUG_SEQUENCE Auto
{Allows us to use in game console to specify the exact sequence we want for a scene.}
GlobalVariable Property DX_USE_EJACULATION Auto
{Toggles whether to display ejaculation effects.}

ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto

Static Property StaticBaseRef Auto
{Deprecated: 2.10 - Holds a dxAnimationMarker static object for the actor placement.}

Message Property MsgStopAnimation Auto
{Shown when the R key is pressed and caught.}
Message Property MsgSexForbidden Auto
{Shown when sex is attempted on actors in the dxForbiddenActorsFaction.}

Armor Property StrapOnArmor Auto
{Sets the UNP Strap On armor to use.}
Armor Property StrapOnArmorCBBE Auto
{Sets the CBBE Strap On armor to use.}
Armor Property PrisonerCuffs Auto
{Sets the prisoner cuffs to be worn if the actor is restrained.}
Spell Property SceneLightSpell Auto
{Provides actor lighting during the scene.}
Armor Property StripOnlyArmor Auto
{Only used on Strip Only actions, to fix a skyrim bug with default outfits.}
Armor Property EjaculationEffect Auto
{Sets an ejaculation effect armor.}
Outfit Property NakedOutfit Auto
{Specifies a naked outfit for use primarily with the VR Clone.}

Keyword Property WearWhenStrippedKeyword Auto
{Items with this keyword will not be stripped during scenes.}
Keyword Property ClothingStrapOnKeyword Auto
{Items with this keyword will be used in place of the automatically added strapon.}

Faction Property ForbiddenActorsFaction Auto
{Members of this faction are forbidden from sex scenes excluding kissing scenes.} 
Faction Property SeductionFaction Auto
{Members of this faction are either Seduced/Declined/Being Seduced.}

FormList Property PermittedFurnitureBeds Auto
FormList Property PermittedFurnitureChairs Auto
FormList Property PermittedFurnitureThrones Auto
FormList Property PermittedFurnitureTables Auto
FormList Property PermittedFurnitureWorkbenches Auto
FormList Property PermittedFurnitureWorkbenchesAlch Auto
FormList Property PermittedFurnitureWorkbenchesEnch Auto

GlobalVariable Property DX_ENABLE_ANIMATIONS Auto
{Allows FG animations to be toggled on and off in the options.}

GlobalVariable Property DX_SKSE_AVAILABLE Auto
{Holds whether SKSE64 is detected.}

Message Property MsgSexHappened Auto
Message Property MsgSexHappenedSolo Auto
Message Property MsgSexHappenedKiss Auto

GlobalVariable Property DX_SCRIPT_WAIT_TIME Auto
{Float value to add delay to positioning commands. Combatting script lag.}

float Property FreecamSpeed = 5.0 Auto Hidden
{Float value of freecam speed.}
int Property KeycodeToggleFreecam = 0x000029 Auto Hidden
{The SKSE64 Keycode to toggle freecam on and off.}
int Property KeycodeAdvanceStage = 0x000034 Auto Hidden
{The SKSE64 Keycode to advance a FG scene stage.}
int Property KeycodeEndScene = 0x000033 Auto Hidden
{The SKSE64 Keycode to end the currently running FG scene.}

Keyword Property SceneSoundEffectKW  Auto  

Sound Property SexSoundsPiv Auto
Sound Property SexSoundsPivSlow Auto
Sound Property SexSoundsPivMed Auto
Sound Property SexSoundsVa Auto

Sound Property SexSoundsOralFemaleLight Auto
Sound Property SexSoundsOralFemaleMedium Auto
Sound Property SexSoundsOralFemaleHeavy Auto
