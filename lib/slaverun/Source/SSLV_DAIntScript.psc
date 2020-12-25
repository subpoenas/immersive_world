Scriptname SSLV_DAIntScript extends daymoyl_QuestTemplate  

GlobalVariable Property GameHour Auto
;GlobalVariable Property ChanceOfEnslavement Auto
Keyword Property ActorTypeNPC AUto
Faction Property BanditFaction Auto
ObjectReference Property SSLV_CageMark  Auto  
;ObjectReference Property SSLV_OldMark  Auto  
;ReferenceAlias Property PlayerRef  Auto  ; an alias on the quest this script is attached
;Race Property FalmerRace  Auto  

Bool Function QuestCondition(Location akLocation, Actor akAggressor, Actor akFollower)
{Condition that must be satisfied for the quest to fire. Should be overloaded in the childs}
	Debug.Trace("SSLV blackout: condition")

return akAggressor.HasKeyword(ActorTypeNPC)
EndFunction

bool Function QuestStart(Location akLocation, Actor akAggressor, Actor akFollower)
	Debug.Trace("SSLV blackout: selected")

	; If Devious Framework is installed try to force a save as Death Alternative will not have done so.
	dfwDeviousFramework qDfwFramework = (Quest.GetQuest("_dfwDeviousFramework") As dfwDeviousFramework)
	If (qDfwFramework)
		qDfwFramework.ForceSave()
	EndIf

	SendModEvent("da_StartRecoverSequence", numArg = 100, strArg = "KeepBlackScreen") ;Without this the "fall through floor bug occurs"

	SSLV_MainScr qMainQuest = (Quest.GetQuest("SimpleSlavery") As SSLV_MainScr)
	Int iStatus = qMainQuest.StartWalkToAuction(akAggressor)
        if (-1 == iStatus)
		return false
        elseif (0 == iStatus)
		; Stop the aggressor walking to the auction house while the player is recovering.
		akAggressor.EnableAI(False)

		; Start the Death Alternative recovery sequence.
		SendModEvent("da_ApplyBlackscreen", strArg="Remove")
		SendModEvent("da_StartRecoverSequence")

		; Give the player some time to recover and then begin the walk to the auction house.
		Utility.Wait(30)
		akAggressor.EnableAI()
		return true
        endif

	registerforsingleupdate(4)

	debug.notification("The pain wracking your body fades away into cool darkness...")

	game.getplayer().unequipall()	

	game.getplayer().setoutfit(sslv_slaveoutfit2)

	;game.getplayer().equipitem(sslv_slaveoutfit2)

	utility.wait(8)
	
	debug.notification("Through your haze of pain and exhaustion, you feel movement, as if you are in a carriage.")

	utility.wait(3)
	
	debug.notification("After an indeterminate amount of time, you come to. It feels unusually chilly.")
	
	utility.wait(2)

	debug.notification("It takes a moment to realize that you are lying on a cold, hard, wooden floor.")

	utility.wait(5)

	debug.notification("You still feel woozy but you blink your eyes open as you struggle to your feet.")
	
	SendModEvent("da_ApplyBlackscreen", strArg = "Remove" ) ;Allow the player a few seconds to see the character on the "cold, hard wooden floor..." before they get up

	Game.DisablePlayerControls()

	game.enableplayercontrols(abfighting = false, abmenu = false)
	
	utility.wait(3)

	SendModEvent("da_StartRecoverSequence") ;The earlier call doesn't seem to clear the bleedout state so repeat the call
	
	return true
endFunction

Event OnUpdate()
	Game.getplayer().moveto(SSLV_CageMark) 
	SSLV_CageMark.Activate(Game.GetPlayer())
	GameHour.Mod(8.0) ; wait 8 hours game time 
endevent



;ObjectReference Property zbfCuffsIronBlack  Auto  

Outfit Property SSLV_SlaveOutfit  Auto  

Outfit Property SSLV_SlaveOutfit2  Auto  
