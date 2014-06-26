-- MTW: queuing functions

--priorities
mtw.queue = {}

mtw.priorities = {
"def_immunity",
"def_spellshield",
"aff_divine_censure",
"def_last_stand",
"aff_prone",
"aff_blackout",
--Entanglement
"aff_grab",
"aff_impale",
"aff_earthbind",
"aff_hostage",
"aff_hogtie",
"aff_oubliette",
"aff_lurker",
"aff_feed",
"aff_restrained",
--Balance
"aff_balance_loss",
"aff_equilibrium_loss",
--Afflictions

--====Key Affs and Insta-Leads====--
"aff_concussion",
"aff_malaise",
"aff_epilepsy",
"aff_horror",
"aff_astral_warp",
"aff_indiscriminate_trust",
"aff_mindmeld",
"aff_impatience",
"aff_burst_organs",
"aff_broken_left_arm",
"aff_fear",
"aff_broken_right_arm",
"aff_dystrophy",
"aff_recklessness",
"aff_compulsion",
"aff_lust",
"aff_paranoia",

--====Bleeding====--
"aff_hemophilia",
"aff_bleeding_5",
"aff_bleeding_4",
"aff_bleeding_3",
"aff_bleeding_2",
"aff_bleeding_1",

--====High Priority (T1)====--
"aff_heretic",
"aff_atoning",
"aff_retribution",
"aff_unstable",
"aff_sensitivity",
"aff_burning_left_arm",
"aff_burning_left_leg",
"aff_burning_right_arm",
"aff_burning_right_leg",
"aff_on_fire",
"aff_depression",
"aff_tainted_aura",
"aff_burns_4",
"aff_burns_3",
"aff_neural_charges",
"aff_health_10",
"aff_magic_10",

--====Defense Disablers and Severe Hinders====--
"aff_blind",
"aff_paralysis",
"aff_chilled_3",
"aff_stupidity",
"aff_chilled_2",
"aff_chilled_1",
"aff_crippled",
"aff_hypersomnia",
"aff_battered",
"aff_brain_damage_5",
"aff_brain_damage_4",
"aff_weariness",
"aff_befuddle_5",
"aff_befuddle_4",
"aff_wither_5",
"aff_wither_4",
"aff_infirmity_5",
"aff_infirmity_4",
"aff_dizziness_2",
"aff_dizziness_1",
"aff_terror",
"aff_cataplexy",
"aff_dystonia",
"aff_maladroitness",
"aff_ataxia",
"aff_anemia",
"aff_hypochondria",

--====High Priority (T2)====--
"aff_magic_35",
"aff_health_35",
"aff_burns_2",
"aff_burns_1",
"aff_severed_nerves_5",
"aff_befuddle_3",
"aff_befuddle_2",
"aff_befuddle_1",
"aff_wither_3",
"aff_wither_2",
"aff_wither_1",
"aff_brain_damage_3",
"aff_broken_right_leg",
"aff_broken_left_leg",
"aff_brain_damage_2",
"aff_heart_palpitations",

--====High Priority (T3)====--
"aff_health_55",
"aff_magic_55",
"aff_faithrot",
"aff_brain_damage_1",
"aff_infirmity_3",
"aff_ill_omen_5",
"aff_ill_omen_4",
"aff_ill_omen_3",
"aff_ill_omen_2",
"aff_ill_omen_1",
"aff_hamstrung",
"aff_vomiting",
"aff_infirmity_2",
"aff_infirmity_1",
"aff_blurry_sight",
"aff_disoriented",
"aff_claustrophobia",
"aff_agoraphobia",
"aff_severed_nerves_4",
"aff_collapsed_lungs",
"aff_severed_nerves_3",

--====Medium Priority====--
"aff_black_lung",
"aff_psychic_feedback",
"aff_headache",
"aff_repenting_3",
"aff_severed_nerves_2",
"aff_repenting_2",
"aff_severed_nerves_1",
"aff_exhaustion",
"aff_repenting_1",
"aff_astral_tether",
"aff_cut_tendon_3",
"aff_dementia_3",
"aff_cut_tendon_2",
"aff_cut_tendon_1",
"aff_confusion",
"aff_clumsiness",
--"aff_commanded",
"aff_sun_allergy",
"aff_health_75",
"aff_magic_75",

--====Low Priority====--
"aff_dementia_2",
"aff_asthma",
"aff_weak_legs",
"aff_somnolence",
"aff_sundered_armor",
"aff_repenting_3",
"aff_holy_shock",
"aff_arcane_fire_3",
"atk_slit_throat",
"aff_dementia_1",
"aff_arcane_fire_2",
"aff_arcane_fire_1",
"aff_repenting_2",
"aff_severed_tendons",
"aff_deaf",

"def_myrrh",
--Vigilance
"def_notice",
"def_skywatch",
"def_deathsense",
"def_awareness",
"def_nightvision",
"def_insomnia",
"def_forboding",
"def_premonition",
"def_vanish",
--Fighting
"def_selfishness",
"def_combat_focus",
"def_perfect_defense",
--Tattoos
"def_lantern",
"def_sun",
"def_censer",
"def_moon",
"def_thirdeye",
"def_shield",
"def_arrow",
"def_glacier",
"def_star",
"def_dragon",
"def_skull",
"def_lotus",
"def_hourglass",
"def_compass",
"def_rose",
"def_owl",
"def_wheel",
"def_tree",
--Rogue: Fencing
"def_krondorian_stance",
"def_bastyran_stance",
"def_roldemish_stance",
--Rogue: Subtlety
"def_hiding",
"def_stalking",
"def_eavesdrop",
"def_deathmask",
"def_ambush",
"def_infiltrate",
"def_deepshroud",
--Rogue: Thievery
"def_arrowsense",
"def_shadowmend",
"def_shadowstep",
--Magician: Thaumaturgy
"def_windweave",
"def_waterbreathing",
"def_levitate",
"def_fire_shield",
"def_frost_shield",
"def_arcane_shield",
"def_electric_shield",
"def_stormfury",
--Magician: Arcana
"def_mirror_image",
"def_invisibility",
"def_arcane_power",
"def_anachronize",
"def_witchsight",
"def_augury",
"def_soullink",
--Magician: Psionics
--Soldier: Arms
"def_grip",
"def_berserking",
"def_enrage",
--Soldier: Warcraft
"def_warcry",
"def_bloodthirst",
"def_aggressive_stance",
"def_defensive_stance",
"def_lightning_stance",
"def_stand_ground",
"def_tenacity",
"def_shielding",
"def_immunity",
"def_last_stand",
--Soldier: Brutality
"def_brutal_savagery",
--Soldier: Swordmastery
"def_serenity",
--Priest: Righteousness
--Priest: Faith
"def_divine_armor",
"def_revitalization",
"def_glorious_word",
"def_divine_mantle",
"def_refuge",
"def_radiant_word",
"def_crusader_mantle",
"def_spiritshield",
"def_inspiring_mantle",
"def_harvest_boon",
"def_illuminated_word",
"def_blessed_mantle",
"def_righteous_word",
"def_vengeful_mantle",
"def_blessed_word",
--Priest: Thanatology
"def_deathsight",
"def_spectral_vision",
"def_deathwhisper",
"def_pale_horse",
"def_ghostwalk",
"def_deaths_door",
--Priest: Pyromania
"def_flameborne",
--Priest: Shadoweaving
--Priest: Bloodlore
"def_bloody_mantle",
--Priest: Crusading
"def_conviction",

"def_sanctification",


--Fighting
"atk_trip",
"atk_sever",
"atk_decapitate",
--Soldier: Arms
"atk_slash",
"atk_club",
"atk_obliterate",
"atk_threaten",
"atk_wildstrike",
"atk_sunder_armor",
"atk_grab",
"atk_evict",
"atk_heartstrike",
"atk_throwdown",
"atk_cleave",
"atk_headslam",
"atk_counter",
"atk_shield_smash",
"atk_mutilating_hack",
"atk_impale",
"atk_bind",
"atk_batter",
"atk_assault",
"atk_rupture",
"atk_rend",
"atk_enervating_jab",
"atk_enfeeble",
"atk_terminate",
--Soldier: Warcraft
"atk_intercept",
"atk_surging_smash",
"atk_desperate_strike",
"atk_charge",
--Soldier: Brutality
"atk_rake",
"atk_roar_maddening",
"atk_gutsmash",
"atk_blackeye",
"atk_slit_throat",
"atk_legslice",
"atk_nerve_strike",
"atk_crunch_arms",
"atk_roar_mighty",
"atk_headsmash",
"atk_shatter_left_leg",
"atk_shatter_right_leg",
"atk_shatter_left_arm",
"atk_shatter_right_arm",
"atk_knockdown",
"atk_earbash",
"atk_burst_lungs",
"atk_crush_skull",
"atk_roar_deafening",
"atk_brainbash",
"atk_chestbash",
"atk_roar_terrifying",
"atk_stomp",
"atk_pulverize",
"atk_burst_organs",
"atk_roar_dreadful",
--Soldier: Swordmastery
"atk_starfury",
"atk_wisplight",
"atk_hummingbird",
"atk_icehowl",
"atk_spinkick",
"atk_spinkick_slash",
"atk_lunarburst",
"atk_windsong",
"atk_thunderburst",
"atk_rainfall_arc",
"atk_leaf_breeze",
"atk_mooncrescent",
"atk_whirlwind",
"atk_sunburst",
"atk_cutting_clouds",
"atk_thornrose",
"atk_phoenix_unfurls",
"atk_eclipse_over_water",
--Rogue: Fencing
"atk_thrust",
"atk_fleche",
"atk_hamstring",
"atk_puncture",
"atk_wristflick",
"atk_lowblow",
"atk_backslice",
"atk_hemorrhage",
"atk_beat",
"atk_pommel",
"atk_balestra",
"atk_beguile",
"atk_flourish",
"atk_disarm",
"atk_press",
"atk_glint",
"atk_inquartata",
"atk_backhand",
--"atk_coup_de_grace",
--Rogue: Subtlety
"atk_backstab",
"atk_slit_throat",
"atk_crossbow",
--Rogue: Thievery
"atk_vileblade",
--"atk_slitthroat",
"atk_cheap_shot",
"atk_lungstab",
--"atk_death_from_above",
--"atk_shiv",
"atk_sucker_punch",
--Rogue: Performance
"atk_canto",
"atk_requiem",
--Magician: Thaumaturgy
"atk_stormlance",
"atk_ignite",
"atk_chill",
"atk_earthbind",
"atk_icespikes",
"atk_earthquake",
"atk_static_discharge",
"atk_gale",
"atk_skylash",
"atk_pyroclasm",
"atk_shatter",
"atk_tomb",
"atk_immolate",
--Magician: Arcana
"atk_sleep",
"atk_dementia",
"atk_counterspell",
"atk_instability",
"atk_cripple",
"atk_barrage",
"atk_disorient",
"atk_timeshift",
"atk_compulsion",
"atk_timequake",
"atk_astral_tether",
"atk_teleport",
"atk_astral_warp",
"atk_undoing",
--Magician: Demonology
"atk_scabies",
"atk_howl_of_terror",
"atk_curse_of_tongues",
"atk_seduce",
"atk_necrotic_plague",
"atk_torture",
--Magician: Psionics
--Priest: Righteousness
"atk_fury",
"atk_mandate",
"atk_heretic",
"atk_kneel",
"atk_atonement",
"atk_spirit_wrack",
"atk_holy_fire",
"atk_convocation",
"atk_wrathful_thunder",
"atk_avenging_flame",
"atk_divine_command",
"atk_retribution",
"atk_righteous_lance",
"atk_searing_arc",
"atk_vindication",
"atk_indolent_penance",
"atk_holy_sword",
"atk_ill_omen",
"atk_divine_censure",
"atk_repentance",
"atk_damnation",
"atk_reckoning",
"atk_judgment",
"atk_sword_spirit",
"atk_verdict",
--Priest: Faith
"atk_martyr",
--Priest: Thanatology
"atk_terror",
"atk_soulspear",
"atk_burden_soul",
"atk_withering_touch",
"atk_exorcism",
"atk_gravechill",
"atk_despair",
"atk_funeral_mass",
"atk_vision_of_death",
"atk_icy_grasp",
"atk_entropy",
"atk_doom",
--Priest: Pyromania
"atk_pimmolate",
--"atk_illuminate",
"atk_bloodboil",
"atk_melt",
"atk_incinerate",
"atk_burning_embers",
"atk_embers",
--Priest: Shadoweaving
"atk_torturous_whip",
--"atk_shadow_theft",
"atk_grotesque_visage",
"atk_deceit",
"atk_horrify",
"atk_shadowlance",
"atk_scarab_curse",
"atk_shadowstorm",
"atk_oubliette",
--Priest: Bloodlore
"atk_savage",
"atk_phlegm",
"atk_mutilate",
"atk_heart_thrum",
"atk_lunar_bay",
"atk_gluttonous_lust",
"atk_sanguis",
"atk_feral_rake",
"atk_rending_strike",
"atk_yellow_bile",
"atk_sanguishift",
--"atk_knife_of_woe",
"atk_carnal_scream",
"atk_black_bile",
"atk_betrayal_of_blood",
"atk_forbidden_revel",
--Priest: Crusading
"atk_bold_smite",
"atk_faithburn",
"atk_crushing_smite",
"atk_dominating_strike",
"atk_virtuous_smite",
"atk_revelation",
}
--do stuff

