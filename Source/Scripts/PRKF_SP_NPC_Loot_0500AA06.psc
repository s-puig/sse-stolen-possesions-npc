;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname PRKF_SP_NPC_Loot_0500AA06 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
If (SP_NPC_CorpseEvent.SendStoryEventAndWait(akTargetRef.GetCurrentLocation(), akTargetRef, akActor, 1, 0) == false)
	akTargetRef.Activate(akActor)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Keyword Property SP_NPC_CorpseEvent  Auto  
{This keyword triggers a quest story manager event.
It tags corpses and has the following parameters:
akLoc = Location of the corpse,
akRef1 = Corpse reference,
akRef2 = Looter reference,
iCheck = 1 tags the items, 0 only consumes the event.
0 is used for only doing a "check" without opening the inventory 
int2 = unused}
