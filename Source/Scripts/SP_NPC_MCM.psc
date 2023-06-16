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
GlobalVariable Property SP_NPC_Warlock Auto
GlobalVariable Property SP_NPC_Giant Auto
GlobalVariable Property SP_NPC_Falmer Auto
GlobalVariable Property SP_NPC_Vampire Auto
GlobalVariable Property SP_NPC_Forsworn Auto
GlobalVariable Property SP_NPC_Dragon Auto


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
        AddToggleOptionST("MOD_ENABLE", "Enable", enableMod, OPTION_FLAG_DISABLED)
        ;Preset selection
        AddTextOptionST("PRESET_OPTION", "Preset", "Default", OPTION_FLAG_DISABLED)
        ;QuickLoot support
        AddHeaderOption("QuickLoot support")
        AddToggleOptionST("QUICKLOOT_ENABLE", "[Experimental] Enable", SP_NPC_QLSupport.GetValueInt() as bool)
        ;Force refresh (only enabled when QL is enabled)
        AddTextOptionST("REFRESH", "Force refresh", "", OPTION_FLAG_DISABLED)
    ElseIf (pageName == PAGE_HUMANOID)
        ;Citizens
        AddHeaderOption("Citizens")
        AddToggleOptionST("CITIZEN_ENABLE", "Enable", SP_NPC_Citizen.GetValueInt())
        ;Bandits
        AddHeaderOption("Outlaws")
        AddToggleOptionST("OUTLAW_ENABLE", "Enable", SP_NPC_Outlaw.GetValueInt())
        ;Bandit warlock/necromancers
        AddHeaderOption("Warlocks")
        AddToggleOptionST("WARLOCK_ENABLE", "Enable", SP_NPC_Warlock.GetValueInt())
        ;Wild Vampires
        AddHeaderOption("Vampires")
        AddToggleOptionST("VAMPIRE_ENABLE", "Enable", SP_NPC_Vampire.GetValueInt())
        ;Supernatural
        AddHeaderOption("Outcasts")
        AddToggleOptionST("OUTCAST_ENABLE", "Enable", SP_NPC_Outcast.GetValueInt())
        SetCursorPosition(1)
        ;Undead
        AddHeaderOption("Undead")
        AddToggleOptionST("UNDEAD_ENABLE", "Enable", SP_NPC_Undead.GetValueInt())
        ;Dragon priests
        AddHeaderOption("Dragon cult")
        AddToggleOptionST("DRAGONCULT_ENABLE", "Enable", SP_NPC_DragonCult.GetValueInt())
        ;Giant
        AddHeaderOption("Giant")
        AddToggleOptionST("GIANT_ENABLE", "Enable", SP_NPC_Giant.GetValueInt())
        ;Falmer
        AddHeaderOption("Falmer")
        AddToggleOptionST("FALMER_ENABLE", "Enable", SP_NPC_Falmer.GetValueInt())
    ElseIf (pageName == PAGE_FACTION)
        ;Civil war
        AddHeaderOption("Civil War")
        AddToggleOptionST("CW_ENABLE", "Enable", SP_NPC_CW.GetValueInt())
        ;Thalmor
        AddHeaderOption("Thalmor")
        AddToggleOptionST("THALMOR_ENABLE", "Enable", SP_NPC_Thalmor.GetValueInt())
        ;Companions
        AddHeaderOption("The Companions")
        AddToggleOptionST("COMPANION_ENABLE", "Enable", SP_NPC_Companion.GetValueInt())
        ;Mage guild
        AddHeaderOption("The College of Winterhold")
        AddToggleOptionST("COLLEGE_ENABLE", "Enable", SP_NPC_College.GetValueInt())
        ;Thieves guild
        AddHeaderOption("Thieves Guild")
        AddToggleOptionST("THIEVES_ENABLE", "Enable", SP_NPC_ThievesG.GetValueInt())
        ;Assassin guild
        AddHeaderOption("The Darkbrotherhood")
        AddToggleOptionST("DBROTHERHOOD_ENABLE", "Enable", SP_NPC_DBrotherhood.GetValueInt())
        SetCursorPosition(1)
        ;Silver Hand
        AddHeaderOption("Silver Hand")
        AddToggleOptionST("SILVERHAND_ENABLE", "Enable", SP_NPC_SilverHand.GetValueInt())
        ;Forsworn
        AddHeaderOption("Forsworn")
        AddToggleOptionST("FORSWORN_ENABLE", "Enable", SP_NPC_Forsworn.GetValueInt())
        ;Alikr
        AddHeaderOption("Alik'r")
        AddToggleOptionST("ALIKR_ENABLE", "Enable", SP_NPC_Alikr.GetValueInt())
        ;DLC Vampires
        AddHeaderOption("Volkihar clan")
        AddToggleOptionST("VOLKIHAR_ENABLE", "Enable", SP_NPC_Volkihar.GetValueInt())
        ;DLC Vampire hunters
        AddHeaderOption("Dawnguard")
        AddToggleOptionST("DAWNGUARD_ENABLE", "Enable", SP_NPC_Dawnguard.GetValueInt())
    ElseIf (pageName == PAGE_CREATURE)
        ;Domestic animals
        AddHeaderOption("Domestic animals")
        AddToggleOptionST("DOMESTIC_ENABLE", "Enable", SP_NPC_Domestic.GetValueInt())
        ;Huntable animals
        AddHeaderOption("Game animals")
        AddToggleOptionST("HUNT_ENABLE", "Enable", SP_NPC_Hunt.GetValueInt())
        ;Animal predators
        AddHeaderOption("Wild predators")
        AddToggleOptionST("PREDATOR_ENABLE", "Enable", SP_NPC_Predator.GetValueInt())
        SetCursorPosition(1)
        ;Dragon
        AddHeaderOption("Dragon")
        AddToggleOptionST("DRAGON_ENABLE", "Enable", SP_NPC_Dragon.GetValueInt())
        ;Daedras
        AddHeaderOption("Daedra")
        AddToggleOptionST("DAEDRA_ENABLE", "Enable", SP_NPC_Daedra.GetValueInt())
        ;Monsters
        AddHeaderOption("Wild creatures")
        AddToggleOptionST("WILD_ENABLE", "Enable", SP_NPC_Wild.GetValueInt())
        ;Dwarven
        AddHeaderOption("Dwarven automatons")
        AddToggleOptionST("DWARVEN_ENABLE", "Enable", SP_NPC_Dwarven.GetValueInt())
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
        SetInfoText("Includes bandits and reavers.")
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
        SetInfoText("Includes werewolves, werebears and Periyite's afflicted.")
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
        SetInfoText("Includes trolls, spriggans, wisps and ice wraiths.")
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
EndState

