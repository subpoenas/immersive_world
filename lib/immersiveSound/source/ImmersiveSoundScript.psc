Scriptname ImmersiveSoundScript extends Quest

Actor Property Player  Auto

Sound Property FurnitureSoundRes  Auto
Sound Property SquirshSoundRes  Auto
Sound Property BlowJobSoundRes  Auto
Sound Property HitSoundRes  Auto

SexLabFramework property SexLab auto

Actor[] actorList = none
bool[] actorVictimList = none
sslThreadController sslController = none
float sfxBedVolume = 0.1


event OnInit()
    Debug.Notification("ImmersiveSound Load..")
    RegisterForModEvent("AnimationStart", "Begin")
	RegisterForModEvent("StageStart", "Stage")
    RegisterForModEvent("AnimationEnd", "Done") 
endEvent

Sound function getTearSound() 
    return Game.GetFormFromFile(0x334A9, "Skyrim.esm") As Sound
endfunction

Sound function getShockSound(bool _isFemale, string _voiceType) 
    Sound _sound = none
    if _isFemale == true
        if _voiceType == "Player"		
            _sound =  (Game.GetFormFromFile(0x06014C0D, "AltonImmersiveSound.esp") As Sound)					
        elseif _voiceType == "Teen"		
            _sound =  (Game.GetFormFromFile(0x0602E13A, "AltonImmersiveSound.esp") As Sound)
        elseif _voiceType == "Young"		
            _sound =  (Game.GetFormFromFile(0x06014C0D, "AltonImmersiveSound.esp") As Sound)
        elseif _voiceType == "Coward"		
            _sound =  (Game.GetFormFromFile(0x0603836B, "AltonImmersiveSound.esp") As Sound)													
        elseif _voiceType == "Evan"		
            _sound =  (Game.GetFormFromFile(0x06038372, "AltonImmersiveSound.esp") As Sound)						
        elseif _voiceType == "Sultry" || _voiceType == "Shrill" || _voiceType == "Con"		
            _sound =  (Game.GetFormFromFile(0x06038366, "AltonImmersiveSound.esp") As Sound)												
        elseif _voiceType == "Old"		
            _sound =  (Game.GetFormFromFile(0x0602E144, "AltonImmersiveSound.esp") As Sound)
        else		
            _sound =  (Game.GetFormFromFile(0x0602E13F, "AltonImmersiveSound.esp") As Sound)						
        endif
    endif

    return _sound
endfunction 


Sound function getShameSound(bool _isFemale, string _voiceType) 
    Sound _sound = none
    if _isFemale == true
        if _voiceType == "Player"
            _sound =  (Game.GetFormFromFile(0x06014C0C, "AltonImmersiveSound.esp") As Sound)							
        elseif _voiceType == "Teen"
            _sound =  (Game.GetFormFromFile(0x0602E139, "AltonImmersiveSound.esp") As Sound)		
        elseif _voiceType == "Young"
            _sound =  (Game.GetFormFromFile(0x06014C0C, "AltonImmersiveSound.esp") As Sound)		
        elseif _voiceType == "Coward"
            _sound =  (Game.GetFormFromFile(0x0603836A, "AltonImmersiveSound.esp") As Sound)															
        elseif _voiceType == "Evan"
            _sound =  (Game.GetFormFromFile(0x06038371, "AltonImmersiveSound.esp") As Sound)								
        elseif _voiceType == "Sultry" || _voiceType == "Shrill" || _voiceType == "Con"
            _sound =  (Game.GetFormFromFile(0x06038365, "AltonImmersiveSound.esp") As Sound)														
        elseif _voiceType == "Old"
            _sound =  (Game.GetFormFromFile(0x0602E143, "AltonImmersiveSound.esp") As Sound)		
        else
            _sound =  (Game.GetFormFromFile(0x0602E13E, "AltonImmersiveSound.esp") As Sound)								
        endif
    endif

    return _sound
endfunction 

