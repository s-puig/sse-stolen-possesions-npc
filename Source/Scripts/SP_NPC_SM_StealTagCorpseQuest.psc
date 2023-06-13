Scriptname SP_NPC_SM_StealTagCorpseQuest extends Quest
{Controls the quest that turns the items into a stolen state when activated. 
It does this by copying the items of the corpse into a container and setting it a faction owner}

ReferenceAlias Property Alias_DeadBody Auto 
{ Alias of physical dead body actor.}
ReferenceAlias Property Alias_FakeContainer Auto
{ Alias of container used to "fake" the inventory since actors can't be tagged as stolen unless they are alive.}
ReferenceAlias Property Alias_Player Auto
{ Player }
Faction Property ICL_CrimeFactionTemp Auto

ObjectReference deadBody
ObjectReference fakeContainer

int DISABLED = 0
int LAST_HIT = 1
int ALWAYS_ILLEGAL = 2

Event OnStoryScript(Keyword _unused, Location location, ObjectReference victim, ObjectReference looter, int lootMode, int _unused2)
    deadBody = Alias_DeadBody.GetReference()
    fakeContainer = Alias_FakeContainer.GetReference()
    ;Block activation to stop other scripts or behaviours from interacting
    deadBody.BlockActivation(true)
    ;TODO: Experiment with followers and how they behave to see if this is necessary
    if looter == Alias_Player.GetReference()
        ;Don't tag if it's on last hit mode and the victim was killed by the looter. 
        ;Disabled should NEVER happen and it's handled by the story manager, but let's be sure.
        If ((lootMode == LAST_HIT && (victim as Actor).GetKiller() == looter) || lootMode == DISABLED)
            fakeContainer.SetFactionOwner(None)
        Else
            fakeContainer.SetFactionOwner(ICL_CrimeFactionTemp)
        EndIf
        ;Activate the fake container
        fakeContainer.Activate(looter)
    endIf
    RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuClose(string menuName)
    ;Not sure if it's necessary since it dies, but doesn't hurt to be sure
    UnregisterForMenu("ContainerMenu")
    ;Return block activation to default behaviour and stop the quest
    deadBody.BlockActivation(false)
    Stop()
EndEvent


