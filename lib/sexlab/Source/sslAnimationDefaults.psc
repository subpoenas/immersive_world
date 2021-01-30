scriptname sslAnimationDefaults extends sslAnimationFactory


;/ 

For JSON loading animation instructions, see /data/SKSE/Plugins/SexLab/Animations/_README_.txt

/;

function LoadAnimations()
	; Prepare factory resources (as non creature)
	PrepareFactory()

	bool APPack = Game.GetPlayer().GetAnimationVariableInt("SexLabAPAnimations") >= 16300

	; Missionary
	RegisterAnimation("SexLabMissionary")
	RegisterAnimation("zjMissionary")
	RegisterAnimation("LeitoMissionary")
	RegisterAnimation("LeitoMissionaryVar")
	RegisterAnimation("SexLabAggrMissionary")
	RegisterAnimation("ArrokAggrMissionary")
	RegisterAnimation("ArrokAggrLegUp")
	if APPack
		RegisterAnimation("APBedMissionary")
		RegisterAnimation("APHoldLegUp")
		RegisterAnimation("APLegUp")
	endIf
	RegisterCategory("Missionary")

	; DoggyStyle
	RegisterAnimation("SexLabDoggyStyle")
	RegisterAnimation("SexLabAggrBehind")
	RegisterAnimation("SexLabAggrDoggyStyle")
	RegisterAnimation("ArrokDoggyStyle")
	RegisterAnimation("LeitoDoggy")
	if APPack
		RegisterAnimation("APDoggyStyle")
	endIf
	RegisterCategory("DoggyStyle")

	; Cowgirl
	RegisterAnimation("SexLabReverseCowgirl")
	RegisterAnimation("ArrokCowgirl")
	RegisterAnimation("ArrokReverseCowgirl")
	RegisterAnimation("zjCowgirl")
	RegisterAnimation("LeitoCowgirl")
	RegisterAnimation("LeitoRCowgirl")
	RegisterAnimation("fdRCowgirl")
	RegisterAnimation("MitosReverseCowgirl")
	if APPack
		RegisterAnimation("APCowgirl")
	endIf
	RegisterCategory("Cowgirl")

	; Sideways
	RegisterAnimation("SexLabSideways")
	RegisterAnimation("ArrokSideways")
	if APPack
		RegisterAnimation("APShoulder")
	endIf
	RegisterCategory("Sideways")
	
	; Standing
	RegisterAnimation("SexLabHuggingSex")
	RegisterAnimation("SexLabStanding")
	RegisterAnimation("ArrokHugFuck")
	RegisterAnimation("ArrokStanding")
	RegisterAnimation("LeitoStanding")
	RegisterAnimation("MitosStanding")
	if APPack
		RegisterAnimation("APStanding")
	endIf
	RegisterCategory("Standing")
	
	; Anal
	RegisterAnimation("ArrokAnal")
	RegisterAnimation("LeitoDoggyAnal")
	RegisterAnimation("MitosHugBehind")
	if APPack
		RegisterAnimation("APAnal")
		RegisterAnimation("APFaceDown")
	endIf
	RegisterCategory("Anal")
	
	; Oral
	RegisterAnimation("ArrokBlowjob")
	RegisterAnimation("ArrokOral")
	RegisterAnimation("ArrokLedgeBlowjob")
	RegisterAnimation("LeitoCunnilingus")
	if APPack
		RegisterAnimation("APBlowjob")
		RegisterAnimation("APKneelBlowjob")
		RegisterAnimation("APStandBlowjob")
		RegisterAnimation("APSkullFuck")
	endIf
	RegisterCategory("Oral")
	
	; Boobjob
	RegisterAnimation("SexLabBoobjob")
	RegisterAnimation("ArrokBoobjob")
	if APPack
		RegisterAnimation("APBoobjob")
	endIf
	RegisterCategory("Boobjob")
	
	; Foreplay
	RegisterAnimation("ArrokForeplay")
	RegisterAnimation("ArrokSittingForeplay")
	RegisterAnimation("ArrokStandingForeplay")
	RegisterCategory("Foreplay")

	; Lesbian
	RegisterAnimation("ArrokLesbian")
	RegisterAnimation("ZynLesbian")
	RegisterCategory("Lesbian")

	; Footjob
	RegisterAnimation("BleaghFootJob")
	RegisterAnimation("LeitoFeet")
	RegisterAnimation("LeitoFeet2")
	RegisterAnimation("LeitoFeet3")
	RegisterAnimation("MitosFootjob")
	RegisterCategory("Footjob")
	
	; Solo
	RegisterAnimation("BleaghFemaleSolo")
	RegisterAnimation("LeitoFemaleSolo")
	RegisterAnimation("ArrokMaleMasturbation")
	RegisterCategory("Solo")

	; Misc
	RegisterCategory("Misc")

	; Register any remaining custom categories from json loaders
	RegisterOtherCategories()
endFunction

function ArrokBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Blowjob"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S1", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S2", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S2", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S3", 0, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S1", -120, side = -3.5, sos = -1)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S2", -120, side = -3.5, sos = -1)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S2", -120, side = -3.5, sos = 1)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S3", -120, side = -3.5, sos = 2)

	Base.SetTags("Arrok,Sex,Hands,Oral,Laying,Blowjob,Handjob,Kneeling,Facial,Dirty")

	Base.Save(id)
endFunction

function ArrokBoobjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Boobjob"


	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Arrok_Boobjob_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Boobjob_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Boobjob_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Boobjob_A1_S4", 0, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male) ; 102
	Base.AddPositionStage(a2, "Arrok_Boobjob_A2_S1", -100, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Boobjob_A2_S2", -100, sos = 3)
	Base.AddPositionStage(a2, "Arrok_Boobjob_A2_S3", -100, sos = -2)
	Base.AddPositionStage(a2, "Arrok_Boobjob_A2_S4", -100, sos = -2)

	Base.SetTags("Arrok,BBP,Sex,Boobs,Penis,Kneeling,Facing,Boobjob,ChestCum,Facial,LeadIn,Breast")

	Base.Save(id)
endFunction

function ArrokCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S5", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S6", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S7", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S8", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S1", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S2", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S3", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S4", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S5", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S6", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S7", 3.5)
	Base.AddPositionStage(a2, "Arrok_Cowgirl_A2_S8", 3.5)

	Base.SetTags("Arrok,Sex,Cowgirl,Beds,Creampie")

	Base.Save(id)
endFunction

function ArrokDoggyStyle(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok DoggyStyle"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S1", -100, sos = -2)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S2", -100, sos = -2)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S3", -100, sos = -2)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S4", -100, sos = -2)

	Base.SetTags("Arrok,Sex,Anal,Doggystyle,Doggy,Reverse,Beds")

	Base.Save(id)
