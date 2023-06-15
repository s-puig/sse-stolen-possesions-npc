Scriptname SP_NPC_MCM extends SKI_ConfigBase
{MCM Menu for this mod. Nothing interesting to see here..}

Quest Property SP_NPC_Bootstrap Auto
GlobalVariable Property SP_NPC_QLSupport Auto
GlobalVariable Property SP_NPC_Citizen Auto
GlobalVariable Property SP_NPC_Outlaw Auto
GlobalVariable Property SP_NPC_Outcast Auto
GlobalVariable Property SP_NPC_Undead Auto
GlobalVariable Property SP_NPC_DragonCult Auto
GlobalVariable Property SP_NPC_Daedra Auto
GlobalVariable Property SP_NPC_Predator Auto
GlobalVariable Property SP_NPC_Domestic Auto
GlobalVariable Property SP_NPC_Hunt Auto
GlobalVariable Property SP_NPC_Wild Auto
GlobalVariable Property SP_NPC_Dwarven Auto
GlobalVariable Property SP_NPC_CW Auto
GlobalVariable Property SP_NPC_Companion Auto
GlobalVariable Property SP_NPC_ThievesG Auto
GlobalVariable Property SP_NPC_College Auto
GlobalVariable Property SP_NPC_DBrotherhood Auto
GlobalVariable Property SP_NPC_Thalmor Auto
GlobalVariable Property SP_NPC_SilverHand Auto
GlobalVariable Property SP_NPC_Volkihar Auto
GlobalVariable Property SP_NPC_Dawnguard Auto
GlobalVariable Property SP_NPC_Alikr Auto


string PAGE_GENERAL = "General"
string PAGE_HUMANOID = "Humanoids"
string PAGE_FACTION = "Factions"
string PAGE_CREATURE = "Creatures"

bool enableMod = true

int function GetVersion()
	return 1
endfunction

Event OnConfigInit()
    Pages = new string[4]    
    Pages[0] = PAGE_GENERAL
    Pages[1] = PAGE_HUMANOID
    Pages[2] = PAGE_FACTION
    Pages[3] = PAGE_CREATURE
EndEvent

Event OnPageReset(string pageName)
    SetCursorFillMode(TOP_TO_BOTTOM)
    If (pageName == PAGE_GENERAL)
        AddHeaderOption("General")
        ;Enable mod
        AddToggleOptionST("MOD_ENABLE", "Enable", enableMod)
        ;Preset selection
        ;TODO!()
        ;QuickLoot support
        AddToggleOptionST("QUICKLOOT_ENABLE", "[Experimental] QuickLoot support", SP_NPC_QLSupport.GetValueInt() as bool)
        ;Force refresh (only enabled when QL is enabled)
        ;TODO!()
    ElseIf (pageName == PAGE_HUMANOID)
        ;Citizens
        AddHeaderOption("Citizens")
        AddToggleOptionST("CITIZEN_ENABLE", "Enable", SP_NPC_Citizen.GetValueInt())
        ;Bandits
        AddHeaderOption("Outlaws")
        AddToggleOptionST("OUTLAW_ENABLE", "Enable", SP_NPC_Outlaw.GetValueInt())
        ;Undead
        AddHeaderOption("Undead")
        AddToggleOptionST("UNDEAD_ENABLE", "Enable", SP_NPC_Undead.GetValueInt())
        SetCursorPosition(1)
        ;Supernatural
        AddHeaderOption("Outcasts")
        AddToggleOptionST("OUTCAST_ENABLE", "Enable", SP_NPC_Outcast.GetValueInt())
        ;Dragon related
        AddHeaderOption("Dragon cult")
        AddToggleOptionST("DRAGONCULT_ENABLE", "Enable", SP_NPC_DragonCult.GetValueInt())
    ElseIf (pageName == PAGE_CREATURE)
        ;Daedras
        AddHeaderOption("Daedra")
        AddToggleOptionST("DAEDRA_ENABLE", "Enable", SP_NPC_Daedra.GetValueInt())
        AddHeaderOption("Domestic animals")
        AddToggleOptionST("DOMESTIC_ENABLE", "Enable", SP_NPC_Domestic.GetValueInt())
        AddHeaderOption("Game animals")
        AddToggleOptionST("HUNT_ENABLE", "Enable", SP_NPC_Hunt.GetValueInt())
        SetCursorPosition(1)
        AddHeaderOption("Wild predators")
        AddToggleOptionST("PREDATOR_ENABLE", "Enable", SP_NPC_Predator.GetValueInt())
        AddHeaderOption("Wild creatures")
        AddToggleOptionST("WILD_ENABLE", "Enable", SP_NPC_Wild.GetValueInt())
        AddHeaderOption("Dwarven automatons")
        AddToggleOptionST("DWARVEN_ENABLE", "Enable", SP_NPC_Dwarven.GetValueInt())
    ElseIf (pageName == PAGE_FACTION)
        AddHeaderOption("The Companions")
        AddToggleOptionST("COMPANION_ENABLE", "Enable", SP_NPC_Companion.GetValueInt())
        AddHeaderOption("The College of Winterhold")
        AddToggleOptionST("COLLEGE_ENABLE", "Enable", SP_NPC_College.GetValueInt())
        AddHeaderOption("Thieves Guild")
        AddToggleOptionST("THIEVES_ENABLE", "Enable", SP_NPC_ThievesG.GetValueInt())
        AddHeaderOption("The Darkbrotherhood")
        AddToggleOptionST("DBROTHERHOOD_ENABLE", "Enable", SP_NPC_DBrotherhood.GetValueInt())
        AddHeaderOption("Civil War")
        AddToggleOptionST("CW_ENABLE", "Enable", SP_NPC_CW.GetValueInt())
        AddHeaderOption("Thalmor")
        AddToggleOptionST("THALMOR_ENABLE", "Enable", SP_NPC_Thalmor.GetValueInt())
        AddHeaderOption("Silver Hand")
        AddToggleOptionST("SILVERHAND_ENABLE", "Enable", SP_NPC_SilverHand.GetValueInt())
        AddHeaderOption("Alik'r")
        AddToggleOptionST("ALIKR_ENABLE", "Enable", SP_NPC_Alikr.GetValueInt())
        AddHeaderOption("Volkihar")
        AddToggleOptionST("VOLKIHAR_ENABLE", "Enable", SP_NPC_Volkihar.GetValueInt())
        AddHeaderOption("Dawnguard")
        AddToggleOptionST("DAWNGUARD_ENABLE", "Enable", SP_NPC_Dawnguard.GetValueInt())
    EndIf