function mtw.do_queue()
 mtw.queue = {}
 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].state ~= "healed" then
   table.insert(mtw.queue, i)
  end
 end
 for k in pairs(mtw.defenses) do
  if mtw.defenses[k].state == "down" and mtw.defenses[k].needit then
   table.insert(mtw.queue, k)
  end
 end
 for z in pairs(mtw.attacks) do
  if mtw.attacks[z].defend_now then
   table.insert(mtw.queue, z)
  end
 end
-- if #mtw.queue >= 1 then
--  display(mtw.queue)
-- end
end

function mtw.do_stuff()
 for _,i in ipairs(mtw.priorities) do
  if table.contains(mtw.queue, i) then
   for _,z in pairs(mtw.method_priority) do
    if mtw.afflictions[i] ~= nil then
     if mtw.afflictions[i].cures[z.balance] ~= nil then
      z.func(i)
     end
    elseif mtw.defenses[i] ~= nil then
     if mtw.defenses[i].balance[z.balance] ~= nil then
      z.func(i)
     end
    elseif mtw.attacks[i] ~= nil then
     if z.balance == "defend" then
      z.func(i)
     end
    end
   end
  end
 end
end

--sending commands function

function mtw.send(command)
--echo(last_type)
--echo(last_item)
--display(last)
 if mtw.have_slow() then
  if mtw.slow_command == "" then
   if mtw.last_type ~= "none" then
    mtw.last[mtw.last_type] = mtw.last_item
    mtw.last_type = "none"
    mtw.last_item = "none"
   end
   mtw.slow_command = command
  end
 else
  if mtw.last_type ~= "none" then
   mtw.last[mtw.last_type] = mtw.last_item
   mtw.last_type = "none"
   mtw.last_item = "none"
  end
  send(command, mtw.toggles.debug)
 end
