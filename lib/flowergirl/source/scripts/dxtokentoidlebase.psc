Scriptname dxTokenToIdleBase extends Quest  

dxFlowerGirlsConfig Property FlowerGirlsConfig Auto
dxPositions Property SexPositions Auto

bool Property HasAvailableBed Auto Hidden
bool Property HasAvailableChair Auto Hidden
bool Property HasAvailableThrone Auto Hidden
bool Property HasAvailableWorkbench Auto Hidden
bool Property HasAvailableTable Auto Hidden
bool Property HasAvailableAlchemyBench Auto Hidden
bool Property HasAvailableEnchantingBench Auto Hidden

bool Property IsUsingBed Auto Hidden
bool Property IsUsingChair Auto Hidden
bool Property IsUsingThrone Auto Hidden
bool Property IsUsingWorkbench Auto Hidden
bool Property IsUsingTable Auto Hidden
bool Property IsUsingAlchemyBench Auto Hidden
bool Property IsUsingEnchantingBench Auto Hidden

int property SOUNDTYPE_NONE					= 0x000000 AutoReadOnly Hidden
int property SOUNDTYPE_SOLO_F			 	= 0x000001 AutoReadOnly Hidden
int property SOUNDTYPE_SOLO_M				= 0x000002 AutoReadOnly Hidden
int property SOUNDTYPE_PIV 					= 0x000003 AutoReadOnly Hidden
int property SOUNDTYPE_PIV_BED				= 0x000004 AutoReadOnly Hidden
int property SOUNDTYPE_SLAP					= 0x000005 AutoReadOnly Hidden
int property SOUNDTYPE_ORAL_F_LIGHT			= 0x000006 AutoReadOnly Hidden
int property SOUNDTYPE_ORAL_F_MEDIUM		= 0x000007 AutoReadOnly Hidden
int property SOUNDTYPE_ORAL_F_HEAVY			= 0x000008 AutoReadOnly Hidden
int property SOUNDTYPE_ORAL_M				= 0x000009 AutoReadOnly Hidden

string[] Function ConvertTokenToIdles(dxAliasActor who, int Sequence = 0)
	return NONE
endFunction

; -----------------------------------------------------------------------------------------
; ConvertTokenToSequences(): Function to retrieve the number of available
; animation sequences from a given category. Used for gettting the max
; random number.
;------------------------------------------------------------------------------------------
int Function ConvertTokenToSequences(dxAliasActor Who)
	return 0
endFunction

;--------------------------------------------------------------------------------------
; ConvertTokenToDurations(): Searches the actor for a love token and
; returns the animation durations according to the token. This function
; allows us to customize durations on a scene basis.
;--------------------------------------------------------------------------------------
float[] Function ConvertTokenToDurations(dxAliasActor who, int Sequence)
	return NONE
endFunction

int[] Function SceneSoundFxTypes(dxAliasActor who, int Sequence)
	return new int[6]
endFunction

float[] Function SceneSoundFxTimings(dxAliasActor who, int Sequence)
	return new float[6]
endFunction

