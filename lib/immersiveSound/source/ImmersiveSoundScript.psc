Scriptname ImmersiveSoundScript extends Quest

Actor Property Player  Auto

Sound Property FurnitureSoundRes  Auto
Sound Property SquirshSoundRes  Auto
Sound Property BlowJobSoundRes  Auto
Sound Property HitSoundRes  Auto

SexLabFramework property SexLab auto

Actor[] actorList = none
Sound[] etcSounds = none
Sound[] shockFSounds = none
Sound[] shameFSounds = none 
Sound[] cryFSounds = none

bool[] actorVictimList = none
sslThreadController sslController = none
float sfxBedVolume = 0.1


event OnInit()
    Debug.Notification("ImmersiveSound Load..")
    RegisterForModEvent("AnimationStart", "Begin")
	RegisterForModEvent("StageStart", "Stage")
    RegisterForModEvent("AnimationEnd", "Done") 

    init()
endEvent

function init()
    if etcSounds == none 

        etcSounds[0] = Game.GetFormFromFile(0x334A9, "Skyrim.esm") As Sound ; clothe tear sound
        etcSounds[1] = Game.GetFormFromFile(0x334A9, "Skyrim.esm") As Sound ; bed squeak sound 
        etcSounds[2] = Game.GetFormFromFile(0x334A9, "Skyrim.esm") As Sound ; fist hit sound 

        ; shocking sound	
                shockFSounds = new Sound[9]
                shockFSounds[0] =  (Game.GetFormFromFile(0x06014C0D, "AltonImmersiveSound.esp") As Sound) ; Player	
                shockFSounds[1] =  (Game.GetFormFromFile(0x0602E13A, "AltonImmersiveSound.esp") As Sound) ; Teen		
                shockFSounds[2] =  (Game.GetFormFromFile(0x06014C0D, "AltonImmersiveSound.esp") As Sound) ; Young
                shockFSounds[3] =  (Game.GetFormFromFile(0x0603836B, "AltonImmersiveSound.esp") As Sound) ; Coward, Sultry, Shrill, Con
                shockFSounds[4] =  (Game.GetFormFromFile(0x06038372, "AltonImmersiveSound.esp") As Sound) ; Evan, Elf, Commander
                shockFSounds[5] =  (Game.GetFormFromFile(0x0602E144, "AltonImmersiveSound.esp") As Sound) ; Old
                shockFSounds[6] =  (Game.GetFormFromFile(0x0602E144, "AltonImmersiveSound.esp") As Sound) ; Orc
                shockFSounds[7] =  (Game.GetFormFromFile(0x0602E144, "AltonImmersiveSound.esp") As Sound) ; Khajit
                shockFSounds[8] =  (Game.GetFormFromFile(0x0602E144, "AltonImmersiveSound.esp") As Sound) ; Argonian

        ; shame sound
                shameFSounds = new Sound[9]
                shameFSounds[0] =  (Game.GetFormFromFile(0x06014C0C, "AltonImmersiveSound.esp") As Sound)							
                shameFSounds[1] =  (Game.GetFormFromFile(0x0602E139, "AltonImmersiveSound.esp") As Sound)		
                shameFSounds[2] =  (Game.GetFormFromFile(0x06014C0C, "AltonImmersiveSound.esp") As Sound)		
                shameFSounds[3] =  (Game.GetFormFromFile(0x0603836A, "AltonImmersiveSound.esp") As Sound)															
                shameFSounds[4] =  (Game.GetFormFromFile(0x06038371, "AltonImmersiveSound.esp") As Sound)	; Evan																					
                shameFSounds[5] =  (Game.GetFormFromFile(0x0602E143, "AltonImmersiveSound.esp") As Sound)		
                shameFSounds[6] =  (Game.GetFormFromFile(0x0602E143, "AltonImmersiveSound.esp") As Sound)
                shameFSounds[8] =  (Game.GetFormFromFile(0x0602E143, "AltonImmersiveSound.esp") As Sound)
                                                          

        ; cry sound
                cryFSounds = new Sound[9]
                cryFSounds[0] =  (Game.GetFormFromFile(0x06014C0A, "AltonImmersiveSound.esp") As Sound)					
                cryFSounds[1] =  (Game.GetFormFromFile(0x0602E137, "AltonImmersiveSound.esp") As Sound)
                cryFSounds[2] =  (Game.GetFormFromFile(0x06014C0A, "AltonImmersiveSound.esp") As Sound)
                cryFSounds[3] =  (Game.GetFormFromFile(0x06038368, "AltonImmersiveSound.esp") As Sound)													
                cryFSounds[4] =  (Game.GetFormFromFile(0x0603836F, "AltonImmersiveSound.esp") As Sound)		; Evan														
                cryFSounds[5] =  (Game.GetFormFromFile(0x0602E141, "AltonImmersiveSound.esp") As Sound)
                cryFSounds[6] =  (Game.GetFormFromFile(0x0602E141, "AltonImmersiveSound.esp") As Sound)					
                cryFSounds[8] =  (Game.GetFormFromFile(0x0602E141, "AltonImmersiveSound.esp") As Sound)	
    endif 
