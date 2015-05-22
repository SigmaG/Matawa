-- MTW: bashing functions for the different classes


function mtw.bashing_function()
 if mtw.am_functional() then
  if mtw.my.class == "soldier" then
   mtw.soldier_bash()
  elseif mtw.my.class == "magician" then
   mtw.magician_bash()
  elseif mtw.my.class == "rogue" then
   mtw.rogue_bash()
  elseif mtw.my.class == "priest" then
   mtw.priest_bash()
  else
   mtw.send("attack "..target)
  end
 end
end

function mtw.soldier_bash()
 if mtw.toggles.berserking and table.contains(mtw.skills, "Berserking") and mtw.bashing.engaged and mtw.defenses.def_berserking.state ~= "deffed" and mtw.balance.balance then
  mtw.send("berserk")
 end
 if table.contains(mtw.skills, "Threaten") and mtw.toggles.threaten then
  if mtw.defenses.def_defensive_stance ~= "deffed" then
   cecho("<yellow>Defensive stance is disabled, cannot threaten!\n")
  else
   mtw.send("threaten everyone")
  end
 end
 if table.contains(mtw.skills, "Desperate Strike") and mtw.balance.desperate and mtw.vitals.adrenaline < 15 and mtw.vitals.percent.health < 25 and not mtw.need_wield and not mtw.need_offwield then
  mtw.send("strike "..mtw.bashing.target)
 elseif not mtw.used.rake and table.contains(mtw.skills, "Rake") and mtw.toggles.raking and not mtw.need_wield and not mtw.need_offwield then
  mtw.send("rake "..mtw.bashing.target)
  if mtw.balance.secondwind and table.contains(mtw.skills, "Second Wind") then
    mtw.used.rake = true
    mtw.send("secondwind")
  end
 elseif not mtw.used.sunder and table.contains(mtw.skills, "Sunder Armor") and mtw.toggles.sundering and not mtw.need_wield and not mtw.need_offwield then
  mtw.send("sunder "..mtw.bashing.target)
  if mtw.balance.secondwind and table.contains(mtw.skills, "Second Wind") then
    mtw.used.sunder = true
    mtw.send("secondwind")
  end
 elseif table.contains(mtw.skills, "swordmastery") and table.contains(mtw.skills, "Starfury Slash") and mtw.toggles.starfurying and not mtw.used.starfury and mtw.vitals.adrenaline >= 85 and not mtw.need_wield and not mtw.need_offwield then
  mtw.send("starfuryslash "..mtw.bashing.target)
  if mtw.balance.secondwind and table.contains(mtw.skills, "Second Wind") then
    mtw.used.starfury = true
    mtw.send("secondwind")
  end
 elseif mtw.vitals.adrenaline > 89 and mtw.toggles.obliterating and not mtw.need_wield and not mtw.need_offwield and mtw.enemy_health ~= "<red> 0-10%" then
  mtw.send("obliterate "..mtw.bashing.target)
  if mtw.balance.secondwind and mtw.waiting.balance and table.contains(mtw.skills, "Second Wind") then
    mtw.send("secondwind")
  end
 elseif (mtw.defenses.def_grip.state == "deffed" or not table.contains(mtw.skills, "Gripping")) and mtw.balance.balance and not mtw.need_wield then
  mtw.send("slash "..mtw.bashing.target)
  if mtw.balance.secondwind and mtw.waiting.balance and table.contains(mtw.skills, "Second Wind") then
    mtw.send("secondwind")
  end
 end
end

