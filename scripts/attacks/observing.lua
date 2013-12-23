-- MTW : third person attacks

--on telegraph


function mtw.third_start(attacker, weapon, attack, tar)
 if tar ~= "you" then
--Display attack echo
  if mtw.toggles.defecho then
   deleteLine()
   echo("\n"..attacker..": START "..attack.." "..tar.."!")
  end
  if not string.find(attack, "atk_") then
   attack = "atk_"..attack
  end
  mtw.enemy.attack = attack
  mtw.enemy.attacker = attacker
  if mtw.soldier_shielding and tar == mtw.soldier_shielded then
--Reset outstanding attacks by the same attacker, if dual wield is not possible
   if mtw.attacks[attack].class ~= "soldier" then
    for i in pairs(mtw.attacks) do
     if mtw.attacks[i].attacker == attacker then
      mtw.reset_attack(i)
     end
    end
   end
--Tell the system this attack is incoming, and from who
   mtw.attacks[attack]["getting_hit"] = true
   mtw.attacks[attack]["attacker"] = attacker
  end
--Create a timer table for the attacker, if one doesn't exist
  if mtw.attack_timers[attacker] == nil then
   mtw.attack_timers[attacker] = {}
  end
--Create a line for the current attack in the attacker's timer table, if one doesn't exist
  if mtw.attack_timers[attacker][attack] == nil then
   mtw.attack_timers[attacker][attack] = createStopWatch()
   startStopWatch(mtw.attack_timers[attacker][attack])
  else
--Reset timer for attacker's current attack, if it does already exist
   resetStopWatch(mtw.attack_timers[attacker][attack])
   startStopWatch(mtw.attack_timers[attacker][attack])
  end
--Create a data table for the attack, if one doesn't exist
  if mtw.attack_times[attacker] == nil then
   mtw.attack_times[attacker] = {}
  end
--Check for stored time data for the current attack, and call it if it exists
  if mtw.attack_times[attacker][attack] ~= nil then
   mtw.defending.delay = mtw.attack_times[attacker][attack]-0.5-getNetworkLatency()
  else
--Otherwise, use the default time for the current attack
   mtw.defending.delay = mtw.attacks[attack]["delay"]-0.5-getNetworkLatency()
  end
--Check if the attacker is anachronized, adjust defense delays accordingly
  for z in pairs(mtw.anachronized) do
   if attacker == mtw.anachronized[z] then
    mtw.defending.delay = math.floor(mtw.defending.delay/2)
   end
  end
--Make sure to avoid negative delays due to lag
  if mtw.defending.delay < 0 then
   mtw.defending.delay = 0
  end
--Adjust delay to account for slowcuring's command delay, if necessary
  if mtw.have_slow() then
   if mtw.defending.delay >= 1 then
    mtw.defending.delay = mtw.defending.delay-1
   else
    mtw.defending.delay = -1
   end
  end
--Set and display the final calculated delay before defending the attack
  if mtw.defending.delay ~= -1 then
   tempTimer(mtw.defending.delay, [[mtw.atk_need(mtw.enemy.attack)]] )
  end
  echo(" "..mtw.defending.delay)
--Clear blackout, since you won't see telegraphs with it
  mtw.aff_remove("blackout")
--Store who's attacking who for future reference
  mtw.people[attacker] = tar
 end
end

--on ending


function mtw.third_hit(attacker, weapon, attack, tar)
 if tar ~= "you" then
  if mtw.toggles.defecho then
   deleteLine()
   echo("\n"..attacker..": ")
   cecho("<red>HIT ")
   echo(attack.." "..tar.."!")
  end
  mtw.third_end(attacker, weapon, attack, tar)
 end
end

function mtw.third_miss(attacker, weapon, attack, tar)
 if tar ~= "you" then
  if not string.find(attack, "atk_") then
   attack = "atk_"..attack
  end
  if mtw.toggles.defecho then
   if mtw.attacks[attack]["class"] == "soldier" then
    if mtw.attacks[attack]["getting_hit"] then
     deleteLine()
     echo("\n"..attacker..": ")
     cecho("<green>MISS ")
     echo(attack.." "..tar.."!")
    end
   else
    deleteLine()
    echo("\n"..attacker..": ")
    cecho("<green>MISS ")
    echo(attack.." "..tar.."!")
   end
  end
  mtw.third_end(attacker, weapon, attack, tar)
 end
end

function mtw.third_defend(attacker, weapon, attack, defense, tar)
 if tar ~= "you" then
  for i in pairs(mtw.third_defendings) do
   if string.find(defense, mtw.third_defendings[i]) then
    if mtw.toggles.defecho then
     deleteLine()
     echo("\n"..attacker..": ")
     cecho("<green>FAIL ")
     echo(attack.." "..tar.."!")
    end
    mtw.third_end(attacker, weapon, attack, tar)
    mtw.third_defended(attacker, string.upper(i), tar)
   end
  end
 end
end

function mtw.third_end(attacker, weapon, attack, tar)
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Adjust for lag and capture the telegraph time
 mtw.tele_time = stopStopWatch(mtw.attack_timers[attacker][attack])-getNetworkLatency()
--Reset the timer for the current attack, once time is stored
 resetStopWatch(mtw.attack_timers[attacker][attack])
--Check that the time is a reasonable, not corrupted one
 if mtw.tele_time <= 5 then
--Create a data table for the attacker if it doesn't already exist
  if mtw.attack_times[attacker] == nil then
   mtw.attack_times[attacker] = {}
  end
--Make sure the telegraph time wasn't corrupted by anachronize
  mtw.anach = false
  for z in pairs(mtw.anachronized) do
   if attacker == mtw.anachronized[z] then
    mtw.anach = true
   end
  end
  if not mtw.anach then
   mtw.attack_times[attacker][attack] = mtw.tele_time
  end
--Display the final telegraph time
  echo(" "..mtw.tele_time)
 end
 if mtw.soldier_shielding and tar == mtw.soldier_shielded then
  if attacker == nil then
   mtw.atk_ended(attack)
  elseif attacker == "Someone" then
   mtw.atk_ended(attack)
  elseif mtw.attacks[attack].attacker == attacker then
   mtw.atk_ended(attack)
  end
  if attacker ~= nil then
   if repulsed[attacker] ~= nil then
    for i in pairs(repulsed) do
     if i == attacker then
      table.remove(repulsed, repulsed[i])
     end
    end
   end
  end
 end
 mtw.aff_remove("blackout")
end

function mtw.third_defended(attacker, defense, tar)
 if mtw.toggles.defecho then
  echo("\n"..tar..": ")
  cecho("<green>"..defense)
  echo(" "..attacker.."!")
 end
end

--table


mtw.third_defendings = {
dodge = " (.*) twirls to the side, partially dodging (.*) attack.",
duck = " (.*) partially ducks under (.*) attack.",
jump = " (.*) leaps away, avoiding the full brunt of (.*) aggression.",
parry = " (.*) attack is deftly parried by (.*).",
block = " (.*) skillfully blocks, mitigating (.*) full assault.",
--repulse = "You strategically repulse (.*) maneuver.",
--shield = "A scintillating shield of light blossoms before you, protecting you.",
--perfect = 
}

--passives


function mtw.third_passive(passive, effect, tar)
 deleteLine()
 cecho("<grey>"..string.title(passive).."<red> HIT<grey> "..tar.."! <red>[<grey>"..effect.."<red>]")
end

