-- MTW: attack aliases

-- rogue
function mtw.deepshroud_alias()
 if mtw.my.class == "rogue" then
  send("deepshroud",false)
  mtw.prechanneling.deepshrouding = true
  tempTimer(mtw.delay(),[[mtw.prechanneling.deepshrouding = false]])
 end
end

function mtw.al_rogue(skill)
 if mtw.my.class == "rogue" then
  mtw.set_balance(skill .. " "..mtw.target)
 end
end

function mtw.al_do_rogue(s)
 if mtw.my.class == "rogue" then
  mtw.set_balance(s)
 end
end

function mtw.reload_with_venom(matches)
send("bqa quiver draw 1")

if matches[2] == "l" then
	send("bqa envenom bolt with lassoxin")
	elseif matches[2] == "m" then
	send("bqa envenom bolt with mortoxis")
	elseif matches[2] == "d" then
	send("bqa envenom bolt with duroxin")
	elseif matches[2] == "s" then
	send("bqa envenom bolt with salenin")
	elseif matches[2] == "c" then
	send("bqa envenom bolt with cruorare")
	elseif matches[2] == "b" then
	send("bqa envenom bolt with botulinum")
	elseif matches[2] == "n" then
	send("bqa envenom bolt with norare")
	elseif matches[2] == "sl" then
	send("bqa envenom bolt with somnulin")
end

send("bqa reload crossbow")
send("bqa wind crossbow")
end

function mtw.bard_canto(matches)
if mtw.my.class == "rogue" then
 if matches[2] == "" then
  mtw.set_balance("Play Bard's Canto "..mtw.target)
 else
 mtw.set_balance("play bard's canto "..matches[2])
 end
end
end

function mtw.naming_of_tears(matches)
if mtw.my.class == "rogue" then
 if matches[2] == "" then
  mtw.set_balance("Play Naming "..mtw.target)
 else
  mtw.set_balance("play naming"..matches[2])
 end
end
end

function mtw.list_allegro()
for i in pairs(mtw.song_list) do
 if mtw.songs[mtw.song_list[i]].id ~= "" then
  send("bqa play allegro "..mtw.songs[mtw.song_list[i]].id)
 end
end
end

-- soldier skills

function mtw.al_soldier(skill)
 if mtw.my.class == "soldier" then
  mtw.set_balance(skill .. " "..mtw.target)
 end
end

function mtw.al_do_soldier(s)
 if mtw.my.class == "soldier" then
  mtw.set_balance(s)
 end
end

function mtw.last_stand_alias()
if mtw.balance.last_stand then
 mtw.defenses["def_last_stand"].needit = true
 table.insert(mtw.less_defs, "def_last_stand")
 cecho("<brown>\nYou: QUEUE last stand!")
 send(" ")
else
 cecho("<red>\nCan't stand true yet!")
 send(" ")
end
end

function mtw.immunity_alias()
if mtw.my.class == "soldier" then
 mtw.set_equil("immunity")
end
end

function mtw.charge_alias(matches)
if mtw.my.class == "soldier" then
 if matches[2] == "" then
  mtw.set_balance("charge "..mtw.target)
 else
  mtw.set_balance("charge "..matches[2])
 end
end
end

function mtw.stance_alias(matches)
if mtw.my.class == "soldier" then
 if matches[1] == "st li" then
  mtw.set_equil("stance lightning")
 elseif matches[1] == "st de" then
  mtw.set_equil("stance defensive")
 elseif matches[1] == "st ag" then
  mtw.set_equil("stance aggressive")
 end
end
end

function mtw.al_swordmaster_q(s)
if mtw.have_def("phoenix_crouching") and table.contains(mtw.skills, "Quickdraw") then
	mtw.send("quickdraw scabbard")
end

if mtw.skills.swordmastery then
 mtw.set_balance(s)
end
end

function mtw.al_swordmaster_o(s)
if mtw.skills.swordmastery then
 mtw.set_offhand(s)
end
end

function mtw.al_swordmaster_b(s)
if mtw.skills.swordmastery then
 mtw.set_balance(s)
end
end

function mtw.windsong_alias(matches)
local ftar = matches[2] or mtw.target
if mtw.skills.swordmastery then
 send("windflow "..ftar,false)
end
end