endFunction

function ArrokForeplay(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Foreplay"


	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Arrok_Foreplay_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Foreplay_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Foreplay_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Foreplay_A1_S4", 0)

	int a2 = Base.AddPosition(Male) ; -104
	Base.AddPositionStage(a2, "Arrok_Foreplay_A2_S1", 0, strapon = false, sos = 0)
	Base.AddPositionStage(a2, "Arrok_Foreplay_A2_S2", 0, strapon = false, sos = 0)
	Base.AddPositionStage(a2, "Arrok_Foreplay_A2_S3", 0, strapon = false, sos = 5)
	Base.AddPositionStage(a2, "Arrok_Foreplay_A2_S4", 0, strapon = false, sos = 5)

	Base.SetTags("Arrok,BBP,Foreplay,Oral,Hands,Dick,Laying,Lying,OnBack,Cuddling,LeadIn,CumInMouth")

	Base.Save(id)
endFunction

function ArrokAggrLegUp(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Aggressive Leg Up"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S1", -44, sos = 2)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S2", -44, sos = 2)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S3", -44, sos = 2)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S4", -44, sos = 4)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S5", -44, sos = 3)

	Base.SetTags("Arrok,Dirty,Aggressive,AggressiveDefault,Missionary,Laying,Lying")

	Base.Save(id)
endFunction

function ArrokMaleMasturbation(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Male Masturbation"

	int a1 = Base.AddPosition(Male)
	Base.AddPositionStage(a1, "Arrok_MaleMasturbation_A1_S1", -55.0, sos = 3)
	Base.AddPositionStage(a1, "Arrok_MaleMasturbation_A1_S2", -55.0, sos = 3)
	Base.AddPositionStage(a1, "Arrok_MaleMasturbation_A1_S3", -55.0, sos = 3)
	Base.AddPositionStage(a1, "Arrok_MaleMasturbation_A1_S4", -55.0, sos = 3)

	Base.SetTags("Arrok,Sex,Solo,Penis,Hands,Masturbation,Standing,AirCum,Dirty")

	Base.Save(id)
endFunction

function ArrokAggrMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Aggressive Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "Arrok_Missionary_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Missionary_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Missionary_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Missionary_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Missionary_A2_S1", -105, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Missionary_A2_S2", -105, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Missionary_A2_S3", -105, sos = 4)
	Base.AddPositionStage(a2, "Arrok_Missionary_A2_S4", -107, sos = 4)

	Base.SetTags("Arrok,Sex,Missionary,Aggressive,AggressiveDefault,Laying,Lying,Beds")

	Base.Save(id)
endFunction

function ArrokOral(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok 69"
	Base.SoundFX = SexMix

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Arrok_Oral_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_Oral_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_Oral_A1_S3", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Oral_A1_S3", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Oral_A1_S4", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Oral_A2_S1", -46, silent = true)
	Base.AddPositionStage(a2, "Arrok_Oral_A2_S1", -46, silent = true)
	Base.AddPositionStage(a2, "Arrok_Oral_A2_S2", -46, silent = true)
	Base.AddPositionStage(a2, "Arrok_Oral_A2_S3", -46, silent = true)
	Base.AddPositionStage(a2, "Arrok_Oral_A2_S3", -46, silent = true)

	Base.SetTags("Arrok,BBP,Sex,Pussy,Cunnilingus,Mouth,Kneeling,69,Laying,Blowjob,Facial,CumInMouth")

	Base.Save(id)
endFunction



function ArrokReverseCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Reverse Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_ReverseCowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_ReverseCowgirl_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_ReverseCowgirl_A2_S1", -105, sos = 5)
	Base.AddPositionStage(a2, "Arrok_ReverseCowgirl_A2_S2", -105, sos = 5)
	Base.AddPositionStage(a2, "Arrok_ReverseCowgirl_A2_S3", -105, sos = 8)
	Base.AddPositionStage(a2, "Arrok_ReverseCowgirl_A2_S4", -105, sos = 8)

	Base.SetTags("Arrok,Sex,Cowgirl,Reverse,ReverseCowgirl")

	Base.Save(id)
endFunction

