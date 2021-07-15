;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_BaboEventDibellaTemplePer_087F160E Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;You already visited the Dibella temple.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Utility.wait(1.0)
setstage(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;You got the perk, now it's time to mock merchants.
Debug.Messagebox("Now you can enthrall a man into your pocket... If you successfully hook him, you will take advantage of him. Please press N button in front of the target to start to allure. He will be your slave..")
Game.GetPlayer().AddPerk(BaboAlllurePerk)
Game.GetPlayer().AddPerk(BaboAlllurePerkPlus)
BaboAllurePerkSetting.Setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Debug.Notification("Please make sure to reset your magic key in MCM menu.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property BaboAllurePerkSetting  Auto  

Perk Property BaboAlllurePerk  Auto  

Perk Property BaboAlllurePerkPlus  Auto  
