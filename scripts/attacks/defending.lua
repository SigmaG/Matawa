-- MTW: defending functions

-- on telegraph

--Warn of incoming insta kills with conditions already met
function mtw.atk_kill(attacker, attack)
 cecho("<blue>\n*************************************************")
 cecho("<red>\n"..attacker.." will succeed "..attack.." on you!")
 cecho("<blue>\n*************************************************")
end

--Run on telegraphs of incoming attacks
function mtw.atk_start(attacker, weapon, attack)
-- We don't want of a nil attacker, prevents the function from bugging, and makes it easier to spot what attacks do that.
 if attacker == nil then
  attacker = "GENERIC"
 end
--Display attack echo
 if mtw.toggles.defecho then
  deleteLine()
  cecho("<purple>\n"..attacker..": START "..attack.." you!")
  if mtw.my.name == "Ged" then
   cecho("<purple>\n"..attacker..": START "..attack.." you!")
  end
 end
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
 mtw.enemy.attack = attack
 mtw.enemy.attacker = attacker
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
--But modify it by personal speed, to be slightly more accurate
  if mtw.attack_times[attacker]["speed"] ~= nil then
   mtw.defending.delay = mtw.defending.delay - mtw.attack_times[attacker]["speed"];
  end
 end
--Check if the attacker is anachronized, adjust defense delays accordingly
 for z in pairs(mtw.anachronized) do
  if attacker == mtw.anachronized[z] then
   mtw.defending.delay = math.floor(mtw.defending.delay/2)
  end
 end
 if attack == "atk_shield_smash" then
  mtw.defending.delay = 0
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
 mtw.aff_remove("blackout")
--Store who's attacking who for future reference
 mtw.people[attacker] = mtw.my.name
 if mtw.my.class == "rogue" and table.contains(mtw.skills, "Flourish") and mtw.toggles.flourishing and mtw.balance.flourish then
  mtw.set_balance("flourish "..attacker)
 end
raiseEvent("mtw.atk.start", attacker, weapon, attack)
end

--after delay

--Run after the calculated delay following an incoming attack telegraph
function mtw.atk_need(attack)
--Don't bother defending if unecessary
 if mtw.have_def("mirror_image") or mtw.have_def("refuge") or (mtw.not_aff("on_fire") and attack == "atk_immolate") then
  return
--Make sure the attack hasn't completed already
 elseif mtw.attacks[attack]["getting_hit"] then
  if mtw.attacks[attack]["attacker"] ~= nil then
--Check if you recently repulsed the attacker
   if mtw.repulsed[mtw.attacks[attack]["attacker"]] ~= nil then
--Ignore repulse was recent, defend if more than 5 seconds ago
    if getStopWatchTime(mtw.repulsed[mtw.attacks[attack]["attacker"]]) > 5 then
     mtw.attacks[attack]["defend_now"] = true
     mtw.status.defending = false
    end
   else
--If never repulsed, defend normally
    mtw.attacks[attack]["defend_now"] = true
    mtw.status.defending = false
   end
  else
--Attempt to defend attacks even when unsure who attacked
   mtw.attacks[attack]["defend_now"] = true
   mtw.status.defending = false
  end
 end
--Run the core, to make sure the defense is sent in time
 mtw.do_core()
end

--on ending

--Alert to incoming passive effects, if necessary
function mtw.atk_passive(passive, effect)
 if mtw.toggles.passecho then
  deleteLine()
  cecho("<grey>"..string.title(passive).."<red> HIT<grey> you! <red><<grey>"..effect.."<red>>")
 end
end

--Run on successful incoming attacks
function mtw.atk_hit(attacker, weapon, attack)
-- We don't want of a nil attacker, prevents the function from bugging, and makes it easier to spot what attacks do that.
 if attacker == nil then
  attacker = "GENERIC"
 end
--Make sure the attack will match the table
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Replace line with incoming attack echo, if necessary
 if mtw.toggles.defecho then
  deleteLine()
  cecho("<purple>\n"..attacker..": <red>HIT <purple>"..attack.." you!")
 end
--Display any afflictions given, if necessary
 if mtw.toggles.affdisplay then
  cecho("<purple> <")
  echo(mtw.attacks[attack].aff)
  if mtw.attacks[attack].aff_def ~= nil then
   echo(" "..mtw.attacks[attack].aff_def)
  end
  cecho("<purple>>")
 end