function mtw.magician_bash()
 if table.contains(mtw.skills, "Anachronize") and mtw.toggles.anachronizing and mtw.balance.anachronize and mtw.vitals.current.magic >= 3000 and not mtw.status.combat then
  mtw.send("cast anachronize")
 end

 if (mtw.have_def("grip") or not mtw.toggles.gripping) and not mtw.need_wield or not mtw.need_offwield then
  if not mtw.used.ignite and mtw.toggles.igniting and table.contains(mtw.skills, "Ignite") then
   mtw.send("cast ignite "..mtw.bashing.target)
   elseif mtw.used.ignite and table.contains(mtw.skills, "Immolate") and mtw.toggles.immolating and (mtw.enemy_health == "<red> 0-10%" or mtw.enemy_health == "<red> 10-25%") then
   mtw.send("cast immolate "..mtw.bashing.target)
   elseif mtw.balance.barrage and table.contains(mtw.skills, "Eldritch Barrage") and mtw.toggles.barraging and not mtw.toggles.spiking and (mtw.vitals.cadence >= 1 or mtw.defenses.def_stormfury.state ~= "deffed") then
   mtw.send("cast eldritch barrage "..mtw.bashing.target)
   elseif mtw.balance.barrage and table.contains(mtw.skills, "Eldritch Barrage") and mtw.toggles.barraging and (mtw.vitals.cadence >= 1 or mtw.defenses.def_stormfury.state ~= "deffed") and mtw.bashing.engaged then
   mtw.send("cast eldritch barrage "..mtw.bashing.target)
   elseif mtw.toggles.spiking and table.contains(mtw.skills, "Ice Spikes") then
   if mtw.defenses.def_stormfury.state == "deffed" then
    if mtw.vitals.cadence == 3 and getStopWatchTime(mtw.last_lance) <= 20 then
     mtw.send("cast ice spikes "..mtw.bashing.target)
     else
     mtw.send("cast stormlance "..mtw.bashing.target)
     end
     else
     mtw.send("cast ice spikes "..mtw.bashing.target)
   end
   elseif table.contains(mtw.skills, "Balefire") and mtw.vitals.cadence >= 1 and not mtw.used.balefire and not mtw.casted.balefire then
   mtw.send("cast balefire "..mtw.bashing.target)
   elseif table.contains(mtw.skills, "Balefire") and mtw.toggles.balefiring then
   mtw.send("cast balefire "..mtw.bashing.target)
   else
   mtw.send("cast stormlance "..mtw.bashing.target)
  end
 end
end

function mtw.rogue_bash()

 if table.contains(mtw.skills, "performance") and table.contains(mtw.skills, "Prelude of Harmony") and mtw.toggles.prelude and mtw.bashing.engaged and mtw.defenses.def_prelude.state ~= "deffed" then
  if mtw.songs.prelude.id ~= "" and table.contains(mtw.skills, "Allegro") then
   mtw.send("play allegro "..mtw.songs.prelude.id)
   mtw.sent.prelude = true
   tempTimer(mtw.delay(), [[mtw.sent.prelude = false]])
   return
  elseif mtw.vitals.cadence == 3 then
   mtw.send("play prelude")
   mtw.sent.prelude = true
   tempTimer(mtw.delay(), [[mtw.sent.prelude = false]])
   return
  end
 end
 
if (mtw.have_def("grip") or not mtw.toggles.gripping) and not mtw.need_wield then
 if mtw.inquartata and table.contains(mtw.skills, "Inquartata") and mtw.toggles.inquartataing then
  mtw.send("inq "..mtw.bashing.target)
 elseif mtw.balance.requiem and table.contains(mtw.skills, "Requiem of the Fallen") and mtw.toggles.requieming and mtw.vitals.cadence == 3 and mtw.enemy_health ~= "<red> 0-10%" and mtw.enemy_health ~= "<red> 10-25%" then
  mtw.send("play requiem "..mtw.bashing.target)
 elseif (not mtw.used.balestra) and mtw.toggles.fleching and table.contains(mtw.skills, "Balestra") and mtw.enemy_health ~= "<red> 0-10%" and mtw.enemy_health ~= "<red> 10-25%" then
  mtw.send("balestra "..mtw.bashing.target)
 elseif (not mtw.used.fleche) and mtw.toggles.fleching and mtw.enemy_health ~= "<red> 0-10%" and mtw.enemy_health ~= "<red> 10-25%" then
  mtw.send("fleche "..mtw.bashing.target)
 elseif table.contains(mtw.skills, "Bard's Canto") and mtw.toggles.cantoing and mtw.balance.canto then
  mtw.send("play bard's canto "..mtw.bashing.target)
 elseif table.contains(mtw.skills, "Balestra") and (mtw.toggles.balestrating or (mtw.enemy_health == "<red> 0-10%" and (mtw.my.area == "the Vale of Dreams" or mtw.my.area == "the edge of the Jal-Pur"))) then
  mtw.send("balestra "..mtw.bashing.target)
 elseif (not mtw.toggles.balestrating or not table.contains(mtw.skills, "Balestra")) then
  mtw.send("thrust "..mtw.bashing.target)
 end
