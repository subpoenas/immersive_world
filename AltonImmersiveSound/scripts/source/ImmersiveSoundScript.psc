Scriptname ImmersiveSoundScript extends Quest

; dynamic moan sound (agressive, excited)
; dynamic sfx sound (bed, water)
; clothe off

; Solo, Beds, Masturbation

Actor Property Player  Auto
Sound Property BedSoundRes  Auto
Sound Property Orgasm1SoundRes Auto
Sound Property Orgasm2SoundRes Auto
Sound Property Orgasm3SoundRes Auto
Sound Property Orgasm4SoundRes Auto
Sound Property Orgasm5SoundRes Auto
Sound Property Orgasm6SoundRes Auto
Sound Property Orgasm7SoundRes Auto
Sound Property Orgasm8SoundRes Auto

SexLabFramework property SexLab auto
ImmersiveAnimScript property immersiveAnim auto

Spell property orgasmSpell auto

Actor[] actorList = none
bool[] actorVictimList = none
sslThreadController sslController = none
float sfxBedVolume = 0.5


event OnInit()
    Debug.Notification("Init ImmersiveSound")

    RegisterForModEvent("AnimationStart", "Begin")
    RegisterForModEvent("OrgasmStart", "OrgasmStart")
    RegisterForModEvent("OrgasmEnd", "OrgasmEnd")
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

    ; Scene에 참여 여성 액터 수 조회
    femaleCount = SexLab.FemaleCount(actorList)

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
endEvent

event OnUpdate()
    if curStage == "play"
        if isBedSfx == true && isSilent == false
            ; sound sfx
            playSfxSound(actorList[0], BedSoundRes, sfxBedVolume)
        endif

        if Animating == 1
            RegisterForSingleUpdate(1.5)
        endif
    endif
endEvent

event Stage(string eventName, string argString, float argNum, form sender)
    
    sslBaseAnimation anim = SexLab.HookAnimation(argString)
    Int totalStageCount = anim.StageCount()
    Int curStageCount = SexLab.HookStage(argString)

    if animName != anim.name
        curStage = "play"
    endif

    If curStage == "foreplay"
        IF curStageCount == 1        ; animation 단계에서 첫번재 스테이지
            Debug.Notification("ForePlay Stage")
            
            ; if anim.HasTag("Kissing") 
            ;     sfxSoundType = "kiss"
            ; endif  

            selectVoice(anim)
        endif        

    elseIf curStage == "play"
        isSilent = anim.IsSilent(0, curStageCount)

        ; if anim.HasTag("Aggressive") || anim.HasTag("Rape") || anim.HasTag("Forced")
        ;     animType = "Rape"
        ;     sslController.SetVictim(actorList[0], true)
        ; endif
         
        IF curStageCount == 1        ; animation 단계에서 첫번재 스테이지        

            ; bed sqweaky sound
            if sslController.CenterOnBed(false, 750.0) || anim.HasTag("Furniture") || anim.HasTag("Chair")
                isBedSfx = true
                Debug.Notification("Play Stage with bedSound")
            else 
                Debug.Notification("Play Stage")
            endif
                
            selectVoice(anim)
        endif       

        ; SFX 음량 조절
        if isBedSfx == true
            ; sound sfx
            sfxBedVolume += 0.1

            if sfxBedVolume > 1.0
                sfxBedVolume = 1.0
            endif
        endif      
    elseIf curStage == "orgasm"

    endif

    if Animating == 0
        Animating = 1
        RegisterForSingleUpdate(1.0)
    endif

    Debug.Notification("Stage -> anim = " + anim.Name +", curStg = " + curStageCount + ", toStg = " +  totalStageCount + ", curStage = " + curStage)      
endevent


event OrgasmStart(string eventName, string argString, float argNum, form sender)
    Debug.Notification("Orgasm start -> " + argNum)
    curStage = "orgasm"

    int numOfActor = actorList.length
    int idx=0
        
    while idx < numOfActor
        float volume = 1.0
        int gender = Sexlab.GetGender(actorList[idx])  

        if gender == 1 ; female
            if actorVictimList[idx] == true 
                volume = 0.5;
            endif
        endif
        
        playOrgasm(actorList[idx], volume)
        idx += 1
    endWhile    
endEvent

event OrgasmEnd(string eventName, string argString, float argNum, form sender)
    Debug.Notification("Orgasm end -> " + argNum)

    int numOfActor = actorList.length
    int idx=0


    while idx < numOfActor  
        Actor _actor = actorList[idx]
        int gender = Sexlab.GetGender(_actor)
        bool isVictim = sslController.IsVictim(_actor)

        if gender == 0; male

            if Sexlab.GetGender(actorList[0]) == 2; victim is woman
                orgasmSpell.Cast(actorList[1],_actor)
            endif
        endif        

        immersiveAnim.playOrgasm(_actor, gender, isVictim)

        idx += 1
    endWhile
endEvent