--Make sure to end the attack properly
 mtw.atk_end(attacker, weapon, attack)
--Check for recklessness on the next prompt, successful attacks deal damage
 if mtw.attacks[attack].class ~= "priest" then
  mtw.check.reckless = true
 end
raiseEvent("mtw.atk.hit", attacker, weapon, attack)
end

--Run on missed incoming attacks
function mtw.atk_miss(attacker, weapon, attack)
-- We don't want of a nil attacker, prevents the function from bugging, and makes it easier to spot what attacks do that.
 if attacker == nil then
  attacker = "GENERIC"
 end
--Make sure the attack will match the table
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Replace line with incoming attack echo, if necessary
 if mtw.toggles.defecho and (mtw.attacks[attack]["getting_hit"] or mtw.attacks[attack].def == "instant") then
  deleteLine()
  cecho("<purple>\n"..attacker..": <green>MISS <purple>"..attack.." you!")
 end
--Make sure to end the attack properly
 mtw.atk_end(attacker, weapon, attack)
raiseEvent("mtw.atk.miss", attacker, weapon, attack)
end

--Run on defended incoming attacks
function mtw.atk_defend(attacker, weapon, attack, defense)
--Make sure the attack will match the table
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Check that the attack was defended
 for i in pairs(mtw.defendings) do
  if string.find(defense, mtw.defendings[i]) then
--Replace line with incoming attack echo, once the defense used is found
   if mtw.toggles.defecho and (mtw.attacks[attack]["getting_hit"] or mtw.attacks[attack].def == "instant") then
    deleteLine()
    cecho("<purple>\n"..attacker..": <green>FAIL <purple>"..attack.." you!")
   end
--Check for and display any afflictions given on defending
   if mtw.attacks[attack].aff_def ~= nil then
    if mtw.toggles.affdisplay then
     cecho("<purple> <")
     echo(mtw.attacks[attack].aff_def)
     cecho("<purple>>")
    end
   end
--Make sure to end the attack properly
   mtw.atk_end(attacker, weapon, attack)
--Display a second line with the defense type used
   mtw.atk_defended(attacker, string.upper(i))
--Check for recklessness on the next prompt, defending attacks costs adrenaline
   mtw.check.reckless = true
  end
 end
raiseEvent("mtw.atk.defend", attacker, weapon, attack, defense)
end

function mtw.reset_attack(attack)
--Simply end an attack with corrupted data
 mtw.atk_ended(attack)
end

function mtw.defending_check()
--Assume attacks that take too long to land were missed, or illusions
 for i in pairs(mtw.attacks) do
  if mtw.attacks[i].getting_hit and getStopWatchTime(mtw.attack_timers[mtw.attacks[i].attacker][i]) > 5 and getStopWatchTime(mtw.attack_timers[mtw.attacks[i].attacker][i]) < 20 then
   mtw.reset_attack(i)
    cecho("<brown>\n[Resetting attack: "..i.."!]")
    send(" ")
  end
 end
end

--Properly end completed attacks
function mtw.atk_end(attacker, weapon, attack)
-- We don't want of a nil attacker, prevents the function from bugging, and makes it easier to spot what attacks do that.
 if attacker == nil then
  attacker = "GENERIC"
 end
--Make sure the attack will match the table
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Make sure the attack hasn't landed already
 if mtw.attacks[attack].getting_hit then
--Adjust for lag and capture the telegraph time
  mtw.tele_time = stopStopWatch(mtw.attack_timers[attacker][attack])-getNetworkLatency()
--Get the theoretical defending point
  mtw.default_time = mtw.attacks[attack]["delay"]-getNetworkLatency();
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
--If the telegraph hits before the default telegraph time, record the difference
    if mtw.default_time > mtw.tele_time then
     mtw.attack_times[attacker]["speed"] = mtw.default_time - mtw.tele_time;
    else
     mtw.attack_times[attacker]["speed"] = nil;
    end
   end
--Display the final telegraph time
   echo(" "..mtw.tele_time)
  end
 end
--Finish properly ending the current attack
 if attacker == nil then
  mtw.atk_ended(attack)
 elseif attack == "Someone" then
  mtw.atk_ended(attack)
 elseif mtw.attacks[attack].attacker == attacker then
  mtw.atk_ended(attack)
 end
