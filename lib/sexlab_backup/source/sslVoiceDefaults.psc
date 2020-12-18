scriptname sslVoiceDefaults extends sslVoiceFactory

function LoadVoices()
	; Prepare factory resources
	PrepareFactory()
	; Female voices
	RegisterVoice("FemaleTeen")
	RegisterVoice("FemaleYoung")
	RegisterVoice("FemaleCommon")
	RegisterVoice("FemaleCoward")	
	RegisterVoice("FemaleSolder")
	RegisterVoice("FemaleSultry")
	RegisterVoice("FemaleEven")
	RegisterVoice("FemaleCommander")
	RegisterVoice("FemaleShrill")
	RegisterVoice("FemaleOld")
	RegisterVoice("FemaleElf")
	RegisterVoice("FemaleKhajit")
	; Male voices
	RegisterVoice("MaleTeen")
	RegisterVoice("MaleYoung")
	RegisterVoice("MaleCommon")
	RegisterVoice("MaleBandit")
	RegisterVoice("MaleBrute")
	RegisterVoice("MaleOld")
	RegisterVoice("MaleOrc")
	RegisterVoice("MaleElf")
	RegisterVoice("MaleKhajit")
endFunction

function FemaleTeen(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Teen (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6E8, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067547, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067546, "SexLab.esm") as Sound

	Base.SetTags("Female,Teen")

	Base.Save(id)
endFunction

function FemaleYoung(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Young (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6E9, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x0106754B, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106754A, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067549, "SexLab.esm") as Sound

	Base.SetTags("Female,Young")

	Base.Save(id)
endFunction

function FemaleCommon(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Common (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EA, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x0106754E, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106754D, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106754C, "SexLab.esm") as Sound

	Base.SetTags("Female,Common")

	Base.Save(id)
endFunction

function FemaleCoward(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Coward (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EB, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067551, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067550, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106754F, "SexLab.esm") as Sound

	Base.SetTags("Female,Coward")

	Base.Save(id)
endFunction

function FemaleSolder(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Solder (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EC, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067554, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067553, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067552, "SexLab.esm") as Sound

	Base.SetTags("Female,Solder")

	Base.Save(id)
endFunction

function FemaleSultry(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Sultry (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EC, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067554, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067553, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067552, "SexLab.esm") as Sound

	Base.SetTags("Female,Sultry")

	Base.Save(id)
endFunction

function FemaleEven(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Even (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EC, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067554, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067553, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067552, "SexLab.esm") as Sound

	Base.SetTags("Female,Even")

	Base.Save(id)
endFunction

function FemaleCommander(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Commander (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EC, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067554, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067553, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067552, "SexLab.esm") as Sound

	Base.SetTags("Female,Commander")

	Base.Save(id)
endFunction


function FemaleShrill(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Shrill (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EC, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067554, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067553, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067552, "SexLab.esm") as Sound

	Base.SetTags("Female,Shrill")

	Base.Save(id)
endFunction

function FemaleOld(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Old (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6ED, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067557, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067556, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067555, "SexLab.esm") as Sound
 

	Base.SetTags("Female,Old")

	Base.Save(id)
endFunction

function FemaleElf(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Elf (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6ED, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067557, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067556, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067555, "SexLab.esm") as Sound
 

	Base.SetTags("Female,Elf")

	Base.Save(id)
endFunction

function FemaleOrc(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Orc (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EE, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x0106755A, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067559, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067558, "SexLab.esm") as Sound

	Base.SetTags("Female,Orc")

	Base.Save(id)
endFunction

function FemaleKhajit(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Khajit (F)"
	Base.Gender = Female

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Victim =  Game.GetFormFromFile(0x0108F6EF, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x0106755D, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106755C, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106755B, "SexLab.esm") as Sound

	Base.SetTags("Female,Khajit")

	Base.Save(id)
endFunction

function MaleTeen(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name = "Teen (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress =  Game.GetFormFromFile(0x0108F6F0, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067560, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106755F, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106755E, "SexLab.esm") as Sound
 
	Base.SetTags("Male,Teen")

	Base.Save(id)
endFunction

function MaleYoung(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name = "Young (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress =  Game.GetFormFromFile(0x0108F6F0, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067560, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106755F, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106755E, "SexLab.esm") as Sound
 
	Base.SetTags("Male,Young")

	Base.Save(id)
endFunction

function MaleCommon(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name = "Common (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress =  Game.GetFormFromFile(0x0108F6F0, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067560, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x0106755F, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x0106755E, "SexLab.esm") as Sound
 
	Base.SetTags("Male,Common")

	Base.Save(id)
endFunction

function MaleBandit(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Bandit (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F1, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067563, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067562, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067561, "SexLab.esm") as Sound

	Base.SetTags("Male,Bandit")

	Base.Save(id)
endFunction

function MaleBrute(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Brute (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F1, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067563, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067562, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067561, "SexLab.esm") as Sound

	Base.SetTags("Male,Brute")

	Base.Save(id)
endFunction

function MaleOld(int id)
	sslBaseVoice Base = Create(id)

	Base.Name   = "Old (M)"
	Base.Gender = Male

	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F2, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067566, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067565, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067564, "SexLab.esm") as Sound

	Base.SetTags("Male,ld")

	Base.Save(id)
endFunction

function MaleOrc(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name   = "Orc (M)"
	Base.Gender = Male
	
	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F3, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067569, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067568, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067567, "SexLab.esm") as Sound

	Base.SetTags("Male,Orc")

	Base.Save(id)
endFunction


function MaleElf(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name   = "Elf (M)"
	Base.Gender = Male
	
	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F3, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067569, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067568, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067567, "SexLab.esm") as Sound

	Base.SetTags("Male,Elf")

	Base.Save(id)
endFunction

function MaleKhajit(int id)
	sslBaseVoice Base = Create(id)
	
	Base.Name   = "Khajit (M)"
	Base.Gender = Male
	
	Base.Orgasm = Game.GetFormFromFile(0x01067548, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x0108F6F2, "SexLab.esm") as Sound
	Base.Mild   = Game.GetFormFromFile(0x01067566, "SexLab.esm") as Sound
	Base.Medium = Game.GetFormFromFile(0x01067565, "SexLab.esm") as Sound
	Base.Hot    = Game.GetFormFromFile(0x01067564, "SexLab.esm") as Sound

	Base.SetTags("Male,Khajit")

	Base.Save(id)
endFunction


function LoadCreatureVoices()
	; Prepare factory resources
	PrepareFactory()
	; Register creature voices
	RegisterVoice("ChaurusVoice01")
	RegisterVoice("DogVoice01")
	RegisterVoice("DraugrVoice01")
	RegisterVoice("FalmerVoice01")
	RegisterVoice("GiantVoice01")
	RegisterVoice("HorseVoice01")
	RegisterVoice("SprigganVoice01")
	RegisterVoice("TrollVoice01")
	RegisterVoice("WerewolfVoice01")
	RegisterVoice("WolfVoice01")
endFunction

function ChaurusVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Chaurus 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C090, "SexLab.esm") as Sound

	Base.AddRaceKey("Chaurus")
	Base.AddRaceKey("Chaurusflyers")

	Base.Save(id)
endFunction

function DogVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Dog 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C091, "SexLab.esm") as Sound

	Base.AddRaceKey("Dogs")
	Base.AddRaceKey("Dogpanic")

	Base.Save(id)
endFunction

function DraugrVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Draugr 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08C, "SexLab.esm") as Sound

	Base.AddRaceKey("Draugrs")

	Base.Save(id)
endFunction

function FalmerVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Falmer 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08F, "SexLab.esm") as Sound

	Base.AddRaceKey("Falmers")

	Base.Save(id)
endFunction

function GiantVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Giant 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08E, "SexLab.esm") as Sound

	Base.AddRaceKey("Giants")

	Base.Save(id)
endFunction

function HorseVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Horse 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08D, "SexLab.esm") as Sound

	Base.AddRaceKey("Horses")
	Base.AddRaceKey("Horseses")

	Base.Save(id)
endFunction

function SprigganVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Spriggan 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08B, "SexLab.esm") as Sound

	Base.AddRaceKey("Spriggans")
	Base.AddRaceKey("SprigganXan")

	Base.Save(id)
endFunction

function TrollVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Troll 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C089, "SexLab.esm") as Sound

	Base.AddRaceKey("Trolls")

	Base.Save(id)
endFunction

function WerewolfVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Werewolf 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8C08A, "SexLab.esm") as Sound

	Base.AddRaceKey("Werewolves")
	Base.AddRaceKey("Werewolfgal")
	Base.AddRaceKey("Werewolfpanic")

	Base.Save(id)
endFunction

function WolfVoice01(int id)
	sslBaseVoice Base = Create(id)

	Base.Name    = "Wolf 1 (Creature)"
	Base.Gender  = Creature
	
	Base.Orgasm = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound
	Base.Victim    = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound
	Base.Aggress = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound
	Base.Mild    = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound
	Base.Medium  = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound
	Base.Hot     = Game.GetFormFromFile(0x8B5BB, "SexLab.esm") as Sound

	Base.AddRaceKey("Wolves")
	Base.AddRaceKey("Wolfpanic")

	Base.Save(id)
endFunction
