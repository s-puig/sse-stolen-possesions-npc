Scriptname SP_NPC_QuickLootIntegration extends ReferenceAlias
{ Exclusively handles the integration of QuickLoot
It uses the OnCrosshairRef event to keep track of what we are looking at, checking for corpses.
Once it receives one, send a CorpseEvent to check if it passes the ruleset to have a steal tag, if succesful tag and refresh the UI.}

Import UI
Import Utility

Keyword Property SP_NPC_CorpseEvent Auto
Faction Property SP_NPC_CrimeFaction Auto

ObjectReference lastActor
Faction lastFaction

Event OnInit()
    RegisterForCrosshairRef()
    Debug.Notification("Run init!")
endEvent

Event OnCrosshairRefChange(ObjectReference ref)
    Actor current = ref as Actor
    Debug.Notification(ref.GetDisplayName())
    ;If SM Shadow quest actually triggered, means we should tag items as Steal by setting the actor faction owner
    ;We need current != lastActor because of the refresh, it will trigger twice
    If (current && current.IsDead() && current != lastActor &&SP_NPC_CorpseEvent.SendStoryEventAndWait(ref.GetCurrentLocation(), ref, GetReference(), 0))
        ;Return previous actor to original state
        ;This probably doesn't do anything since it will be saved to the file, but it doesn't hurt to try..
        If lastActor != None
            lastActor.SetFactionOwner(lastFaction)
        endIf
        ;Save the actor and faction to change it back
        lastFaction = ref.GetFactionOwner()
        lastActor = ref
        ;Tag to Steal
        ref.SetFactionOwner(SP_NPC_CrimeFaction)
        ;Refresh UI
        RefreshUI()
    endIf
endEvent

Function RefreshUI()
    SetFloat("TweenMenu", "_root.TweenMenu_mc._alpha", 0.0)
    InvokeString("HUD Menu", "_global.skse.OpenMenu", "TweenMenu")
    InvokeString("HUD Menu", "_global.skse.CloseMenu", "TweenMenu")
endFunction