function ArrokSideways(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Sideways Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_Sideways_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Sideways_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Sideways_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Sideways_A1_S4", 0)

	int a2 = Base.AddPosition(Male) ; -100
	Base.AddPositionStage(a2, "Arrok_Sideways_A2_S1", -118.5, sos = 8)
	Base.AddPositionStage(a2, "Arrok_Sideways_A2_S2", -118.5, sos = 8)
	Base.AddPositionStage(a2, "Arrok_Sideways_A2_S3", -118.5, sos = 6)
	Base.AddPositionStage(a2, "Arrok_Sideways_A2_S4", -118.5, sos = 5)

	Base.SetTags("Arrok,Sex,Reverse,Beds,Dirty,Sideways")

	Base.Save(id)
endFunction

function ArrokStanding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Standing Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_Standing_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Standing_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Standing_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Standing_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Standing_A2_S1", -104, sos = 9)
	Base.AddPositionStage(a2, "Arrok_Standing_A2_S2", -104, sos = 6)
	Base.AddPositionStage(a2, "Arrok_Standing_A2_S3", -104, sos = -7)
	Base.AddPositionStage(a2, "Arrok_Standing_A2_S4", -104, sos = 7)

	Base.SetTags("Arrok,Sex,Standing,Reverse")

	Base.Save(id)
endFunction

function ArrokStandingForeplay(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Standing Foreplay"

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Arrok_StandingForeplay_A1_S1", 0, silent = true)
	Base.AddPositionStage(a1, "Arrok_StandingForeplay_A1_S2", 0, silent = true)
	Base.AddPositionStage(a1, "Arrok_StandingForeplay_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_StandingForeplay_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_StandingForeplay_A2_S1", 0, silent = true, strapon = false, sos = -1)
	Base.AddPositionStage(a2, "Arrok_StandingForeplay_A2_S2", 0, silent = true, strapon = false, sos = -1)
	Base.AddPositionStage(a2, "Arrok_StandingForeplay_A2_S3", 0, silent = true, strapon = false, sos = 5)
	Base.AddPositionStage(a2, "Arrok_StandingForeplay_A2_S4", 0, silent = true, strapon = false, sos = 5)

	Base.SetTags("Arrok,BBP,Foreplay,Mouth,Penis,Vaginal,Kissing,LeadIn,Standing")

	Base.Save(id)
endFunction

function ArrokHugFuck(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok HugFuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "Arrok_Hugfuck_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Hugfuck_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Hugfuck_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Hugfuck_A1_S4", 0)

	int a2 = Base.AddPosition(Male) ; -99
	Base.AddPositionStage(a2, "Arrok_Hugfuck_A2_S1", -103.5, sos = 9)
	Base.AddPositionStage(a2, "Arrok_Hugfuck_A2_S2", -103.5, sos = 9)
	Base.AddPositionStage(a2, "Arrok_Hugfuck_A2_S3", -103.5, sos = 9)
	Base.AddPositionStage(a2, "Arrok_Hugfuck_A2_S4", -103.5, sos = 9)

	Base.SetTags("Arrok,Sex,Facing,Standing,Holding,Hugging")

	Base.Save(id)
endFunction

function ArrokLesbian(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Lesbian"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Arrok_Lesbian_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Lesbian_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Lesbian_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Lesbian_A1_S4", 0)

	int a2 = Base.AddPosition(Female)
	Base.AddPositionStage(a2, "Arrok_Lesbian_A2_S1", -100)
	Base.AddPositionStage(a2, "Arrok_Lesbian_A2_S2", -100)
	Base.AddPositionStage(a2, "Arrok_Lesbian_A2_S3", -100)
	Base.AddPositionStage(a2, "Arrok_Lesbian_A2_S4", -100)

	Base.SetTags("Arrok,BBP,Sex,Pussy,Hands,Boobs,Standing,69,Oral,Cunnilingus,Lesbian")

	Base.Save(id)
endFunction

function ArrokSittingForeplay(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Sitting Foreplay"


	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Arrok_SittingForeplay_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_SittingForeplay_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_SittingForeplay_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_SittingForeplay_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_SittingForeplay_A2_S1", 0, strapon = false)
	Base.AddPositionStage(a2, "Arrok_SittingForeplay_A2_S2", 0, strapon = false)
	Base.AddPositionStage(a2, "Arrok_SittingForeplay_A2_S3", 0, strapon = false)
	Base.AddPositionStage(a2, "Arrok_SittingForeplay_A2_S4", 0, strapon = false)

	Base.SetTags("Arrok,BBP,Mouth,Hands,Petting,Handjob,Kissing,Cuddling,Laying,HandsCum,Foreplay,LeadIn")

	Base.Save(id)
endFunction

function ArrokAnal(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Anal"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "Arrok_Anal_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_Anal_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Anal_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_Anal_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Anal_A2_S1", -17, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "Arrok_Anal_A2_S2", -8, sos = 3)
	Base.AddPositionStage(a2, "Arrok_Anal_A2_S3", -17, sos = 4)
	Base.AddPositionStage(a2, "Arrok_Anal_A2_S4", -17, sos = 3)

	Base.SetTags("Arrok,TBBP,Sex,Anal,Penis,Kneeling,Standing,Dirty")

	Base.Save(id)
endFunction

function ArrokLedgeBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Bed Blowjob"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Arrok_LedgeBlowjob_A1_S1", 0)
	Base.AddPositionStage(a1, "Arrok_LedgeBlowjob_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_LedgeBlowjob_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_LedgeBlowjob_A1_S4", 0)
	Base.AddPositionStage(a1, "Arrok_LedgeBlowjob_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_LedgeBlowjob_A2_S1", 0, sos = 0)
	Base.AddPositionStage(a2, "Arrok_LedgeBlowjob_A2_S2", 0, sos = 0)
	Base.AddPositionStage(a2, "Arrok_LedgeBlowjob_A2_S3", 0, sos = 0)
	Base.AddPositionStage(a2, "Arrok_LedgeBlowjob_A2_S4", 0, sos = 0)
	Base.AddPositionStage(a2, "Arrok_LedgeBlowjob_A2_S5", 0, sos = 0)

	Base.SetBedOffsets(-30.0, 0, -37.0, 0)

	Base.SetTags("Arrok,TBBP,Sex,Penis,Boobs,Oral,Boobjob,Handjob,Blowjob,Facing,CumInMouth,Beds,Dirty")

	Base.Save(id)
endFunction

function SexLabAggrBehind(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Rough Behind"
	Base.SoundFX = Squishing


	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "AggrBehind_A1_S1", 0)
	Base.AddPositionStage(a1, "AggrBehind_A1_S2", 0)
	Base.AddPositionStage(a1, "AggrBehind_A1_S3", 0)
	Base.AddPositionStage(a1, "AggrBehind_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AggrBehind_A2_S1", -12)
	Base.AddPositionStage(a2, "AggrBehind_A2_S2", -12)
	Base.AddPositionStage(a2, "AggrBehind_A2_S3", -12)
	Base.AddPositionStage(a2, "AggrBehind_A2_S4", -12)

	Base.SetTags("Sex,Aggressive,Default,AggressiveDefault,Anal,Doggystyle,Reverse,Behind,Holding,Kneeling,Standing")

	Base.Save(id)
endFunction

function SexLabAggrDoggyStyle(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Rough Doggy Style"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "AggrDoggyStyle_A1_S1", 0)
	Base.AddPositionStage(a1, "AggrDoggyStyle_A1_S2", 0)
	Base.AddPositionStage(a1, "AggrDoggyStyle_A1_S3", 0)
	Base.AddPositionStage(a1, "AggrDoggyStyle_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AggrDoggyStyle_A2_S1", -100, sos = 5)
	Base.AddPositionStage(a2, "AggrDoggyStyle_A2_S2", -100, sos = 5)
	Base.AddPositionStage(a2, "AggrDoggyStyle_A2_S3", -100, sos = 7)
	Base.AddPositionStage(a2, "AggrDoggyStyle_A2_S4", -100, sos = 5)

	Base.SetTags("Sex,Aggressive,AggressiveDefault,Default,Anal,Doggy,Doggystyle,Reverse,Behind,Kneeling,Beds,AnalCum")

	Base.Save(id)
endFunction

function SexLabAggrMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Rough Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "AggrMissionary_A1_S1", 0)
	Base.AddPositionStage(a1, "AggrMissionary_A1_S2", 0)
	Base.AddPositionStage(a1, "AggrMissionary_A1_S3", 0)
	Base.AddPositionStage(a1, "AggrMissionary_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AggrMissionary_A2_S1", -86, sos = 4)
	Base.AddPositionStage(a2, "AggrMissionary_A2_S2", -86, sos = 4)
	Base.AddPositionStage(a2, "AggrMissionary_A2_S3", -86, sos = 3)
	Base.AddPositionStage(a2, "AggrMissionary_A2_S4", -86, sos = 3)

	Base.SetTags("Sex,Aggressive,AggressiveDefault,Default,Missionary,Laying,Lying,Beds")

	Base.Save(id)
endFunction

function SexLabBoobjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Boobjob"


	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Boobjob_A1_S1", 0)
	Base.AddPositionStage(a1, "Boobjob_A1_S2", 0)
	Base.AddPositionStage(a1, "Boobjob_A1_S3", 0)
	Base.AddPositionStage(a1, "Boobjob_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Boobjob_A2_S1", -102)
	Base.AddPositionStage(a2, "Boobjob_A2_S2", -102)
	Base.AddPositionStage(a2, "Boobjob_A2_S3", -102)
	Base.AddPositionStage(a2, "Boobjob_A2_S4", -102)

	Base.SetTags("Default,Sex,Boobs,Breast,Penis,Boobjob,Laying,Facing,Beds,ChestCum,Dirty")

	Base.Save(id)
endFunction

function SexLabDoggyStyle(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "DoggyStyle"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S1", 0)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S2", 0)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S3", 0)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S1", -104, sos = 3)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S2", -104, sos = 3)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S3", -104, sos = 3)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S4", -104, sos = 3)

	Base.SetTags("Default,Sex,Anal,Doggystyle,Doggy,Reverse,Beds,VaginalCum")

	Base.Save(id)
endFunction

function SexLabHuggingSex(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Hugging Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "HuggingSex_A1_S1", 0)
	Base.AddPositionStage(a1, "HuggingSex_A1_S2", 0)
	Base.AddPositionStage(a1, "HuggingSex_A1_S3", 0)
	Base.AddPositionStage(a1, "HuggingSex_A1_S4", 0)

	int a2 = Base.AddPosition(Male) ; -99
	Base.AddPositionStage(a2, "HuggingSex_A2_S1", -100, sos = 7)
	Base.AddPositionStage(a2, "HuggingSex_A2_S2", -100, sos = 7)
	Base.AddPositionStage(a2, "HuggingSex_A2_S3", -100, sos = 7)
	Base.AddPositionStage(a2, "HuggingSex_A2_S4", -100, sos = 7)

	Base.SetTags("Default,Sex,Facing,Kneeling,Hugging,Creampie")

	Base.Save(id)
endFunction

function SexLabMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "SexLab Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "Missionary_A1_S1", 0)
	Base.AddPositionStage(a1, "Missionary_A1_S2", 0)
	Base.AddPositionStage(a1, "Missionary_A1_S3", 0)
	Base.AddPositionStage(a1, "Missionary_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Missionary_A2_S1", -100, sos = 2)
	Base.AddPositionStage(a2, "Missionary_A2_S2", -100, sos = 2)
	Base.AddPositionStage(a2, "Missionary_A2_S3", -100, sos = 2)
	Base.AddPositionStage(a2, "Missionary_A2_S4", -100, sos = 2)

	Base.SetTags("Default,Sex,Missionary,Laying,Lying,Beds")

	Base.Save(id)
endFunction

function SexLabReverseCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Reverse Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S4", 0)

	int a2 = Base.AddPosition(Male) ; -102
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S1", -107, sos = 3)
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S2", -107, sos = 3)
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S3", -107, sos = 3)
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S4", -107, sos = 3)

	Base.SetTags("Default,Sex,Reverse,ReverseCowgirl,Standing,Creampie,Dirty")

	Base.Save(id)
endFunction

function SexLabSideways(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Sideways Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Sideways_A1_S1", 0)
	Base.AddPositionStage(a1, "Sideways_A1_S2", 0)
	Base.AddPositionStage(a1, "Sideways_A1_S3", 0)
	Base.AddPositionStage(a1, "Sideways_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Sideways_A2_S1", -98, -3.0, sos = 2)
	Base.AddPositionStage(a2, "Sideways_A2_S2", -98, -3.0, sos = 2)
	Base.AddPositionStage(a2, "Sideways_A2_S3", -98, -3.0, sos = 2)
	Base.AddPositionStage(a2, "Sideways_A2_S4", -98, -3.0, sos = 2)

	Base.SetTags("Default,Sex,Reverse,Sideways,Beds,Dirty")

	Base.Save(id)
endFunction

function SexLabStanding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Standing Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "Standing_A1_S1", 0)
	Base.AddPositionStage(a1, "Standing_A1_S2", 0)
	Base.AddPositionStage(a1, "Standing_A1_S3", 0)
	Base.AddPositionStage(a1, "Standing_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Standing_A2_S1", -81, sos = 4)
	Base.AddPositionStage(a2, "Standing_A2_S2", -81, sos = 3)
	Base.AddPositionStage(a2, "Standing_A2_S3", -81, sos = 5)
	Base.AddPositionStage(a2, "Standing_A2_S4", -81, sos = 6)

	Base.SetTags("Default,Sex,Facing,Standing,Holding")

	Base.Save(id)
endFunction

function BleaghFootJob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Bleagh FootJob"

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "Bleagh_FootJob_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "Bleagh_FootJob_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "Bleagh_FootJob_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "Bleagh_FootJob_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "Bleagh_FootJob_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Bleagh_FootJob_A2_S1", -42)
	Base.AddPositionStage(a2, "Bleagh_FootJob_A2_S2", -42)
	Base.AddPositionStage(a2, "Bleagh_FootJob_A2_S3", -42)
	Base.AddPositionStage(a2, "Bleagh_FootJob_A2_S4", -42)
	Base.AddPositionStage(a2, "Bleagh_FootJob_A2_S5", -42)

	Base.SetTags("Bleagh,Sex,Fetish,Feet,Penis,Laying,Beds,Footjob,FeetCum")

	Base.Save(id)