end

--handle balance

function mtw.set_balance(my_balance)
 mtw.next.balance = my_balance
 if mtw.next.balance == "flee" or string.find(mtw.next.balance, "teleport") then
  mtw.fleeing = true
 end
 mtw.do_core()
 if mtw.next.balance ~= "none" then
  cecho("<brown>You: QUEUE "..mtw.next.balance.."!")
  send(" ")
 end
end

function mtw.do_balance()
 if mtw.toggles.killing and (mtw.next.balance ~= "none") and mtw.not_aff("prone") and mtw.not_entangled() then
  if mtw.balance.balance and not mtw.waiting.balance then
   mtw.send(mtw.next.balance)
   if string.find(mtw.next.balance, "cast rift") or string.find(mtw.next.balance, "demoncall gate") then
    mtw.waiting.overdrive = true
    tempTimer(mtw.delay(), [[mtw.waiting.overdrive = false]])
    mtw.prechanneling.rifting = true
    tempTimer(mtw.delay(), [[mtw.prechanneling.rifting = false]])
   end
   mtw.waiting.balance = true
   tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
   if not mtw.toggles.looping then
    mtw.next.balance = "none"
   end
  end
 end
end

function mtw.set_equil(my_equil)
 mtw.next.equil = my_equil
 if mtw.balance.equilibrium and mtw.not_aff("prone") then
  mtw.send(mtw.next.equil)
  mtw.waiting.equilibrium = true
  tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
  mtw.next.equil = "none"
 else
  cecho("<brown>You: QUEUE "..mtw.next.equil.."!")
  send(" ")
 end
