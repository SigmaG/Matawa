-- MTW: handling custom aliases

function mtw.adddefaultalias(id, skill, balancetype, alias, what, comment)
 mtw.defaultaliases[id] = {["skill"] = skill, ["bal"] = balancetype, ["alias"] = alias, ["what"] = what, ["comment"] = comment}
end

function mtw.loaddefaultaliases()
 mtw.defaultaliases = {}
 -- rogue
 mtw.adddefaultalias("rf_th", "Thrust", "b", "thr", "thrust #T")
 mtw.adddefaultalias("rf_fl", "Fleche", "b", "fle", "fleche #T")
 mtw.adddefaultalias("rf_hs", "Hamstring", "b", "hms", "hamstring #T")
 mtw.adddefaultalias("rf_pnc", "Puncture", "b", "pnc", "puncture #T")
 mtw.adddefaultalias("rf_wrf", "Wristflick", "b", "wrf", "wristflick #T")
 mtw.adddefaultalias("rf_lb", "Lowblow", "b", "lbl", "lowblow #T")
 mtw.adddefaultalias("rf_bs", "Backslice", "b", "bsl", "backslice #T")
 mtw.adddefaultalias("rf_hm", "Hemorrhage", "b", "hmr", "hemorrhage #T")
 mtw.adddefaultalias("rf_bt", "Beat", "b", "bt", "beat #T")
 mtw.adddefaultalias("rf_pml", "Pommel", "b", "pml", "pommel #T")
 mtw.adddefaultalias("rf_bal", "Balestra", "b", "bal", "balestra #T")
 mtw.adddefaultalias("rf_bg", "Beguile", "b", "bgu", "beguile #T")
 mtw.adddefaultalias("rf_flo", "Flourish", "b", "flo", "flourish #T")
 mtw.adddefaultalias("rf_dis", "Disarm", "b", "dis", "disarm #T")
 mtw.adddefaultalias("rf_pr", "Press", "b", "prs", "press #T #D")
 mtw.adddefaultalias("rf_gl", "Glint", "b", "glt", "glint #T")
 mtw.adddefaultalias("rf_inq", "Inquartata", "b", "inq", "inquartata #T")
 mtw.adddefaultalias("rf_bh", "Backhand", "b", "bh", "backhand #T")
 mtw.adddefaultalias("rf_bb", "Bladebarrier", "b", "bbr", "bladebarrier #D")
 mtw.adddefaultalias("rf_cdg", "Coup de Grace", "b", "cdg", "coupdegrace #T")
 mtw.adddefaultalias("rs_sb1", "Smoke Bomb", "b", "csb", "vout coal;construct smokebomb", "Construct smokebomb")
 mtw.adddefaultalias("rs_sb2", "Smoke Bomb", "b", "tsb", "throw smokebomb", "Throw smokebomb")
 mtw.adddefaultalias("rs_sb3", "Smoke Bomb", "b", "tsb", "throw smokebomb #D", "Throw smokebomb in a direction")
 mtw.adddefaultalias("rs_sb4", "Smoke Bomb", "b", "ttsb", "throw smokebomb #T", "Throw smokebomb at target")
 mtw.adddefaultalias("rs_sb5", {"Smoke Bomb", "Thieves Highway"}, "b", "rtsb", "throw smokebomb at ground", "Throw smokebomb from the rooftops")
 mtw.adddefaultalias("rs_cb1", "Cusser", "b", "ccb", "vout coal;construct cusser", "Construct cusser")
 mtw.adddefaultalias("rs_cb2", "Cusser", "b", "tcb", "throw cusser", "Throw cusser")
 mtw.adddefaultalias("rs_cb3", "Cusser", "b", "tcb", "throw cusser #D", "Throw cusser in a direction")
 mtw.adddefaultalias("rs_cb4", "Cusser", "b", "ttcb", "throw cusser #T", "Throw cusser at target")
 mtw.adddefaultalias("rs_cb5", {"Cusser", "Thieves Highway"}, "b", "rtcb", "throw cusser at ground", "Throw cusser from the rooftops")
 mtw.adddefaultalias("rs_fw", "Fireworks", "b", "frwk", "vout coal;construct cusser;bqa throw cusser at sky")
 mtw.adddefaultalias("rs_fb1", "Fire Bomb", "b", "cfb", "vout 1 wood with quality < 70;vout naphtha;construct firebomb", "Construct firebomb")
 mtw.adddefaultalias("rs_fb2", "Fire Bomb", "b", "tfb", "throw firebomb", "Throw firebomb")
 mtw.adddefaultalias("rs_fb3", "Fire Bomb", "b", "tfb", "throw firebomb #D", "Throw firebomb in a direction")
 mtw.adddefaultalias("rs_fb4", "Fire Bomb", "b", "ttfb", "throw firebomb #T", "Throw firebomb at target")
 mtw.adddefaultalias("rs_fb5", {"Fire Bomb", "Thieves Highway"}, "b", "rtfb", "throw firebomb at ground", "Throw firebomb from the rooftops")
 mtw.adddefaultalias("rs_pb", "Point Blank", "b", "fcb", "fire "..mtw.options.crossbow.." at #T", "Fire crossbow at point blank")
 mtw.adddefaultalias("rs_cr1", "Crossbow", "b", "fcb", "fire "..mtw.options.crossbow.." #D at #T", "Fire crossbow in a direction")
 mtw.adddefaultalias("rs_cr2", {"Crossbow", "Balance Queue"}, "n", "wcd", "bqa wind crossbow", "Wind crossbow")
 mtw.adddefaultalias("rs_cr3", {"Crossbow", "Envenimer"}, "f", "rld #W", "mtw.reload_with_venom", "Reload crossbow with venom")
 mtw.adddefaultalias("rs_cr4", {"Crossbow", "Balance Queue"}, "n", "rld", "bqa reload crossbow with bolt;bqa wind crossbow")
 mtw.adddefaultalias("rs_hs1", "Hostage", "b", "hs", "hostage #T")
 mtw.adddefaultalias("rs_hs2", "Hostage", "b", "hsw", "warn #T", "Warn hostage")
 mtw.adddefaultalias("rs_hs3", "Hostage", "b", "hse", "execute #T", "Execute hostage")
 mtw.adddefaultalias("rs_hs4", "Hostage", "b", "hsre", "release #T", "Release hostage")
 mtw.adddefaultalias("rs_hs5", "Rifle", "b", "hsr", "rifle #T")
 mtw.adddefaultalias("rs_bst", "Backstab", "b", "bst", "backstab #T")
 mtw.adddefaultalias("rs_em", "Hide", "b", "es", "emerge silently", "Emerge silently")
 mtw.adddefaultalias("rs_tw", "Tripwire", "b", "ltw", "vout rope;lay tripwire #D")
 mtw.adddefaultalias("rs_io", "Infiltrate", "n", "io", "infiltrate nobody", "Stop infiltration")
 mtw.adddefaultalias("rs_md", "Misdirect", "n", "md", "misdirect #D")
 mtw.adddefaultalias("rt_svi", {"Envenimer", "Shiv"}, "b", "svi", "envenom knife with duroxin; shiv #T", "Shiv with impatience")
 mtw.adddefaultalias("rt_sve", {"Envenimer", "Shiv"}, "b", "sve", "envenom knife with salenin; shiv #T", "Shiv with epilepsy")
 mtw.adddefaultalias("rt_svp", {"Envenimer", "Shiv"}, "b", "svp", "envenom knife with mortoxis; shiv #T", "Shiv with paralysis")
 mtw.adddefaultalias("rt_svh", {"Envenimer", "Shiv"}, "b", "svh", "envenom knife with cruoare; shiv #T", "Shiv with hemophilia")
 mtw.adddefaultalias("rt_svl", {"Envenimer", "Shiv"}, "b", "svl", "envenom knife with lassoxin; shiv #T", "Shiv with depression")
 mtw.adddefaultalias("rt_svsl", {"Envenimer", "Shiv"}, "b", "svsl", "envenom knife with somnulin; shiv #T", "Shiv with hypersomnia")
 mtw.adddefaultalias("rt_svn", {"Envenimer", "Shiv"}, "b", "svn", "envenom knife with botulinum; shiv #T", "Shiv with nausea")
 mtw.adddefaultalias("rt_sva", {"Envenimer", "Shiv"}, "b", "sva", "envenom knife with norare; shiv #T", "Shiv with anorexia")
 mtw.adddefaultalias("rt_svpa", {"Envenimer", "Shiv"}, "b", "svpa", "envenom knife with curonin; shiv #T", "Shiv with paranoia")
 mtw.adddefaultalias("rt_svst", {"Envenimer", "Shiv"}, "b", "svst", "envenom knife with demensare; shiv #T", "Shiv with stupidity")
 mtw.adddefaultalias("rt_svb", {"Envenimer", "Shiv"}, "b", "svb", "envenom knife with caecunim; shiv #T", "Shiv with blindness")
 mtw.adddefaultalias("rt_sv", "Shiv", "b", "sv", "shiv #T")
 mtw.adddefaultalias("rt_w1", "Unseen whisper", "b", "wstu", "swhisper #T stupidity", "Whisper stupidity")
 mtw.adddefaultalias("rt_w2", "Unseen whisper", "b", "wreck", "swhisper #T recklessness", "Whisper recklessness")
 mtw.adddefaultalias("rt_w3", "Unseen whisper", "b", "wdiz", "swhisper #T dizziness", "Whisper dizziness")
 mtw.adddefaultalias("rt_w4", "Unseen whisper", "b", "wpar", "swhisper #T paranoia", "Whisper paranoia")
 mtw.adddefaultalias("rt_w5", "Unseen whisper", "b", "wconf", "swhisper #T confusion", "Whisper confusion")
 mtw.adddefaultalias("rt_w6", "Unseen whisper", "b", "whyp", "swhisper #T hypersomnia", "Whisper hypersomnia")
 mtw.adddefaultalias("rt_w7", "Unseen whisper", "b", "wlull", "swhisper #T lull", "Lull")
 mtw.adddefaultalias("rt_dw", "Disarming whisper", "b", "wdw", "swhisper #T disarming")
 mtw.adddefaultalias("rt_vs", "Vileblade", "b", "vs", "vilestab #T")
 mtw.adddefaultalias("rt_ls", "Lungstab", "b", "lst", "lungstab #T")
 mtw.adddefaultalias("rt_cs", "Cheap Shot", "b", "cs", "cheapshot #T")
 mtw.adddefaultalias("rt_sp", "Sucker Punch", "b", "sp", "suckerpunch #T")
 mtw.adddefaultalias("rt_soh", "Sleight of Hand", "b", "soh", "sleight #T")
 mtw.adddefaultalias("rt_hg", "Hogtie", "b", "hgt", "vout rope;hogtie #T")
 mtw.adddefaultalias("rt_st", "Slit Throat", "b", "slt", "slit throat #T")
 mtw.adddefaultalias("rt_ssp", "Shadowstep", "n", "sstp", "shadowstep")
 mtw.adddefaultalias("rt_th1", "Thieves Highway", "n", "clu", "climb up", "Climb up")
 mtw.adddefaultalias("rt_th2", "Thieves Highway", "n", "cld", "climb down", "Climb down")
 mtw.adddefaultalias("rt_pp1", "Pickpocketing", "b", "pp", "pickpocket #T", "Pickpocket (PvP)")
 mtw.adddefaultalias("rt_pp2", "Pickpocketing", "b", "ppb", "pickpocket #T with bump", "Pickpocket with bump")
 mtw.adddefaultalias("rt_pp3", "Pickpocketing", "b", "ppd", "pickpocket #T with distraction", "Pickpocket with distraction")
 mtw.adddefaultalias("rt_pp4", "Pickpocketing", "b", "pps", "pickpocket #T with sleight", "Pickpocket with sleight")
 mtw.adddefaultalias("rb_res", "Resonance", "b", "pres", "play resonance")
 mtw.adddefaultalias("rb_mc", "Maiden's Caress", "b", "pmc", "play maiden's caress")
 mtw.adddefaultalias("rb_fb", "Feast of Banapis", "b", "pfe", "play feast of banapis")
 mtw.adddefaultalias("rb_bc", "Bard's Canto", "f", "pc#.", "bard_canto")
 mtw.adddefaultalias("rb_lbi", "Lay of the Blessed Isles", "b", "plbi", "play lay of the blessed isles")
 mtw.adddefaultalias("rb_lr", "Legacy of the Riftwar", "b", "plr", "play legacy of the riftwar")
 mtw.adddefaultalias("rb_hp", "Hymn of Piety", "b", "php", "play hymn of piety")
 mtw.adddefaultalias("rb_dl", "Dryad's Lullaby", "b", "pll", "play dryad's lullaby")
 mtw.adddefaultalias("rb_lb", "Longbow's Balm", "b", "plb", "play longbow's balm")
 mtw.adddefaultalias("rb_rd", "Rains of Darkmoor", "b", "prd", "play rains of darkmoor")
 mtw.adddefaultalias("rb_abs", "Air of the Black Sorcerer", "b", "pabs", "play air of the black sorcerer")
 mtw.adddefaultalias("rb_mr", "Mythar's Rage", "b", "pmr", "play mythar's rage")
 mtw.adddefaultalias("rb_ph", "Prelude of Harmony", "b", "pph", "play prelude of harmony")
 mtw.adddefaultalias("rb_os", "Oath of the Stoneborn", "b", "pos", "play oath of the stoneborn")
 mtw.adddefaultalias("rb_req", "Romance of the Elf Queen", "b", "pr", "play romance of the elf queen")
 mtw.adddefaultalias("rb_ff", "Fugue of Forgetting", "b", "pff", "play fugue of forgetting")
 mtw.adddefaultalias("rb_pa", "Pyres of Armengar", "b", "ppa", "play pyres of armengar")
 mtw.adddefaultalias("rb_sev", "Song of Eldar's Vigil", "b", "psev", "play song of eldar's vigil")
 mtw.adddefaultalias("rb_rl", "Rhuagh's Lament", "b", "prl", "play rhuagh's lament")
 mtw.adddefaultalias("rb_bh", "Ballad of the Hand", "b", "pbh", "play ballad of the hand")
 mtw.adddefaultalias("rb_va", "Verse of Ages", "b", "pva", "play verse of ages")
 mtw.adddefaultalias("rb_sb", "Sanguine Bolero", "b", "psb", "play sanguine bolero")
 mtw.adddefaultalias("rb_si", "Silence of Sethanon", "b", "pss", "play silence of sethanon")
 mtw.adddefaultalias("rb_lar", "Laurie's Refrain", "b", "plar", "play laurie's refrain")
 mtw.adddefaultalias("rb_ns", "Nocturne of Shadow", "b", "pns", "play nocture of shadow")
 mtw.adddefaultalias("rb_ba", "Battaglia Anthem", "b", "pba", "play battaglia anthem")
 mtw.adddefaultalias("rb_sv", "Serenade of the Void", "b", "psv", "play serenade of the void")
 mtw.adddefaultalias("rb_sq", "Squall of Storms", "b", "psos", "play squall of storms")
 mtw.adddefaultalias("rb_nt", "Naming of Tears", "f", "pnt#.", "naming_of_tears")
 mtw.adddefaultalias("rb_rf", "Requiem of the Fallen", "b", "preq", "play requiem of the fallen")
 mtw.adddefaultalias("rb_dis", "Dissonance", "f", "pdis #.", "dissonance")
 mtw.adddefaultalias("rb_al", "Allegro", "f", "pal #d#d#d", "allegro")
 mtw.adddefaultalias("rb_lss", "Musicality", "f", "lss #W", "load_songs")
 mtw.adddefaultalias("rb_alg", "Allegro", "f", "alg", "list_allegro")
 mtw.adddefaultalias("rf_e1", "Envenimer", "n", "vsd", "bqa envenom saber with duroxin", "Envenom saber with duroxin")
 mtw.adddefaultalias("rf_e2", "Envenimer", "n", "vss", "bqa envenom saber with salenin", "Envenom saber with salenin")
 mtw.adddefaultalias("rf_e3", "Envenimer", "n", "vsc", "bqa envenom saber with cruorare", "Envenom saber with cruorare")
 mtw.adddefaultalias("rf_e4", "Envenimer", "n", "vsl", "bqa envenom saber with lassoxin", "Envenom saber with lassoxin")
 mtw.adddefaultalias("rf_e5", "Envenimer", "n", "vsp", "bqa envenom saber with mortoxis", "Envenom saber with mortoxis")
 mtw.adddefaultalias("rf_e6", "Envenimer", "n", "vssl", "bqa envenom saber with somnulin", "Envenom saber with somnulin")
 mtw.adddefaultalias("rf_e7", "Envenimer", "n", "vsv", "bqa envenom saber with botulinum", "Envenom saber with botulinum")
 mtw.adddefaultalias("rf_e8", "Envenimer", "n", "vsa", "bqa envenom saber with norare", "Envenom saber with norare")
 mtw.adddefaultalias("rf_e9", "Envenimer", "n", "vspa", "bqa envenom saber with curonin", "Envenom saber with curonin")
 mtw.adddefaultalias("rf_e10", "Envenimer", "n", "vsst", "bqa envenom saber with demensare", "Envenom saber with demensare")
 mtw.adddefaultalias("rf_e11", "Envenimer", "n", "vsb", "bqa envenom saber with caecunim", "Envenom saber with caecunim")
 mtw.adddefaultalias("rf_e12", "Envenimer", "n", "vdd", "bqa envenom dagger with duroxin", "Envenom dagger with duroxin")
 mtw.adddefaultalias("rf_e13", "Envenimer", "n", "vds", "bqa envenom dagger with salenin", "Envenom dagger with salenin")
 mtw.adddefaultalias("rf_e14", "Envenimer", "n", "vdc", "bqa envenom dagger with cruorare", "Envenom dagger with cruorare")
 mtw.adddefaultalias("rf_e15", "Envenimer", "n", "vdl", "bqa envenom dagger with lassoxin", "Envenom dagger with lassoxin")
 mtw.adddefaultalias("rf_e16", "Envenimer", "n", "vdp", "bqa envenom dagger with mortoxis", "Envenom dagger with mortoxis")
 mtw.adddefaultalias("rf_e17", "Envenimer", "n", "vdsl", "bqa envenom dagger with somnulin", "Envenom dagger with somnulin")
 mtw.adddefaultalias("rf_e18", "Envenimer", "n", "vdv", "bqa envenom dagger with botulinum", "Envenom dagger with botulinum")
 mtw.adddefaultalias("rf_e19", "Envenimer", "n", "vda", "bqa envenom dagger with norare", "Envenom dagger with norare")
 mtw.adddefaultalias("rf_e20", "Envenimer", "n", "vdpa", "bqa envenom dagger with curonin", "Envenom dagger with curonin")
 mtw.adddefaultalias("rf_e21", "Envenimer", "n", "vdst", "bqa envenom dagger with demensare", "Envenom dagger with demensare")
 mtw.adddefaultalias("rf_e22", "Envenimer", "n", "vdb", "bqa envenom dagger with caecunim", "Envenom dagger with caecunim")
 mtw.adddefaultalias("rf_e23", "Envenimer", "n", "vcd", "bqa envenom bolt with duroxin", "Envenom bolt with duroxin")
 mtw.adddefaultalias("rf_e24", "Envenimer", "n", "vcs", "bqa envenom bolt with salenin", "Envenom bolt with salenin")
 mtw.adddefaultalias("rf_e25", "Envenimer", "n", "vcc", "bqa envenom bolt with cruorare", "Envenom bolt with cruorare")
 mtw.adddefaultalias("rf_e26", "Envenimer", "n", "vcl", "bqa envenom bolt with lassoxin", "Envenom bolt with lassoxin")
 mtw.adddefaultalias("rf_e27", "Envenimer", "n", "vcp", "bqa envenom bolt with mortoxis", "Envenom bolt with mortoxis")
 mtw.adddefaultalias("rf_e28", "Envenimer", "n", "vcsl", "bqa envenom bolt with somnulin", "Envenom bolt with somnulin")
 mtw.adddefaultalias("rf_e29", "Envenimer", "n", "vcv", "bqa envenom bolt with botulinum", "Envenom bolt with botulinum")
 mtw.adddefaultalias("rf_e30", "Envenimer", "n", "vca", "bqa envenom bolt with norare", "Envenom bolt with norare")
 mtw.adddefaultalias("rf_e31", "Envenimer", "n", "vcpa", "bqa envenom bolt with curonin", "Envenom bolt with curonin")
 mtw.adddefaultalias("rf_e32", "Envenimer", "n", "vcst", "bqa envenom bolt with demensare", "Envenom bolt with demensare")
 mtw.adddefaultalias("rf_e33", "Envenimer", "n", "vcb", "bqa envenom bolt with caecunim", "Envenom bolt with caecunim")

 --soldier

 --mage
 mtw.adddefaultalias("ma_at", "Astral Tether", "b", "teth", "cast tether #T")
 mtw.adddefaultalias("ma_aw", "Astral Warp", "b", "asw", "cast warp #T")
 mtw.adddefaultalias("ma_tsh", "Timeshift", "b", "tshi", "cast timeshift #T")
 mtw.adddefaultalias("ma_eb", "Eldritch Barrage", "b", "bar", "cast eldritch barrage #T")
 mtw.adddefaultalias("ma_cr", "Cripple", "b", "crip", "cast cripple #T")
 mtw.adddefaultalias("ma_sl", "Sleep", "b", "slp", "cast sleep #T")
 mtw.adddefaultalias("ma_dem", "Dementia", "b", "dem", "cast dementia #T")
 mtw.adddefaultalias("ma_dis", "Disorient", "b", "dis", "cast disorient #T")
 mtw.adddefaultalias("ma_co", "Compulsion", "f", "comp#.", "compulsion")
 mtw.adddefaultalias("ma_in", "Instability", "b", "inst", "cast instability #T")
 mtw.adddefaultalias("ma_sg", "Singularity", "b", "sing", "cast singularity")
 mtw.adddefaultalias("ma_un", "Undoing", "b", "undo", "cast undoing #T")
 mtw.adddefaultalias("ma_tq", "Timequake", "b", "tqu", "cast timequake")
 mtw.adddefaultalias("ma_cnt", "Counterspell", "b", "cnt", "cast counterspell #T")
 mtw.adddefaultalias("ma_sn", "Supernova", "b", "nova", "cast supernova 15")
 mtw.adddefaultalias("ma_bf", "Balefire", "b", "blf", "cast balefire #T")
 mtw.adddefaultalias("ma_sc", {}, "f", "scry #W", "scry", "Scry") -- because of the scrying orb
 mtw.adddefaultalias("ma_ri", "Rift", "b", "rift", "cast rift #D")
 mtw.adddefaultalias("ma_di", "Distort", "b", "dist", "cast distort")
 mtw.adddefaultalias("ma_dd", "Distort", "b", "ddist", "dispel distortion", "Dispel Distortion")
 mtw.adddefaultalias("ma_rs", "Riftsense", "b", "rsense", "riftsense")
 mtw.adddefaultalias("ma_df", "Distortion Field", "b", "dfield", "cast distortion field")
 mtw.adddefaultalias("ma_wrd", "Warding", "b", "ward", "cast warding")
 mtw.adddefaultalias("ma_cc", "Conceal", "b", "conc", "cast conceal #D")
 mtw.adddefaultalias("ma_tp", "Teleport", "f", "tele", "teleport")
 mtw.adddefaultalias("ma_il", "Illusion", "f", "ci #.", "illusion")
 mtw.adddefaultalias("ma_sc2", {}, "f", "scry #W #.", "scry_announce", "Scry and announce")
 mtw.adddefaultalias("ma_mi", "Mirror Image", "b", "mi", "cast mirror image")
 mtw.adddefaultalias("ma_sh", "Spellshield", "b", "spsh", "cast spellshield")
 mtw.adddefaultalias("ma_ap", "Arcane Power", "b", "apow", "cast arcane power")
 mtw.adddefaultalias("ma_iv", "Invisibility", "b", "invis", "cast invisibility")
 mtw.adddefaultalias("ma_ac", "Anachronize", "b", "anac", "cast anachronize")
