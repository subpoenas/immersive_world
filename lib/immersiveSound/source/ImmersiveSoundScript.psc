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
    endWhile

    ; 목소리 선택
    selectVoice()
endEvent

event OnUpdate()
    if collisionUse
       RegisterForSingleUpdate(collisionRepeatTime)
    endif
endEvent

event Stage(string eventName, string argString, float argNum, form sender)
    
    sslBaseAnimation anim = SexLab.HookAnimation(argString)
    Int totalStageCount = anim.StageCount()
    Int curStageCount = SexLab.HookStage(argString)

    if animName != anim.name
        curStage = "play"
    endif

    collisionUse = anim.GetCollisionUse(0, curStageCount)
    collisionStartTime = anim.GetCollisionStartTime(0, curStageCount)
    collisionRepeatTime = anim.GetCollisionRepeatTime(0, curStageCount)
    collisionType = anim.GetCollisionType(0, curStageCount)
    collisionStrong = anim.GetCollisionStrong(0, curStageCount)

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

    RegisterForSingleUpdate(1.0)    

    Debug.Notification("Stage -> anim = " + anim.Name +", curStg = " + curStageCount + ", toStg = " +  totalStageCount + ", curStage = " + curStage)      
endevent

function selectVoice()

    int numOfActor = actorList.length
    int idx=0
        
    while idx < numOfActor  
    
        Actor _actor = actorList[idx]
        int gender = Sexlab.GetGender(_actor)
        string vType = "none"
        ; voice type
        ActorBase actBase = _actor.GetBaseObject() as ActorBase    
        VoiceType actVoiceType = actBase.GetVoiceType()
        int formId= actVoiceType.GetFormID()

        if gender == 0 ; male   
            sslBaseVoice voice = SexLab.GetVoiceBySlot(9) ; young
                        
            if Player == _actor ; player
                SexLab.GetVoiceBySlot(0)
                vType = "Player"            
            elseif formId == 0x13AE8
                voice = SexLab.GetVoiceBySlot(12)
                vType = "Child"            
            elseif formId == 0x13AD1
                voice = SexLab.GetVoiceBySlot(12)
                vType = "Young"
            elseif formId == 0x13AD8
                voice = SexLab.GetVoiceBySlot(14)                             
                vType = "Commander"                
            elseif formId == 0x13ADA
                voice = SexLab.GetVoiceBySlot(14)                       
                vType = "Brute"       
            elseif formId == 0x13AD6 ||  formId == 0x13AD7
                voice = SexLab.GetVoiceBySlot(13)                       
                vType = "Old"                 
            elseif formId == 0x13AEC
                voice = SexLab.GetVoiceBySlot(15)                       
                vType = "Khajit"     
            elseif formId == 0x13AEA
                voice = SexLab.GetVoiceBySlot(15)                       
                vType = "Orc"    
            elseif formId == 0x13AEE
                voice = SexLab.GetVoiceBySlot(15)                       
                vType = "Argonian"                                                                        
            else                             
                voice = SexLab.GetVoiceBySlot(12)
                vType = "Common"
            endif
                    
            sslController.SetVoice(_actor, voice) 
            Debug.Notification("maleVoice = " + vType)           
        endif
    
        if gender == 1 ; female   
            sslBaseVoice voice = SexLab.GetVoiceBySlot(2) ; young

            if Player == _actor ; player
                voice = SexLab.GetVoiceBySlot(0)
                vType = "Player"
            elseif formId == 0x13AE9 ;child
                voice = SexLab.GetVoiceBySlot(8)
                vType = "Teen"
            elseif formId == 0x13ADC ;young
                voice = SexLab.GetVoiceBySlot(2)
                vType = "Young"
            elseif formId == 0x13AE3 ;commander
                voice = SexLab.GetVoiceBySlot(5)
                vType = "Commander"                
            elseif formId == 0x13AE5 ;coward
                voice = SexLab.GetVoiceBySlot(4)
                vType = "Coward"                    
            elseif formId == 0x1B560 ;solder
                voice = SexLab.GetVoiceBySlot(5)
                vType = "Solder"
            elseif formId == 0x13BC3 ;shrill
                voice = SexLab.GetVoiceBySlot(3)
                vType = "Shrill"   
            elseif formId == 0x13AE0 ;sultry
                voice = SexLab.GetVoiceBySlot(3)
                vType = "Sultry"    
            elseif formId == 0x13AE4 ;con
                voice = SexLab.GetVoiceBySlot(1)
                vType = "Con"    
            elseif formId == 0x13ADD ;even
                voice = SexLab.GetVoiceBySlot(1)
                vType = "Evan" 			
            elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
                voice = SexLab.GetVoiceBySlot(7) 
                vType = "Old"   
            elseif formId == 0x13AF3 || formId == 0x13Af1 ; elf
                voice = SexLab.GetVoiceBySlot(2)
                vType = "Elf"
            elseif formId == 0x13AE8 ; orc
                voice = SexLab.GetVoiceBySlot(9) 
                vType = "Orc"
            elseif formId == 0x13AED ; Khajit
                voice = SexLab.GetVoiceBySlot(11) 
                vType = "Khajit"  
            elseif formId == 0x13AE9 ; Argonian
                voice = SexLab.GetVoiceBySlot(10) 
                vType = "Argonian"
            else 
                voice = SexLab.GetVoiceBySlot(6) 
                vType = "Common"
            endif
            
            sslController.SetVoice(_actor, voice)           
            Debug.Notification("femaleVoice = " + vType)      
        endif        

        idx += 1

    endWhile
endFunction

function getSoundType(int collisionType)    
    ;vp(0)/vf(1)/ap(2)/af(3)/mp(4)/mf(5)/hit(6)
    if collisionType == 0     ; vargina + penis
        return SquirshSoundRes
    elseif collisionType == 1 ; vargina + finger
        return SquirshSoundRes
    elseif collisionType == 2 ; ass + penis
        return SquirshSoundRes
    elseif collisionType == 3 ; ass + finger
        return BlowJobSoundRes
    elseif collisionType == 2 ; mouse + penis
        return BlowJobSoundRes
    elseif collisionType == 2 ; mouse + finger
        return HitSoundRes
    endif 

    Sound.SetInstanceVolume(soundInfo.Play(_actor), volumn)
endFunction

function playSfxSound(actor _actor, Sound soundInfo)    
    
    int volumn = 1

    if collisionStrong == 0     ; weak
        volumn = 2
    elseif collisionStrong == 1 ; normal
        volumn = 4
    elseif collisionStrong == 2 ; string 
        volumn = 7
    endif 

    if isFurnitureSfx 
        Sound.SetInstanceVolume(FurnitureSoundRes.Play(_actor), volumn)
    endif

    Sound.SetInstanceVolume(soundInfo.Play(_actor), volumn)
endFunction

function stopSound(sound soundInfo)
    Sound.StopInstance(soundInfo.soundId)    
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

bool    collisionUse = 0;
int     collisionStartTime = 0;
int     collisionRepeatTime = 0;
int     collisionType = 0;
int     collisionStrong = 0;

bool    isFurnitureSfx = false
bool    isBlowJobSfx = false
bool    isSquirshSfx = false
bool    isHitSfx = false









