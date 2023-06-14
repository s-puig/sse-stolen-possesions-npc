Scriptname SP_NPC_MimicInventory extends ReferenceAlias
{Mimics the inventory of Alias_Deadbody.
It does this by making a copy of the items to itself and sync item exchanges
In this case, because we want the items to appear with a steal tag, we set this Object Reference with a faction owner}

ReferenceAlias Property Alias_DeadBody Auto
ReferenceAlias Property Alias_Player Auto
Form Property SP_NPC_Empty Auto

ObjectReference deadBody

Event OnInit()
    Debug.Notification("MimicInit?")
    deadBody = Alias_DeadBody.GetReference()
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
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if akSourceContainer == Alias_Player.GetReference()
        deadBody.AddItem(akBaseItem, aiItemCount, true)
    endIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if akDestContainer == Alias_Player.GetReference()
        deadBody.RemoveItem(akBaseItem, aiItemCount, true, None)
    endIf
EndEvent