--Remove the attacker from the repulsed list, if necessary, since a landed attack from them clears the repulse debuff
 if attacker ~= nil then
  if mtw.repulsed[attacker] ~= nil then
   for i in pairs(mtw.repulsed) do
    if i == attacker then
     table.remove(mtw.repulsed, mtw.repulsed[i])
    end
   end
  end
 end
--Clear blackout, since incoming attack lines don't display during it
 mtw.aff_remove("blackout")
end

--Properly end a completed attack, once all data is grabbed
function mtw.atk_ended(attack)
--Make sure attack will match the table
 if not string.find(attack, "atk_") then
  attack = "atk_"..attack
 end
--Clear any data about the attack left in the table
 mtw.attacks[attack]["getting_hit"] = false
 mtw.attacks[attack]["defend_now"] = false
 mtw.attacks[attack]["attacker"] = "none"
end

--Display defense types when used
function mtw.atk_defended(attacker, defense)
-- We don't want of a nil attacker, prevents the function from bugging, and makes it easier to spot what attacks do that.
 if attacker == nil then
  attacker = "GENERIC"
 end
 if mtw.toggles.defecho then
  cecho("<purple>\nYou: <green>"..defense.." <purple>"..attacker.."!")
 end
--Indicate that a defense was recently used, enabling counter attacks
 mtw.recent_defend = true
--Clear the counter attack window when it expires
 tempTimer(5, [[mtw.recent_defend = false]])
 if defense == "BLOCK" and table.contains(mtw.skills, "Shield Smash") then
  cecho("<blue>\nSHIELD SMASH NOW!!")
  cecho("<blue>\nSHIELD SMASH NOW!!")
  cecho("<blue>\nSHIELD SMASH NOW!!")
 end
--Check if the defense used was repulse
 if defense == "REPULSE" then
--Add the repulsed person to the repulsed list
  if mtw.repulsed[attacker] == nil then
   mtw.repulsed[attacker] = createStopWatch()
  else
--Reset any existing data on the repulsed person, for an accurate timer
   resetStopWatch(mtw.repulsed[attacker])
   startStopWatch(mtw.repulsed[attacker])
  end
 end
end

function mtw.do_counter()
 if mtw.recent_defend and mtw.not_aff("timewarp") and mtw.not_aff("divine_censure") then
  if mtw.toggles.killing and mtw.toggles.countering and mtw.balance.balance and not mtw.waiting.balance and mtw.not_aff("prone") and mtw.not_entangled() then
   if mtw.my.class == "soldier" and table.contains(mtw.skills, "Counter") and not counter_sent and not counterstroke then
    mtw.send("counter "..mtw.target)
    counter_sent = true
    mtw.waiting.balance = true
    tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
    tempTimer(mtw.delay(), [[counter_sent = false]])
   elseif mtw.my.class == "rogue" and table.contains(mtw.skills, "Inquartata") then
    mtw.send("inquartata "..mtw.target)
    mtw.waiting.balance = true
    tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
   end
  end
 end
  if mtw.recent_defend and mtw.not_aff("timewarp") and mtw.not_aff("divine_censure") then
  if mtw.toggles.killing and mtw.toggles.countering and mtw.not_aff("prone") and mtw.not_entangled() then
   if mtw.my.class == "soldier" and table.contains(mtw.skills, "Counter") and not counter_sent and not counterstroke then
    mtw.send("counter "..mtw.target)
    counter_sent = true
    tempTimer(mtw.delay(), [[counter_sent = false]])
   end
  end
 end
end

--defended()

mtw.defendings = {
dodge = "You twirl to the side, partially dodging (.*) attack.",
duck = "You partially duck under (.*) attack.",
jump = "You leap away, avoiding the full brunt of (.*) aggression.",
parry = "You deftly parry (.*) maneuver.",
block = "You skillfully block, mitigating (.*) full assault.",
repulse = "You strategically repulse (.*) maneuver.",
shield = "A scintillating shield of light blossoms before you, protecting you.",
warlord = "With preternatural grace, you dart fluidly to one side.",
perfect = "You whirl about in a blur of motion, your perfect defense impossible to penetrate.",
}