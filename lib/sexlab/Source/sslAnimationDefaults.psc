scriptname sslAnimationDefaults extends sslAnimationFactory

function LoadAnimations()	
	; Prepare factory resources (as non creature)
	PrepareFactory()

	; Missionary
	; RegisterAnimation("SexLabMissionary")   			; 완료
 	; RegisterAnimation("APLegUp")						; 완료
	; endIf
	RegisterCategory("Missionary")

	RegisterAnimation("ArrokRapeLegUp") 				; 완료
	RegisterCategory("Rape")

	; DoggyStyle
	; RegisterAnimation("SexLabDoggyStyle")   			; 완료
	; RegisterAnimation("ArrokDoggyLoving")				; 완료
	; RegisterAnimation("LeitoDoggyAnalLoving")			; 완료
	RegisterCategory("DoggyStyle")

	; Cowgirl
	; RegisterAnimation("SexLabCowgirlLoving")			; 완료
	; RegisterAnimation("ArrokCowgirl")					; 완료
 	; RegisterAnimation("APCowgirlLoving")				; 완료

	RegisterCategory("Cowgirl")

	; Sideways
	; RegisterAnimation("SexLabSideways")
	; RegisterAnimation("ArrokSideways")
	RegisterCategory("Sideways")
	
	; Standing
	; RegisterAnimation("SexLabHuggingSex")
	; RegisterAnimation("SexLabStanding")
	; if APPack
	; 	RegisterAnimation("APStanding")
	; endIf
	RegisterCategory("Standing")
	
	; Anal
	; if APPack
	; 	RegisterAnimation("APAnal")
	; endIf
	RegisterCategory("Anal")
	
	; Oral
	; RegisterAnimation("ArrokBlowjob") 			; 완료
	; RegisterAnimation("ForcedBlowjob") 			; 완료
	; if APPack	
	 	;RegisterAnimation("APBlowjob") 			; 완료
	 	;RegisterAnimation("APKneelBlowjob") 		; 완료
	; endIf
	RegisterCategory("Oral")
	
	; Boobjob
	; RegisterAnimation("SexLabBoobjob")
	; RegisterAnimation("ArrokBoobjob")
	; RegisterAnimation("APBoobjob")
	RegisterCategory("Boobjob")
	
	; Lesbian
	; RegisterAnimation("ArrokLesbian")
	RegisterCategory("Lesbian")
	
	; Solo
	; RegisterAnimation("BleaghFemaleSolo")
	; RegisterAnimation("ArrokMaleMasturbation")
	RegisterCategory("Solo")

	; Misc
	RegisterCategory("Misc")

	; Register any remaining custom categories from json loaders
	RegisterOtherCategories()
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
	Base.AddPositionStage(a2, "Missionary_A2_S1", -100, sos = 2, sndTimeSlices="slt:2.5,pus:0.0|0.8,nxt")
	Base.AddPositionStage(a2, "Missionary_A2_S2", -100, sos = 2, sndTimeSlices="pus:0.2|1.43")
	Base.AddPositionStage(a2, "Missionary_A2_S3", -100, sos = 2, sndTimeSlices="pus:0.2|0.43")
	Base.AddPositionStage(a2, "Missionary_A2_S4", -100, sos = 2)

	Base.SetTags("Default,Sex,Missionary,Laying,Lying,Beds")

	Base.Save(id)
endFunction

function ArrokRapeLegUp(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Rape Leg Up"

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S1", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S2", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S4", 0, rotate = 180)
	Base.AddPositionStage(a1, "Arrok_LegUp_A1_S5", 0, rotate = 180)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S1", -46, sos = 2, sndTimeSlices="afd:0.0|5.0,nxt")
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S2", -46, sos = 2, sndTimeSlices="pus:0.4|0.8")
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S3", -46, sos = 2, sndTimeSlices="pus:0.2|0.5")
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S4", -46, sos = 4, sndTimeSlices="pus:0.0|0:4")
	Base.AddPositionStage(a2, "Arrok_LegUp_A2_S5", -46, sos = 3)

	Base.SetTags("Arrok,Rape,Aggressive,AggressiveDefault,Missionary,Laying,Lying")

	Base.Save(id)
endFunction


function ArrokBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok Blowjob"

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S1", 0, silent = true, openMouth = true, sndTimeSlices="slt:11,mou:3.0,mou:3.0,mou:3.0,mou:3.0,mou:3.0,mou:3.0,mou:3.0,mou:3.0,mou:1.0,nxt")
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S2", 0, silent = true, openMouth = true, sndTimeSlices="lic:2.0,lic:2.0,lic:1.0,,mou:2.0,mou:2.0,mou:1.0")
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S2", 0, silent = true, openMouth = true, sndTimeSlices="lic:2.0,lic:2.0,lic:1.0,,mou:2.0,mou:2.0,mou:1.0")
	Base.AddPositionStage(a1, "Arrok_Blowjob_A1_S3", 0, silent = true, openMouth = true, sndTimeSlices="lic:2.0")

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S1", -110, side = -3.5, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S2", -110, side = -3.5, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S2", -110, side = -3.5, sos = 2)
	Base.AddPositionStage(a2, "Arrok_Blowjob_A2_S3", -110, side = -3.5, sos = 2)

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
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S1", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S3", 0, sndTimeSlices="fck:0.2|0.46")
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S4", 0, sndTimeSlices="fck:0.2|0.2")
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S5", 0, sndTimeSlices="fck:0.2|0.3")
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S6", 0)
	Base.AddPositionStage(a1, "Arrok_Cowgirl_A1_S7", 0, sndTimeSlices="fck:0.2|0.3")
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