Function ResizeSchlongArray(dxAliasActor who)
	if (who.IsUsingKissing)
		int[] schlongs = who.SchlongBends
		if (who.SchlongBends.Length > 6)
			if (who.SchlongBends.Length == 7)
				who.SchlongBends = new int[10]
			elseIf (who.SchlongBends.Length == 8)
				who.SchlongBends = new int[11]
			elseIf (who.SchlongBends.Length == 9)
				who.SchlongBends = new int[12]
			elseIf (who.SchlongBends.Length == 10)
				who.SchlongBends = new int[13]
			elseIf (who.SchlongBends.Length == 11)
				who.SchlongBends = new int[14]
			elseIf (who.SchlongBends.Length == 12)
				who.SchlongBends = new int[15]
			elseIf (who.SchlongBends.Length == 13)
				who.SchlongBends = new int[16]
			endIf
		else
			who.SchlongBends = new int[9]
		endIf
		
		; Apply initial flacid state for kissing scenes:
		who.SchlongBends[0] = -8
		who.SchlongBends[1] = -6
		who.SchlongBends[2] = -2
		
		int cnt = 0
		int index = 0
		while (cnt < who.SchlongBends.Length)
			if (cnt > 2)
				who.SchlongBends[cnt] = schlongs[index]
				index += 1
			endIf
			cnt += 1
		endWhile
		
		bool[] ejaculations = who.EjaculationStages
		if (who.EjaculationStages.Length > 6)
			if (who.EjaculationStages.Length == 7)
				who.EjaculationStages = new bool[10]
			elseIf (who.EjaculationStages.Length == 8)
				who.EjaculationStages = new bool[11]
			elseIf (who.EjaculationStages.Length == 9)
				who.EjaculationStages = new bool[12]
			elseIf (who.EjaculationStages.Length == 10)
				who.EjaculationStages = new bool[13]
			elseIf (who.EjaculationStages.Length == 11)
				who.EjaculationStages = new bool[14]
			elseIf (who.EjaculationStages.Length == 12)
				who.EjaculationStages = new bool[15]
			elseIf (who.EjaculationStages.Length == 13)
				who.EjaculationStages = new bool[16]
			endIf
		else
			who.EjaculationStages = new bool[9]
		endIf
				
		cnt = 0
		index = 0
		while (cnt < who.EjaculationStages.Length)
			if (cnt > 2)
				who.EjaculationStages[cnt] = ejaculations[index]
				index += 1
			endIf
			cnt += 1
		endWhile
	endIf
endFunction

bool Function IsThreesome(dxAliasActor who)
	return (who.SexType == SexPositions.TokenFFMActor1 || who.SexType == SexPositions.TokenFFMActor2 || who.SexType == SexPositions.TokenFFMActor3 \
		|| who.SexType == SexPositions.TokenMMFActor1 || who.SexType == SexPositions.TokenMMFActor2 || who.SexType == SexPositions.TokenMMFActor3 \
		|| who.SexType == SexPositions.TokenFFFActor1 || who.SexType == SexPositions.TokenFFFActor2 || who.SexType == SexPositions.TokenFFFActor3)
endFunction

bool Function IsSoloScene(dxAliasActor who)
	return (who.SexType == SexPositions.TokenSoloFemale || who.SexType == SexPositions.TokenSoloMale)
endFunction

bool Function CanUseBed(dxAliasActor who)
	return (who.SexType == SexPositions.TokenOralFemale || who.SexType == SexPositions.TokenOralMale \
		|| who.SexType == SexPositions.TokenCowgirlFemale || who.SexType == SexPositions.TokenCowgirlMale \
		|| who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
endFunction

bool Function CanUseThrone(dxAliasActor who)
	return (who.SexType == SexPositions.TokenOralFemale || who.SexType == SexPositions.TokenOralMale \
		|| who.SexType == SexPositions.TokenCowgirlFemale || who.SexType == SexPositions.TokenCowgirlMale \
		|| who.SexType == SexPositions.TokenCunnilingusFemale || who.SexType == SexPositions.TokenCunnilingusMale \
		|| who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
endFunction

bool Function CanUseTable(dxAliasActor who)
	return (who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
endFunction

bool Function CanUseChair(dxAliasActor who)
	return (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenSoloFemale)
endFunction

bool Function CanUseWorkbench(dxAliasActor who)
	return (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenStandingFemale || who.SexType == SexPositions.TokenStandingMale \
		|| who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
endFunction

bool Function CanUseAlchemyBench(dxAliasActor who)
	return (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenStandingFemale || who.SexType == SexPositions.TokenStandingMale)
endFunction

bool Function CanUseEnchantingBench(dxAliasActor who)
	return (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \
		|| who.SexType == SexPositions.TokenStandingFemale || who.SexType == SexPositions.TokenStandingMale)
endFunction
