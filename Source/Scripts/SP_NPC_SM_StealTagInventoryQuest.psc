Scriptname SP_NPC_SM_StealTagInventoryQuest extends Quest
{Controls the quest that turns the items into a stolen state when activated. 
It does this by copying the items of the corpse into a container and setting it a faction owner}

ReferenceAlias Property Alias_DeadBody Auto 
{ Alias of physical dead body actor.}
ReferenceAlias Property Alias_FakeContainer Auto
{ Alias of container used to "fake" the inventory since actors can't be tagged as stolen unless they are alive.}

Event OnStoryScript(Keyword _keyword, Location _location, ObjectReference victim, ObjectReference looter, int _int, int _int2)
    ;Block activation to stop other scripts or behaviours from interacting
    Alias_DeadBody.GetReference().BlockActivation(true)
    ;Startup the container
    (Alias_FakeContainer as SP_NPC_MimicInventory).Startup()
    ;TODO: Experiment with followers and how they behave to see if this is necessary
    ;Activate the fake container
    Alias_FakeContainer.GetReference().Activate(looter)
    RegisterForMenu("ContainerMenu")
EndEvent

Event OnMenuClose(string menuName)
    ;Not sure if it's necessary since it dies, but doesn't hurt to be sure
    UnregisterForMenu("ContainerMenu")
    (Alias_FakeContainer as SP_NPC_MimicInventory).Shutdown()
    ;FIXME: This wait is a band-aid when taking all items (with LOTS of items!). Quest closes before processing all items and becomes a dupe exploit
    Utility.Wait(1)
    ;Return block activation to default behaviour and stop the quest
    Alias_DeadBody.GetReference().BlockActivation(false)
    Stop()
EndEvent


