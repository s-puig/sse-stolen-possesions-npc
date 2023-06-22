Scriptname SP_NPC_MCM extends SKI_ConfigBase
{MCM Menu for this mod. Nothing interesting to see here..}

; SCRIPT VERSION ----------------------------------------------------------------------------------
;
; History
;
; 1:	- Initial version
;
; 2:	- Clean up UI
;		- Add exempt HK
;		- Add mod description to general
;       - Add option flags


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
GlobalVariable Property SP_NPC_CWSons Auto
GlobalVariable Property SP_NPC_CWImperial Auto
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

GlobalVariable Property SP_NPC_Citizen_HK Auto
GlobalVariable Property SP_NPC_Outlaw_HK Auto
GlobalVariable Property SP_NPC_Outcast_HK Auto
GlobalVariable Property SP_NPC_Undead_HK Auto
GlobalVariable Property SP_NPC_DragonCult_HK Auto
GlobalVariable Property SP_NPC_Daedra_HK Auto
GlobalVariable Property SP_NPC_Predator_HK Auto
GlobalVariable Property SP_NPC_Domestic_HK Auto
GlobalVariable Property SP_NPC_Hunt_HK Auto
GlobalVariable Property SP_NPC_Wild_HK Auto
GlobalVariable Property SP_NPC_Dwarven_HK Auto
GlobalVariable Property SP_NPC_CWSons_HK Auto
GlobalVariable Property SP_NPC_CWImperial_HK Auto
GlobalVariable Property SP_NPC_Companion_HK Auto
GlobalVariable Property SP_NPC_ThievesG_HK Auto
GlobalVariable Property SP_NPC_College_HK Auto
GlobalVariable Property SP_NPC_DBrotherhood_HK Auto
GlobalVariable Property SP_NPC_Thalmor_HK Auto
GlobalVariable Property SP_NPC_SilverHand_HK Auto
GlobalVariable Property SP_NPC_Volkihar_HK Auto
GlobalVariable Property SP_NPC_Dawnguard_HK Auto
GlobalVariable Property SP_NPC_Alikr_HK Auto
GlobalVariable Property SP_NPC_Warlock_HK Auto
GlobalVariable Property SP_NPC_Giant_HK Auto
GlobalVariable Property SP_NPC_Falmer_HK Auto
GlobalVariable Property SP_NPC_Vampire_HK Auto
GlobalVariable Property SP_NPC_Forsworn_HK Auto
GlobalVariable Property SP_NPC_Dragon_HK Auto

GlobalVariable Property SP_NPC_Citizen_Follower Auto
GlobalVariable Property SP_NPC_Citizen_Friend Auto

Spell Property SP_NPC_QLDispelCloak Auto

; --- Version 1 ---

string PAGE_GENERAL = "General"
string PAGE_HUMANOID = "Humanoids"
string PAGE_FACTION = "Factions"
string PAGE_CREATURE = "Creatures"

bool enableMod = true

;Preset
int presetMode = 1
string[] presetList
int presetOID

; --- Version 2 ---

string[] statusOpts
string[] killOpts

int lootFlag = 0x00 ;NONE
int citizenFlag = 0x00
int outlawFlag = 0x01
int outcastFlag = 0x01
int undeadFlag = 0x01
int dragonCultFlag = 0x01
int daedraFlag = 0x01
int predatorFlag = 0x01
int domesticFlag = 0x00
int huntFlag = 0x01
int wildFlag = 0x01
int dwarvenFlag = 0x01
int CWSonsFlag = 0x00
int CWImperialFlag = 0x00
int companionFlag = 0x00
int thievesGFlag = 0x00
int collegeFlag = 0x00
int DBrotherhoodFlag = 0x00
int thalmorFlag = 0x00
int silverHandFlag = 0x01
int volkiharFlag = 0x00
int dawnguardFlag = 0x00
int alikrFlag = 0x01
int warlockFlag = 0x01
int giantFlag = 0x01
int falmerFlag = 0x01
int vampireFlag = 0x01
int forswornFlag = 0x01
int dragonFlag = 0x01


int function GetVersion()
	return 2
endfunction

Event OnConfigInit()
    Pages = new string[4]    
    Pages[0] = PAGE_GENERAL
    Pages[1] = PAGE_HUMANOID
    Pages[2] = PAGE_FACTION
    Pages[3] = PAGE_CREATURE

    presetList = new string[4]
    presetList[0] = "Vanilla"
    presetList[1] = "Default"
    presetList[2] = "Immersive"
    presetList[3] = "All"
EndEvent

Event OnConfigClose()
    {Called when the config page is closed, we use this to start/stop quests that handle multiple features}
    If (enableMod)
        if (!SP_NPC_Bootstrap.IsRunning())
            SP_NPC_Bootstrap.Start()
        endIf
    Else
        if (SP_NPC_Bootstrap.IsRunning())
            SP_NPC_Bootstrap.Stop()
        endIf
    EndIf
EndEvent

event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}
	; --- Version 2 ---
	if (a_version >= 2 && CurrentVersion < 2)
		statusOpts = new string[3]
        statusOpts[0] = "LEGAL"
        statusOpts[1] = "ILLEGAL"
        statusOpts[2] = "AUTO"

        killOpts = new String[3]
        killOpts[0] = "OFF"
        killOpts[1] = "ON"
        killOpts[2] = "HONORABLE"
	endIf
endEvent