function selectVoice(sslBaseAnimation anim)

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
                            
            if formId == 0x13ADC || formId == 0x13AE9
                voice = SexLab.GetVoiceBySlot(9)
                vType = "young"
            elseif formId == 0x13AE2  || formId == 0x13AE1
                voice = SexLab.GetVoiceBySlot(12) ; old                                
                vType = "old"
            else             
                int voiceIdx = Utility.RandomInt(1, 2)        
                if voiceIdx == 1
                    voice = SexLab.GetVoiceBySlot(10)
                else 
                    voice = SexLab.GetVoiceBySlot(11)
                endif
                vType = "mature"
            endif
                    
            sslController.SetVoice(_actor, voice) 
            Debug.Notification("maleVoice = " + vType)           
        endif
    
        if gender == 1 ; female   
            sslBaseVoice voice = SexLab.GetVoiceBySlot(2) ; young

            if formId == 0x13AE9 ;child
                SexLab.GetVoiceBySlot(0)
                ;if actorVictimList[idx]
                ;    voice = SexLab.GetVoiceBySlot(0)
                ;endif 
                vType = "child"

            elseif formId == 0x13ADC ;young
                voice = SexLab.GetVoiceBySlot(1)
                vType = "young"

            elseif formId == 0x13AE0 || formId == 0x13AE3 ; mature sultry
                voice = SexLab.GetVoiceBySlot(4)
                vType = "mature"

            elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
                voice = SexLab.GetVoiceBySlot(5) 
                vType = "old"   

            elseif formId == 0x13AE8 ; orc
                voice = SexLab.GetVoiceBySlot(6) 
                vType = "orc"

            elseif formId == 0x13AED ; Khajit
                voice = SexLab.GetVoiceBySlot(7) 
                vType = "Khajit"                

            else 
                int voiceIdx = Utility.RandomInt(1, 2)

                if voiceIdx == 1
                    voice = SexLab.GetVoiceBySlot(2)   
                else 
                    voice = SexLab.GetVoiceBySlot(3)
                endif

                ;if actorVictimList[idx]
                ;    voice = SexLab.GetVoiceBySlot(3)
                ;endif 
                vType = "mature"
            endif
            
            sslController.SetVoice(_actor, voice)           
            Debug.Notification("femaleVoice = " + vType)      
        endif        

        idx += 1

    endWhile
endFunction

function playOrgasm(actor playActor, float volume)
        int gender = Sexlab.GetGender(playActor)
        string vType = "none"
        ; 목소리 타입 선택
        ActorBase actBase = playActor.GetBaseObject() as ActorBase    
        VoiceType actVoiceType = actBase.GetVoiceType()
        int formId= actVoiceType.GetFormID()
    
        if gender == 1 ; 여자   
            sslBaseVoice voice = SexLab.GetVoiceBySlot(2) ; young

            if formId == 0x13AE9 ;child
                Sound.SetInstanceVolume(Orgasm1SoundRes.Play(playActor), volume)
            elseif formId == 0x13ADC ;young
                Sound.SetInstanceVolume(Orgasm2SoundRes.Play(playActor), volume)
            elseif formId == 0x13AE0 || formId == 0x13AE3 ; mature sultry
                Sound.SetInstanceVolume(Orgasm5SoundRes.Play(playActor), volume)               
            elseif formId == 0x13AE1 || formId == 0x13AE2 ; old
                Sound.SetInstanceVolume(Orgasm6SoundRes.Play(playActor), volume)
            elseif formId == 0x13AE8 ;orc
                Sound.SetInstanceVolume(Orgasm7SoundRes.Play(playActor), volume)
            elseif formId == 0x13AED ;Khajit
                Sound.SetInstanceVolume(Orgasm8SoundRes.Play(playActor), volume)
            else 
                int voiceIdx = Utility.RandomInt(1, 2)

                if voiceIdx == 1
                    Sound.SetInstanceVolume(Orgasm3SoundRes.Play(playActor), volume)
                else 
                    Sound.SetInstanceVolume(Orgasm4SoundRes.Play(playActor), volume)                         
                endif
            endif   
        endif        

endFunction

function playSfxSound(actor playActor, Sound soundInfo, float volume)    
    ; soundInfo.PlayAndWait(playActor)
    Sound.SetInstanceVolume(soundInfo.Play(playActor), volume)
endFunction

function stopSound(sound soundInfo)
    ; Sound.StopInstance(soundInfo.soundId)
    ; soundInfo.isPlaying = false
    Debug.Notification("stopSound")
endFunction

event Done(string eventName, string argString, float argNum, form sender)
    isSilent = false
    isBedSfx = false
    curStage = "foreplay"
    Animating = 0 
    enjoyment = 0 
    ftimestart = 0.0
    animName = "nothing"
    sslController = none
    actorList = none
    femaleCount = 0
endEvent

float   ftimeStart = 0.0

int     Animating = 0 
int     enjoyment = 0

string  animName = "nothing"
string  curStage = "foreplay"  ; foreplay, play, orgasm, postplay

bool    isSilent = false
bool    isBedSfx = false
int     femaleCount = 0