EndEvent

State MOD_ENABLE
    event OnSelectST()
        enableMod = !enableMod

        If (enableMod)
            SP_NPC_Bootstrap.Start()
        Else
            SP_NPC_Bootstrap.Stop()
        EndIf

        ;SetOptionFlags..
        ;TODO!()
        SetToggleOptionValueST(enableMod)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(true)
    endEvent

    event OnHighlightST()
        SetInfoText("Controls the mod functionality. If you want to uninstall, uncheck and wait for atleast an hour.")
    endEvent
EndState

State QUICKLOOT_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_QLSupport.GetValueInt() as bool
        SP_NPC_QLSupport.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_QLSupport.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Experimental support for QuickLoot. BEWARE! THIS IS EXPERIMENTAL AND HAS NOT BEEN TESTED ENOUGH. NOT RESPONSIBLE IF YOUR SAVE BREAKS")
    endEvent
EndState

State CITIZEN_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Citizen.GetValueInt() as bool
        SP_NPC_Citizen.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Citizen.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes law-abiding citizens and hunters.")
    endEvent
EndState

State OUTLAW_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Outlaw.GetValueInt() as bool
        SP_NPC_Outlaw.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Outlaw.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes bandits, forsworn, hagraven, warlocks and reavers.")
    endEvent
EndState

State UNDEAD_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Undead.GetValueInt() as bool
        SP_NPC_Undead.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Undead.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes draugr, skeletons, ghosts and ash spawns.")
    endEvent
EndState

State OUTCAST_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Outcast.GetValueInt() as bool
        SP_NPC_Outcast.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Outcast.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes vampires, werewolves, werebears and afflicted.")
    endEvent
EndState

State DRAGONCULT_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_DragonCult.GetValueInt() as bool
        SP_NPC_DragonCult.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_DragonCult.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes dragons and dragon priests.")
    endEvent
EndState

State DAEDRA_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Daedra.GetValueInt() as bool
        SP_NPC_Daedra.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Daedra.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes atronach, dremora and Dragonborn DLC daedra.")
    endEvent
EndState

State DOMESTIC_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Domestic.GetValueInt() as bool
        SP_NPC_Domestic.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Domestic.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes cows, chickens, dogs, goats and horses.")
    endEvent
EndState

State HUNT_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Hunt.GetValueInt() as bool
        SP_NPC_Hunt.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Hunt.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes mudcrabs, elks, deers, horkers, rabbits, foxes and mammoths.")
    endEvent
EndState

State PREDATOR_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Predator.GetValueInt() as bool
        SP_NPC_Predator.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Predator.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes wolves, bears, sabre cats, chaurus, spiders, skeevers, slaughterfish and ash hoppers.")
    endEvent
EndState

State WILD_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Wild.GetValueInt() as bool
        SP_NPC_Wild.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Wild.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes trolls, spriggans, wisps, ice wraiths, falmer and giants.")
    endEvent
EndState

State DWARVEN_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Dwarven.GetValueInt() as bool
        SP_NPC_Dwarven.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Dwarven.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes dwarven automatons.")
    endEvent
EndState