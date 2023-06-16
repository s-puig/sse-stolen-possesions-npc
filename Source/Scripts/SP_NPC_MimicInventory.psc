Scriptname SP_NPC_MimicInventory extends ReferenceAlias
{Mimics the inventory of Alias_Deadbody.
It does this by making a copy of normal items, transfer quest items into this reference and keeps them in sync with Alias_Deadbody.
In this case, because we want the items to appear with a steal tag, we set this Object Reference with a faction owner}

import PO3_SKSEFunctions

ReferenceAlias Property Alias_DeadBody Auto
ReferenceAlias Property Alias_Player Auto
Form Property SP_NPC_Empty Auto

ObjectReference fakeContainer
ObjectReference deadBody

Function Startup()
    ;Convenience references
    deadBody = Alias_DeadBody.GetReference()
    fakeContainer = GetReference()
    ;Disable OnItem(Added/Removed) events
    AddInventoryEventFilter(SP_NPC_Empty);
    ;Cleanup the fake inventory of items.
    fakeContainer.RemoveAllItems(None, false, true)
    ;We separate the operation in two: copy (normal items) and transfer (quest items)
    Form[] questItems = GetQuestItems(deadBody)
    Form[] normalItems = AddAllItemsToArray(deadBody, false, false, true)
    int index = 0
    Form item = None
    ;Copy normal items to this container
    While (index < normalItems.Length)
        item = normalItems[index]
        fakeContainer.AddItem(item, deadBody.GetItemCount(item), true)
        index += 1
    EndWhile
    ;Transfer quest items to this container
    index = 0
    While (index < questItems.Length)
        item = questItems[index]
        deadBody.RemoveItem(item, deadBody.GetItemCount(item), true, fakeContainer)
        index += 1
    EndWhile
    ;Enable OnItem(Added/Removed) events
    RemoveInventoryEventFilter(SP_NPC_Empty)
endFunction

;Return back the quest items to the dead body
Function Shutdown()
    AddInventoryEventFilter(SP_NPC_Empty);
    Form[] questItems = GetQuestItems(fakeContainer)
    int index = 0
    Form item = None
    While (index < questItems.Length)
        item = questItems[index]
        fakeContainer.RemoveItem(item, fakeContainer.GetItemCount(item), true, deadBody)
        index += 1
    EndWhile
    RemoveInventoryEventFilter(SP_NPC_Empty)
EndFunction

;Items transfered from the player to this fake container are moved to the corpse and a copy is made here to keep them in sync.
;NOTE: They are moved so QuickLoot can keep item ownership. We can't do that in normal mode (yet).
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if akSourceContainer == Alias_Player.GetReference()
        fakeContainer.RemoveItem(akBaseItem, aiItemCount, true, deadBody)
        fakeContainer.AddItem(akBaseItem, aiItemCount, true)
    endIf
EndEvent

;Items transfered from the fake container to the player are removed from the corpse to keep them in sync.
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if akDestContainer == Alias_Player.GetReference()
        deadBody.RemoveItem(akBaseItem, aiItemCount, true)
    endIf
EndEvent