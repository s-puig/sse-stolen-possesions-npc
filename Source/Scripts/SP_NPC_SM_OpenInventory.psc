Scriptname SP_NPC_SM_OpenInventory extends Quest
{The documentation string.}

Event OnStoryScript(Keyword _keyword, Location _location, ObjectReference victim, ObjectReference _killer, int _open, int _int2)
    victim.Activate(Game.GetPlayer(), true)
    Stop()
EndEvent