function ArrokDoggyLoving(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Arrok DoggyLoving"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S1", 0, sndTimeSlices="hpy:0.0|10.0")
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S2", 0)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S3", 0)
	Base.AddPositionStage(a1, "Arrok_DoggyStyle_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S1", -100, sos = 1)
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S2", -100, sos = 1, sndTimeSlices="fck:0.3|0.7")
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S3", -100, sos = 2, sndTimeSlices="fck:0.3|0.53")
	Base.AddPositionStage(a2, "Arrok_DoggyStyle_A2_S4", -100, sos = 2, sndTimeSlices="fck:0.8|1.53")

	Base.SetTags("Arrok,Sex,Anal,Doggystyle,Doggy,Loving,Reverse,Beds")

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

	Base.SetTags("Arrok,Sex,Solo,Penis,Hands,Masturbation,Standing,Dirty")

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


function ForcedBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Forced BlowJob"

	int a1 = Base.AddPosition(Female, Oral)	
	Base.AddPositionStage(a1, "ForcedBJ_A1_S2", 0, silent = true, openMouth = false, sndTimeSlices="slt:0.5,afd:4.0")
	Base.AddPositionStage(a1, "ForcedBJ_A1_S3", 0, silent = true, openMouth = true,  sndTimeSlices="slt:0.5,mou:2.5")
	Base.AddPositionStage(a1, "ForcedBJ_A1_S4", 0, silent = true, openMouth = true,  sndTimeSlices="slt:0.5,mou:2.5")
	Base.AddPositionStage(a1, "ForcedBJ_A1_S5", 0, silent = true, openMouth = true,  sndTimeSlices="mou:1.0")
	Base.AddPositionStage(a1, "ForcedBJ_A1_S6", 0, silent = true, openMouth = true,  sndTimeSlices="slt:1.0,dep:3.0")

	int a2 = Base.AddPosition(Male) 
	Base.AddPositionStage(a2, "ForcedBJ_A2_S2", 2, sos = 1)
	Base.AddPositionStage(a2, "ForcedBJ_A2_S3", 2, sos = 1)
	Base.AddPositionStage(a2, "ForcedBJ_A2_S4", 2, sos = 2)
	Base.AddPositionStage(a2, "ForcedBJ_A2_S5", 2, sos = 2)
	Base.AddPositionStage(a2, "ForcedBJ_A2_S6", 2, sos = 2)

	Base.SetTags("Force,Aggressive,AggressiveDefault,Sex,Penis,Oral,Boobjob,Handjob,Blowjob,Facing,CumInMouth,Beds,Dirty,Rape")

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

	Base.Name    = "SexlabDoggyStyle"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Anal)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S1", 0, sndTimeSlices="afd:0.0|3.0,nxt")
	Base.AddPositionStage(a1, "DoggyStyle_A1_S2", 0)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S3", 0)
	Base.AddPositionStage(a1, "DoggyStyle_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S1", -100, sos = 2, sndTimeSlices="fck:0.0|1.0,nxt")
	Base.AddPositionStage(a2, "DoggyStyle_A2_S2", -100, sos = 2)
	Base.AddPositionStage(a2, "DoggyStyle_A2_S3", -100, sos = 3, sndTimeSlices="fck:0.3|0.33")
	Base.AddPositionStage(a2, "DoggyStyle_A2_S4", -100, sos = 5)
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