Sound function getFaintSound(bool _isFemale, string _voiceType) 
    Sound _sound = none
    if _isFemale == true
        if _voiceType == "Player"
            _sound =  (Game.GetFormFromFile(0x06014C0A, "AltonImmersiveSound.esp") As Sound)					
        elseif _voiceType == "Teen"
            _sound =  (Game.GetFormFromFile(0x0602E137, "AltonImmersiveSound.esp") As Sound)
        elseif _voiceType == "Young"
            _sound =  (Game.GetFormFromFile(0x06014C0A, "AltonImmersiveSound.esp") As Sound)
        elseif _voiceType == "Coward"
            _sound =  (Game.GetFormFromFile(0x06038368, "AltonImmersiveSound.esp") As Sound)													
        elseif _voiceType == "Evan"
            _sound =  (Game.GetFormFromFile(0x0603836F, "AltonImmersiveSound.esp") As Sound)						
        elseif _voiceType == "Sultry" || _voiceType == "Shrill" || _voiceType == "Con"
            _sound =  (Game.GetFormFromFile(0x06038363, "AltonImmersiveSound.esp") As Sound)												
        elseif _voiceType == "Old"
            _sound =  (Game.GetFormFromFile(0x0602E141, "AltonImmersiveSound.esp") As Sound)
        else
            _sound =  (Game.GetFormFromFile(0x0602E13C, "AltonImmersiveSound.esp") As Sound)					
        endif
    endif

    return _sound
endfunction 

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
            selectVoiceType(_actor, gender)
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


String function selectVoiceType(actor _actor, int _gender)
	String vType = None
	ActorBase actBase = _actor.GetBaseObject() as ActorBase    
	VoiceType actVoiceType = actBase.GetVoiceType()
	int formId= actVoiceType.GetFormID()

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
			vType = "Player"

		elseif formId == 0x13AE9 ;Teen
			vType = "Teen"

		elseif formId == 0x13ADC ;young
			vType = "Young"

		elseif formId == 0x13AE3 ;commander
			vType = "Commander"                

		elseif formId == 0x13AE5 ;coward
			vType = "Coward"                    
			
		elseif formId == 0x1B560 ;solder
			vType = "Solder"                  

		elseif formId == 0x13BC3 ;shrill
			vType = "Shrill"   

		elseif formId == 0x13AE0 ;sultry
			vType = "Sultry"    

		elseif formId == 0x13AE4 ;con
			vType = "Con"    

		elseif formId == 0x13ADD ;even
			vType = "Evan" 			

		elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
			vType = "Old"   

		elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
			vType = "Elf"

		elseif formId == 0x13AE8 ; orc
			vType = "Orc"

		elseif formId == 0x13AED ; Khajit
			vType = "Khajit"  

		elseif formId == 0x13AE9 ; Argonian
			vType = "Argonian"                             
			
		else 
			vType = "Common"
		endif  
	endif        

	return vType
endFunction

; function selectVoice()

;     int numOfActor = actorList.length
;     int idx=0
        
;     while idx < numOfActor  
    
;         Actor _actor = actorList[idx]
;         int gender = Sexlab.GetGender(_actor)
;         string vType = "none"
;         ; voice type
;         ActorBase actBase = _actor.GetBaseObject() as ActorBase    
;         VoiceType actVoiceType = actBase.GetVoiceType()
;         int formId= actVoiceType.GetFormID()

;         if gender == 0 ; male   
;             sslBaseVoice voice = SexLab.GetVoiceBySlot(9) ; young
                        
;             if Player == _actor ; player
;                 SexLab.GetVoiceBySlot(0)
;                 vType = "Player"            
;             elseif formId == 0x13AE8
;                 voice = SexLab.GetVoiceBySlot(12)
;                 vType = "Child"            
;             elseif formId == 0x13AD1
;                 voice = SexLab.GetVoiceBySlot(12)
;                 vType = "Young"
;             elseif formId == 0x13AD8
;                 voice = SexLab.GetVoiceBySlot(14)                             
;                 vType = "Commander"                
;             elseif formId == 0x13ADA
;                 voice = SexLab.GetVoiceBySlot(14)                       
;                 vType = "Brute"       
;             elseif formId == 0x13AD6 ||  formId == 0x13AD7
;                 voice = SexLab.GetVoiceBySlot(13)                       
;                 vType = "Old"                 
;             elseif formId == 0x13AEC
;                 voice = SexLab.GetVoiceBySlot(15)                       
;                 vType = "Khajit"     
;             elseif formId == 0x13AEA
;                 voice = SexLab.GetVoiceBySlot(15)                       
;                 vType = "Orc"    
;             elseif formId == 0x13AEE
;                 voice = SexLab.GetVoiceBySlot(15)                       
;                 vType = "Argonian"                                                                        
;             else                             
;                 voice = SexLab.GetVoiceBySlot(12)
;                 vType = "Common"
;             endif
                    
