Scriptname SP_NPC_MimicInventory extends ReferenceAlias

ReferenceAlias Property Alias_DeadBody Auto
ReferenceAlias Property Alias_Player Auto
Form Property ICL_Empty Auto

ObjectReference deadBody
ObjectReference fakeContainer
ObjectReference player

Event OnInit()
    fakeContainer = GetReference()
    deadBody = Alias_DeadBody.GetReference()
    AddInventoryEventFilter(ICL_Empty);
    fakeContainer.RemoveAllItems(None, false, true)
    Form[] items = deadBody.GetContainerForms()
    int index = 0
    Form item = None
    While (index < items.Length)
        item = items[index]
        GetReference().AddItem(item, deadBody.GetItemCount(item))
        index += 1
    EndWhile
    RemoveInventoryEventFilter(ICL_Empty)
    player = Alias_Player.GetReference()
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
    if akSourceContainer == player
        deadBody.AddItem(akBaseItem, aiItemCount, true)
    endIf
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    if akDestContainer == player
        deadBody.RemoveItem(akBaseItem, aiItemCount, true, None)
    endIf
EndEvent