endFunction

function BleaghFemaleSolo(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Bleagh Female Masturbation"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Bleagh_FemaleSolo_A1_S1", -55.0)
	Base.AddPositionStage(a1, "Bleagh_FemaleSolo_A1_S2", -55.0)
	Base.AddPositionStage(a1, "Bleagh_FemaleSolo_A1_S3", -55.0)
	Base.AddPositionStage(a1, "Bleagh_FemaleSolo_A1_S4", -55.0)
	Base.AddPositionStage(a1, "Bleagh_FemaleSolo_A1_S5", -55.0)

	Base.SetTags("Bleagh,Sex,Solo,Pussy,Hands,Laying,Beds,Masturbation,Dirty")

	Base.Save(id)
endFunction

function APAnal(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Anal"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "AP_Anal_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Anal_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Anal_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Anal_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Anal_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_Anal_A2_S1", -44)
	Base.AddPositionStage(a2, "AP_Anal_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_Anal_A2_S3", -44)
	Base.AddPositionStage(a2, "AP_Anal_A2_S4", -44)
	Base.AddPositionStage(a2, "AP_Anal_A2_S5", -44)

	Base.SetTags("AP,Sex,Straight,Anal,Penis,Doggystyle,Reverse,Beds,AnalCreampie,Dirty")

	Base.Save(id)
endFunction

function APBedMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Bed Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S5", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_BedMissionary_A1_S6", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S1", -44, sos = 5)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S2", -44, sos = 5)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S3", -44, sos = 5)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S4", -44, sos = 5)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S4", -44, sos = 5)
	Base.AddPositionStage(a2, "AP_BedMissionary_A2_S4", -44, sos = 5)

	Base.SetTags("AP,Sex,Missionary,Laying,Beds,Creampie")

	Base.Save(id)