endfunction

function playShockSound(actor _actor, int _idx, float _volume)     
    int gender = _actor.GetActorBase().getSex()

    if gender == 1 ; female
        Sound.SetInstanceVolume(shockFSounds[_idx].Play(_actor), _volume)
    endif 
endfunction

function playShameSound(actor _actor, int _idx, float _volume) 
    int gender = _actor.GetActorBase().getSex()

    if gender == 1 ; female
        Sound.SetInstanceVolume(shameFSounds[_idx].Play(_actor), _volume)
    endif 
endfunction

function playCrySound(actor _actor, int _idx, float _volume) 
    int gender = _actor.GetActorBase().getSex()

    if gender == 1 ; female
        Sound.SetInstanceVolume(cryFSounds[_idx].Play(_actor), _volume)
    endif 
endfunction

function playTearSound(actor _actor, float _volume) 
    Sound.SetInstanceVolume(etcSounds[0].Play(_actor), _volume)
endfunction


int function getVoiceTypeIdx(actor _actor)

    init()

	int vType = 0
	ActorBase actBase = _actor.GetBaseObject() as ActorBase    
	VoiceType actVoiceType = actBase.GetVoiceType()
    int formId= actVoiceType.GetFormID()
    int gender = _actor.GetActorBase().getSex()

    if gender == 1 
        ; female   
		if _actor == Game.GetPlayer()
			vType = 0

		elseif formId == 0x13AE9 ;Teen
			vType = 1

		elseif formId == 0x13ADC ;young
            vType = 2
            
		elseif formId == 0x13AE5 ;coward
			vType = 3        

		elseif formId == 0x13AE0 ;sultry
            vType = 3

		elseif formId == 0x13BC3 ;shrill
            vType = 3  

		elseif formId == 0x13AE4 ;con
			vType = 3            
                        
		elseif formId == 0x13ADD ;even
            vType = 4                       

		elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
			vType = 4

		elseif formId == 0x13AE3 ;commander
            vType = 4               
            
		elseif formId == 0x1B560 ;solder
			vType = 4              
		
		elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
			vType = 5 

		elseif formId == 0x13AE8 ; orc
			vType = 6

		elseif formId == 0x13AED ; Khajit
			vType = 7

		elseif formId == 0x13AE9 ; Argonian
            vType = 8                   
			
		else 
			vType = 3
        endif  
        
    else 
        ; male
        vType = 1
	endif        

	return vType
endFunction


; sexlab support
event Begin(string eventName, string argString, float argNum, form sender)

    sslBaseAnimation anim = SexLab.HookAnimation(argString)
    sslController = SexLab.HookController(argString)

    animName = anim.Name

    if anim.HasTag("Foreplay") || anim.HasTag("LeadIn") 
        curStage = "foreplay"
    else 
        curStage = "play"
    endif 

    Debug.Notification("Begin = " + argString + ", Tag = " + anim.Name)

    ; Scene에 참여 전체 액터 리스트 조회
    actorList = SexLab.HookActors(argString)

    ; actor 정보 구성
    int numOfActor = actorList.length
    int idx=0    

    while idx < numOfActor        
            Actor _actor = actorList[idx]

            int gender = Sexlab.GetGender(_actor)
            
            if gender < 2   ; 사람인 경우(남,여)만 활용
                ; victim 여부 확인
                if idx == 0
                    actorVictimList[idx] = false
                    actorVictimList[idx] = sslController.IsVictim(_actor)

                    if actorVictimList[idx] == true
                        Debug.Notification("It's rape scene")
                    endif
                endif     
            endif
            idx += 1

            ; 목소리 선택
            setSexlabVoiceType(_actor, gender)
    endWhile
endEvent

event OnUpdate()
       RegisterForSingleUpdate(10.0)
endEvent

event Stage(string eventName, string argString, float argNum, form sender)
    
    sslBaseAnimation anim = SexLab.HookAnimation(argString)
    Int totalStageCount = anim.StageCount()
    Int curStageCount = SexLab.HookStage(argString)

    if animName != anim.name
        curStage = "play"
    endif

    If curStage == "foreplay"
        if curStageCount == 1        ; animation 단계에서 첫번재 스테이지
            Debug.Notification("ForePlay Stage")            
        endif        

    elseIf curStage == "play"
       ; Debug.Notification("CollisionStartTime " + anim.GetCollisionStartTime(0, curStageCount))

        if curStageCount == 1        ; animation 단계에서 첫번재 스테이지        

            ; bed sqweaky sound
            if sslController.CenterOnBed(false, 750.0) || anim.HasTag("Furniture") || anim.HasTag("Chair")
                isFurnitureSfx = true
            endif
            Debug.Notification("Play Stage")            
        endif 
    endif

    ; RegisterForSingleUpdate(1.0)    

    Debug.Notification("Stage -> anim = " + anim.Name +", curStg = " + curStageCount + ", toStg = " +  totalStageCount + ", curStage = " + curStage)      
