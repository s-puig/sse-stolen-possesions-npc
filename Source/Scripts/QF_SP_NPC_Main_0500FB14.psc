;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_SP_NPC_Main_0500FB14 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.GetPlayer().AddPerk(SP_NPC_Loot)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.GetPlayer().RemovePerk(SP_NPC_Loot)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Perk Property SP_NPC_Loot  Auto  
{Perk activates when dealing with a corpse.
It triggers the SM to identify if the corpses items should be Steal tagged or not.}