end

function mtw.do_equil()
 if mtw.toggles.killing and (mtw.next.equil ~= "none") and mtw.not_aff("prone") then
  if mtw.balance.equilibrium then
   mtw.send(mtw.next.equil)
   mtw.waiting.equilibrium = true
   tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
   mtw.next.equil = "none"
  end
 end
end

function mtw.set_psi(my_psi)
 mtw.next.psi = my_psi
 if mtw.balance.psi and not mtw.waiting.psi and mtw.not_aff("brain_damage_1") and mtw.not_aff("brain_damage_2") and mtw.not_aff("brain_damage_3") and mtw.not_aff("brain_damage_4") and mtw.not_aff("brain_damage_5") then
  mtw.send(mtw.next.psi)
  mtw.waiting.psi = true
  tempTimer(mtw.delay(), [[mtw.waiting.psi = false]])
  mtw.next.psi = "none"
 else
  cecho("<purple>You: QUEUE "..mtw.next.psi.."!")
  send(" ")
 end
end

function mtw.do_psi()
 if mtw.toggles.killing and (mtw.next.psi ~= "none") and mtw.not_aff("brain_damage_1") and mtw.not_aff("brain_damage_2") and mtw.not_aff("brain_damage_3") and mtw.not_aff("brain_damage_4") and mtw.not_aff("brain_damage_5") then
  if mtw.balance.psi and not mtw.waiting.psi then
   mtw.send(mtw.next.psi)
   mtw.waiting.psi = true
   tempTimer(mtw.delay(), [[mtw.waiting.psi = false]])
   mtw.next.psi = "none"
  end
 end