end

function mtw.deletealiases()
 if mtw.aliases then
  for k,id in pairs(mtw.aliases) do
   killAlias(id)
  end
 end
 mtw.aliases = {}
end

-- mtw.defaultaliases[id] = {["skill"] = skill, ["bal"] = balancetype, ["alias"] = alias, ["do"] = do}, ["comment"] = comment}

function mtw.serialize_skills(t)
 local s = "{"
 for k,v in pairs(t) do
  if type(k) == "string" then
   s = s .. "[\"" .. k .. "\"] = "
  elseif type(k) == "integer" then
   s = s .. "[" .. k .. "] = "
  end
  if type(v) == "string" then
   s = s .. "\"" .. v .. "\", "
  elseif type(v) == "integer" then
   s = s .. v .. ", "
  end
 end
 return s
end

function mtw.generatealiases()
 mtw.deletealiases()
 for k,v in pairs(mtw.defaultaliases) do
  local al
  local id
  local what
  if v.bal == "f" then
   al = "^" .. string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(v.alias, "#%.", "(.*)"), "#d", "(\\d)"), "#w", "(\\w)"), "#D", "(\\d+)"), "#W", "(\\w+)") .. "$"
   if type(v.skill) == "string" then
    id = tempAlias(al, string.format([[mtw.aliasdo("%s", "%s", "%s", matches)]], v.skill, v.what, v.bal))
   else
    id = tempAlias(al, string.format([[mtw.aliasdo(%s, "%s", "%s", matches)]], mtw.serialize_skills(v.skill), v.what, v.bal))
   end
  else
   al = "^"..v.alias
   local dir = false
   local targ = false
   if string.find(v.what, "#D") then
    al = al.." (\\w+)"
    dir = true
   end
   if string.find(v.what, "#T") then
    al = al.."( \\w+)?"
    targ = true
   end
   al = al.."$"
   if type(v.skill) == "string" then
    id = tempAlias(al, string.format([[mtw.aliasdo("%s", "%s", "%s", matches)]], v.skill, v.what, v.bal))
   else
    id = tempAlias(al, string.format([[mtw.aliasdo(%s, "%s", "%s", matches)]], mtw.serialize_skills(v.skill), v.what, v.bal))
   end
  end
  mtw.aliases[k] = id
 end
