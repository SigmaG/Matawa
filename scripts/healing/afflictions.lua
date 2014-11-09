-- MTW: afflictions handling

-- table of afflictions
mtw.afflictions = {
--Low vitals
aff_health_75 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_health_55 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_health_35 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_health_10 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_magic_75 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_magic_55 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_magic_35 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
aff_magic_10 = {state = "healed", cures = {overdrive = "send"}, assess = false, timer = createStopWatch()},
--Misc
aff_sleep = {state = "healed", msg = "", cures = {}, assess = false, effect = "can't do anything", timer = createStopWatch()},
aff_stun = {state = "healed", msg = "stunned", cures = {}, assess = false, effect = "can't do anything", timer = createStopWatch()},
aff_tomb = {state = "healed", msg = "", cures = {}, assess = false, effect = "can't do anything", timer = createStopWatch()},
aff_unconscious = {state = "healed", msg = "", cures = {}, assess = false, effect = "can't do anything", timer = createStopWatch()},
aff_prone = {state = "healed", msg = "prone", cures = {stand = "send"}, assess = false, effect = "can't move/attack/defend", timer = createStopWatch()},

aff_timewarp = {state = "healed", cures = {}, assess = false, effect = "delay between commands", timer = createStopWatch()},
aff_bolero = {state = "healed", cures = {}, assess = false, effect = "can't clot", timer = createStopWatch()},
aff_blood_omen = {state = "healed", msg = "suffused with a blood omen", cures = {}, assess = false, effect = "can't heal ill omen", timer = createStopWatch()},
aff_blood_betrayal = {state = "healed", msg = "betrayed by your writhing blood", cures = {}, assess = false, effect = "OD heals nothing", timer = createStopWatch()},
aff_illuminated = {state = "healed", msg = "illuminated by glowing phosphorescence", cures = {}, assess = false, effect = "can't hide or deepshroud", timer = createStopWatch()},

aff_balance_loss = {state = "healed", msg = "knocked permanently off-balance", cures = {recover = "balance"}, assess = false, effect = "can't regain balance", timer = createStopWatch()},
aff_equilibrium_loss = {state = "healed", msg = "knocked permanently off-equilibrium", cures = {recover = "equilibrium"}, assess = false, effect = "can't regain equilibrium", timer = createStopWatch()},

aff_commanded = {state = "healed", msg = "awestruck by (.*)", cures = {reject = "priest"}, assess = false, effect = "forced to do a single action", timer = createStopWatch()},
aff_mindmeld = {state = "healed", msg = "mind melded by (.*)", cures = {reject = "psion"}, assess = false, effect = "can't cure tethered, psi becomes ranged", timer = createStopWatch()},
aff_lust = {state = "healed", cures = {reject = "lust"}, assess = false, effect = "", timer = createStopWatch()},
aff_threaten = {state = "healed", msg = "threatened", cures = {}, asses = false, effect = "accuracy malus vs all but threatener", timer = createStopWatch()},

--Bleeding
aff_bleeding_1 = {state = "healed", msg = "bleeding lightly from open wounds", cures = {clot = "send"}, assess = false, effect = "damage over time", timer = createStopWatch()},
aff_bleeding_2 = {state = "healed", msg = "bleeding from open wounds", cures = {clot = "send"}, assess = false, effect = "damage over time", timer = createStopWatch()},
aff_bleeding_3 = {state = "healed", msg = "bleeding heavily from open wounds", cures = {clot = "send"}, assess = false, effect = "damage over time", timer = createStopWatch()},
aff_bleeding_4 = {state = "healed", msg = "bleeding profusely from open wounds", cures = {clot = "send"}, assess = false, effect = "damage over time", timer = createStopWatch()},
aff_bleeding_5 = {state = "healed", msg = "gushing blood from open wounds", cures = {clot = "send"}, assess = false, effect = "damage over time", timer = createStopWatch()},

--Entanglement
aff_grab = {state = "healed", msg = "grabbed", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_impale = {state = "healed", msg = "impaled", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_earthbind = {state = "healed", msg = "earthbound by grasping claws of stone", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_hostage = {state = "healed", msg = "being held hostage", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_hogtie = {state = "healed", msg = "", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_oubliette = {state = "healed",  msg = "imprisoned in a horrifying oubliette",cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_lurker = {state = "healed", msg = "covered in sticky webbing", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_feed = {state = "healed", msg = "being fed on by a vampire", cures = {writhe = "send"}, assess = false, effect = "can't od, attacks slowed", timer = createStopWatch()},
aff_restrained = {state = "healed", msg = "restrained", cures = {writhe = "send"}, assess = false, effect = "entangled", timer = createStopWatch()},

--Physical
aff_anemia = {state = "healed", msg = "anemic", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_asthma = {state = "healed", msg = "asthmatic", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_ataxia = {state = "healed", msg = "suffering from ataxia", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_battered = {state = "healed", msg = "suffering from battered weapons", cures = {focus = "body"}, assess = false, effect = "can't defend", timer = createStopWatch()},
aff_black_lung = {state = "healed", msg = "coughing up disgusting black phlegm", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_blind = {state = "healed", msg = "blind", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_broken_left_arm = {state = "healed", msg = "hindered by a broken left arm", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_broken_left_leg = {state = "healed", msg = "hindered by a broken left leg", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_broken_right_arm = {state = "healed", msg = "hindered by a broken right arm", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_broken_right_leg = {state = "healed", msg = "hindered by a broken right leg", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burning_left_arm = {state = "healed", msg = "roasting with a burning left arm", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()}, 
aff_burning_left_leg = {state = "healed", msg = "roasting with a burning left leg", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()}, 
aff_burning_right_arm = {state = "healed", msg = "roasting with a burning right arm", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burning_right_leg = {state = "healed", msg = "roasting with a burning right leg", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()}, 
aff_burns_1 = {state = "healed", msg = "suffering from first degree burns", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burns_2 = {state = "healed", msg = "suffering from second degree burns", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burns_3 = {state = "healed", msg = "suffering from third degree burns", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burns_4 = {state = "healed", msg = "suffering from fourth degree burns", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burnt_tongue = {state = "healed", msg = "unable to speak, due to a burnt tongue", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_burst_organs = {state = "healed", msg = "bleeding to death from burst organs", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_chilled_1 = {state = "healed", msg = "chilled", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_chilled_2 = {state = "healed", msg = "deeply chilled", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_chilled_3 = {state = "healed", msg = "chilled to the bone", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_collapsed_lungs  = {state = "healed", msg = "suffering from collapsed lungs", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_concussion = {state = "healed", msg = "suffering from a concussion", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_cut_tendon_1 = {state = "healed", msg = "suffering from a cut tendon", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_cut_tendon_2 = {state = "healed", msg = "suffering from 2 cut tendons", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_cut_tendon_3 = {state = "healed", msg = "suffering from 3 cut tendons", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_deaf = {state = "healed", msg = "deaf", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_dystrophy = {state = "healed", msg = "suffering from muscular dystrophy", cures = {focus = "body"}, assess = false, effect = "can't writhe/contort", timer = createStopWatch()},
aff_exhaustion = {state = "healed", msg = "physically exhausted", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_hamstrung  = {state = "healed", msg = "hamstrung", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_heart_palpitations = {state = "healed", msg = "afflicted with heart palpitations", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_on_fire  = {state = "healed", msg = "on fire", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_paralysis  = {state = "healed", msg = "paralyzed", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_plague = {state = "healed", msg = "infected with a necrotic plague", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_scabies  = {state = "healed", msg = "infested with scabies", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_nerves_1 = {state = "healed", msg = "suffering from a severed nerve", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_nerves_2 = {state = "healed", msg = "suffering from 2 severed nerves", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_nerves_3 = {state = "healed", msg = "suffering from 3 severed nerves", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_nerves_4 = {state = "healed", msg = "suffering from 4 severed nerves", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_nerves_5 = {state = "healed", msg = "suffering from 5 severed nerves", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_severed_tendons = {state = "healed", msg = "suffering from severed tendons", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_slit_throat  = {state = "healed", msg = "suffering from a slit throat", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_vomiting = {state = "healed", msg = "sick to your stomach", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_weak_legs  = {state = "healed", msg = "suffering from weak legs", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_wither_1 = {state = "healed", msg = "withered", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_wither_2 = {state = "healed", msg = "deeply withered", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_wither_3 = {state = "healed", msg = "greatly withered", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_wither_4 = {state = "healed", msg = "extraordinarily withered", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},
aff_wither_5 = {state = "healed", msg = "cripplingly withered", cures = {focus = "body"}, assess = false, effect = "", timer = createStopWatch()},

--Mental
aff_agoraphobia = {state = "healed", msg = "afraid of open spaces", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_amnesia = {state = "healed", msg = "suffering from amnesia", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_anorexia = {state = "healed", msg = "anorexic", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_aphasia = {state = "healed", msg = "debilitated by aphasia", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_befuddle_1 = {state = "healed", msg = "befuddled", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_befuddle_2 = {state = "healed", msg = "quite befuddled", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_befuddle_3 = {state = "healed", msg = "very befuddled", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_befuddle_4 = {state = "healed", msg = "extraordinarily befuddled", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_befuddle_5 = {state = "healed", msg = "cripplingly befuddled", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_blackout = {state = "healed", msg = "blacked out", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_blurry_sight = {state = "healed", msg = "suffering from blurred sight", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_brain_damage_1 = {state = "healed", msg = "suffering from light brain damage", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_brain_damage_2 = {state = "healed", msg = "suffering from moderate brain damage", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_brain_damage_3 = {state = "healed", msg = "suffering from heavy brain damage", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_brain_damage_4 = {state = "healed", msg = "suffering from severe brain damage", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_brain_damage_5 = {state = "healed", msg = "suffering from critical brain damage", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_cataplexy = {state = "healed", msg = "suffering from cataplexy", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_claustrophobia = {state = "healed", msg = "afraid of enclosed spaces", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_clumsiness = {state = "healed", msg = "clumsy", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_confusion = {state = "healed", msg = "lost in a cloud of confusion", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_dementia_1 = {state = "healed", msg = "demented", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_dementia_2 = {state = "healed", msg = "highly demented", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_dementia_3 = {state = "healed", msg = "ravingly demented", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_depression = {state = "healed", msg = "depressed", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_disloyalty = {state = "healed", msg = "horribly disfigured", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_disoriented = {state = "healed", msg = "disoriented", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_dizziness_1 = {state = "healed", msg = "dizzy", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_dizziness_2 = {state = "healed", msg = "extremely dizzy", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_epilepsy = {state = "healed", msg = "epileptic", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_fear = {state = "healed", msg = "caught in the grip of fear", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_headache = {state = "healed", msg = "suffering from a splitting headache", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_horror = {state = "healed", msg = "horrified to the point of dizziness", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_hypersomnia = {state = "healed", msg = "a hypersomniac", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_hypochondria = {state = "healed", msg = "a hypochondriac", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_indiscriminate_trust  = {state = "healed", msg = "suffering from indiscriminate trust", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_malaise = {state = "healed", msg = "afflicted with extreme malaise", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_neural_charges = {state = "healed", msg = "", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_nightmares = {state = "healed", msg = "plagued by nightmares", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_paranoia = {state = "healed", msg = "extremely paranoid", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_psychic_feedback = {state = "healed", msg = "caught in a psychic feedback loop", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_stupidity = {state = "healed", msg = "an idiot", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_terror = {state = "healed", msg = "terrified of the world", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},
aff_weariness = {state = "healed", msg = "extremely weary", cures = {focus = "mind"}, assess = false, effect = "", timer = createStopWatch()},

--Spiritual
aff_arcane_fire_1 = {state = "healed", msg = "burning faintly with blue, arcane fire", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_arcane_fire_2 = {state = "healed", msg = "burning with blue, arcane fire", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_arcane_fire_3 = {state = "healed", msg = "burning brightly with blue, arcane fire", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_astral_tether = {state = "healed", msg = "astrally tethered to another place", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_astral_warp = {state = "healed", msg = "suffering from a warped astral aura", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_atoning = {state = "healed", msg = "atoning for sins", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_compulsion = {state = "healed", msg = "under (.*) web of compulsion", cures = {focus = "spirit", reject = "mage"}, assess = false, effect = "", timer = createStopWatch()},
aff_crippled = {state = "healed", msg = "crippled", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_curse_of_tongues = {state = "healed", msg = "cursed with a demon tongue", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_divine_censure = {state = "healed", msg = "laboring under the guilt of divine censure", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_dystonia = {state = "healed", msg = "suffering from dystonia", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_faithrot = {state = "healed", msg = "cursed with rotting faith", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_hemophilia = {state = "healed", msg = "a hemophiliac", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_heretic = {state = "healed", msg = "branded a heretic", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_holy_shock = {state = "healed", msg = "suffering from holy shock", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_ill_omen_1 = {state = "healed", msg = "under a mark of ill omen", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_ill_omen_2 = {state = "healed", msg = "under 2 marks of ill omen", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_ill_omen_3 = {state = "healed", msg = "under 3 marks of ill omen", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_ill_omen_4 = {state = "healed", msg = "under 4 marks of ill omen", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_ill_omen_5 = {state = "healed", msg = "under 5 marks of ill omen", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_impatience = {state = "healed", msg = "impatient", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_infirmity_1 = {state = "healed", msg = "infirm", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_infirmity_2 = {state = "healed", msg = "quite infirm", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_infirmity_3 = {state = "healed", msg = "very infirm", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_infirmity_4 = {state = "healed", msg = "extraordinarily infirm", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_infirmity_5 = {state = "healed", msg = "cripplingly infirm", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_maladroitness = {state = "healed", msg = "extremely maladroit", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_manaleech = {state = "healed", msg = "cursed with decaying magic", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_porphyria = {state = "healed", msg = "", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_recklessness = {state = "healed", msg = "reckless", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_repenting_1 = {state = "healed", msg = "ailing from a mind muddled by repentance", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_repenting_2 = {state = "healed", msg = "ailing from a mind gripped by repentance", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_repenting_3 = {state = "healed", msg = "ailing from a mind crippled by repentance", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_retribution = {state = "healed", msg = "under a penance of retribution", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_sensitivity = {state = "healed", msg = "sensitive to pain", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_somnolence = {state = "healed", msg = "drowsy from somnolence", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_sun_allergy = {state = "healed", msg = "allergic to the sun", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_sundered_armor = {state = "healed", msg = "wearing sundered armor", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_tainted_aura = {state = "healed", msg = "sickened with a tainted aura", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_unstable = {state = "healed", msg = "in an unstable state", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_vindication = {state = "healed", msg = "", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()},
aff_waking_dreams = {state = "healed", msg = "experiencing waking dreams", cures = {focus = "spirit"}, assess = false, effect = "", timer = createStopWatch()}
}

-- No neural charge
-- No indescriminate trust, faithrot, vindictaion

-- give/take functions

function mtw.aff_check()
 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].cures.writhe ~= nil then
   if getStopWatchTime(mtw.afflictions[i].timer) > 5 and mtw.afflictions[i].state == "waiting" then
    mtw.aff_timeout(i)
   end
  elseif mtw.afflictions[i].state == "waiting" and getStopWatchTime(mtw.afflictions[i].timer) > 2 then
   mtw.aff_timeout(i)
  end
 end
end
function mtw.aff_timeout(affliction)
 mtw.afflictions[affliction].state = "afflicted"
 cecho("<brown>\n[Resetting affliction: "..affliction.."!]")
 send(" ")
end

function mtw.aff_gain(affliction)
 if mtw.toggles.affecho then
  deleteLine()
  cecho("<blue>\nYou: <red>GOT<blue> "..affliction.."!")
 end
 if mtw.check.bloodboil and (affliction == "dementia" or affliction == "impatient") then
  mtw.check.bloodboil = false
 end
 mtw.aff_have(affliction)
 if affliction == "aff_amnesia" and mtw.not_aff("timewarp") and mtw.not_aff("divine_censure") then
  for i = 1,5 do
   mtw.send("stand")
  end
 end
end

function mtw.aff_have(affliction)
 if not string.find(affliction, "aff_") then
  affliction = "aff_"..affliction
 end
 if not mtw.afflictions[affliction] then
  cecho("Affliction <red>"..affliction.."<white> not tracked by the system!")
  return
 end
 if mtw.afflictions[affliction].state == "healed" then
  mtw.afflictions[affliction].state = "possible"
 end
 if affliction == "aff_blackout" then
  mtw.aff_remove("stun")
 end
 mtw.gui.update_affs()
end

function mtw.aff_diag(affliction)
 if not string.find(affliction, "aff_") then
  affliction = "aff_"..affliction
 end
 if mtw.sent.diag then
  mtw.aff_have(affliction)
 elseif mtw.sent.assess then
  mtw.afflictions[affliction].assess = true
 end
 if mtw.toggles.affecho then
  deleteLine()
  if mtw.afflictions[affliction].cures.focus ~= nil then
   if mtw.afflictions[affliction].cures.focus == "body" then
    mtw.aff_color = "<red>"
   elseif mtw.afflictions[affliction].cures.focus == "mind" then
    mtw.aff_color = "<blue>"
   elseif mtw.afflictions[affliction].cures.focus == "spirit" then
    mtw.aff_color = "<green>"
   end
  else
   mtw.aff_color = "<yellow>"
  end
  cecho(mtw.aff_color.."\n"..affliction)
 end
 if mtw.toggles.diageffect then
  if not string.find(affliction, "aff_") then
   affliction = "aff_"..affliction
  end
  echo(" "..mtw.afflictions[affliction].effect)
 end
 mtw.gui.update_affs()
end

function mtw.aff_cure(affliction)
 if mtw.toggles.affecho then
  deleteLine()
  cecho("<blue>\nYou: <green>HEAL<blue> "..affliction.."!")
 end
 mtw.aff_remove(affliction)
end

function mtw.aff_remove(affliction)
 if not string.find(affliction, "aff_") then
  affliction = "aff_"..affliction
 end
 if not mtw.afflictions[affliction] then
  cecho("Affliction <red>"..affliction.."<white> not tracked by the system!")
  return
 end
 if mtw.afflictions[affliction].cures.writhe ~= nil then
  mtw.status.writhing = false
 end
 if string.find(affliction, "bleeding") then
  if mtw.have_aff("blood_omen") then
   mtw.aff_remove("blood_omen")
  end
--  if mtw.have_aff("blood_betrayal") then
--   mtw.aff_remove("blood_betrayal")
--  end
 end
 mtw.afflictions[affliction].state = "healed"
 mtw.gui.update_affs()
end


function mtw.clear_afflictions(type)
 mtw.clear_affs = {}
 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].cures[type] ~= nil then
   if mtw.afflictions[i].cures[type] == mtw.last[type] and mtw.afflictions[i].state ~= "healed" then
    table.insert(mtw.clear_affs, i)
    mtw.aff_remove(i)
   end
  end
 end
 if #mtw.clear_affs > 0 then
  cecho("<red>\n[Removing:")
  for k in pairs(mtw.clear_affs) do
   if mtw.clear_affs[k] then
    cecho("<blue> "..mtw.clear_affs[k])
   end
  end
  cecho("<red>]")
  send(" ")
 end
end