function mtw.unfurl_alias()
if not mtw.have_def("phoenix_crouching") then
 cecho("<green>-----You must be crouching to unfurl!-----")
end
if mtw.skills.swordmastery then
 mtw.set_balance("blade unfurl "..mtw.target)
end
end


-- magician aliases


function mtw.al_mage(skill)
 if mtw.my.class == "magician" then
  mtw.set_balance(skill .. " "..mtw.target)
 end
end

function mtw.al_do_mage(s)
 if mtw.my.class == "magician" then
  mtw.set_balance(s)
 end
end

function mtw.compulsion_alias(matches)
if mtw.my.class == "magician" then
 if matches[2] == "" then
  mtw.set_balance("cast compulsion "..mtw.target)
 else
  mtw.set_balance("compel "..mtw.target.." "..matches[2])
 end
end
end

function mtw.scry_alias(matches)
if mtw.my.class == "magician" then
 mtw.set_balance("cast scry "..matches[2])
else
 send(matches[1])
end
for h in pairs(mtw.scry) do
 mtw.scry[h] = "none"
end
end

function mtw.teleport_alias(matches)
if mtw.defenses.def_spellshield.needit then
 mtw.defenses.def_spellshield.needit = false
 echo("No longer keeping spellshield")
 send(" ")
end
if mtw.my.class == "magician" then
 mtw.set_balance("cast teleport "..matches[2])
end
end

function mtw.scry_announce(matches)
if mtw.my.class == "magician" then
 mtw.scry.target = matches[2]
 mtw.scry.call = matches[3]
 mtw.set_balance("cast scry "..matches[2])
end
end

function mtw.gale_alias(matches)
if mtw.my.class == "magician" then
 if matches[3] == "" then
  mtw.set_balance("cast gale "..mtw.target.." "..matches[2])
 else
  mtw.set_balance("cast gale "..matches[3].." "..matches[2])
 end
end
end

function mtw.al_warlock(skill)
if table.contains(mtw.skills, "demonology") then
 mtw.set_balance(skill.." "..mtw.target)
end
end

function mtw.al_do_warlock(s)
if table.contains(mtw.skills, "demonology") then
 mtw.set_balance(s)
end
end

function mtw.wild_hunt_alias(matches)
if table.contains(mtw.skills, "demonology") then
 if matches[2] == "" then
  mtw.set_balance("demoncall hunt "..mtw.target)
 else
  mtw.set_balance("demoncall hunt"..matches[2])
end
end
end

function mtw.summon_alias(matches)
if table.contains(mtw.skills, "demonology") then
 if matches[2] == "lurker" or "battle demon" or "demon lord" then
  mtw.send("vout heartstone")
 end
  mtw.set_balance("summon "..matches[2])
end
end

function mtw.order_demon_attack(matches)
if mtw.my.class == "magician" and table.contains(mtw.skills, "demonology") then
 if matches[2] == "" then
  send("order thrall attack "..mtw.target)
 else
  mtw.set_balance("order thrall attack "..matches[2])
 end
end
end

function mtw.blood_command_attack(matches)
if mtw.my.class == "magician" and table.contains(mtw.skills, "demonology") then
if matches[2] == nil then
 mtw.set_balance("blood command thrall attack "..mtw.target)
else
 mtw.set_balance("blood command thrall attack "..matches[2])
end
end
end

function mtw.summon_alias2(matches)
if table.contains(mtw.skills, "demonology") then
toggle("demon")
demon.stat = "prepare"
demon.type = matches[2]
demon.augury = false
end
end

function mtw.augury_alias()
if table.contains(mtw.skills, "demonology") then
toggle("demon")
demon.stat = "prepare"
demon.type = "imp"
demon.augury = true
end
end

function mtw.al_psion(skill)
if table.contains(mtw.skills, "psionics") then
 mtw.set_psi(skill.." "..mtw.target)
end
end

function mtw.al_do_psion(s)
if table.contains(mtw.skills, "psionics") then
 mtw.set_psi(s)
end
end


-- priest aliases

function mtw.al_smite(skill)
if mtw.my.class == "priest" then
 if mtw.toggles.bloodsensing and table.contains(mtw.skills, "Bloodsense") then
  mtw.next.bloodsense = true
 end
 mtw.set_balance("smite ".. mtw.target .." with "..skill)
end
end

function mtw.al_pray(skill)
if mtw.my.class == "priest" then
 mtw.set_balance("pray for "..skill)