end

function mtw.printaliases()
 
end

function mtw.aliasdo(skill, what, bal, matches)
 if type(skill) == "string" then
  if not table.contains(mtw.skills, skill) then
   cecho("\n<pink>Unknown skill: ".. skill)
   return
  end
 elseif type(skill) == "table" then
  for _,v in pairs(skill) do
   if not table.contains(mtw.skills, v) then
    cecho("\n<pink>Unknown skill: ".. v)
    return
   end
  end
 end
 if bal == "f" then
  mtw.al[what](matches)
 else
  local dir = false
  local targ = false
  if string.find(what, "#D") then
   dir = true
  end
  if string.find(what, "#T") then
   targ = true
  end
  if targ and dir then
   what = string.gsub(what, "#D", matches[2])
   if matches[3] and matches[3] ~= "" and matches[3] ~= " " then
    what = string.gsub(what, " #T", matches[3])
   else
    what = string.gsub(what, "#T", mtw.target)
   end
  elseif dir then
   what = string.gsub(what, "#D", matches[2])
  elseif targ then
   if matches[2] and matches[2] ~= "" and matches[2] ~= " " then
    what = string.gsub(what, " #T", matches[2])
   else
    what = string.gsub(what, "#T", mtw.target)
   end
  end
  if bal == "b" then
   mtw.set_balance(what)
  elseif bal == "n" then
   mtw.send(what)
  elseif bal == "p" then
   mtw.set_psi(what)
  elseif bal == "e" then
   mtw.set_equil(what)
  elseif bal == "o" then
   mtw.set_offhand(what)
  end
 end
end