end
end

function mtw.priest_bash()

 if mtw.need_heal then
  mtw.priest_heal()
  mtw.need_heal = false
 elseif (mtw.vitals.percent.health < 30) and (mtw.vitals.current.faith > 35) and table.contains(mtw.skills, "Desperate Prayer") and mtw.toggles.despraying then
  if table.contains(mtw.skills, "shadoweaving") then
   mtw.send("shadowcall desperate prayer")
  elseif table.contains(mtw.skills, "crusading") then
   mtw.send("warcall desperate prayer")
  elseif table.contains(mtw.skills, "bloodlore") then
   mtw.send("bloodcall desperate prayer")
  elseif table.contains(mtw.skills, "thanatology") then
   mtw.send("deathcall desperate prayer")
  end
 end

 if (mtw.have_def("grip") or not mtw.toggles.gripping) and not mtw.need_wield then
  if (mtw.vitals.percent.health < 60) and (mtw.vitals.current.faith > 30) and table.contains(mtw.skills, "Zealous Mandate") then
   mtw.send("smite "..mtw.bashing.target.." with zealous mandate")
  elseif (mtw.vitals.percent.health < 75) and (mtw.vitals.current.faith > 35) and table.contains(mtw.skills, "Revitalization") and mtw.defenses.def_revitalization.state == "down" and mtw.toggles.revitalizing then
   mtw.send("pray for revitalization")
  elseif (mtw.vitals.percent.health < 75) and (mtw.vitals.current.faith > 30) and table.contains(mtw.skills, "Zealous Mandate") then
   mtw.send("smite "..mtw.bashing.target.." with zealous mandate")
  elseif (mtw.vitals.percent.health < 60) and not table.contains(mtw.skills, "Pyromaniac") then
   mtw.ally = nil
   mtw.priest_heal()
  elseif (not mtw.used.heretic) and mtw.toggles.hereticing and (mtw.vitals.current.faith > 100) and mtw.enemy_health ~= "<red> 0-10%" and mtw.enemy_health ~= "<red> 10-25%" then
   mtw.send("smite "..mtw.bashing.target.." with heresy")
  elseif (not mtw.used.savage) and mtw.toggles.savaging and table.contains(mtw.skills, "Savage") then
   mtw.send("bloodcall savage "..mtw.bashing.target)
  elseif mtw.my.area == "an Imp Cave" and table.contains(mtw.skills, "Exorcism") then
   mtw.send("deathcall exorcism "..mtw.bashing.target)
  elseif mtw.vitals.current.faith > 100 and table.contains(mtw.skills, "Torturous Whip") and mtw.toggles.lashing then
   mtw.send("shadowcall lash "..mtw.bashing.target)
  elseif mtw.vitals.current.faith > 100 and table.contains(mtw.skills, "Knife of Woe") and mtw.toggles.knifing and (bleeding_state == true or mtw.used.savage) then
   mtw.send("bloodcall knife "..mtw.bashing.target)
  elseif mtw.vitals.current.faith > 100 and table.contains(mtw.skills, "Divinestrike") and mtw.toggles.divinestriking then
   mtw.send("castigate divinestrike "..mtw.bashing.target)
  elseif mtw.vitals.current.faith > 200 and mtw.toggles.swording and table.contains(mtw.skills, "Holy Sword") and mtw.enemy_health ~= "<red> 0-10%" then
   mtw.send("smite "..mtw.bashing.target.." with holy sword")
  elseif mtw.vitals.current.faith > 75 and table.contains(mtw.skills, "Zealous Mandate") and mtw.toggles.mandate then
   mtw.send("smite "..mtw.bashing.target.." with zealous mandate")
  elseif (mtw.enemy_health == "<brown> UNDEAD" or mtw.my.area == "a crypt in the Highlands") and table.contains(mtw.skills, "Holy Fire") then
   mtw.send("smite "..mtw.bashing.target.." with holy fire")
  else
   mtw.send("smite "..mtw.bashing.target.." with fury")
  end
 end
end 
function mtw.priest_heal()
 if mtw.ally == nil then
  mtw.send("pray for healing")
 else
  mtw.send("pray for healing of "..mtw.ally)
  mtw.ally = nil
 end
end