endFunction

function APBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Blowjob"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S1", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S2", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S3", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S4", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S5", 0, rotate = 180, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S1", -43, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -43, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -43, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S3", -43, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S4", -43, sos = 1)

	Base.SetTags("AP,Sex,Oral,Blowjob,Laying,Facing,CumInMouth")

	Base.Save(id)
endFunction

function APBoobjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Boobjob"


	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_Boobjob_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Boobjob_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Boobjob_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Boobjob_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Boobjob_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S1", -40, sos = 6)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S2", -40, sos = 6)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S3", -40, sos = 6)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S4", -40, sos = 6)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S5", -40, sos = 6)

	Base.SetTags("AP,Sex,Straight,Penis,Boobs,Breast,Standing,Facing,Boobjob,ChestCum,Dirty")

	Base.Save(id)
endFunction

function APCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S5", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S6", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S1", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S3", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S4", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S4", -44, sos = 2)

	Base.SetTags("AP,Sex,Straight,Penis,Vaginal,Cowgirl,Facing,Beds,Creampie")

	Base.Save(id)
endFunction

function APKneelBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Kneeling Blowjob"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S1", 0, rotate = 180, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S2", 0, rotate = 180, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S3", 0, rotate = 180, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S4", 0, rotate = 180, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S5", 0, rotate = 180, up = 1, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S1", -45, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S2", -45, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S3", -45, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S4", -45, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S5", -45, sos = 1)

	Base.SetTags("AP,Sex,Blowjob,Standing,Kneeling,CumInMouth")

	Base.Save(id)
endFunction

function APLegUp(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Leg Up Fuck"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_LegUp_A2_S1", -44, up = 5, sos = 3)
	Base.AddPositionStage(a2, "AP_LegUp_A2_S2", -44, up = 5, sos = 3)
	Base.AddPositionStage(a2, "AP_LegUp_A2_S3", -44, up = 5, sos = 3)
	Base.AddPositionStage(a2, "AP_LegUp_A2_S4", -44, up = 5, sos = 3)
	Base.AddPositionStage(a2, "AP_LegUp_A2_S5", -44, up = 5, sos = 3)

	Base.SetTags("AP,Sex,Dirty,Aggressive,AggressiveDefault,Reverse,Standing")

	Base.Save(id)
endFunction

