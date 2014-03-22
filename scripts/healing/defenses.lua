-- MTW: defenses handling functions

-- table of defenses
mtw.less_defs = {}

mtw.defenses = {
def_myrrh = {defense = "learning speed", type = "normal", effect = "Shortens learning telegraph", balance = {balanceneed = "vout myrrh;eat myrrh"}, state = "down", needit = false, timer = createStopWatch()},
def_highcastle = {defense = "", type = "normal", effect = "10% damage increase vs mobs", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_veilgarden = {defense = "", type = "normal", effect = "Extends duration of defenses", skill = "veilgarden", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Vigilance
def_notice = {defense = "increased notice", type = "endurance", effect = "Checks against stealth actions", skill = "Notice", balance = {equilibriumtake= "notice"}, state = "down", needit = false, timer = createStopWatch()},
def_skywatch = {defense = "skywatch", type = "normal", effect = "Detect rooftop movement", skill = "Skywatch", balance = {equilibriumtake= "skywatch on"}, state = "down", needit = false, timer = createStopWatch()},
def_deathsense = {defense = "deathsense", type = "normal", effect = "Sense the deaths of other players", skill = "Deathsense", balance = {needyequilibriumtake= "deathsense on"}, state = "down", needit = false, timer = createStopWatch()},
def_awareness = {defense = "awareness", type = "endurance", effect = "Detect movement in adjacent rooms", skill = "Awareness", balance = {needyequilibriumtake= "awareness on"}, state = "down", needit = false, timer = createStopWatch()},
def_nightvision = {defense = "night vision", type = "normal", effect = "Reveal identities of players in shadow", skill = "Nightvision", balance = {needybalancetake= "nightvision on"}, state = "down", needit = false, timer = createStopWatch()},
--def_nightvision = {defense = "night vision", type = "normal", effect = "Reveal identities of players in shadow", skill = "nightvision", balance = {needybalancetake= "touch lantern tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_insomnia = {defense = "insomnia", type = "important", effect = "Prevents natural sleep", skill = "Insomnia", balance = {equilibriumtake = "insomnia"}, state = "down", needit = false, timer = createStopWatch()},
def_forboding = {defense = "forboding", type = "normal", effect = "Detect scrying attempts", skill = "Forboding", balance = {needybalancetake= "forboding on"}, state = "down", needit = false, timer = createStopWatch()},
def_premonition = {defense = "premonition", type = "endurance", effect = "Detect enemies entering your area", skill = "Premonition", balance = {needyequilibriumtake= "premonition on"}, state = "down", needit = false, timer = createStopWatch()},
def_vanish = {defense = "", type = "normal", effect = "Temporarily unscryable", skill = "Vanish", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Fighting
def_selfishness = {defense = "selfishness", type = "important", effect = "Prevents GIVE commands and counters pickpockets", skill = "Selfishness", balance = {needybalancetake= "selfishness"}, state = "down", needit = false, timer = createStopWatch()},
def_combat_focus = {defense = "combat focus", type = "normal", effect = "Gags incoming combat text unrelated to you or your target", skill = "Combat Focus", balance = {needyequilibriumtake= "combatfocus on"}, state = "down", needit = false, timer = createStopWatch()},
def_perfect_defense = {defense = "", type = "normal", effect = "", skill = "Perfect Defense", balance = { equilibriumtake = "perfectdefense" }, state = "down", needit = false, timer = createStopWatch()},
--Tattoos
def_lantern = {defense = "", type = "normal", effect = "Reveal identities of players in shadow", balance = {needybalancetake= "touch lantern tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_sun = {defense = "", type = "normal", effect = "Passive health regeneration", balance = {needybalancetake= "touch sun tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_censer = {defense = "", type = "normal", effect = "Increased essence generation", balance = {needybalancetake= "touch censer tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_moon = {defense = "", type = "normal", effect = "Passive mana regeneration", balance = {needybalancetake= "touch moon tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_thirdeye = {defense = "increased perception", type = "normal", effect = "Empowers vigilance checks", balance = {needybalancetake= "touch thirdeye tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_shield = {defense = "", type = "important", effect = "Prevents most attacks", balance = {balancetake= "touch shield tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_arrow = {defense = "", type = "normal", effect = "Protection from ranged attacks", balance = {needybalancetake= "touch arrow tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_glacier = {defense = "", type = "normal", effect = "Passively cures burns", balance = {needybalancetake= "touch glacier tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_star = {defense = "", type = "normal", effect = "Passive adrenaline regeneration below 50%", balance = {needybalancetake= "touch star tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_dragon = {defense = "increased repute", type = "normal", effect = "Increased reputation gains", balance = {needybalancetake= "touch dragon tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_skull = {defense = "protected from loss", type = "normal", effect = "Decreases exp loss from death", balance = {needybalancetake= "touch skull tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_lotus = {defense = "", type = "normal", effect = "Temporary increase in one skill", balance = {needybalancetake= "touch lotus tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_hourglass = {defense = "sands of time", type = "normal", effect = "One-time immunity to DIVINE CENSURE", balance = {needybalancetake= "touch hourglass tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_compass = {defense = "ready to haggle", type = "normal", effect = "Slight decrease in NPC shop costs", balance = {needybalancetake= "touch compass tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_rose = {defense = "scent of roses", type = "normal", effect = "Remove WAKEing delay", balance = {needybalancetake= "touch rose tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_owl = {defense = "sense of wonder", type = "important", effect = "Temporary increase in experience gains", balance = {needybalancetake= "touch owl tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_wheel = {defense = "regaining endurance", type = "normal", effect = "Temporary endurance regeneration", balance = {needybalancetake= "touch wheel tattoo"}, state = "down", needit = false, timer = createStopWatch()},
def_tree = {defense = "", type = "normal", effect = "Prevents true death one time", balance = {needybalancetake= "touch tree tattoo"}, state = "down", needit = false, timer = createStopWatch()},
--Alchemy
def_immunization = {defense = "", type = "normal", effect = "Immune to chosen poison", skill = "Immunization", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Rogue: Fencing
def_krondorian_stance = {defense = "", type = "normal", effect = "+25 to Speed and Damage", skill = "Mastery", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_bastyran_stance = {defense = "", type = "normal", effect = "+25 to Speed and Precision", skill = "Mastery", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_roldemish_stance = {defense = "", type = "normal", effect = "+25 to Precision and Damage", skill = "Mastery", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Rogue: Subtlety
def_hiding = {defense = "hide", type = "important", effect = "Hidden from LOOK/WHO HERE, third-person messages on movement hidden", skill = "Hide", balance = {balancetake= "hide"}, state = "down", needit = false, timer = createStopWatch()},
def_stalking = {defense = "", type = "normal", effect = "Following your target discreetly", skill = "Stalk", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_eavesdrop = {defense = "", type = "normal", effect = "Hearing SAYs and EMOTEs from chosen direction", skill = "Eavesdrop", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_deathmask = {defense = "", type = "normal", effect = "Recovering endurance and guile", skill = "Deathmask", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_ambush = {defense = "", type = "normal", effect = "Prepared to ambush an enemy who enters your room", skill = "Ambush", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_infiltrate = {defense = "", type = "important", effect = "Listening to all mindlinks on your target", skill = "Infiltrate", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_deepshroud = {defense = "", type = "important", effect = "Completely undetectable", skill = "Deepshroud", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Rogue: Thievery
def_arrowsense = {defense = "arrowsense", type = "normal", effect = "Defense against missile attacks", skill = "Arrowsense", balance = {balancetake="arrowsense"}, state = "down", needit = false, timer = createStopWatch()},
def_shadowmend = {defense = "shadowmend", type = "normal", effect = "Regenerating health", skill = "Shadowmend", balance = {equilibriumtake="shadowmend"}, state = "down", needit = false, timer = createStopWatch()},
def_shadowstep = {defense = "", type = "normal", effect = "TRACKs are hidden", skill = "Shadowstep", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_vileblade = {defense = "", type = "normal", effect = "Next defended attack will apply a poison", skill = "Vileblade", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Rogue: Performance
def_prelude = {defense = "", type = "normal", effect = "increased healing effects", skill = "Prelude of Harmony", balance = {balancetake = "play prelude"}, state = "down", needit = false, timer = createStopWatch()},
def_pyres = {defense = "", type = "normal", effect = "increased accuracy", skill = "Pyres of Armengar", balance = {balancetake = "play pyres"}, state = "down", needit = false, timer = createStopWatch()},
--Magician: Thaumaturgy
def_windweave = {defense = "windweave", type = "normal", effect = "Damage reduction", skill = "Windweave", balance = {balancetake="cast windweave"}, state = "down", needit = false, timer = createStopWatch()},
def_waterbreathing = {defense = "water breathing", type = "normal", effect = "Immune to drowning damage", skill = "Waterbreathing", balance = {needybalancetake = "cast waterbreathing"}, state = "down", needit = false, timer = createStopWatch()},
def_levitate = {defense = "levitate", type = "normal", effect = "Floating over water", skill = "Levitate", balance = {balancetake="cast levitate"}, state = "down", needit = false, timer = createStopWatch()},
def_fire_shield = {defense = "fire elemental shield", type = "normal", effect = "Resistant to Fire-based damage", skill = "Elemental Shield", balance = {needybalancetake= "cast elementshield fire"}, state = "down", needit = false, timer = createStopWatch()},
def_frost_shield = {defense = "frost elemental shield", type = "normal", effect = "Resistant to Frost-based damage", skill = "Elemental Shield", balance = {needybalancetake= "cast elementshield frost"}, state = "down", needit = false, timer = createStopWatch()},
def_arcane_shield = {defense = "arcane elemental shield", type = "normal", effect = "Resistant to Arcane-based damage", skill = "Elemental Shield", balance = {needybalancetake= "cast elementshield arcane"}, state = "down", needit = false, timer = createStopWatch()},
def_electric_shield = {defense = "electric elemental shield", type = "normal", effect = "Resistant to Electric-based damage", skill = "Elemental Shield", balance = {needybalancetake= "cast elementshield electric"}, state = "down", needit = false, timer = createStopWatch()},
def_stormfury = {defense = "stormfury", type = "normal", effect = "Building Stormfury charges", skill = "Stormfury", balance = {needyequilibriumtake="stormfury embrace"}, state = "down", needit = false, timer = createStopWatch()},
--Magician: Arcana
def_mirror_image = {defense = "mirror image", type = "normal", effect = "The next attack against you will miss", skill = "Mirror Image", balance = {balancetake="cast mirror image"}, state = "down", needit = false, timer = createStopWatch()},
def_spellshield = {defense = "golden spellshield", type = "important", effect = "Damage resistance and allows mana to absorb damage", skill = "Spellshield", balance = {balancetake="cast spellshield"}, state = "down", needit = false, timer = createStopWatch()},
def_invisibility = {defense = "invisibility", type = "important", effect = "Will not appear in LOOK/WHO HERE", skill = "Invisibility", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_arcane_power = {defense = "arcane power", type = "normal", effect = "Increases your maximum mana", skill = "Arcane Power", balance = {balancetake="cast arcane power"}, state = "down", needit = false, timer = createStopWatch()},
def_anachronize = {defense = "anachronize", type = "normal", effect = "All balance times are halved", skill = "Anachronize", balance = {needybalancetake="cast anachronize"}, state = "down", needit = false, timer = createStopWatch()},
--Magician: Demonology
def_witchsight = {defense = "witchsight", type = "normal", effect = "Increase vigilance checks, allows special demon-related commands", skill = "Witchsight", balance = {needybalancetake="witchsight"}, state = "down", needit = false, timer = createStopWatch()},
def_augury = {defense = "", type = "normal", effect = "A random stat is increased +10", skill = "Black Augury", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_soullink = {defense = "", type = "normal", effect = "Damage taken is split between you and your demon, damage resistance", skill = "Soul Link", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Magician: Psionics
def_psi_barrier = {defense = "mental barrier", type = "normal", effect = "psionic damage resistance", balance = {balanceneed = "psi barrier"}, state = "down", needit = false, timer = createStopWatch()},
def_thalamus = {defense = "amplified thalamus", type = "normal", effect = "stun cooldown reduction", balance = {balanceneed = "psi amplify thalamus"}, state = "down", needit = false, timer = createStopWatch()},
def_mesencephalon = {defense = "amplified mesencephalon", type = "normal", effect = "dexterity +5", balance = {balanceneed = "psi amplify mesencephalon"}, state = "down", needit = false, timer = createStopWatch()},
def_cerebellum = {defense = "amplified cerebellum", type = "normal", effect = "strength +5", balance = {balanceneed = "psi amplify cerebellum"}, state = "down", needit = false, timer = createStopWatch()},
def_meninges = {defense = "amplified meninges", type = "normal", effect = "willpower +5", balance = {balanceneed = "psi amplify meninges"}, state = "down", needit = false, timer = createStopWatch()},
def_hypothalamus = {defense = "amplified hypothalamus", type = "normal", effect = "burn level protection", balance = {balanceneed = "psi amplify hypothalamus"}, state = "down", needit = false, timer = createStopWatch()},
def_pons = {defense = "amplified pons", type = "normal", effect = "asphyxiation damage reduction", balance = {balanceneed = "psi amplify pons"}, state = "down", needit = false, timer = createStopWatch()},
def_medulla_oblongata = {defense = "amplified medulla oblongata", type = "normal", effect = "increased adrenaline gain", balance = {balanceneed = "psi amplify medulla"}, state = "down", needit = false, timer = createStopWatch()},
def_corpus_callosum = {defense = "amplified corpus callosum", type = "normal", effect = "intelligence +5", balance = {balanceneed = "psi amplify corpus"}, state = "down", needit = false, timer = createStopWatch()},
def_hippocampus = {defense = "amplified hippocampus", type = "normal", effect = "fear immunity", balance = {balanceneed = "psi amplify hippocampus"}, state = "down", needit = false, timer = createStopWatch()},
def_cerebral_cortex = {defense = "amplified cerebral cortex", type = "normal", effect = "drunken speech immunity", balance = {balanceneed = "psi amplify cortex"}, state = "down", needit = false, timer = createStopWatch()},
--Soldier: Arms
def_grip = {defense = "", type = "normal", effect = "One-time immunity to DISARM", skill = "Gripping", balance = {balanceneed = "grip"}, state = "down", needit = false, timer = createStopWatch()},
def_berserking = {defense = "", type = "normal", effect = "Increases damage delt and taken", skill = "Berserking", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_enrage = {defense = "", type = "normal", effect = "Passively regenerating adrenaline", skill = "Enrage", balance = {equilibriumtake = "rage"}, state = "down", needit = false, timer = createStopWatch()},
--Soldier: Warcraft
def_warcry = {defense = "call to war", type = "normal", effect = "Increased health regeneration", skill = "Call To War", balance = {needybalancetake="warcry"}, state = "down", needit = false, timer = createStopWatch()},
def_bloodthirst = {defense = "", type = "normal", effect = "Passively regenerating health", skill = "Bloodthirst", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_aggressive_stance = {defense = "", type = "normal", effect = "10% increased damage, 5% increased precision, taking 10% more damage", skill = "Aggressive Stance", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_defensive_stance = {defense = "", type = "normal", effect = "10% damage resistance, 10% less damage dealt	", skill = "Defensive Stance", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_lightning_stance = {defense = "", type = "normal", effect = "15% increased attack speed, 20% less damage dealt", skill = "Lightning Stance", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_stand_ground = {defense = "", type = "normal", effect = "Resisting forced movement", skill = "Stand Ground", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_tenacity = {defense = "focused tenacity", type = "normal", effect = "Immune to knockdown - may be stripped", skill = "Tenacity", balance = {needyequilibriumtake = "tenacity"}, state = "down", needit = false, timer = createStopWatch()},
def_shielding = {defense = "", type = "normal", effect = "Intercepting attacks against target", skill = "Shield of the Weak", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_immunity = {defense = "charged immune system", type = "normal", effect = "Enhanced resistance to poisons - may be stripped", skill = "Immunity", balance = {equilibriumtake = "immunity"}, state = "down", needit = false, timer = createStopWatch()},
def_last_stand = {defense = "last stand", type = "normal", effect = "Significant temporary damage resistance boost", skill = "Last Stand", balance = {needybalancetake = "stand true"}, state = "down", needit = false, timer = createStopWatch()},
--Soldier: Brutality
def_brutal_savagery = {defense = "", type = "normal", effect = "Passively regenerating adrenaline", skill = "Brutal Savagery", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Soldier: Swordmastery
def_greenburst = {defense = "", type = "normal", effect = "", skill = "Greenburst", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_phoenix_crouching = {defense = "", type = "normal", effect = "", skill = "Phoenix Crouching", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_serenity = {defense = "", type = "normal", effect = "Deflecting and reflecting ranged attacks", skill = "Serenity", balance = {balanceneed = "serenity"}, state = "down", needit = false, timer = createStopWatch()},
--Priest: Righteousness
--Priest: Faith
def_divine_armor = {defense = "divine armor", type = "normal", effect = "Increased damage resistance", skill = "Divine Armor", balance = {needyequilibriumtake = "pray for divine armor"}, state = "down", needit = false, timer = createStopWatch()},
def_revitalization = {defense = "", type = "normal", effect = "Healing-over-time", skill = "Revitalization", balance = {needybalancetake = "pray for revitalization"}, state = "down", needit = false, timer = createStopWatch()},
def_glorious_word = {defense = "glorious word", type = "normal", effect = "+10 Strength", skill = "Glorious Word", balance = {needybalancetake = "pray for glorious word"}, state = "down", needit = false, timer = createStopWatch()},
def_divine_mantle = {defense = "", type = "normal", effect = "Increase faith of non-priests in your presence", skill = "Divine Mantle", balance = {needybalancetake = "pray for divine mantle"}, state = "down", needit = false, timer = createStopWatch()},
def_refuge = {defense = "faithful refuge", type = "normal", effect = "Next attack against you will miss", skill = "Faithful Refuge", balance = {needyequilibriumtake = "pray for faithful refuge"}, state = "down", needit = false, timer = createStopWatch()},
def_radiant_word = {defense = "radiant word", type = "normal", effect = "+10 Dexterity", skill = "Radiant Word", balance = {needybalancetake = "pray for radiant word"}, state = "down", needit = false, timer = createStopWatch()},
def_crusader_mantle = {defense = "", type = "normal", effect = "Increase protection received from armor", skill = "Crusader Mantle", balance = {needybalancetake = "pray for crusader mantle"}, state = "down", needit = false, timer = createStopWatch()},
def_sanctification = {defense = "", type = "important", effect = "Protect your Mantle from assault", skill = "Sanctification", balance = {needybalancetake = "pray for sanctification"}, state = "down", needit = false, timer = createStopWatch()},
def_spiritshield = {defense = "", type = "normal", effect = "Dramatic increase in damage resistance", skill = "Spiritshield", balance = {needybalancetake = "pray for spiritshield"}, state = "down", needit = false, timer = createStopWatch()},
def_inspiring_mantle = {defense = "", type = "normal", effect = "Passively regenerates adrenaline", skill = "Inspiring Mantle", balance = {needybalancetake = "pray for inspiring mantle"}, state = "down", needit = false, timer = createStopWatch()},
def_harvest_boon = {defense = "", type = "normal", effect = "Increase experience gains for your party", skill = "Harvest Boon", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_illuminated_word = {defense = "illuminated word", type = "normal", effect = "+10 Intelligence", skill = "Illuminated Word", balance = {needybalancetake = "pray for illuminated word"}, state = "down", needit = false, timer = createStopWatch()},
def_blessed_mantle = {defense = "", type = "normal", effect = "Regenerates health over time", skill = "Blessed Mantle", balance = {needybalancetake = "pray for blessed mantle"}, state = "down", needit = false, timer = createStopWatch()},
def_righteous_word = {defense = "righteous word", type = "normal", effect = "+10 Willpower", skill = "Righteous Word", balance = {needybalancetake = "pray for righteous word"}, state = "down", needit = false, timer = createStopWatch()},
def_vengeful_mantle = {defense = "", type = "normal", effect = "Damages all enemies in your presence", skill = "Vengeful Mantle", balance = {needybalancetake = "pray for vengeful mantle"}, state = "down", needit = false, timer = createStopWatch()},
def_blessed_word = {defense = "blessed word", type = "normal", effect = "+10 Constitution", skill = "Blessed Word", balance = {needybalancetake="pray for blessed word"}, state = "down", needit = false, timer = createStopWatch()},
--Priest: Thanatology
def_deathsight = {defense = "deathsight", type = "normal", effect = "", skill = "Deathsight", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_spectral_vision = {defense = "", type = "normal", effect = "", skill = "Spectral Vision", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_deathwhisper = {defense = "aura of spectral whispers", type = "normal", effect = "", skill = "Deathwhisper", balance = {balancetake = "deathcall deathwhisper"}, state = "down", needit = false, timer = createStopWatch()},
def_pale_horse = {defense = "", type = "normal", effect = "", skill = "On a Pale Horse", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_ghostwalk = {defense = "", type = "normal", effect = "", skill = "Ghostwalk", balance = {}, state = "down", needit = false, timer = createStopWatch()},
def_deaths_door = {defense = "death's door", type = "normal", effect = "", skill = "Death's Door", balance = {balanceequilibriumtake = "deathcall death's door"}, state = "down", needit = false, timer = createStopWatch()},
--Priest: Pyromania
def_flameborne = {defense = "", type = "normal", effect = "", skill = "Flameborne", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Priest: Shadoweaving
--Priest: Bloodlore
def_bloody_mantle = {defense = "", type = "normal", effect = "", skill = "Bloody Mantle", balance = {}, state = "down", needit = false, timer = createStopWatch()},
--Priest: Crusading
def_conviction = {defense = "conviction", type = "normal", effect = "5% precision gain when defended", skill = "Conviction", balance = {needybalancetake = "warcall conviction"}, state = "down", needit = false, timer = createStopWatch()},
}

--give/take functions
function mtw.def_check()
 for i in pairs(mtw.defenses) do
  if mtw.defenses[i].state == "waiting" and getStopWatchTime(mtw.defenses[i].timer) > 2 then
   mtw.def_timeout(i)
  end
 end
end

function mtw.def_timeout(defense)
 mtw.defenses[defense].state = "down"
 cecho("<brown>\n[Resetting defense: "..defense.."!]")
 send(" ")
end

function mtw.def_gain(defense)
 if mtw.toggles.defendecho then
  deleteLine()
  cecho("<white>\nYou: <green>GAIN <white>"..defense)
 end
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 x = stopStopWatch(mtw.defenses[defense].timer)
-- resetStopWatch(mtw.defenses[defense].timer)
 mtw.def_have(defense)
 mtw.defenses[defense].timer = createStopWatch()
end

function mtw.def_have(defense)
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 mtw.defenses[defense].state = "deffed"
 for i in pairs(mtw.less_defs) do
  if mtw.less_defs[i] == defense then
   mtw.defenses[defense].needit = false
   table.remove(mtw.less_defs, i)
  end
 end
end

function mtw.def_def(defense)
 if mtw.toggles.defendecho then
  deleteLine()
  if mtw.defenses["def_"..defense].type == "endurance" then
   cecho("<red>\n"..defense)
  elseif mtw.defenses["def_"..defense].type == "important" then
   cecho("<blue>\n"..defense)
  else
   cecho("<green>\n"..defense)
  end
 end
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 if mtw.toggles.defeffect then
  echo(" "..mtw.defenses[defense].effect)
 end
 mtw.def_have(defense)
end

function mtw.def_take(defense)
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 if mtw.defenses[defense].state == "deffed" and mtw.toggles.defendecho then
  deleteLine()
  cecho("<white>\nYou: <red>LOSE <white>"..defense)
 end
 mtw.def_remove(defense)
end

function mtw.def_remove(defense)
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 mtw.defenses[defense].state = "down"
end

--loading defenses

function mtw.load_def(option)
 if mtw.def_options[option] ~= nil then
  cecho("<green>Loading defense options for: "..option)
  send(" ")
  mtw.less_defs = {}
  for i in pairs(mtw.defenses) do
   mtw.defenses[i].needit = false
   for h in pairs(mtw.def_options[option]) do
    if mtw.def_options[option][h] == "once" then
     if h == i and ( not mtw.defenses[h]["skill"] or table.contains(mtw.skills, mtw.defenses[h]["skill"]) ) then
      if mtw.defenses[i].state ~= "deffed" then
       mtw.defenses[i].needit = true
       table.insert(mtw.less_defs, i)
      end
     end
    elseif mtw.def_options[option][h] == "on" then
     if h == i and ( not mtw.defenses[h]["skill"] or table.contains(mtw.skills, mtw.defenses[h]["skill"]) ) then
     	--display(h)
      mtw.defenses[i].needit = true
     end
    end
   end
  end
 else
  cecho("<red>No such defense option as "..option.."!")
  send(" ")
 end
end

function mtw.tweak_def_option(option, defense, status)
 if not mtw.def_options[option] then
  mtw.def_options[option] = {}
 end
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 local opt = mtw.def_options[option]
 if status == "once" or status == "on" then
  opt[defense] = status
  cecho("\n<white>Added defense <red>"..defense.."<white> ("..status..") from defense option <green>"..option)
 end
 if status == "off" then
  opt[defense] = "off"
  cecho("\n<white>Removed defense <red>"..defense.."<white> from defense option <green>"..option)
 end
 mtw.def_options[option] = opt
end

function mtw.show_def_option(option)
 cecho("\nContents of the defense option <green>"..option)
 for k,v in pairs(mtw.def_options[option]) do
  local def = k
  if mtw.defenses[k].effect ~= "" then
   def = def .." - " .. mtw.defenses[k].effect
  end
  if v ~= "off" then
   cecho("\n "..def.." - "..v)
  end
 end
end

--presets, they can be altered in game with 'chd preset defense on/off/once'

mtw_struct.set_metatable_custom("def_options")

mtw.default.def_options = {

none = {
},

newb = {
def_rose = "on",
--def_thirdeye = "once",
def_skywatch = "once",
def_deathsense = "once",
},

basic = {
def_rose = "on",
def_thirdeye = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
},

soldier = {
def_rose = "on",
def_thirdeye = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
def_grip = "on",
def_enrage = "on",
def_warcry = "on",
def_tenacity = "on",
def_immunity = "once"
},

swordmaster = {
def_rose = "on",
def_thirdeye = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
--def_premonition = "once",
def_hourglass = "once",
def_selfishness = "on",
def_grip = "on",
def_enrage = "on",
def_warcry = "on",
def_tenacity = "on",
def_immunity = "once",
def_serenity = "once",
def_censer = "once",
def_arrow = "once",
},

rogue = {
def_rose = "on",
def_thirdeye = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
def_hiding = "once",
},

thief = {
def_rose = "on",
def_thirdeye = "once",
def_hourglass = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
def_hiding = "once",
def_arrowsense = "once"
},

priest = {
def_rose = "on",
def_thirdeye = "once",
def_hourglass = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
def_divine_armor = "once",
def_refuge = "once",
def_glorious_word = "once",
def_radiant_word = "once",
def_illuminated_word = "once",
def_righteous_word = "once",
def_blessed_word = "once",
def_inspiring_mantle = "once",
def_sanctification = "once",
--def_conviction = "on",
},

mage = {
def_rose = "on",
def_thirdeye = "once",
def_hourglass = "once",
def_skywatch = "once",
def_deathsense = "once",
def_nightvision = "once",
def_insomnia = "on",
def_forboding = "once",
def_premonition = "once",
def_selfishness = "on",
def_spellshield = "on",
def_arcane_power = "on",
def_windweave = "on",
def_levitate = "once",
def_waterbreathing = "once",
def_arcane_shield = "once",
def_mirror_image = "once"
}

}