function SexLabCowgirlLoving(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name    = "Reverse Cowgirl"

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S1", 0, sndTimeSlices="hpy:0.0|3.3,nxt")
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S2", 0)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S3", 0)
	Base.AddPositionStage(a1, "ReverseCowgirl_A1_S4", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S1", -102, sos = 3, sndTimeSlices="fck:2.8|0.5,nxt")
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S2", -102, sos = 3, sndTimeSlices="fck:0.1|1.2")
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S3", -102, sos = 3, sndTimeSlices="fck:0.1|0.53")
	Base.AddPositionStage(a2, "ReverseCowgirl_A2_S4", -102, sos = 3, sndTimeSlices="slt:2.8,fck:0.0|0.5")

	Base.SetTags("Default,Sex,Reverse,ReverseCowgirl,Standing,Creampie,Loving")

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

	Base.SetTags("Bleagh,Sex,Solo,Pussy,Hands,Laying,Beds,Masturbation,Dirty,Lesbian")

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

function APBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Blowjob"

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S1", 0, rotate = 180, silent = true, openMouth = true, sndTimeSlices="lic:2.0")
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S2", 0, rotate = 180, silent = true, openMouth = true, sndTimeSlices="mou:1.5")
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S3", 0, rotate = 180, silent = true, openMouth = true, sndTimeSlices="mou:1.0")
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S4", 0, rotate = 180, silent = true, openMouth = true, sndTimeSlices="mou:0.5")
	Base.AddPositionStage(a1, "AP_Blowjob_A1_S5", 0, rotate = 180, silent = true, openMouth = true, sndTimeSlices="dep:0.3")

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

function APCowgirlLoving(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Cowgirl"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, VaginalAnal)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S1", 0, rotate = 180, sndTimeSlices="hpy:0.0|10.0")
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S2", 0, rotate = 180, sndTimeSlices="fck:1.0|0.2")
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S3", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S4", 0, rotate = 180, sndTimeSlices="fck:0.8|0.2")
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S5", 0, rotate = 180)
	Base.AddPositionStage(a1, "AP_Cowgirl_A1_S6", 0, rotate = 180, sndTimeSlices="fck:0.3|0.3")

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S1", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S2", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S3", -44, sos = 1)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S4", -44, sos = 2)
	Base.AddPositionStage(a2, "AP_Cowgirl_A2_S4", -44, sos = 2)

	Base.SetTags("AP,Sex,Loving,Penis,Vaginal,Cowgirl,Facing,Beds,Creampie")

	Base.Save(id)
endFunction

function APKneelBlowjob(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Kneeling Blowjob"

	int a1 = Base.AddPosition(Female, Oral)
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S1", 0, rotate = 180, up = 1, silent = true, openMouth = true, sndTimeSlices="slt:0.2,mou:1.8")
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S2", 0, rotate = 180, up = 1, silent = true, openMouth = true, sndTimeSlices="slt:0.2,mou:1.3")
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S3", 0, rotate = 180, up = 1, silent = true, openMouth = true, sndTimeSlices="slt:0.2,mou:1.0")
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S4", 0, rotate = 180, up = 1, silent = true, openMouth = true, sndTimeSlices="slt:0.2,mou:0.3")
	Base.AddPositionStage(a1, "AP_KneelBlowjob_A1_S5", 0, rotate = 180, up = 1, silent = true, openMouth = true, sndTimeSlices="slt:0.2,dep:3.0")

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S1", -40, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S2", -40, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S3", -40, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S4", -40, sos = 1)
	Base.AddPositionStage(a2, "AP_IdleStand_A2_S5", -40, sos = 1)

	Base.SetTags("AP,Sex,Blowjob,Standing,Kneeling,CumInMouth")

	Base.Save(id)
endFunction

function APLegUp(int id)
	sslBaseAnimation Base = Create(id)

	Base.Enabled = true
	Base.Name    = "AP Leg Up"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, Vaginal)
	Base.AddPositionStage(a1, "AP_LegUp_A1_S1", 0, rotate = 180, sndTimeSlices="hpy:0.0|10.0")
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

	Base.SetTags("AP,Sex,Loving,Reverse,Standing")

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

	Base.SetTags("AP,Sex,Loving,Missionary,Standing")

	Base.Save(id)
endFunction

function LeitoDoggyAnalLoving(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "Leito DoggyStyle Anal"
	Base.SoundFX = Squishing

	int a1 = Base.AddPosition(Female, addCum=Anal)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S1", 0, sndTimeSlices="hpy:0.0|10.0")
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S2", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S3", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S4", 0)
	Base.AddPositionStage(a1, "Leito_DoggystyleAnal_A1_S5", 0)

	int a2 = Base.AddPosition(Male)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S1", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S2", 0, sos = 0)
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S3", 0, sos = 0, sndTimeSlices="fck:0.2|0.4")
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S4", 0, sos = 0, sndTimeSlices="fck:0.2|0.4")
	Base.AddPositionStage(a2, "Leito_DoggystyleAnal_A2_S5", 0, sos = 0)

	Base.SetTags("Leito,Sex,Loving,Anal,Anus,Doggy,Doggystyle,Knees,Behind,AnalCreampie")

	Base.Save(id)
endFunction