end

function mtw.set_offhand(my_offhand)
 mtw.next.offhand = my_offhand
 if mtw.balance.offhand and not mtw.waiting.offhand and mtw.not_aff("prone") then
  mtw.send(mtw.next.offhand)
  mtw.waiting.offhand = true
  tempTimer(mtw.delay(), [[mtw.waiting.offhand = false]])
  mtw.next.offhand = "none"
 else
  cecho("<purple>You: QUEUE "..mtw.next.offhand.."!")
  send(" ")
 end
end

function mtw.do_offhand()
 if mtw.toggles.killing and (mtw.next.offhand ~= "none") and mtw.not_aff("prone") then
  if mtw.balance.offhand and not mtw.waiting.offhand then
   mtw.send(mtw.next.offhand)
   mtw.waiting.offhand = true
   tempTimer(mtw.delay(), [[mtw.waiting.offhand = false]])
   mtw.next.offhand = "none"
  end
 end
end

function mtw.queue_diag()
 if mtw.balance.equilibrium and not mtw.waiting.equilibrium and mtw.am_functional() then
  mtw.send_diag()
 else
  mtw.need_diag = true
  cecho("<brown>You: QUEUE diagnose!")
  send(" ")
 end
end
function mtw.do_diag()
 if mtw.need_diag then
  mtw.send_diag()
 end