State DRAGON_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Dragon.GetValueInt() as bool
        SP_NPC_Dragon.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Dragon.SetValueInt(0)
    endEvent
EndState

State WARLOCK_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Warlock.GetValueInt() as bool
        SP_NPC_Warlock.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Warlock.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes warlocks and necromancers.")
    endEvent
EndState

State GIANT_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Giant.GetValueInt() as bool
        SP_NPC_Giant.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Giant.SetValueInt(0)
    endEvent
EndState

State FALMER_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Falmer.GetValueInt() as bool
        SP_NPC_Falmer.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Falmer.SetValueInt(0)
    endEvent
EndState

State VAMPIRE_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Vampire.GetValueInt() as bool
        SP_NPC_Vampire.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Vampire.SetValueInt(0)
    endEvent
EndState

State CW_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_CW.GetValueInt() as bool
        SP_NPC_CW.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_CW.SetValueInt(0)
    endEvent
EndState

State COMPANION_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Companion.GetValueInt() as bool
        SP_NPC_Companion.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Companion.SetValueInt(0)
    endEvent
EndState

State THIEVES_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_ThievesG.GetValueInt() as bool
        SP_NPC_ThievesG.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_ThievesG.SetValueInt(0)
    endEvent
EndState

State COLLEGE_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_College.GetValueInt() as bool
        SP_NPC_College.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_College.SetValueInt(0)
    endEvent
EndState

State DBROTHERHOOD_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_DBrotherhood.GetValueInt() as bool
        SP_NPC_DBrotherhood.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_DBrotherhood.SetValueInt(0)
    endEvent
EndState

State THALMOR_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Thalmor.GetValueInt() as bool
        SP_NPC_Thalmor.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Thalmor.SetValueInt(0)
    endEvent
EndState

State SILVERHAND_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_SilverHand.GetValueInt() as bool
        SP_NPC_SilverHand.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_SilverHand.SetValueInt(0)
    endEvent
EndState

State VOLKIHAR_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Volkihar.GetValueInt() as bool
        SP_NPC_Volkihar.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Volkihar.SetValueInt(0)
    endEvent
EndState

State DAWNGUARD_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Dawnguard.GetValueInt() as bool
        SP_NPC_Dawnguard.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Dawnguard.SetValueInt(0)
    endEvent
EndState

State ALIKR_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Alikr.GetValueInt() as bool
        SP_NPC_Alikr.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Alikr.SetValueInt(0)
    endEvent
EndState

State FORSWORN_ENABLE
    event OnSelectST()
        bool newValue = !SP_NPC_Forsworn.GetValueInt() as bool
        SP_NPC_Forsworn.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SetToggleOptionValueST(false)
        SP_NPC_Forsworn.SetValueInt(0)
    endEvent

    event OnHighlightST()
        SetInfoText("Includes forsworn and hagraven.")
    endEvent
EndState