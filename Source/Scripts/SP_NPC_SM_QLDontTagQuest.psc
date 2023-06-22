Scriptname SP_NPC_SM_QLDontTagQuest extends Quest
{The documentation string.}

Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2)
    Utility.Wait(0.09)
    Stop()
EndEvent