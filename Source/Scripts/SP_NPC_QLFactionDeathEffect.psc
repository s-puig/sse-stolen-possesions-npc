Scriptname SP_NPC_QLFactionDeathEffect extends ActiveMagicEffect
{Assign faction to the NPC if it's dead or OnDeath event if the Keyword triggers}
Faction Property SP_NPC_CrimeFaction Auto
Keyword Property SP_NPC_CorpseEvent Auto
Quest Property SP_NPC_PhantomMarker Auto

Event OnEffectStart(Actor target, Actor caster)
    If (target.IsDead())
        TagActor()
    EndIf
EndEvent

Event OnDeath(Actor killer)
    TagActor()
EndEvent

;This is a band-aid for checking the conditions but the alternative is a massive (slow and fragile) amount of condition checks in Papyrus that would easily break
Event OnUpdate()
   TagActor()
EndEvent

Function TagActor()
    Actor target = GetTargetActor()
    ;Send a SM to check if it should be tagged
    ;Checking if the quest is stopped here doesn't work. If we get multiple kills at the same frame, they all will see the quest not running but only one will start
    If (SP_NPC_CorpseEvent.SendStoryEventAndWait(target.GetCurrentLocation(), target, GetCasterActor(), 0))
        target.SetFactionOwner(SP_NPC_CrimeFaction)
    ;SM might fail because the quest was activating or running for another actor e.g. A mass killing
    ElseIf (SP_NPC_PhantomMarker.IsStopped())
        target.SetFactionOwner(None)
    ;If the quest was indeed running, try again
    Else 
        RegisterForSingleUpdate(0.05)
    EndIf
EndFunction