function APShoulder(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Shoulder"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "AP_Shoulder_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Shoulder_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Shoulder_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Shoulder_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Shoulder_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S1", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S2", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S3", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S4", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S5", -44, sos = 2)

	Base.SetTags("AP,Sex,Straight,Penis,Vaginal,Standing,Reverse,Creampie")

	Base.Save(id)
endFunction

function APStandBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Standing Blowjob"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_StandBlowjob_A1_S1", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_StandBlowjob_A1_S2", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_StandBlowjob_A1_S3", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_StandBlowjob_A1_S4", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_StandBlowjob_A1_S5", 0, rotate = 180, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S1", -44, sos = -1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S2", -44, sos = -1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S3", -44, sos = -1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S4", -44, sos = -1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S5", -44, sos = -1)

	Base.SetTags("AP,Sex,Straight,Oral,Blowjob,Standing,Facing,Dirty,CumInMouth")

	Base.Save(id)
endFunction

function APStanding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Standing"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "AP_Standing_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Standing_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Standing_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Standing_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Standing_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_Standing_A2_S1", -43, sos = 2)
	Base.AddPositionStage(a2, "AP_Standing_A2_S2", -43, sos = 2)
	Base.AddPositionStage(a2, "AP_Standing_A2_S2", -43, sos = 2)
	Base.AddPositionStage(a2, "AP_Standing_A2_S3", -43, sos = 2)
	Base.AddPositionStage(a2, "AP_Standing_A2_S3", -43, sos = 2)

	Base.SetTags("AP,Sex,Straight,Vaginal,Standing,Creampie")

	Base.Save(id)
endFunction

function APDoggyStyle(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP DoggyStyle"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "AP_DoggyStyle_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_DoggyStyle_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_DoggyStyle_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_DoggyStyle_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_DoggyStyle_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S1", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S3", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S3", -44)

	Base.SetTags("AP,Sex,Straight,Penis,Anal,Doggystyle,Doggy,Knees,Kneeling,Reverse,Beds,Creampie")

	Base.Save(id)
endFunction

function APHoldLegUp(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Holding Leg Up"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "AP_HoldLegUp_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_HoldLegUp_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_HoldLegUp_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_HoldLegUp_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_HoldLegUp_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S1", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S3", -44)
	Base.AddPositionStage(a2, "AP_HoldLegUp_A2_S3", -44)

	Base.SetTags("AP,Sex,Aggressive,AggressiveDefault,Missionary,Standing")

	Base.Save(id)
endFunction

function APFaceDown(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Face Down Anal"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "AP_FaceDown_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_FaceDown_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_FaceDown_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_FaceDown_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_FaceDown_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_FaceDown_A2_S1", -44)
	Base.AddPositionStage(a2, "AP_FaceDown_A2_S2", -44)
	Base.AddPositionStage(a2, "AP_FaceDown_A2_S3", -44)
	Base.AddPositionStage(a2, "AP_FaceDown_A2_S3", -44)
	Base.AddPositionStage(a2, "AP_FaceDown_A2_S4", -44)

	Base.SetTags("AP,Sex,Straight,Penis,Vaginal,Missionary,Laying,Lying,OnBack,Beds,Reverse,Creampie,Aggressive,AggressiveDefault,Dirty")

	Base.Save(id)
endFunction

function APSkullFuck(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Skull Fuck"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_SkullFuck_A1_S1", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_SkullFuck_A1_S2", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_SkullFuck_A1_S3", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_SkullFuck_A1_S4", 0, rotate = 180, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "AP_SkullFuck_A1_S5", 0, rotate = 180, silent = true, openMouth = true)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_SkullFuck_A2_S1", -49, sos = 1)
	Base.AddPositionStage(a2, "AP_SkullFuck_A2_S2", -49, sos = 1)
	Base.AddPositionStage(a2, "AP_SkullFuck_A2_S3", -49, sos = 2)
	Base.AddPositionStage(a2, "AP_SkullFuck_A2_S4", -49, sos = 2)
	Base.AddPositionStage(a2, "AP_SkullFuck_A2_S5", -49, sos = 2)

	Base.SetTags("AP,Sex,Straight,Penis,Oral,Holding,Blowjob,CumInMouth,Aggressive,AggressiveDefault,Dirty")

	Base.Save(id)
endFunction



function ZynLesbian(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Zyn Lesbian"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "Zyn_Lesbian_A1_S1", 0, silent = true)
	Base.AddPositionStage(a1, "Zyn_Lesbian_A1_S2", 0)
	Base.AddPositionStage(a1, "Zyn_Lesbian_A1_S3", 0)
	Base.AddPositionStage(a1, "Zyn_Lesbian_A1_S4", 0)

	int a2 = Base.AddPosition(Female)
	Base.AddPositionStage(a2, "Zyn_Lesbian_A2_S1", -81, silent = true)
	Base.AddPositionStage(a2, "Zyn_Lesbian_A2_S2", -81, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "Zyn_Lesbian_A2_S3", -81)
	Base.AddPositionStage(a2, "Zyn_Lesbian_A2_S4", -81)

	Base.SetTags("Zyn,Sex,Mouth,Pussy,Facing,Standing,Kissing,Lesbian")

	Base.Save(id)
endFunction

function zjCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "3jiou Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "3j_Cowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "3j_Cowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "3j_Cowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "3j_Cowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "3j_Cowgirl_A1_S5", 0)
		
	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "3j_Cowgirl_A2_S1", 0)
	Base.AddPositionStage(a2, "3j_Cowgirl_A2_S2", 0)
	Base.AddPositionStage(a2, "3j_Cowgirl_A2_S3", 0)
	Base.AddPositionStage(a2, "3j_Cowgirl_A2_S4", 0)
	Base.AddPositionStage(a2, "3j_Cowgirl_A2_S5", 0)
	
	Base.SetTags("3jiou,Sex,Cowgirl,Reverse,Beds")

	Base.Save(id)
endFunction

function zjMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "3jiou Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=VaginalAnal)
	Base.AddPositionStage(a1, "3j_Missionary_A1_S1", 0)
	Base.AddPositionStage(a1, "3j_Missionary_A1_S2", 0)
	Base.AddPositionStage(a1, "3j_Missionary_A1_S3", 0)
	Base.AddPositionStage(a1, "3j_Missionary_A1_S4", 0)
	
	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "3j_Missionary_A2_S1", 0)
	Base.AddPositionStage(a2, "3j_Missionary_A2_S2", 0)
	Base.AddPositionStage(a2, "3j_Missionary_A2_S3", 0)
	Base.AddPositionStage(a2, "3j_Missionary_A2_S4", 0)
	
	Base.SetTags("3jiou,Sex,Laying,Missionary,Beds,Laying,Lying")

	Base.Save(id)
endFunction

function LeitoCunnilingus(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Cunnilingus"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Leito_Cunnilingus_A1_S1", -50.0)
	Base.AddPositionStage(a1, "Leito_Cunnilingus_A1_S2", -50.0)
	Base.AddPositionStage(a1, "Leito_Cunnilingus_A1_S3", -50.0)
	Base.AddPositionStage(a1, "Leito_Cunnilingus_A1_S4", -50.0)
	Base.AddPositionStage(a1, "Leito_Cunnilingus_A1_S5", -50.0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Cunnilingus_A2_S1", -50.0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cunnilingus_A2_S2", -50.0, silent = true, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cunnilingus_A2_S3", -50.0, silent = true, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cunnilingus_A2_S4", -50.0, silent = true, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cunnilingus_A2_S5", -50.0, sos = 3)

	Base.SetStageTimer(5, 7.0)

	Base.SetTags("Leito,Sex,Pussy,Hands,Mouth,Cunnilingus,Doggystyle,Missionary,Foreplay")

	Base.Save(id)
endFunction

function LeitoCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_Cowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Cowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Cowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Cowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Cowgirl_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Cowgirl_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cowgirl_A2_S2", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cowgirl_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cowgirl_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Cowgirl_A2_S5", 0, sos = 3)

	Base.SetStageSoundFX(5, none)

	Base.SetTags("Leito,Sex,Cowgirl")

	Base.Save(id)
endFunction

function LeitoDoggy(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito DoggyStyle"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_Doggystyle_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Doggystyle_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Doggystyle_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Doggystyle_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Doggystyle_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Doggystyle_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Doggystyle_A2_S2", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Doggystyle_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Doggystyle_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Doggystyle_A2_S5", 0, sos = 3)

	Base.SetStageSoundFX(1, none)
	Base.SetStageSoundFX(5, none)

	Base.SetTags("Leito,Sex,Straight,Penis,Vaginal,Doggy,Doggystyle,Reverse,Knees,Standing,Hugging,Creampie,Dirty")

	Base.Save(id)
endFunction

function LeitoDoggyAnal(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito DoggyStyle Anal"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Anal)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S1", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S2", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S3", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S4", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S5", 0, sos = 0)

	Base.SetTags("Leito,Sex,Straight,Penis,Anal,Anus,Doggy,Doggystyle,Knees,Behind,Dirty,AnalCreampie")

	Base.Save(id)
endFunction

function LeitoFemaleSolo(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Female Masturbation"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Leito_FemaleSolo_A1_S1", -55.0)
	Base.AddPositionStage(a1, "Leito_FemaleSolo_A1_S2", -55.0)
	Base.AddPositionStage(a1, "Leito_FemaleSolo_A1_S3", -55.0)
	Base.AddPositionStage(a1, "Leito_FemaleSolo_A1_S4", -55.0)
	Base.AddPositionStage(a1, "Leito_FemaleSolo_A1_S5", -55.0)

	Base.SetStageTimer(5, 8.2)
	
	Base.SetTags("Leito,Solo,Pussy,Hands,Doggystyle,Kneeling,Masturbation,Dirty")

	Base.Save(id)
endFunction

function LeitoFeet(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Footjob 1"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Leito_Feet_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Feet_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Feet_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Feet_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Feet_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Feet_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Feet_A2_S2", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Feet_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Feet_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Feet_A2_S5", 0, sos = 3)

	Base.SetStageSoundFX(1, none)
	Base.SetStageSoundFX(2, none)
	Base.SetStageSoundFX(5, none)

	Base.SetTags("Leito,Sex,Straight,Penis,Mouth,Fetish,Feet,Footjob,Missionary,Dirty,FeetCum")

	Base.Save(id)
endFunction

function LeitoFeet2(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Footjob 2"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Leito_Feet2_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Feet2_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Feet2_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Feet2_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Feet2_A1_S5", 0)

	int a2 = Base.AddPosition(Male, addCum=Vaginal)
	Base.AddPositionStage(a2, "Leito_Feet2_A2_S1", 0, sos = 9)
	Base.AddPositionStage(a2, "Leito_Feet2_A2_S2", 0, sos = 1)
	Base.AddPositionStage(a2, "Leito_Feet2_A2_S3", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_Feet2_A2_S4", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_Feet2_A2_S5", 0, sos = 0)

	Base.SetStageSoundFX(1, none)
	Base.SetStageSoundFX(2, none)
	Base.SetStageSoundFX(5, none)

	Base.SetTags("Leito,Sex,Straight,Penis,Mouth,Feet,Footjob,Cowgirl,Fetish,Facing,Dirty,FeetCum")

	Base.Save(id)
endFunction

function LeitoFeet3(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Footjob 3"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Anal)
	Base.AddPositionStage(a1, "Leito_Feet3_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Feet3_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Feet3_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Feet3_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Feet3_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Feet3_A2_S1", 0, sos = 6)
	Base.AddPositionStage(a2, "Leito_Feet3_A2_S2", 0, sos = 6)
	Base.AddPositionStage(a2, "Leito_Feet3_A2_S3", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_Feet3_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Feet3_A2_S5", 0, sos = 3)

	Base.SetTags("Leito,Sex,Straight,Penis,Hands,Feet,Handjob,Footjob,Fetish,Doggystyle,FeetCum,Dirty,AnalCum")

	Base.Save(id)
endFunction

function LeitoMissionary(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Missionary"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_Missionary1_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Missionary1_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Missionary1_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Missionary1_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Missionary1_A1_S5", 0)
	
	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Missionary1_A2_S1", 0)
	Base.AddPositionStage(a2, "Leito_Missionary1_A2_S2", 0)
	Base.AddPositionStage(a2, "Leito_Missionary1_A2_S3", 0)
	Base.AddPositionStage(a2, "Leito_Missionary1_A2_S4", 0)
	Base.AddPositionStage(a2, "Leito_Missionary1_A2_S5", 0)
	
	Base.SetTags("Leito,Sex,Missionary,Laying,Lying,OnBack,Beds,Creampie")

	Base.Save(id)
endFunction

function LeitoMissionaryVar(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Missionary 2"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_Missionary2_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Missionary2_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Missionary2_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Missionary2_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Missionary2_A1_S5", 0)
	
	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Missionary2_A2_S1", 0)
	Base.AddPositionStage(a2, "Leito_Missionary2_A2_S2", 0)
	Base.AddPositionStage(a2, "Leito_Missionary2_A2_S3", 0)
	Base.AddPositionStage(a2, "Leito_Missionary2_A2_S4", 0)
	Base.AddPositionStage(a2, "Leito_Missionary2_A2_S5", 0)
	
	Base.SetTags("Leito,Sex,Missionary,Laying,Lying,Beds,Creampie")

	Base.Save(id)
endFunction

function LeitoRCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Reverse Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_ReverseCowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_ReverseCowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_ReverseCowgirl_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_ReverseCowgirl_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_ReverseCowgirl_A2_S2", 0, sos = 8)
	Base.AddPositionStage(a2, "Leito_ReverseCowgirl_A2_S3", 0, sos = 8)
	Base.AddPositionStage(a2, "Leito_ReverseCowgirl_A2_S4", 0, sos = 8)
	Base.AddPositionStage(a2, "Leito_ReverseCowgirl_A2_S5", 0, sos = 8)

	Base.SetTags("Leito,Sex,Cowgirl,Laying,Reverse,ReverseCowgirl,Beds")

	Base.Save(id)
endFunction

function LeitoStanding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito Standing"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Leito_Standing_A1_S1", 0)
	Base.AddPositionStage(a1, "Leito_Standing_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_Standing_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_Standing_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_Standing_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_Standing_A2_S1", 0, sos = -1)
	Base.AddPositionStage(a2, "Leito_Standing_A2_S2", 0, sos = -1)
	Base.AddPositionStage(a2, "Leito_Standing_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Standing_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Leito_Standing_A2_S5", 0, sos = 3)

	Base.SetStageSoundFX(1, none)
	Base.SetStageSoundFX(2, none)

	Base.SetTags("Leito,Sex,Straight,Penis,Hands,Vaginal,Handjob,Standing,Facing,Hugging,Creampie")

	Base.Save(id)
endFunction

function fdRCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "4uDIK Reverse Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=VaginalAnal)
	Base.AddPositionStage(a1, "4D_ReverseCowgirl_A1_S1", 0, silent=true, openMouth = true)
	Base.AddPositionStage(a1, "4D_ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "4D_ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "4D_ReverseCowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "4D_ReverseCowgirl_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "4D_ReverseCowgirl_A2_S1", 0, sos = 2, silent=true, openMouth = true)
	Base.AddPositionStage(a2, "4D_ReverseCowgirl_A2_S2", 0, sos = 6)
	Base.AddPositionStage(a2, "4D_ReverseCowgirl_A2_S3", 0, sos = -1)
	Base.AddPositionStage(a2, "4D_ReverseCowgirl_A2_S4", 0, sos = -4)
	Base.AddPositionStage(a2, "4D_ReverseCowgirl_A2_S5", 0, sos = -4)

	Base.SetTags("4D,Sex,Cowgirl,Reverse,ReverseCowgirl,Beds,Dirty")

	Base.Save(id)
endFunction

function MitosFootjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Mitos Footjob"

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Mitos_Footjob_A1_S1", 0)
	Base.AddPositionStage(a1, "Mitos_Footjob_A1_S2", 0)
	Base.AddPositionStage(a1, "Mitos_Footjob_A1_S3", 0)
	Base.AddPositionStage(a1, "Mitos_Footjob_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Mitos_Footjob_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Footjob_A2_S2", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Footjob_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Footjob_A2_S4", 0, sos = 0)

	Base.SetTags("Mitos,Sex,Straight,Anus,Penis,Fetish,Feet,Footjob,Reverse,Standing,Dirty,FeetCum")

	Base.Save(id)
endFunction

function MitosHugBehind(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Mitos Hugging Behind"

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "Mitos_Hugbehind_A1_S1", 0)
	Base.AddPositionStage(a1, "Mitos_Hugbehind_A1_S2", 0)
	Base.AddPositionStage(a1, "Mitos_Hugbehind_A1_S3", 0)
	Base.AddPositionStage(a1, "Mitos_Hugbehind_A1_S4", 0)
	Base.AddPositionStage(a1, "Mitos_Hugbehind_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Mitos_Hugbehind_A2_S1", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Hugbehind_A2_S2", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Hugbehind_A2_S3", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Hugbehind_A2_S4", 0, sos = 3)
	Base.AddPositionStage(a2, "Mitos_Hugbehind_A2_S5", 0, sos = 3)

	Base.SetStageTimer(5, 7.0)

	Base.SetTags("Mitos,Sex,Straight,Penis,Fetish,Feet,Footjob,Reverse,Laying,Dirty,FeetCum")

	Base.Save(id)
endFunction

function MitosReverseCowgirl(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Mitos Reverse Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Vaginal)
	Base.AddPositionStage(a1, "Mitos_ReverseCowgirl_A1_S1", 0)
	Base.AddPositionStage(a1, "Mitos_ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Mitos_ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "Mitos_ReverseCowgirl_A1_S4", 0)
	Base.AddPositionStage(a1, "Mitos_ReverseCowgirl_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Mitos_ReverseCowgirl_A2_S1", 0)
	Base.AddPositionStage(a2, "Mitos_ReverseCowgirl_A2_S2", 0)
	Base.AddPositionStage(a2, "Mitos_ReverseCowgirl_A2_S3", 0)
	Base.AddPositionStage(a2, "Mitos_ReverseCowgirl_A2_S4", 0)
	Base.AddPositionStage(a2, "Mitos_ReverseCowgirl_A2_S5", 0)

	Base.SetTags("Mitos,Sex,Cowgirl,Reverse,ReverseCowgirl,Laying,Lying,Dirty")

	Base.Save(id)
endFunction

function MitosStanding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Mitos Standing"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Anal)
	Base.AddPositionStage(a1, "Mitos_Standing_A1_S1", 0)
	Base.AddPositionStage(a1, "Mitos_Standing_A1_S2", 0)
	Base.AddPositionStage(a1, "Mitos_Standing_A1_S3", 0)
	Base.AddPositionStage(a1, "Mitos_Standing_A1_S4", 0)
	Base.AddPositionStage(a1, "Mitos_Standing_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Mitos_Standing_A2_S1", 0)
	Base.AddPositionStage(a2, "Mitos_Standing_A2_S2", 0)
	Base.AddPositionStage(a2, "Mitos_Standing_A2_S3", 0)
	Base.AddPositionStage(a2, "Mitos_Standing_A2_S4", 0)
	Base.AddPositionStage(a2, "Mitos_Standing_A2_S5", 0)

	Base.SetTags("Mitos,Sex,Anal,Standing,Reverse,Behind,Dirty")

	Base.Save(id)
endFunction

