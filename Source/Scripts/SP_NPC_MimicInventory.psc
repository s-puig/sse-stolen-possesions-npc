Scriptname SP_NPC_MimicInventory extends ReferenceAlias
{Mimics the inventory of Alias_Deadbody.
It does this by making a copy of the items to itself and sync item exchanges
In this case, because we want the items to appear with a steal tag, we set this Object Reference with a faction owner}

import PO3_SKSEFunctions


ReferenceAlias Property Alias_DeadBody Auto
;ReferenceAlias Property Alias_ProxyContainer Auto
Form Property SP_NPC_Empty Auto

ObjectReference deadBody
ObjectReference player

Function Startup()
    {deadBody = Alias_DeadBody.GetReference()
    AddInventoryEventFilter(SP_NPC_Empty);
    GetReference().RemoveAllItems(None, false, true)
    Form[] items = deadBody.GetContainerForms()
    int index = 0
    Form item = None
    While (index < items.Length)
        item = items[index]
        GetReference().AddItem(item, deadBody.GetItemCount(item))
        index += 1
    EndWhile
    RemoveInventoryEventFilter(SP_NPC_Empty)
    player = Game.GetPlayer()}
    AddInventoryEventFilter(SP_NPC_Empty);
    deadBody = Alias_DeadBody.GetReference()
    GetReference().RemoveAllItems(None, false, true)
    Form[] questItems = GetQuestItems(deadBody)
    Form[] normalItems = AddAllItemsToArray(deadBody, false, false, true)
    Debug.Notification(normalItems.Length)
    int index = 0
    Form item = None
    While (index < normalItems.Length)
        item = normalItems[index]
        GetReference().AddItem(item, deadBody.GetItemCount(item), true)
        index += 1
    EndWhile
    index = 0
    While (index < questItems.Length)
        item = questItems[index]
        deadBody.RemoveItem(item, deadBody.GetItemCount(item), true, GetReference())
        index += 1
    EndWhile
    RemoveInventoryEventFilter(SP_NPC_Empty)
    player = Game.GetPlayer()
endFunction

Function Shutdown()
    AddInventoryEventFilter(SP_NPC_Empty);
    Form[] questItems = GetQuestItems(GetReference())
    int index = 0
    Form item = None
    While (index < questItems.Length)
        item = questItems[index]
        GetReference().RemoveItem(item, GetReference().GetItemCount(item), true, deadBody)
        index += 1
    EndWhile
    GetReference().RemoveAllItems(None, false, true)
    RemoveInventoryEventFilter(SP_NPC_Empty)
EndFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    ;Items transfered from the player to this fake container are moved to the corpse and a copy is made here.
    if akSourceContainer == player as ObjectReference
        GetReference().RemoveItem(akBaseItem, aiItemCount, true, deadBody)
        GetReference().AddItem(akBaseItem, aiItemCount, true)
    endIf
EndEvent

;This is the item pipeline.
;When the player takes an item, they take a NON-PERSISTENT COPY. 
;This is usually ok, but QUEST items will break if you do so.
;To fix this we:
;   1. REMOVE the copy from the player.
;   2. MOVE the item from the corpse to a secondary fake container. 
;       This assigns the stolen tag. NOTE: We can't do that here or we will enter an infinite loop
;   3. MOVE the item from the secondary fake container to the player.
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if akDestContainer == player as ObjectReference
        deadBody.RemoveItem(akBaseItem, aiItemCount, true)
        ;From here on the secondary fake container sends the item back to the player.
    endIf
EndEvent