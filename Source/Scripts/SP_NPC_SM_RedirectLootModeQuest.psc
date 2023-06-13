Scriptname SP_NPC_SM_RedirectLootModeQuest extends Quest
{This quests redirects the event to ICL_SM_StealTagCorpseQuest, but with the chosen LootMode
This way we avoid doing a bunch of unnecessary check condition and leverage it to the story manager}

GlobalVariable Property ICL_LootMode Auto
{Assigns what loot mode it should use e.g. ICL_Citizen or ICL_Outlaw.
Value meanings:
    0 -> Disabled,
    1 -> Last hit looting right
    2 -> Always stolen 
}
Keyword Property ICL_StealTagCorpseEvent Auto
{
Starts the quest that tags the victim's inventory as stolen, depending on lootMode selected
}

Event OnStoryScript(Keyword _unused, Location location, ObjectReference victim, ObjectReference looter, int lootMode, int _unused2)
    ICL_StealTagCorpseEvent.SendStoryEvent(victim.GetCurrentLocation(), victim, looter, ICL_LootMode.GetValueInt(), -1)
    Stop()
EndEvent