end
end

function mtw.al_pray_of(skill,matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("pray for "..skill)
 else
  mtw.set_balance("pray for "..skill.." of "..matches[2])
 end
end
end

function mtw.healing_alias(matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("pray for healing")
 else
  mtw.set_balance("pray for healing of "..matches[2])
  ally = matches[2]
 end
 need_heal = true
 end
end

function mtw.divine_command_alias(matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("smite "..mtw.target .." with divine command")
 else
  mtw.set_balance("command "..mtw.target.." to "..matches[2])
 end
end
end

function mtw.al_do_priest(s)
if mtw.my.class == "priest" then
 mtw.set_balance(s)
end
end

function mtw.liturgy_alias()
if mtw.my.class == "priest" then
 mtw.set_equil("pray for liturgy")
end
end

function mtw.spirit_tap_alias(matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("pray for spirit tap of " ..mtw.target)
 else
  mtw.set_balance("pray for spirit tap of "..matches[2])
 end
end
end

function mtw.blessings_alias(matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  send("pray for glorious word", false)
  if table.contains(mtw.skills, "Balance Queue") then
   send("bqa pray for radiant word", false)
   send("bqa pray for illuminated word", false)
   send("bqa pray for righteous word", false)
   send("bqa pray for blessed word", false)
  else
   tempTimer(3.3, [[send("pray for radiant word", false)]] )
   tempTimer(6.4, [[send("pray for illuminated word", false)]] )
   tempTimer(9.6, [[send("pray for righteous word", false)]] )
   tempTimer(12.79, [[send("pray for blessed word", false)]] )
  end
 else
  blessed = matches[2]
  send("pray for glorious word to "..blessed, false)
  if table.contains(mtw.skills, "Balance Queue") then
   send("bqa pray for radiant word to "..blessed, false)
   send("bqa pray for illuminated word to "..blessed, false)
   send("bqa pray for righteous word to "..blessed, false)
   send("bqa pray for blessed word to "..blessed, false)
  else
   tempTimer(3.3, [[send("pray for radiant word to "..blessed, false)]] )
   tempTimer(6.4, [[send("pray for illuminated word to "..blessed, false)]] )
   tempTimer(9.6, [[send("pray for righteous word to "..blessed, false)]] )
   tempTimer(12.8, [[send("pray for blessed word to "..blessed, false)]] )
  end
 end
end
end

function mtw.spiritshield_alias()
mtw.defenses["def_spiritshield"].needit = true
table.insert(mtw.less_defs, "def_spiritshield")
cecho("<brown>\nYou: QUEUE spiritshield!")
send(" ")
end

function mtw.al_pyro(skill)
if mtw.my.class == "priest" then
 mtw.set_balance("firecall "..skill.." "..mtw.target)
end
end

function mtw.al_do_pyro(skill)
if mtw.my.class == "priest" and mtw.skills.pyromania then
 mtw.set_balance("firecall "..skill)
end
end

function mtw.full_inferno_alias()
if mtw.my.class == "priest" then
 send("firecall inferno", false)
 tempTimer(4.1, [[send("firecall wildfire", false)]])
 tempTimer(8.6, [[send("firecall heatwave", false)]])
 tempTimer(14.3, [[send("firecall smokescreen on", false)]])
 tempTimer(19.3, [[send("firecall ashfall", false)]])
 tempTimer(23.5, [[send("firecall backdraft", false)]])
 tempTimer(28.4, [[send("firecall firerain", false)]])
 tempTimer(32.6, [[send("firecall fumes", false)]])
 tempTimer(36.6, [[send("firecall heatstroke", false)]])
end
end

function mtw.al_thana(skill)
if mtw.my.class == "priest" and mtw.skills.thanatology then
 mtw.set_balance("deathcall "..skill.." "..mtw.target)
end
end

function mtw.al_sweaver(skill)
if mtw.my.class == "priest" and mtw.skills.shadoweaving then
	mtw.set_balance("shadowcall "..skill)
end
end

function mtw.greater_heal_sw_alias(matches)
if mtw.my.class == "priest" and mtw.skills.shadoweaving then
 if matches[2] == "" then
  mtw.set_balance("shadowcall greater heal")
 else
  mtw.set_balance("shadowcall greater heal " ..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.al_do_sweaver(s)
if mtw.my.class == "priest" then
	mtw.set_balance(s)
end
end

function mtw.atk_sweaver(skill)
if mtw.my.class == "priest" and mtw.skills.shadoweaving then
	mtw.set_balance("shadowcall "..skill.." "..mtw.target)
end
end

function mtw.stalker_alias(matches)
if mtw.my.class == "priest" then
	if matches[2] == "" then
		mtw.set_balance("shadowcall stalk " ..mtw.target)
	else
		mtw.set_balance("shadowcall stalk " ..matches[2])
	end
end
end

function mtw.desperate_prayer_alias(matches)
if mtw.my.class == "priest" then
	if matches[2] == "" then
		mtw.set_balance("shadowcall desperate prayer")
	else
		mtw.set_balance("shadowcall desperate prayer " ..matches[2])
	end
end
end

function mtw.al_hema(skill)
if mtw.my.class == "priest" then
 mtw.set_balance("bloodcall "..skill)
end
end

function mtw.al_do_hema(s)

end

function mtw.atk_hema(skill)
if mtw.my.class == "priest" then
 if mtw.toggles.bloodsensing and table.contains(mtw.skills, "Bloodsense") then
  mtw.next.bloodsense = true
 end
 mtw.set_balance("bloodcall "..skill.." "..mtw.target)
end
end

function mtw.greater_heal_hema(matches)
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("bloodcall greater heal")
 else
  mtw.set_balance("bloodcall greater heal " ..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.desperate_prayer_hema(matches)
if table.contains(mtw.skills, "bloodlore") then
 if matches[2] == "" then
  mtw.set_balance("bloodcall desperate prayer")
 else
  mtw.set_balance("bloodcall greater heal " ..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.bloodmend_alias(matches)
--definitely looks weird
if mtw.my.class == "priest" then
 if matches[2] == "" then
  mtw.set_balance("bloodcall greater heal " ..ally)
 else
  mtw.set_balance("bloodcall greater heal " ..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.atk_sader(skill)
if table.contains(mtw.skills, "crusading") then
 mtw.set_balance("warcall "..skill.." "..mtw.target)
end
end

function mtw.revelation_alias(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall revelation "..mtw.target)
 else
  mtw.set_balance("warcall revelation "..matches[2])
 end
end
end

function mtw.al_do_sader(s)
if table.contains(mtw.skills, "crusading") then
 mtw.set_balance(s)
end
end

function mtw.greater_heal_sader(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall greater heal")
 else
  mtw.set_balance("warcall greater heal"..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.desperate_prayer_sader(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall desperate prayer")
 else
  mtw.set_balance("warcall desperate prayer" ..matches[2])
  ally = matches[2]
 end
 need_heal = true
end
end

function mtw.effigy_alias(e)
if table.contains(mtw.skills, "crusading") then
 send("vout 1 wood with quality < 70;vout 1 cloth")
 mtw.set_balance("warcall effigy of "..e)
end
end

function mtw.valorblast_alias(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall valorblast "..mtw.target)
 else
  mtw.set_balance("warcall valorblast "..matches[2])
 end
end
end

function mtw.joyous_onslaught_alias(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" or nil then
  mtw.set_balance("warcall onslaught effigy")
 else
  mtw.set_balance("warcall onslaught "..matches[2])
 end
end
end

function mtw.marked_for_death(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall charge "..mtw.target)
 else
  mtw.set_balance("warcall charge "..matches[2])
 end
end
end

function mtw.crusadesight_alias(matches)
if table.contains(mtw.skills, "crusading") then
 if matches[2] == "" then
  mtw.set_balance("warcall crusadesight "..mtw.target)
 else
  mtw.set_balance("warcall crusadesight "..matches[2])
 end
end
end

-- fighting and vigilance aliases

function mtw.perfect_defense_alias()
if mtw.balance.perfect then
 mtw.defenses["def_perfect"].needit = true
 table.insert(mtw.less_defs, "def_perfect")
 cecho("<brown>\nYou: QUEUE perfect defense!")
 send(" ")
else
 cecho("<red>\nCan't perfect yet!")
 send(" ")
end
end

function mtw.assess_alias(matches)
if matches[2] ~= "" then
 mtw.set_equil("assess "..matches[2])
else
 mtw.set_equil("assess "..mtw.target)
end
end

