Scriptname SP_NPC_PlayerXHair extends ReferenceAlias
{The documentation string.}

Import UI
Import Utility

Keyword Property ICLL_DeadBodyEvent Auto
Quest Property ICLL_SMDeadBody Auto

Actor lastActor

Event OnInit()
    RegisterForCrosshairRef()
    ;lastActor = None
endEvent

Event OnCrosshairRefChange(ObjectReference ref)
    Actor npc = ref as Actor
    If npc && npc.IsDead() && npc.GetNumItems() > 0
        ;npc.GetFactionOwner() == None && !locked
        ;locked = true
        ;npc.SetFactionOwner(npc.GetCrimeFaction())
        ;RefreshUI()
        ;Wait(0.1)
        ;locked = false
        ;lastActor = npc
        ICLL_DeadBodyEvent.SendStoryEvent(None, npc)
    elseif ICLL_SMDeadBody.IsRunning()
        ICLL_SMDeadBody.Stop()
    endIf
endEvent

Function RefreshUI()
    SetFloat("TweenMenu", "_root.TweenMenu_mc._alpha", 0.0)
    InvokeString("HUD Menu", "_global.skse.OpenMenu", "TweenMenu")
    InvokeString("HUD Menu", "_global.skse.CloseMenu", "TweenMenu")
endFunction