end
function mtw.send_diag()
 if mtw.balance.equilibrium and not mtw.waiting.equilibrium then
  mtw.send("diag")
  mtw.did_diag = true
  mtw.waiting.equilibrium = true
  tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
  tempTimer(2, [[mtw.did_diag = false]])
 end
end


mtw.method_priority = {
{balance = "special", func = function(current) mtw.do_special(current) end},
{balance = "balanceneed", func = function(current) mtw.do_balance_need(current) end},
{balance = "equilibriumneed", func = function(current) mtw.do_equilibrium_need(current) end},
{balance = "balanceequilibrium", func = function(current) mtw.do_balance_equilibrium_need(current) end},
{balance = "recover", func = function(current) mtw.do_recover(current) end},
{balance = "focus", func = function(current) mtw.do_focus(current) end},
{balance = "reject", func = function(current) mtw.do_reject(current) end},
{balance = "overdrive", func = function(current) mtw.do_overdrive(current) end},
{balance = "stand", func = function(current) mtw.do_stand(current) end},
{balance = "writhe", func = function(current) mtw.do_writhe(current) end},
{balance = "clot", func = function(current) mtw.do_clot(current) end},
{balance = "defend", func = function(current) mtw.do_def(current) end},
{balance = "balancetake", func = function(current) mtw.do_balance_take(current) end},
{balance = "equilibriumtake", func = function(current) mtw.do_equilibrium_take(current) end},
{balance = "needybalancetake", func = function(current) mtw.do_needy_balance_take(current) end},
{balance = "needyequilibriumtake", func = function(current) mtw.do_needy_equilibrium_take(current) end},
{balance = "balanceequilibriumtake", func = function(current) mtw.do_balance_equilibrium_take(current) end}
}

--handle timewarp


function mtw.slow_queue()
 if mtw.toggles.healing and mtw.am_functional() then
  if mtw.have_aff("sleep") and mtw.toggles.standing and (not mtw.status.waking) and (not mtw.waiting.wake) then
   echo("(wake)")
   mtw.send("wake")
   mtw.waiting.wake = true
   tempTimer(mtw.delay(), [[mtw.waiting.wake = false]] )
  end
  if mtw.not_aff("sleep") then
   if mtw.need_wield and mtw.balance.balance and mtw.balance.equilibrium then
    mtw.send("wield "..mtw.my.weapon.." right")
   end
   if mtw.need_loot then
    mtw.do_loot()
   end
   mtw.do_diag()
--   mtw.do_balance()
--   mtw.do_equil()
   mtw.do_queue()
   mtw.do_stuff()
  end
 end
end


function mtw.do_slow()
 if mtw.next.balance ~= "none" and mtw.balance.balance and not mtw.waiting.balance and mtw.not_aff("prone") then
  mtw.do_balance()
 elseif mtw.next.psi ~= "none" and mtw.balance.psi and not mtw.waiting.psi and mtw.not_aff("brain_damage_1") and mtw.not_aff("brain_damage_2") and mtw.not_aff("brain_damage_3") and mtw.not_aff("brain_damage_4") and mtw.not_aff("brain_damage_5") then
  mtw.do_psi()
 elseif mtw.next.equil ~= "none" and mtw.balance.equilibrium and not mtw.waiting.equilibrium and mtw.not_aff("prone") then
  mtw.do_equil()
 else
  mtw.slow_queue()
 end
 if mtw.slow_command ~= "" and not mtw.waiting.slow and not mtw.waiting.sent then
  send(mtw.slow_command, mtw.toggles.debug)
  mtw.slow_command = ""
  mtw.waiting.sent = true
  tempTimer(1, [[mtw.waiting.sent = false]])
 end 
end

