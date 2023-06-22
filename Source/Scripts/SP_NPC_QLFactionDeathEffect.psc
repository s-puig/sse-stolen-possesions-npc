Scriptname SP_NPC_QLFactionDeathEffect extends ActiveMagicEffect
{Assign faction to the NPC if it's dead or OnDeath event if the Keyword triggers}
Faction Property SP_NPC_CrimeFaction Auto
Keyword Property SP_NPC_CorpseEvent Auto
Quest Property SP_NPC_QLTag Auto
Quest Property SP_NPC_QLDontTag Auto

int currentTry = 0
int MAX_TRY = 10

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
    ;Limit the number of loops to ensure that if something goes wrong it will always eventually finish
    currentTry = currentTry+1
    if currentTry < MAX_TRY
        TagActor()
    endIf
EndEvent

Function TagActor()
    Actor target = GetTargetActor()
    ;Send a SM to check if it should be tagged
    bool hasStarted = SP_NPC_CorpseEvent.SendStoryEventAndWait(target.GetCurrentLocation(), target, target.GetKiller(), 0)
    ;Checking if the quest is stopped here doesn't work. If we get multiple kills at the same frame, they all will see the quest not running but only one will start
    If (hasStarted)
        If (SP_NPC_QLTag.isRunning() && (SP_NPC_QLTag.GetAliasByName("Alias_DeadBody") as ReferenceAlias).GetActorReference() == target)
            target.SetFactionOwner(SP_NPC_CrimeFaction)
        ElseIf ((SP_NPC_QLDontTag.isRunning() && (SP_NPC_QLDontTag.GetAliasByName("Alias_DeadBody") as ReferenceAlias).GetActorReference() == target))
            target.SetFactionOwner(None)
        else
            ;This should NEVER happen
            RegisterForSingleUpdate(0.1)
        EndIf
    ;If it failed because it didn't find an appropiate condition, check that both quests are stopped to confirm
    ElseIf (SP_NPC_QLDontTag.IsStopped() && SP_NPC_QLTag.IsStopped())
        target.SetFactionOwner(None)
    ;SM might fail because the quest was activating or running for another actor e.g. A mass killing. In such cases try again
    Else 
        RegisterForSingleUpdate(0.1)
    EndIf
EndFunction