;             sslController.SetVoice(_actor, voice) 
;             Debug.Notification("maleVoice = " + vType)           
;         endif
    
;         if gender == 1 ; female   
;             sslBaseVoice voice = SexLab.GetVoiceBySlot(2) ; young

;             if Player == _actor ; player
;                 voice = SexLab.GetVoiceBySlot(0)
;                 vType = "Player"
;             elseif formId == 0x13AE9 ;child
;                 voice = SexLab.GetVoiceBySlot(8)
;                 vType = "Teen"
;             elseif formId == 0x13ADC ;young
;                 voice = SexLab.GetVoiceBySlot(2)
;                 vType = "Young"
;             elseif formId == 0x13AE3 ;commander
;                 voice = SexLab.GetVoiceBySlot(5)
;                 vType = "Commander"                
;             elseif formId == 0x13AE5 ;coward
;                 voice = SexLab.GetVoiceBySlot(4)
;                 vType = "Coward"                    
;             elseif formId == 0x1B560 ;solder
;                 voice = SexLab.GetVoiceBySlot(5)
;                 vType = "Solder"
;             elseif formId == 0x13BC3 ;shrill
;                 voice = SexLab.GetVoiceBySlot(3)
;                 vType = "Shrill"   
;             elseif formId == 0x13AE0 ;sultry
;                 voice = SexLab.GetVoiceBySlot(3)
;                 vType = "Sultry"    
;             elseif formId == 0x13AE4 ;con
;                 voice = SexLab.GetVoiceBySlot(1)
;                 vType = "Con"    
;             elseif formId == 0x13ADD ;even
;                 voice = SexLab.GetVoiceBySlot(1)
;                 vType = "Evan" 			
;             elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
;                 voice = SexLab.GetVoiceBySlot(7) 
;                 vType = "Old"   
;             elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
;                 voice = SexLab.GetVoiceBySlot(2)
;                 vType = "Elf"
;             elseif formId == 0x13AE8 ; orc
;                 voice = SexLab.GetVoiceBySlot(9) 
;                 vType = "Orc"
;             elseif formId == 0x13AED ; Khajit
;                 voice = SexLab.GetVoiceBySlot(11) 
;                 vType = "Khajit"  
;             elseif formId == 0x13AE9 ; Argonian
;                 voice = SexLab.GetVoiceBySlot(10) 
;                 vType = "Argonian"
;             else 
;                 voice = SexLab.GetVoiceBySlot(6) 
;                 vType = "Common"
;             endif
            
;             sslController.SetVoice(_actor, voice)           
;             Debug.Notification("femaleVoice = " + vType)      
;         endif        

;         idx += 1

;     endWhile
; endFunction

; function getSoundType(int collisionType)    
;     ;vp(0)/vf(1)/ap(2)/af(3)/mp(4)/mf(5)/hit(6)
;     if collisionType == 0     ; vargina + penis
;         return SquirshSoundRes
;     elseif collisionType == 1 ; vargina + finger
;         return SquirshSoundRes
;     elseif collisionType == 2 ; ass + penis
;         return SquirshSoundRes
;     elseif collisionType == 3 ; ass + finger
;         return BlowJobSoundRes
;     elseif collisionType == 2 ; mouse + penis
;         return BlowJobSoundRes
;     elseif collisionType == 2 ; mouse + finger
;         return HitSoundRes
;     endif 

;     Sound.SetInstanceVolume(soundInfo.Play(_actor), volumn)
; endFunction

function playSfxSound(actor _actor, Sound soundInfo)    
    
    int volumn = 1

    if isFurnitureSfx 
        Sound.SetInstanceVolume(FurnitureSoundRes.Play(_actor), volumn)
    endif

    Sound.SetInstanceVolume(soundInfo.Play(_actor), volumn)
endFunction

event Done(string eventName, string argString, float argNum, form sender)
    isFurnitureSfx = false
    isBlowJobSfx = false
    isSquirshSfx = false
    isHitSfx = false

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
bool    isBlowJobSfx = false
bool    isSquirshSfx = false
bool    isHitSfx = false