Event OnPageReset(string pageName)
    SetCursorFillMode(TOP_TO_BOTTOM)
    If (pageName == PAGE_GENERAL)
        ; -- Mod description section (LEFT) --
        ;AddTextOption("This mod tags deceased actors with the stolen mark if the conditions are met.", "")
        SetCursorPosition(1)
        ; -- General options section (RIGHT) --
        AddHeaderOption("General")
        ;Enable mod
        AddToggleOptionST("MOD_ENABLE", "Enable", enableMod)
        ;Preset selection
        presetOID = AddMenuOption("Preset", presetList[presetMode], lootFlag)
        ;QuickLoot support
        AddHeaderOption("QuickLoot support")
        AddToggleOptionST("QUICKLOOT_ENABLE", "[Experimental] Enable", SP_NPC_QLSupport.GetValueInt() as bool, lootFlag)
        ;Force refresh (only enabled when QL is enabled)
        AddTextOptionST("QL_FORCE_REFRESH", "Force refresh", "", lootFlag)
    ElseIf (pageName == PAGE_HUMANOID)
        ;Citizens
        AddHeaderOption("Citizens")
        AddTextOptionST("CITIZEN_ENABLE", "Status", statusOpts[SP_NPC_Citizen.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("CITIZEN_HK", "Exempt kills", killOpts[SP_NPC_Citizen_HK.GetValueInt()], citizenFlag)
        AddToggleOptionST("CITIZEN_FOLLOWER", "Exempt followers", SP_NPC_Citizen_FOLLOWER.GetValueInt(), OPTION_FLAG_DISABLED)  ;citizenFlag but disabled until implemented
        AddToggleOptionST("CITIZEN_FRIEND", "Exempt friends", SP_NPC_Citizen_FRIEND.GetValueInt(), OPTION_FLAG_DISABLED)    
        ;Bandits
        AddHeaderOption("Outlaws")
        AddTextOptionST("OUTLAW_ENABLE", "Status", statusOpts[SP_NPC_Outlaw.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("OUTLAW_HK", "Exempt kills", killOpts[SP_NPC_Outlaw_HK.GetValueInt()], outlawFlag)
        ;Bandit warlock/necromancers
        AddHeaderOption("Warlocks")
        AddTextOptionST("WARLOCK_ENABLE", "Status", statusOpts[SP_NPC_Warlock.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("WARLOCK_HK", "Exempt kills", killOpts[SP_NPC_Warlock_HK.GetValueInt()], warlockFlag)
        ;Wild Vampires
        AddHeaderOption("Vampires")
        AddTextOptionST("VAMPIRE_ENABLE", "Status", statusOpts[SP_NPC_Vampire.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("VAMPIRE_HK", "Exempt kills", killOpts[SP_NPC_Vampire_HK.GetValueInt()], vampireFlag)
        ;Supernatural
        AddHeaderOption("Outcasts")
        AddTextOptionST("OUTCAST_ENABLE", "Status", statusOpts[SP_NPC_Outcast.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("OUTCAST_HK", "Exempt kills", killOpts[SP_NPC_Outcast_HK.GetValueInt()], outcastFlag)
        SetCursorPosition(1)
        ;Undead
        AddHeaderOption("Undead")
        AddTextOptionST("UNDEAD_ENABLE", "Status", statusOpts[SP_NPC_Undead.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("UNDEAD_HK", "Exempt kills", killOpts[SP_NPC_Undead_HK.GetValueInt()], undeadFlag)
        ;Dragon priests
        AddHeaderOption("Dragon cult")
        AddTextOptionST("DRAGONCULT_ENABLE", "Status", statusOpts[SP_NPC_DragonCult.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("DRAGONCULT_HK", "Exempt kills", killOpts[SP_NPC_DragonCult_HK.GetValueInt()], dragonCultFlag)
        ;Giant
        AddHeaderOption("Giant")
        AddTextOptionST("GIANT_ENABLE", "Status", statusOpts[SP_NPC_Giant.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("GIANT_HK", "Exempt kills", killOpts[SP_NPC_Giant_HK.GetValueInt()], giantFlag)
        ;Falmer
        AddHeaderOption("Falmer")
        AddTextOptionST("FALMER_ENABLE", "Status", statusOpts[SP_NPC_Falmer.GetValueInt()], lootFlag)
        AddEmptyOption()
        AddTextOptionST("FALMER_HK", "Exempt kills", killOpts[SP_NPC_Falmer_HK.GetValueInt()], falmerFlag)
    ElseIf (pageName == PAGE_FACTION)
        ;CW Stormcloak
        AddHeaderOption("Civil War - Stormcloak")
        AddTextOptionST("CWSons_ENABLE", "Enable", statusOpts[SP_NPC_CWSons.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("CWSons_HK", "Exempt kills", killOpts[SP_NPC_CWSons_HK.GetValueInt()], CWSonsFlag)
        ;CW Imperial
        AddHeaderOption("Civil War - Imperial")
        AddTextOptionST("CWImperial_ENABLE", "Enable", statusOpts[SP_NPC_CWImperial.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("CWImperial_HK", "Exempt kills", killOpts[SP_NPC_CWImperial_HK.GetValueInt()], CWImperialFlag)
        ;Thalmor
        AddHeaderOption("Thalmor")
        AddTextOptionST("THALMOR_ENABLE", "Enable", statusOpts[SP_NPC_Thalmor.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("THALMOR_HK", "Exempt kills", killOpts[SP_NPC_Thalmor_HK.GetValueInt()], thalmorFlag)
        ;Companions
        AddHeaderOption("The Companions")
        AddTextOptionST("COMPANION_ENABLE", "Enable", statusOpts[SP_NPC_Companion.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("COMPANION_HK", "Exempt kills", killOpts[SP_NPC_Companion_HK.GetValueInt()], companionFlag)
        ;Mage guild
        AddHeaderOption("The College of Winterhold")
        AddTextOptionST("COLLEGE_ENABLE", "Enable", statusOpts[SP_NPC_College.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("COLLEGE_HK", "Exempt kills", killOpts[SP_NPC_College_HK.GetValueInt()], collegeFlag)
        ;Thieves guild
        AddHeaderOption("Thieves Guild")
        AddTextOptionST("THIEVES_ENABLE", "Enable", statusOpts[SP_NPC_ThievesG.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("THIEVES_HK", "Exempt kills", killOpts[SP_NPC_ThievesG_HK.GetValueInt()], thievesGFlag)
        ;Assassin guild
        AddHeaderOption("The Darkbrotherhood")
        AddTextOptionST("DBROTHERHOOD_ENABLE", "Enable", statusOpts[SP_NPC_DBrotherhood.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DBROTERHOOD_HK", "Exempt kills", killOpts[SP_NPC_DBrotherhood_HK.GetValueInt()], dbrotherhoodFlag)
        SetCursorPosition(1)
        ;Silver Hand
        AddHeaderOption("Silver Hand")
        AddTextOptionST("SILVERHAND_ENABLE", "Enable", statusOpts[SP_NPC_SilverHand.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("SILVERHAND_HK", "Exempt kills", killOpts[SP_NPC_SILVERHAND_HK.GetValueInt()], silverhandFlag)
        ;Forsworn
        AddHeaderOption("Forsworn")
        AddTextOptionST("FORSWORN_ENABLE", "Enable", statusOpts[SP_NPC_Forsworn.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("FORSWORN_HK", "Exempt kills", killOpts[SP_NPC_Forsworn_HK.GetValueInt()], forswornFlag)
        ;Alikr
        AddHeaderOption("Alik'r")
        AddTextOptionST("ALIKR_ENABLE", "Enable", statusOpts[SP_NPC_Alikr.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("ALIKR_HK", "Exempt kills", killOpts[SP_NPC_Alikr_HK.GetValueInt()], alikrFlag)
        ;DLC Vampires
        AddHeaderOption("Volkihar clan")
        AddTextOptionST("VOLKIHAR_ENABLE", "Enable", statusOpts[SP_NPC_Volkihar.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("VOLKIHAR_HK", "Exempt kills", killOpts[SP_NPC_Volkihar_HK.GetValueInt()], volkiharFlag)
        ;DLC Vampire hunters
        AddHeaderOption("Dawnguard")
        AddTextOptionST("DAWNGUARD_ENABLE", "Enable", statusOpts[SP_NPC_Dawnguard.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DAWNGUARD_HK", "Exempt kills", killOpts[SP_NPC_Dawnguard_HK.GetValueInt()], dawnguardFlag)
    ElseIf (pageName == PAGE_CREATURE)
        ;Domestic animals
        AddHeaderOption("Domestic animals")
        AddTextOptionST("DOMESTIC_ENABLE", "Enable", statusOpts[SP_NPC_Domestic.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DOMESTIC_HK", "Exempt kills", killOpts[SP_NPC_Domestic_HK.GetValueInt()], domesticFlag)
        ;Huntable animals
        AddHeaderOption("Game animals")
        AddTextOptionST("HUNT_ENABLE", "Enable", statusOpts[SP_NPC_Hunt.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("HUNT_HK", "Exempt kills", killOpts[SP_NPC_Hunt_HK.GetValueInt()], huntFlag)
        ;Animal predators
        AddHeaderOption("Wild predators")
        AddTextOptionST("PREDATOR_ENABLE", "Enable", statusOpts[SP_NPC_Predator.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("PREDATOR_HK", "Exempt kills", killOpts[SP_NPC_Predator_HK.GetValueInt()], predatorFlag)
        SetCursorPosition(1)
        ;Dragon
        AddHeaderOption("Dragon")
        AddTextOptionST("DRAGON_ENABLE", "Enable", statusOpts[SP_NPC_Dragon.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DRAGON_HK", "Exempt kills", killOpts[SP_NPC_Dragon_HK.GetValueInt()], dragonFlag)
        ;Daedras
        AddHeaderOption("Daedra")
        AddTextOptionST("DAEDRA_ENABLE", "Enable", statusOpts[SP_NPC_Daedra.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DAEDRA_HK", "Exempt kills", killOpts[SP_NPC_Daedra_HK.GetValueInt()], daedraFlag)
        ;Monsters
        AddHeaderOption("Wild creatures")
        AddTextOptionST("WILD_ENABLE", "Enable", statusOpts[SP_NPC_Wild.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("WILD_HK", "Exempt kills", killOpts[SP_NPC_Wild_HK.GetValueInt()], wildFlag)
        ;Dwarven
        AddHeaderOption("Dwarven automatons")
        AddTextOptionST("DWARVEN_ENABLE", "Enable", statusOpts[SP_NPC_Dwarven.GetValueInt()])
        AddEmptyOption()
        AddTextOptionST("DWARVEN_HK", "Exempt kills", killOpts[SP_NPC_Dwarven_HK.GetValueInt()], dwarvenFlag)
    EndIf
EndEvent


Function SetPreset(int option)
    If (option == 0);VANILLA
        ;Enable
        SP_NPC_Citizen.SetValueInt(0)
        SP_NPC_Outlaw.SetValueInt(0)
        SP_NPC_Outcast.SetValueInt(0)
        SP_NPC_Undead.SetValueInt(0)
        SP_NPC_DragonCult.SetValueInt(0)
        SP_NPC_Daedra.SetValueInt(0)
        SP_NPC_Predator.SetValueInt(0)
        SP_NPC_Domestic.SetValueInt(0)
        SP_NPC_Hunt.SetValueInt(0)
        SP_NPC_Wild.SetValueInt(0)
        SP_NPC_Dwarven.SetValueInt(0)
        SP_NPC_CWSons.SetValueInt(0)
        SP_NPC_CWImperial.SetValueInt(0)
        SP_NPC_Companion.SetValueInt(0)
        SP_NPC_ThievesG.SetValueInt(0)
        SP_NPC_College.SetValueInt(0)
        SP_NPC_DBrotherhood.SetValueInt(0)
        SP_NPC_Thalmor.SetValueInt(0)
        SP_NPC_SilverHand.SetValueInt(0)
        SP_NPC_Volkihar.SetValueInt(0)
        SP_NPC_Dawnguard.SetValueInt(0)
        SP_NPC_Alikr.SetValueInt(0)
        SP_NPC_Warlock.SetValueInt(0)
        SP_NPC_Giant.SetValueInt(0)
        SP_NPC_Falmer.SetValueInt(0)
        SP_NPC_Vampire.SetValueInt(0)
        SP_NPC_Forsworn.SetValueInt(0)
        SP_NPC_Dragon.SetValueInt(0)

        ;HK
        SP_NPC_Citizen_HK.SetValueInt(0)
        SP_NPC_Outlaw_HK.SetValueInt(0)
        SP_NPC_Outcast_HK.SetValueInt(0)
        SP_NPC_Undead_HK.SetValueInt(0)
        SP_NPC_DragonCult_HK.SetValueInt(0)
        SP_NPC_Daedra_HK.SetValueInt(0)
        SP_NPC_Predator_HK.SetValueInt(0)
        SP_NPC_Domestic_HK.SetValueInt(0)
        SP_NPC_Hunt_HK.SetValueInt(0)
        SP_NPC_Wild_HK.SetValueInt(0)
        SP_NPC_Dwarven_HK.SetValueInt(0)
        SP_NPC_CWSons_HK.SetValueInt(0)
        SP_NPC_CWImperial_HK.SetValueInt(0)
        SP_NPC_Companion_HK.SetValueInt(0)
        SP_NPC_ThievesG_HK.SetValueInt(0)
        SP_NPC_College_HK.SetValueInt(0)
        SP_NPC_DBrotherhood_HK.SetValueInt(0)
        SP_NPC_Thalmor_HK.SetValueInt(0)
        SP_NPC_SilverHand_HK.SetValueInt(0)
        SP_NPC_Volkihar_HK.SetValueInt(0)
        SP_NPC_Dawnguard_HK.SetValueInt(0)
        SP_NPC_Alikr_HK.SetValueInt(0)
        SP_NPC_Warlock_HK.SetValueInt(0)
        SP_NPC_Giant_HK.SetValueInt(0)
        SP_NPC_Falmer_HK.SetValueInt(0)
        SP_NPC_Vampire_HK.SetValueInt(0)
        SP_NPC_Forsworn_HK.SetValueInt(0)
        SP_NPC_Dragon_HK.SetValueInt(0)

        ;flags
        citizenFlag = OPTION_FLAG_DISABLED
        outlawFlag = OPTION_FLAG_DISABLED
        outcastFlag = OPTION_FLAG_DISABLED
        undeadFlag = OPTION_FLAG_DISABLED
        dragonCultFlag = OPTION_FLAG_DISABLED
        daedraFlag = OPTION_FLAG_DISABLED
        predatorFlag = OPTION_FLAG_DISABLED
        domesticFlag = OPTION_FLAG_DISABLED
        huntFlag = OPTION_FLAG_DISABLED
        wildFlag = OPTION_FLAG_DISABLED
        dwarvenFlag = OPTION_FLAG_DISABLED
        CWSonsFlag = OPTION_FLAG_DISABLED
        CWImperialFlag = OPTION_FLAG_DISABLED
        companionFlag = OPTION_FLAG_DISABLED
        thievesGFlag = OPTION_FLAG_DISABLED
        collegeFlag = OPTION_FLAG_DISABLED
        DBrotherhoodFlag = OPTION_FLAG_DISABLED
        thalmorFlag = OPTION_FLAG_DISABLED
        silverHandFlag = OPTION_FLAG_DISABLED
        volkiharFlag = OPTION_FLAG_DISABLED
        dawnguardFlag = OPTION_FLAG_DISABLED
        alikrFlag = OPTION_FLAG_DISABLED
        warlockFlag = OPTION_FLAG_DISABLED
        giantFlag = OPTION_FLAG_DISABLED
        falmerFlag = OPTION_FLAG_DISABLED
        vampireFlag = OPTION_FLAG_DISABLED
        forswornFlag = OPTION_FLAG_DISABLED
        dragonFlag = OPTION_FLAG_DISABLED
    ElseIf (option == 1) ;Default
        SP_NPC_Citizen.SetValueInt(1)
        SP_NPC_Outlaw.SetValueInt(0)
        SP_NPC_Outcast.SetValueInt(0)
        SP_NPC_Undead.SetValueInt(0)
        SP_NPC_DragonCult.SetValueInt(0)
        SP_NPC_Daedra.SetValueInt(0)
        SP_NPC_Predator.SetValueInt(0)
        SP_NPC_Domestic.SetValueInt(1)
        SP_NPC_Hunt.SetValueInt(0)
        SP_NPC_Wild.SetValueInt(0)
        SP_NPC_Dwarven.SetValueInt(0)
        SP_NPC_CWSons.SetValueInt(2)
        SP_NPC_CWImperial.SetValueInt(2)
        SP_NPC_Companion.SetValueInt(1)
        SP_NPC_ThievesG.SetValueInt(2)
        SP_NPC_College.SetValueInt(1)
        SP_NPC_DBrotherhood.SetValueInt(2)
        SP_NPC_Thalmor.SetValueInt(1)
        SP_NPC_SilverHand.SetValueInt(0)
        SP_NPC_Volkihar.SetValueInt(2)
        SP_NPC_Dawnguard.SetValueInt(1)
        SP_NPC_Alikr.SetValueInt(0)
        SP_NPC_Warlock.SetValueInt(0)
        SP_NPC_Giant.SetValueInt(0)
        SP_NPC_Falmer.SetValueInt(0)
        SP_NPC_Vampire.SetValueInt(0)
        SP_NPC_Forsworn.SetValueInt(0)
        SP_NPC_Dragon.SetValueInt(0)

        ;HK
        SP_NPC_Citizen_HK.SetValueInt(0)
        SP_NPC_Outlaw_HK.SetValueInt(0)
        SP_NPC_Outcast_HK.SetValueInt(0)
        SP_NPC_Undead_HK.SetValueInt(0)
        SP_NPC_DragonCult_HK.SetValueInt(0)
        SP_NPC_Daedra_HK.SetValueInt(0)
        SP_NPC_Predator_HK.SetValueInt(0)
        SP_NPC_Domestic_HK.SetValueInt(0)
        SP_NPC_Hunt_HK.SetValueInt(0)
        SP_NPC_Wild_HK.SetValueInt(0)
        SP_NPC_Dwarven_HK.SetValueInt(0)
        SP_NPC_CWSons_HK.SetValueInt(0)
        SP_NPC_CWImperial_HK.SetValueInt(0)
        SP_NPC_Companion_HK.SetValueInt(0)
        SP_NPC_ThievesG_HK.SetValueInt(0)
        SP_NPC_College_HK.SetValueInt(0)
        SP_NPC_DBrotherhood_HK.SetValueInt(0)
        SP_NPC_Thalmor_HK.SetValueInt(0)
        SP_NPC_SilverHand_HK.SetValueInt(0)
        SP_NPC_Volkihar_HK.SetValueInt(0)
        SP_NPC_Dawnguard_HK.SetValueInt(0)
        SP_NPC_Alikr_HK.SetValueInt(0)
        SP_NPC_Warlock_HK.SetValueInt(0)
        SP_NPC_Giant_HK.SetValueInt(0)
        SP_NPC_Falmer_HK.SetValueInt(0)
        SP_NPC_Vampire_HK.SetValueInt(0)
        SP_NPC_Forsworn_HK.SetValueInt(0)
        SP_NPC_Dragon_HK.SetValueInt(0)

        ;flags
        citizenFlag = OPTION_FLAG_NONE
        outlawFlag = OPTION_FLAG_DISABLED
        outcastFlag = OPTION_FLAG_DISABLED
        undeadFlag = OPTION_FLAG_DISABLED
        dragonCultFlag = OPTION_FLAG_DISABLED
        daedraFlag = OPTION_FLAG_DISABLED
        predatorFlag = OPTION_FLAG_DISABLED
        domesticFlag = OPTION_FLAG_NONE
        huntFlag = OPTION_FLAG_DISABLED
        wildFlag = OPTION_FLAG_DISABLED
        dwarvenFlag = OPTION_FLAG_DISABLED
        CWSonsFlag = OPTION_FLAG_NONE
        CWImperialFlag = OPTION_FLAG_NONE
        companionFlag = OPTION_FLAG_NONE
        thievesGFlag = OPTION_FLAG_NONE
        collegeFlag = OPTION_FLAG_NONE
        DBrotherhoodFlag = OPTION_FLAG_NONE
        thalmorFlag = OPTION_FLAG_DISABLED
        silverHandFlag = OPTION_FLAG_DISABLED
        volkiharFlag = OPTION_FLAG_NONE
        dawnguardFlag = OPTION_FLAG_NONE
        alikrFlag = OPTION_FLAG_DISABLED
        warlockFlag = OPTION_FLAG_DISABLED
        giantFlag = OPTION_FLAG_DISABLED
        falmerFlag = OPTION_FLAG_DISABLED
        vampireFlag = OPTION_FLAG_DISABLED
        forswornFlag = OPTION_FLAG_DISABLED
        dragonFlag = OPTION_FLAG_DISABLED
    ElseIf (option == 2) ;Immersive
        SP_NPC_Citizen.SetValueInt(1)
        SP_NPC_Outlaw.SetValueInt(1)
        SP_NPC_Outcast.SetValueInt(1)
        SP_NPC_Undead.SetValueInt(1)
        SP_NPC_DragonCult.SetValueInt(0)
        SP_NPC_Daedra.SetValueInt(1)
        SP_NPC_Predator.SetValueInt(1)
        SP_NPC_Domestic.SetValueInt(1)
        SP_NPC_Hunt.SetValueInt(1)
        SP_NPC_Wild.SetValueInt(1)
        SP_NPC_Dwarven.SetValueInt(1)
        SP_NPC_CWSons.SetValueInt(2)
        SP_NPC_CWImperial.SetValueInt(2)
        SP_NPC_Companion.SetValueInt(1)
        SP_NPC_ThievesG.SetValueInt(2)
        SP_NPC_College.SetValueInt(1)
        SP_NPC_DBrotherhood.SetValueInt(2)
        SP_NPC_Thalmor.SetValueInt(1)
        SP_NPC_SilverHand.SetValueInt(1)
        SP_NPC_Volkihar.SetValueInt(2)
        SP_NPC_Dawnguard.SetValueInt(1)
        SP_NPC_Alikr.SetValueInt(1)
        SP_NPC_Warlock.SetValueInt(1)
        SP_NPC_Giant.SetValueInt(1)
        SP_NPC_Falmer.SetValueInt(1)
        SP_NPC_Vampire.SetValueInt(1)
        SP_NPC_Forsworn.SetValueInt(1)
        SP_NPC_Dragon.SetValueInt(0)

        ;HK
        SP_NPC_Citizen_HK.SetValueInt(0)
        SP_NPC_Outlaw_HK.SetValueInt(1)
        SP_NPC_Outcast_HK.SetValueInt(1)
        SP_NPC_Undead_HK.SetValueInt(1)
        SP_NPC_DragonCult_HK.SetValueInt(0)
        SP_NPC_Daedra_HK.SetValueInt(1)
        SP_NPC_Predator_HK.SetValueInt(1)
        SP_NPC_Domestic_HK.SetValueInt(0)
        SP_NPC_Hunt_HK.SetValueInt(0)
        SP_NPC_Wild_HK.SetValueInt(1)
        SP_NPC_Dwarven_HK.SetValueInt(1)
        SP_NPC_CWSons_HK.SetValueInt(0)
        SP_NPC_CWImperial_HK.SetValueInt(0)
        SP_NPC_Companion_HK.SetValueInt(0)
        SP_NPC_ThievesG_HK.SetValueInt(0)
        SP_NPC_College_HK.SetValueInt(0)
        SP_NPC_DBrotherhood_HK.SetValueInt(0)
        SP_NPC_Thalmor_HK.SetValueInt(0)
        SP_NPC_SilverHand_HK.SetValueInt(1)
        SP_NPC_Volkihar_HK.SetValueInt(0)
        SP_NPC_Dawnguard_HK.SetValueInt(0)
        SP_NPC_Alikr_HK.SetValueInt(1)
        SP_NPC_Warlock_HK.SetValueInt(1)
        SP_NPC_Giant_HK.SetValueInt(1)
        SP_NPC_Falmer_HK.SetValueInt(1)
        SP_NPC_Vampire_HK.SetValueInt(1)
        SP_NPC_Forsworn_HK.SetValueInt(1)
        SP_NPC_Dragon_HK.SetValueInt(0)

        ;flags
        citizenFlag = OPTION_FLAG_NONE
        outlawFlag = OPTION_FLAG_NONE
        outcastFlag = OPTION_FLAG_NONE
        undeadFlag = OPTION_FLAG_NONE
        dragonCultFlag = OPTION_FLAG_DISABLED
        daedraFlag = OPTION_FLAG_NONE
        predatorFlag = OPTION_FLAG_NONE
        domesticFlag = OPTION_FLAG_NONE
        huntFlag = OPTION_FLAG_NONE
        wildFlag = OPTION_FLAG_NONE
        dwarvenFlag = OPTION_FLAG_NONE
        CWSonsFlag = OPTION_FLAG_NONE
        CWImperialFlag = OPTION_FLAG_NONE
        companionFlag = OPTION_FLAG_NONE
        thievesGFlag = OPTION_FLAG_NONE
        collegeFlag = OPTION_FLAG_NONE
        DBrotherhoodFlag = OPTION_FLAG_NONE
        thalmorFlag = OPTION_FLAG_NONE
        silverHandFlag = OPTION_FLAG_NONE
        volkiharFlag = OPTION_FLAG_NONE
        dawnguardFlag = OPTION_FLAG_NONE
        alikrFlag = OPTION_FLAG_NONE
        warlockFlag = OPTION_FLAG_NONE
        giantFlag = OPTION_FLAG_NONE
        falmerFlag = OPTION_FLAG_NONE
        vampireFlag = OPTION_FLAG_NONE
        forswornFlag = OPTION_FLAG_NONE
        dragonFlag = OPTION_FLAG_DISABLED
    Elseif (option == 3) ;Always
        SP_NPC_Citizen.SetValueInt(1)
        SP_NPC_Outlaw.SetValueInt(1)
        SP_NPC_Outcast.SetValueInt(1)
        SP_NPC_Undead.SetValueInt(1)
        SP_NPC_DragonCult.SetValueInt(1)
        SP_NPC_Daedra.SetValueInt(1)
        SP_NPC_Predator.SetValueInt(1)
        SP_NPC_Domestic.SetValueInt(1)
        SP_NPC_Hunt.SetValueInt(1)
        SP_NPC_Wild.SetValueInt(1)
        SP_NPC_Dwarven.SetValueInt(1)
        SP_NPC_CWSons.SetValueInt(1)
        SP_NPC_CWImperial.SetValueInt(1)
        SP_NPC_Companion.SetValueInt(1)
        SP_NPC_ThievesG.SetValueInt(1)
        SP_NPC_College.SetValueInt(1)
        SP_NPC_DBrotherhood.SetValueInt(1)
        SP_NPC_Thalmor.SetValueInt(1)
        SP_NPC_SilverHand.SetValueInt(1)
        SP_NPC_Volkihar.SetValueInt(1)
        SP_NPC_Dawnguard.SetValueInt(1)
        SP_NPC_Alikr.SetValueInt(1)
        SP_NPC_Warlock.SetValueInt(1)
        SP_NPC_Giant.SetValueInt(1)
        SP_NPC_Falmer.SetValueInt(1)
        SP_NPC_Vampire.SetValueInt(1)
        SP_NPC_Forsworn.SetValueInt(1)
        SP_NPC_Dragon.SetValueInt(1)

        ;HK
        SP_NPC_Citizen_HK.SetValueInt(0)
        SP_NPC_Outlaw_HK.SetValueInt(0)
        SP_NPC_Outcast_HK.SetValueInt(0)
        SP_NPC_Undead_HK.SetValueInt(0)
        SP_NPC_DragonCult_HK.SetValueInt(0)
        SP_NPC_Daedra_HK.SetValueInt(0)
        SP_NPC_Predator_HK.SetValueInt(0)
        SP_NPC_Domestic_HK.SetValueInt(0)
        SP_NPC_Hunt_HK.SetValueInt(0)
        SP_NPC_Wild_HK.SetValueInt(0)
        SP_NPC_Dwarven_HK.SetValueInt(0)
        SP_NPC_CWSons_HK.SetValueInt(0)
        SP_NPC_CWImperial_HK.SetValueInt(0)
        SP_NPC_Companion_HK.SetValueInt(0)
        SP_NPC_ThievesG_HK.SetValueInt(0)
        SP_NPC_College_HK.SetValueInt(0)
        SP_NPC_DBrotherhood_HK.SetValueInt(0)
        SP_NPC_Thalmor_HK.SetValueInt(0)
        SP_NPC_SilverHand_HK.SetValueInt(0)
        SP_NPC_Volkihar_HK.SetValueInt(0)
        SP_NPC_Dawnguard_HK.SetValueInt(0)
        SP_NPC_Alikr_HK.SetValueInt(0)
        SP_NPC_Warlock_HK.SetValueInt(0)
        SP_NPC_Giant_HK.SetValueInt(0)
        SP_NPC_Falmer_HK.SetValueInt(0)
        SP_NPC_Vampire_HK.SetValueInt(0)
        SP_NPC_Forsworn_HK.SetValueInt(0)
        SP_NPC_Dragon_HK.SetValueInt(0)

        ;flags
        citizenFlag = OPTION_FLAG_NONE
        outlawFlag = OPTION_FLAG_NONE
        outcastFlag = OPTION_FLAG_NONE
        undeadFlag = OPTION_FLAG_NONE
        dragonCultFlag = OPTION_FLAG_NONE
        daedraFlag = OPTION_FLAG_NONE
        predatorFlag = OPTION_FLAG_NONE
        domesticFlag = OPTION_FLAG_NONE
        huntFlag = OPTION_FLAG_NONE
        wildFlag = OPTION_FLAG_NONE
        dwarvenFlag = OPTION_FLAG_NONE
        CWSonsFlag = OPTION_FLAG_NONE
        CWImperialFlag = OPTION_FLAG_NONE
        companionFlag = OPTION_FLAG_NONE
        thievesGFlag = OPTION_FLAG_NONE
        collegeFlag = OPTION_FLAG_NONE
        DBrotherhoodFlag = OPTION_FLAG_NONE
        thalmorFlag = OPTION_FLAG_NONE
        silverHandFlag = OPTION_FLAG_NONE
        volkiharFlag = OPTION_FLAG_NONE
        dawnguardFlag = OPTION_FLAG_NONE
        alikrFlag = OPTION_FLAG_NONE
        warlockFlag = OPTION_FLAG_NONE
        giantFlag = OPTION_FLAG_NONE
        falmerFlag = OPTION_FLAG_NONE
        vampireFlag = OPTION_FLAG_NONE
        forswornFlag = OPTION_FLAG_NONE
        dragonFlag = OPTION_FLAG_NONE
    EndIf
EndFunction

;Returns next status e.g. LEGAL->ILLEGAL->AUTO->LEGAL
int Function GetNextStatus(int currentStatus, bool withAuto = false)
    int next = currentStatus + 1
    If ((next == 2 && !withAuto) || next > 2)
        next = 0
    EndIf
    return next
EndFunction

int Function GetNextKillOption(int currentKill, bool withHK = false)
    int next = currentKill + 1
    If (next == 2 && !withHK)
        next = next + 1
    EndIf
    If (next >= 3)
        next = 0
    EndIf
    return next
EndFunction

Event OnOptionMenuOpen(int option)
    if (option == presetOID)
		SetMenuDialogOptions(presetList)
		SetMenuDialogStartIndex(presetMode)
		SetMenuDialogDefaultIndex(1)
	endIf
EndEvent

event OnOptionMenuAccept(int option, int index)
	if (option == presetOID)
        presetMode = index
		SetMenuOptionValue(presetOID, presetList[presetMode])
        SetPreset(presetMode)
	endIf
endEvent

State MOD_ENABLE
    event OnSelectST()
        enableMod = !enableMod

        ;Flags..

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

STATE QL_FORCE_REFRESH
    event OnSelectST()
        SP_NPC_QLDispelCloak.Cast(Game.GetPlayer(), Game.GetPlayer())
    endEvent
endState

State CITIZEN_ENABLE
    event OnSelectST()
        ;Update to next status
        SP_NPC_Citizen.SetValueInt(GetNextStatus(SP_NPC_Citizen.GetValueInt()))
        
        ;Flagging updates
        If (SP_NPC_Citizen.GetValueInt() != 0)
            citizenFlag = OPTION_FLAG_NONE
        else 
            citizenFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(citizenFlag, true, "CITIZEN_HK")
        SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "CITIZEN_FOLLOWER")
        SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "CITIZEN_FRIEND")

        SetTextOptionValueST(statusOpts[SP_NPC_Citizen.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Citizen.SetValueInt(0)
            citizenFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Citizen.SetValueInt(1)
            citizenFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Citizen.SetValueInt(1)
            citizenFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Citizen.SetValueInt(1)
            citizenFlag = OPTION_FLAG_NONE
        EndIf
    
        SetOptionFlagsST(citizenFlag, true, "CITIZEN_HK")
        SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "CITIZEN_FOLLOWER")
        SetOptionFlagsST(OPTION_FLAG_DISABLED, true, "CITIZEN_FRIEND")
        SetTextOptionValueST(statusOpts[SP_NPC_Citizen.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes law-abiding citizens and hunters.")
    endEvent
EndState

State OUTLAW_ENABLE
    event OnSelectST()
        SP_NPC_Outlaw.SetValueInt(GetNextStatus(SP_NPC_Outlaw.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Outlaw.GetValueInt() != 0)
            outlawFlag = OPTION_FLAG_NONE
        else 
            outlawFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(outlawFlag, true, "OUTLAW_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Outlaw.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Outlaw.SetValueInt(0)
            outlawFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Outlaw.SetValueInt(0)
            outlawFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Outlaw.SetValueInt(1)
            outlawFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Outlaw.SetValueInt(1)
            outlawFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(outlawFlag, true, "OUTLAW_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Outlaw.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes bandits and reavers.")
    endEvent
EndState

State UNDEAD_ENABLE
    event OnSelectST()
        SP_NPC_Undead.SetValueInt(GetNextStatus(SP_NPC_Undead.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Undead.GetValueInt() != 0)
            UndeadFlag = OPTION_FLAG_NONE
        else 
            UndeadFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(UndeadFlag, true, "Undead_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Undead.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Undead.SetValueInt(0)
            UndeadFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Undead.SetValueInt(0)
            UndeadFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Undead.SetValueInt(1)
            UndeadFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Undead.SetValueInt(1)
            UndeadFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(UndeadFlag, true, "Undead_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Undead.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes draugr, skeletons, ghosts and ash spawns.")
    endEvent
EndState

State OUTCAST_ENABLE
    event OnSelectST()
        SP_NPC_Outcast.SetValueInt(GetNextStatus(SP_NPC_Outcast.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Outcast.GetValueInt() != 0)
            OutcastFlag = OPTION_FLAG_NONE
        else 
            OutcastFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(OutcastFlag, true, "Outcast_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Outcast.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Outcast.SetValueInt(0)
            OutcastFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Outcast.SetValueInt(0)
            OutcastFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Outcast.SetValueInt(1)
            OutcastFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Outcast.SetValueInt(1)
            OutcastFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(OutcastFlag, true, "Outcast_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Outcast.GetValueInt()])
    endEvent
    event OnHighlightST()
        SetInfoText("Includes werewolves, werebears and Periyite's afflicted.")
    endEvent
EndState

State DRAGONCULT_ENABLE
    event OnSelectST()
        SP_NPC_DragonCult.SetValueInt(GetNextStatus(SP_NPC_DragonCult.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_DragonCult.GetValueInt() != 0)
            DragonCultFlag = OPTION_FLAG_NONE
        else 
            DragonCultFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DragonCultFlag, true, "DragonCult_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_DragonCult.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_DragonCult.SetValueInt(0)
            DragonCultFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_DragonCult.SetValueInt(0)
            DragonCultFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_DragonCult.SetValueInt(0)
            DragonCultFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 3)
            SP_NPC_DragonCult.SetValueInt(1)
            DragonCultFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DragonCultFlag, true, "DragonCult_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_DragonCult.GetValueInt()])
    endEvent
EndState

State DAEDRA_ENABLE
    event OnSelectST()
        SP_NPC_Daedra.SetValueInt(GetNextStatus(SP_NPC_Daedra.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Daedra.GetValueInt() != 0)
            DaedraFlag = OPTION_FLAG_NONE
        else 
            DaedraFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DaedraFlag, true, "Daedra_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Daedra.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Daedra.SetValueInt(0)
            DaedraFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Daedra.SetValueInt(0)
            DaedraFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Daedra.SetValueInt(1)
            DaedraFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Daedra.SetValueInt(1)
            DaedraFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DaedraFlag, true, "Daedra_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Daedra.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes atronach, dremora and Dragonborn DLC daedra.")
    endEvent
EndState

State DOMESTIC_ENABLE
    event OnSelectST()
        SP_NPC_Domestic.SetValueInt(GetNextStatus(SP_NPC_Domestic.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Domestic.GetValueInt() != 0)
            DomesticFlag = OPTION_FLAG_NONE
        else 
            DomesticFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DomesticFlag, true, "Domestic_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Domestic.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Domestic.SetValueInt(0)
            DomesticFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Domestic.SetValueInt(1)
            DomesticFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Domestic.SetValueInt(1)
            DomesticFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Domestic.SetValueInt(1)
            DomesticFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DomesticFlag, true, "Domestic_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Domestic.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes cows, chickens, dogs, goats and horses.")
    endEvent
EndState

State HUNT_ENABLE
    event OnSelectST()
        SP_NPC_Hunt.SetValueInt(GetNextStatus(SP_NPC_Hunt.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Hunt.GetValueInt() != 0)
            HuntFlag = OPTION_FLAG_NONE
        else 
            HuntFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(HuntFlag, true, "Hunt_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Hunt.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Hunt.SetValueInt(0)
            HuntFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Hunt.SetValueInt(0)
            HuntFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Hunt.SetValueInt(1)
            HuntFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Hunt.SetValueInt(1)
            HuntFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(HuntFlag, true, "Hunt_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Hunt.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes mudcrabs, elks, deers, horkers, rabbits, foxes and mammoths.")
    endEvent
EndState

State PREDATOR_ENABLE
    event OnSelectST()
        SP_NPC_Predator.SetValueInt(GetNextStatus(SP_NPC_Predator.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Predator.GetValueInt() != 0)
            PredatorFlag = OPTION_FLAG_NONE
        else 
            PredatorFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(PredatorFlag, true, "Predator_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Predator.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Predator.SetValueInt(0)
            PredatorFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Predator.SetValueInt(0)
            PredatorFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Predator.SetValueInt(1)
            PredatorFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Predator.SetValueInt(1)
            PredatorFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(PredatorFlag, true, "Predator_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Predator.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes wolves, bears, sabre cats, chaurus, spiders, skeevers, slaughterfish and ash hoppers.")
    endEvent
EndState

State WILD_ENABLE
    event OnSelectST()
        SP_NPC_Wild.SetValueInt(GetNextStatus(SP_NPC_Wild.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Wild.GetValueInt() != 0)
            WildFlag = OPTION_FLAG_NONE
        else 
            WildFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(WildFlag, true, "Wild_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Wild.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Wild.SetValueInt(0)
            WildFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Wild.SetValueInt(0)
            WildFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Wild.SetValueInt(1)
            WildFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Wild.SetValueInt(1)
            WildFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(WildFlag, true, "Wild_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Wild.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes trolls, spriggans, wisps and ice wraiths.")
    endEvent
EndState

State DWARVEN_ENABLE
    event OnSelectST()
        SP_NPC_Dwarven.SetValueInt(GetNextStatus(SP_NPC_Dwarven.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Dwarven.GetValueInt() != 0)
            DwarvenFlag = OPTION_FLAG_NONE
        else 
            DwarvenFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DwarvenFlag, true, "Dwarven_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dwarven.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dwarven.SetValueInt(0)
            DwarvenFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Dwarven.SetValueInt(0)
            DwarvenFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Dwarven.SetValueInt(1)
            DwarvenFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Dwarven.SetValueInt(1)
            DwarvenFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DwarvenFlag, true, "Dwarven_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dwarven.GetValueInt()])
    endEvent
EndState

State DRAGON_ENABLE
    event OnSelectST()
        SP_NPC_Dragon.SetValueInt(GetNextStatus(SP_NPC_Dragon.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Dragon.GetValueInt() != 0)
            DragonFlag = OPTION_FLAG_NONE
        else 
            DragonFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DragonFlag, true, "Dragon_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dragon.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dragon.SetValueInt(0)
            DragonFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Dragon.SetValueInt(0)
            DragonFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Dragon.SetValueInt(0)
            DragonFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 3)
            SP_NPC_Dragon.SetValueInt(1)
            DragonFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DragonFlag, true, "Dragon_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dragon.GetValueInt()])
    endEvent
EndState

State WARLOCK_ENABLE
    event OnSelectST()
        SP_NPC_Warlock.SetValueInt(GetNextStatus(SP_NPC_Warlock.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Warlock.GetValueInt() != 0)
            WarlockFlag = OPTION_FLAG_NONE
        else 
            WarlockFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(WarlockFlag, true, "Warlock_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Warlock.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Warlock.SetValueInt(0)
            WarlockFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Warlock.SetValueInt(0)
            WarlockFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Warlock.SetValueInt(1)
            WarlockFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Warlock.SetValueInt(1)
            WarlockFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(WarlockFlag, true, "Warlock_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Warlock.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes warlocks and necromancers.")
    endEvent
EndState

State GIANT_ENABLE
    event OnSelectST()
        SP_NPC_Giant.SetValueInt(GetNextStatus(SP_NPC_Giant.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Giant.GetValueInt() != 0)
            GiantFlag = OPTION_FLAG_NONE
        else 
            GiantFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(GiantFlag, true, "Giant_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Giant.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Giant.SetValueInt(0)
            GiantFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Giant.SetValueInt(0)
            GiantFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Giant.SetValueInt(1)
            GiantFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Giant.SetValueInt(1)
            GiantFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(GiantFlag, true, "Giant_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Giant.GetValueInt()])
    endEvent
EndState

State FALMER_ENABLE
    event OnSelectST()
        SP_NPC_Falmer.SetValueInt(GetNextStatus(SP_NPC_Falmer.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Falmer.GetValueInt() != 0)
            FalmerFlag = OPTION_FLAG_NONE
        else 
            FalmerFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(FalmerFlag, true, "Falmer_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Falmer.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Falmer.SetValueInt(0)
            FalmerFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Falmer.SetValueInt(0)
            FalmerFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Falmer.SetValueInt(1)
            FalmerFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Falmer.SetValueInt(1)
            FalmerFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(FalmerFlag, true, "Falmer_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Falmer.GetValueInt()])
    endEvent
EndState

State VAMPIRE_ENABLE
    event OnSelectST()
        SP_NPC_Vampire.SetValueInt(GetNextStatus(SP_NPC_Vampire.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Vampire.GetValueInt() != 0)
            VampireFlag = OPTION_FLAG_NONE
        else 
            VampireFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(VampireFlag, true, "Vampire_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Vampire.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Vampire.SetValueInt(0)
            VampireFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Vampire.SetValueInt(0)
            VampireFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Vampire.SetValueInt(1)
            VampireFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Vampire.SetValueInt(1)
            VampireFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(VampireFlag, true, "Vampire_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Vampire.GetValueInt()])
    endEvent
EndState

State CWSons_ENABLE
    event OnSelectST()
        SP_NPC_CWSons.SetValueInt(GetNextStatus(SP_NPC_CWSons.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_CWSons.GetValueInt() != 0)
            CWSonsFlag = OPTION_FLAG_NONE
        else 
            CWSonsFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(CWSonsFlag, true, "CWSons_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_CWSons.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_CWSons.SetValueInt(0)
            CWSonsFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_CWSons.SetValueInt(2)
            CWSonsFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_CWSons.SetValueInt(2)
            CWSonsFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_CWSons.SetValueInt(1)
            CWSonsFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(CWSonsFlag, true, "CWSons_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_CWSons.GetValueInt()])
    endEvent
EndState

State CWImperial_ENABLE
    event OnSelectST()
        SP_NPC_CWImperial.SetValueInt(GetNextStatus(SP_NPC_CWImperial.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_CWImperial.GetValueInt() != 0)
            CWImperialFlag = OPTION_FLAG_NONE
        else 
            CWImperialFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(CWImperialFlag, true, "CWImperial_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_CWImperial.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_CWImperial.SetValueInt(0)
            CWImperialFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_CWImperial.SetValueInt(2)
            CWImperialFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_CWImperial.SetValueInt(2)
            CWImperialFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_CWImperial.SetValueInt(1)
            CWImperialFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(CWImperialFlag, true, "CWImperial_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_CWImperial.GetValueInt()])
    endEvent
EndState

State COMPANION_ENABLE
    event OnSelectST()
        SP_NPC_Companion.SetValueInt(GetNextStatus(SP_NPC_Companion.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_Companion.GetValueInt() != 0)
            CompanionFlag = OPTION_FLAG_NONE
        else 
            CompanionFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(CompanionFlag, true, "Companion_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Companion.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Companion.SetValueInt(0)
            CompanionFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Companion.SetValueInt(1)
            CompanionFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Companion.SetValueInt(1)
            CompanionFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Companion.SetValueInt(1)
            CompanionFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(CompanionFlag, true, "Companion_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Companion.GetValueInt()])
    endEvent
EndState

State THIEVES_ENABLE
    event OnSelectST()
        SP_NPC_ThievesG.SetValueInt(GetNextStatus(SP_NPC_ThievesG.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_ThievesG.GetValueInt() != 0)
            ThievesGFlag = OPTION_FLAG_NONE
        else 
            ThievesGFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(ThievesGFlag, true, "ThievesG_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_ThievesG.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_ThievesG.SetValueInt(0)
            ThievesGFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_ThievesG.SetValueInt(2)
            ThievesGFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_ThievesG.SetValueInt(1)
            ThievesGFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_ThievesG.SetValueInt(1)
            ThievesGFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(ThievesGFlag, true, "ThievesG_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_ThievesG.GetValueInt()])
    endEvent
EndState

State COLLEGE_ENABLE
    event OnSelectST()
        SP_NPC_College.SetValueInt(GetNextStatus(SP_NPC_College.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_College.GetValueInt() != 0)
            CollegeFlag = OPTION_FLAG_NONE
        else 
            CollegeFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(CollegeFlag, true, "College_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_College.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_College.SetValueInt(0)
            CollegeFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_College.SetValueInt(1)
            CollegeFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_College.SetValueInt(1)
            CollegeFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_College.SetValueInt(1)
            CollegeFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(CollegeFlag, true, "College_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_College.GetValueInt()])
    endEvent
EndState

State DBROTHERHOOD_ENABLE
    event OnSelectST()
        SP_NPC_DBrotherhood.SetValueInt(GetNextStatus(SP_NPC_DBrotherhood.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_DBrotherhood.GetValueInt() != 0)
            DBrotherhoodFlag = OPTION_FLAG_NONE
        else 
            DBrotherhoodFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DBrotherhoodFlag, true, "DBrotherhood_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_DBrotherhood.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_DBrotherhood.SetValueInt(0)
            DBrotherhoodFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_DBrotherhood.SetValueInt(2)
            DBrotherhoodFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_DBrotherhood.SetValueInt(2)
            DBrotherhoodFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_DBrotherhood.SetValueInt(1)
            DBrotherhoodFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DBrotherhoodFlag, true, "DBrotherhood_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_DBrotherhood.GetValueInt()])
    endEvent
EndState

State THALMOR_ENABLE
    event OnSelectST()
        SP_NPC_Thalmor.SetValueInt(GetNextStatus(SP_NPC_Thalmor.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Thalmor.GetValueInt() != 0)
            ThalmorFlag = OPTION_FLAG_NONE
        else 
            ThalmorFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(ThalmorFlag, true, "Thalmor_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Thalmor.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Thalmor.SetValueInt(0)
            ThalmorFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Thalmor.SetValueInt(1)
            ThalmorFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Thalmor.SetValueInt(1)
            ThalmorFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Thalmor.SetValueInt(1)
            ThalmorFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(ThalmorFlag, true, "Thalmor_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Thalmor.GetValueInt()])
    endEvent
EndState

State SILVERHAND_ENABLE
    event OnSelectST()
        SP_NPC_SilverHand.SetValueInt(GetNextStatus(SP_NPC_SilverHand.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_SilverHand.GetValueInt() != 0)
            SilverHandFlag = OPTION_FLAG_NONE
        else 
            SilverHandFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(SilverHandFlag, true, "SilverHand_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_SilverHand.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_SilverHand.SetValueInt(0)
            SilverHandFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_SilverHand.SetValueInt(0)
            SilverHandFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_SilverHand.SetValueInt(1)
            SilverHandFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_SilverHand.SetValueInt(1)
            SilverHandFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(SilverHandFlag, true, "SilverHand_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_SilverHand.GetValueInt()])
    endEvent
EndState

State VOLKIHAR_ENABLE
    event OnSelectST()
        SP_NPC_Volkihar.SetValueInt(GetNextStatus(SP_NPC_Volkihar.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_Volkihar.GetValueInt() != 0)
            VolkiharFlag = OPTION_FLAG_NONE
        else 
            VolkiharFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(VolkiharFlag, true, "Volkihar_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Volkihar.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Volkihar.SetValueInt(0)
            VolkiharFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Volkihar.SetValueInt(2)
            VolkiharFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Volkihar.SetValueInt(2)
            VolkiharFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Volkihar.SetValueInt(1)
            VolkiharFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(VolkiharFlag, true, "Volkihar_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Volkihar.GetValueInt()])
    endEvent
EndState

State DAWNGUARD_ENABLE
    event OnSelectST()
        SP_NPC_Dawnguard.SetValueInt(GetNextStatus(SP_NPC_Dawnguard.GetValueInt(), true))
        ;Flagging updates
        If (SP_NPC_Dawnguard.GetValueInt() != 0)
            DawnguardFlag = OPTION_FLAG_NONE
        else 
            DawnguardFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(DawnguardFlag, true, "Dawnguard_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dawnguard.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dawnguard.SetValueInt(0)
            DawnguardFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Dawnguard.SetValueInt(1)
            DawnguardFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 2)
            SP_NPC_Dawnguard.SetValueInt(1)
            DawnguardFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Dawnguard.SetValueInt(1)
            DawnguardFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(DawnguardFlag, true, "Dawnguard_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Dawnguard.GetValueInt()])
    endEvent
EndState

State ALIKR_ENABLE
    event OnSelectST()
        SP_NPC_Alikr.SetValueInt(GetNextStatus(SP_NPC_Alikr.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Alikr.GetValueInt() != 0)
            AlikrFlag = OPTION_FLAG_NONE
        else 
            AlikrFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(AlikrFlag, true, "Alikr_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Alikr.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Alikr.SetValueInt(0)
            AlikrFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Alikr.SetValueInt(0)
            AlikrFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Alikr.SetValueInt(1)
            AlikrFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Alikr.SetValueInt(1)
            AlikrFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(AlikrFlag, true, "Alikr_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Alikr.GetValueInt()])
    endEvent
EndState

State FORSWORN_ENABLE
    event OnSelectST()
        SP_NPC_Forsworn.SetValueInt(GetNextStatus(SP_NPC_Forsworn.GetValueInt()))
        ;Flagging updates
        If (SP_NPC_Forsworn.GetValueInt() != 0)
            ForswornFlag = OPTION_FLAG_NONE
        else 
            ForswornFlag = OPTION_FLAG_DISABLED
        EndIf
        SetOptionFlagsST(ForswornFlag, true, "Forsworn_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Forsworn.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Forsworn.SetValueInt(0)
            ForswornFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 1)
            SP_NPC_Forsworn.SetValueInt(0)
            ForswornFlag = OPTION_FLAG_DISABLED
        ElseIf (presetMode == 2)
            SP_NPC_Forsworn.SetValueInt(1)
            ForswornFlag = OPTION_FLAG_NONE
        ElseIf (presetMode == 3)
            SP_NPC_Forsworn.SetValueInt(1)
            ForswornFlag = OPTION_FLAG_NONE
        EndIf

        SetOptionFlagsST(ForswornFlag, true, "Forsworn_HK")
        SetTextOptionValueST(statusOpts[SP_NPC_Forsworn.GetValueInt()])
    endEvent

    event OnHighlightST()
        SetInfoText("Includes forsworn and hagraven.")
    endEvent
EndState

State CITIZEN_HK
    event OnSelectST()
        SP_NPC_Citizen_HK.SetValueInt(GetNextStatus(SP_NPC_Citizen_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Citizen_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Citizen_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Citizen_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Citizen_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Citizen_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Citizen_HK.GetValueInt()])
    endEvent

    event OnHighlightST()
    endEvent
EndState

State OUTLAW_HK
    event OnSelectST()
        SP_NPC_Outlaw_HK.SetValueInt(GetNextStatus(SP_NPC_Outlaw_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Outlaw_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Outlaw_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Outlaw_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Outlaw_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Outlaw_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Outlaw_HK.GetValueInt()])
    endEvent
EndState

State Outcast_HK
    event OnSelectST()
        SP_NPC_Outcast_HK.SetValueInt(GetNextStatus(SP_NPC_Outcast_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Outcast_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Outcast_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Outcast_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Outcast_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Outcast_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Outcast_HK.GetValueInt()])
    endEvent
EndState

State Undead_HK
    event OnSelectST()
        SP_NPC_Undead_HK.SetValueInt(GetNextStatus(SP_NPC_Undead_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Undead_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Undead_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Undead_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Undead_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Undead_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Undead_HK.GetValueInt()])
    endEvent
EndState

State DragonCult_HK
    event OnSelectST()
        SP_NPC_DragonCult_HK.SetValueInt(GetNextStatus(SP_NPC_DragonCult_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_DragonCult_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_DragonCult_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_DragonCult_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_DragonCult_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_DragonCult_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_DragonCult_HK.GetValueInt()])
    endEvent
EndState

State Warlock_HK
    event OnSelectST()
        SP_NPC_Warlock_HK.SetValueInt(GetNextStatus(SP_NPC_Warlock_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Warlock_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Warlock_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Warlock_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Warlock_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Warlock_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Warlock_HK.GetValueInt()])
    endEvent
EndState

State Giant_HK
    event OnSelectST()
        SP_NPC_Giant_HK.SetValueInt(GetNextStatus(SP_NPC_Giant_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Giant_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Giant_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Giant_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Giant_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Giant_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Giant_HK.GetValueInt()])
    endEvent
EndState

State Falmer_HK
    event OnSelectST()
        SP_NPC_Falmer_HK.SetValueInt(GetNextStatus(SP_NPC_Falmer_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Falmer_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Falmer_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Falmer_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Falmer_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Falmer_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Falmer_HK.GetValueInt()])
    endEvent
EndState

State Vampire_HK
    event OnSelectST()
        SP_NPC_Vampire_HK.SetValueInt(GetNextStatus(SP_NPC_Vampire_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Vampire_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Vampire_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Vampire_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Vampire_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Vampire_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Vampire_HK.GetValueInt()])
    endEvent
EndState

State CWSons_HK
    event OnSelectST()
        SP_NPC_CWSons_HK.SetValueInt(GetNextStatus(SP_NPC_CWSons_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_CWSons_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_CWSons_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_CWSons_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_CWSons_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_CWSons_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_CWSons_HK.GetValueInt()])
    endEvent
EndState

State CWImperial_HK
    event OnSelectST()
        SP_NPC_CWImperial_HK.SetValueInt(GetNextStatus(SP_NPC_CWImperial_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_CWImperial_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_CWImperial_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_CWImperial_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_CWImperial_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_CWImperial_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_CWImperial_HK.GetValueInt()])
    endEvent
EndState

State ThievesG_HK
    event OnSelectST()
        SP_NPC_ThievesG_HK.SetValueInt(GetNextStatus(SP_NPC_ThievesG_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_ThievesG_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_ThievesG_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_ThievesG_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_ThievesG_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_ThievesG_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_ThievesG_HK.GetValueInt()])
    endEvent
EndState

State College_HK
    event OnSelectST()
        SP_NPC_College_HK.SetValueInt(GetNextStatus(SP_NPC_College_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_College_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_College_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_College_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_College_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_College_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_College_HK.GetValueInt()])
    endEvent
EndState

State DBrotherhood_HK
    event OnSelectST()
        SP_NPC_DBrotherhood_HK.SetValueInt(GetNextStatus(SP_NPC_DBrotherhood_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_DBrotherhood_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_DBrotherhood_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_DBrotherhood_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_DBrotherhood_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_DBrotherhood_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_DBrotherhood_HK.GetValueInt()])
    endEvent
EndState

State Thalmor_HK
    event OnSelectST()
        SP_NPC_Thalmor_HK.SetValueInt(GetNextStatus(SP_NPC_Thalmor_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Thalmor_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Thalmor_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Thalmor_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Thalmor_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Thalmor_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Thalmor_HK.GetValueInt()])
    endEvent
EndState

State SilverHand_HK
    event OnSelectST()
        SP_NPC_SilverHand_HK.SetValueInt(GetNextStatus(SP_NPC_SilverHand_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_SilverHand_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_SilverHand_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_SilverHand_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_SilverHand_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_SilverHand_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_SilverHand_HK.GetValueInt()])
    endEvent
EndState

State Volkihar_HK
    event OnSelectST()
        SP_NPC_Volkihar_HK.SetValueInt(GetNextStatus(SP_NPC_Volkihar_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Volkihar_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Volkihar_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Volkihar_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Volkihar_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Volkihar_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Volkihar_HK.GetValueInt()])
    endEvent
EndState

State Dawnguard_HK
    event OnSelectST()
        SP_NPC_Dawnguard_HK.SetValueInt(GetNextStatus(SP_NPC_Dawnguard_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Dawnguard_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dawnguard_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Dawnguard_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Dawnguard_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Dawnguard_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Dawnguard_HK.GetValueInt()])
    endEvent
EndState

State Alikr_HK
    event OnSelectST()
        SP_NPC_Alikr_HK.SetValueInt(GetNextStatus(SP_NPC_Alikr_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Alikr_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Alikr_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Alikr_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Alikr_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Alikr_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Alikr_HK.GetValueInt()])
    endEvent
EndState

State Forsworn_HK
    event OnSelectST()
        SP_NPC_Forsworn_HK.SetValueInt(GetNextStatus(SP_NPC_Forsworn_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Forsworn_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Forsworn_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Forsworn_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Forsworn_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Forsworn_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Forsworn_HK.GetValueInt()])
    endEvent
EndState

State Predator_HK
    event OnSelectST()
        SP_NPC_Predator_HK.SetValueInt(GetNextStatus(SP_NPC_Predator_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Predator_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Predator_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Predator_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Predator_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Predator_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Predator_HK.GetValueInt()])
    endEvent
EndState

State Domestic_HK
    event OnSelectST()
        SP_NPC_Domestic_HK.SetValueInt(GetNextStatus(SP_NPC_Domestic_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Domestic_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Domestic_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Domestic_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Domestic_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Domestic_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Domestic_HK.GetValueInt()])
    endEvent
EndState

State Hunt_HK
    event OnSelectST()
        SP_NPC_Hunt_HK.SetValueInt(GetNextStatus(SP_NPC_Hunt_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Hunt_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Hunt_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Hunt_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Hunt_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Hunt_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Hunt_HK.GetValueInt()])
    endEvent
EndState

State Dragon_HK
    event OnSelectST()
        SP_NPC_Dragon_HK.SetValueInt(GetNextStatus(SP_NPC_Dragon_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Dragon_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dragon_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Dragon_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Dragon_HK.SetValueInt(0)
        ElseIf (presetMode == 3)
            SP_NPC_Dragon_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Dragon_HK.GetValueInt()])
    endEvent
EndState

State Daedra_HK
    event OnSelectST()
        SP_NPC_Daedra_HK.SetValueInt(GetNextStatus(SP_NPC_Daedra_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Daedra_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Daedra_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Daedra_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Daedra_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Daedra_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Daedra_HK.GetValueInt()])
    endEvent
EndState

State Wild_HK
    event OnSelectST()
        SP_NPC_Wild_HK.SetValueInt(GetNextStatus(SP_NPC_Wild_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Wild_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Wild_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Wild_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Wild_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Wild_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Wild_HK.GetValueInt()])
    endEvent
EndState

State Dwarven_HK
    event OnSelectST()
        SP_NPC_Dwarven_HK.SetValueInt(GetNextStatus(SP_NPC_Dwarven_HK.GetValueInt()))
        SetTextOptionValueST(killOpts[SP_NPC_Dwarven_HK.GetValueInt()])
    endEvent

    event OnDefaultST()
        If (presetMode == 0)
            SP_NPC_Dwarven_HK.SetValueInt(0)
        ElseIf (presetMode == 1)
            SP_NPC_Dwarven_HK.SetValueInt(0)
        ElseIf (presetMode == 2)
            SP_NPC_Dwarven_HK.SetValueInt(1)
        ElseIf (presetMode == 3)
            SP_NPC_Dwarven_HK.SetValueInt(0)
        EndIf
        SetTextOptionValueST(killOpts[SP_NPC_Dwarven_HK.GetValueInt()])
    endEvent
EndState

State CITIZEN_FRIEND
    event OnSelectST()
        bool newValue = !SP_NPC_Citizen_Friend.GetValueInt() as bool
        SP_NPC_Citizen_Friend.SetValueInt(newValue as int)
        SetToggleOptionValueST(newValue)
    endEvent

    event OnDefaultST()
        SP_NPC_Citizen_Friend.SetValueInt(0)
        SetToggleOptionValueST(false)
    endEvent
EndState