# Stolen Possesions - the Deceased 
Stolen Possesions - the Deceased is a Skyrim SE mod.

> Deceased NPC items are always marked as non-stolen, even if it actually belongs to someone (e.g. horses) or is an illicit murder (e.g. citizens). This might be immersion breaking for some people.

This mod sets some simple rules and tags said items with the *Steal* tag when appropiate and aims to make it as customizable as possible for the end-user.

It accomplishes this by copying the items of the deceased into a fake container and mimicking the actions on the body. The category and ruleset is applied by (ab)using the story manager.

## Roadmap

- [x] Tag loot as stolen
- [x] QuickLoot Support 
    - [x] Tag stolen in inventory menu
    - [x] Tag stolen in QuickLoot menu
- [ ] Customizable categories
    - [x] Civilian
        * Citizens and Hunters
    - [x] Outlaw
        * Bandits, Forsworn, Hagravens, Warlocks,Reavers
    - [x] Outcast
        * Vampires, Werewolves, Afflicted, Werebears
        * Vampire Thrall (?)
    - [x] Undead
        * Draugr, Skeleton and Ghosts, Ash Spawn
    - [x] Dragon cult
        * Dragons and dragon priests
    - [x] Daedra
        * Atronachs and Dremora
        * Lurkers and Seekers (?)
        * Ash Guardian (?)
    - [x] Predator
        * Wolf, Bear, Sabrecat, Chaurus, Spider, Skeever, Slaughterfish, Ash Hopper
    - [x] Domestic animals
        * Cow, Chicken, Dog, Goat, Horse
    - [x] Wild Game
        * Mudcrab, Elk, Deer, Horker, Mammoth, Rabbit, Fox
        Cant find rabbit
    - [ ] Wild creature
        * Ice Wraith, Spriggan, Troll, Wisp, Wispmother, Falmer and Giants
    - [ ] Dwarven automaton
        * Spider, Sphere and Centurion
        * ballista (?)
    - [ ] Factions
        - [ ] Civil War
        - [ ] Companions
        - [ ] Thieves Guild
        - [ ] Winterhold
        - [ ] Dark Brotherhood
        - [ ] Thalmor
        - [ ] Silver Hand
        - [ ] Volkihar
        - [ ] Dawnguard
        - [ ] Alik'r
- [ ] Ruleset
    - [ ] Enable/Disable
    - [ ] Allow friends
    - [ ] Allow followers
    - [ ] Allow members(?)
    - [ ] Allow killed
- [ ] MCM

## Alternatives

### [Contraband](https://www.nexusmods.com/skyrimspecialedition/mods/26021)

* __Pro__
    * Adds (Forsworn/Bandit) barters
    * Dungeon loot module
* __Non__
    * SKSE
    * Partial QuickLoot support
* __Con__
    * Immersion breaking. NPC are denuded during the interaction
    * Laggy interactions
    * Limited customization to citizen or all humanoids
    * No ruleset

### [Honor the Dead](https://www.nexusmods.com/skyrimspecialedition/mods/76208)

* __Pro__
    * Adds stealing interactions
    * SKSE-less
* __Non__
    * Partial QuickLoot support
* __Con__
    * UX. Items are not flagged as stolen
    * Does not support the existing crime system, defaulting to a fixed bounty
    * Limited to citizens
    * No ruleset

### [SV Mods Menu SE - More Punishable Crimes](https://www.nexusmods.com/skyrimspecialedition/mods/34784)

* __Pro__
    * Adds extra cool things (vagrancy, disturbing the jarl, etc) outside the scope of this mod
    * Modular.
    * Partial SKSE requirement
* __Non__
    * Partial QuickLoot support
* __Con__
    * UX. Items are not flagged as stolen
    * Limited to citizens
    * No ruleset

## Acknowledgements

This mod is by no means an original idea, it is inspired by the aforementioned mods and aims to improve upon their groundwork and deliver a better player experience.