endevent


String function setSexlabVoiceType(actor _actor, int _gender)
	String vType = None
	ActorBase actBase = _actor.GetBaseObject() as ActorBase    
	VoiceType actVoiceType = actBase.GetVoiceType()
    int formId= actVoiceType.GetFormID()
    int gender = _actor.GetActorBase().getSex()

	; if _gender == 0 ; male   					
	; 	if formId == 0x13AE8
	; 		vType = "Child"            
	; 	elseif formId == 0x13AD1
	; 		vType = "Young"
	; 	elseif formId == 0x9843B                           
	; 		vType = "Bandit"
	; 	elseif formId == 0x13AD8                           
	; 		vType = "Commander"                
	; 	elseif formId == 0x13ADA                    
	; 		vType = "Brute"       
	; 	elseif formId == 0x13AD6 ||  formId == 0x13AD7                    
	; 		vType = "Old"                 
	; 	elseif formId == 0x13AEC                    
	; 		vType = "Khajit"     
	; 	elseif formId == 0x13AEA                     
	; 		vType = "Orc"    
	; 	elseif formId == 0x13AEE                  
	; 		vType = "Argonian"                                                                        
	; 	else                             
	; 		vType = "Common"
	; 	endif           
	; endif

	if _gender == 1 ; female   
        if _actor == Game.GetPlayer()
            SexLab.GetVoiceBySlot(0)
			vType = "Player"

        elseif formId == 0x13AE9 ;Teen
            SexLab.GetVoiceBySlot(1)
			vType = "Teen"

        elseif formId == 0x13ADC ;young
            SexLab.GetVoiceBySlot(2)
			vType = "Young"

        elseif formId == 0x13AE3 ;commander
            SexLab.GetVoiceBySlot(3)
			vType = "Commander"                

        elseif formId == 0x1B560 ;solder
            SexLab.GetVoiceBySlot(3)
            vType = "Solder"   

        elseif formId == 0x13ADD ;even
            SexLab.GetVoiceBySlot(4)
			vType = "Evan" 			

        elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
            SexLab.GetVoiceBySlot(4)
            vType = "Elf"
                        
        elseif formId == 0x13AE5 ;coward
            SexLab.GetVoiceBySlot(5)
			vType = "Coward"                    			               

        elseif formId == 0x13BC3 ;shrill
            SexLab.GetVoiceBySlot(6)
			vType = "Shrill"   

        elseif formId == 0x13AE0 ;sultry
            SexLab.GetVoiceBySlot(6)
			vType = "Sultry"    

        elseif formId == 0x13AE4 ;con
            SexLab.GetVoiceBySlot(6)
			vType = "Con"    

        elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
            SexLab.GetVoiceBySlot(7)
			vType = "Old"   

        elseif formId == 0x13AE8 ; orc
            SexLab.GetVoiceBySlot(8)
			vType = "Orc"

        elseif formId == 0x13AED ; Khajit
            SexLab.GetVoiceBySlot(9)
			vType = "Khajit"  

        elseif formId == 0x13AE9 ; Argonian
            SexLab.GetVoiceBySlot(10)
			vType = "Argonian"                             
			
        else 
            SexLab.GetVoiceBySlot(6)
			vType = "Common"
		endif  
	endif        

	return vType
endFunction


function playSfxSound(actor _actor, Sound soundInfo)    
    
    int volumn = 1

    if isFurnitureSfx 
        Sound.SetInstanceVolume(FurnitureSoundRes.Play(_actor), volumn)
    elseif isFistHitSfx
        Sound.SetInstanceVolume(FurnitureSoundRes.Play(_actor), volumn)
    endif

    Sound.SetInstanceVolume(soundInfo.Play(_actor), volumn)
endFunction

event Done(string eventName, string argString, float argNum, form sender)
    isFurnitureSfx = false
    isFistHitSfx = false

    curStage = "foreplay"
    animName = "nothing"
    ftimestart = 0.0    
    sslController = none
    actorList = none
endEvent

float   ftimeStart = 0.0

string  animName = "nothing"
string  curStage = "foreplay"  ; foreplay, play, orgasm, postplay

bool    isFurnitureSfx = false
bool    isFistHitSfx = false









