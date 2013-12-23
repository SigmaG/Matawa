-- MTW : attacking functions

--tracking


--Run on first person telegraphs
function mtw.attack_start(hitting, curattk)
 if not string.find(curattk, "atk_") then
  curattk = "atk_"..curattk
 end
--Clear any outstanding attacks by you, if not a soldier
 if mtw.my.class ~= "soldier" then
  for i in pairs(mtw.attacks) do
   mtw.attack_end(i)
  end
 end
--Set some data in attacks table for the current attack
 mtw.attacks[curattk]["hitting_with"] = true
 mtw.attacks[curattk]["targeting"] = hitting
--Check if attack consumed offhand balance
 if mtw.my.class == "soldier" and table.contains(mtw.skills, "swordmastery") and (string.find(curattk, "burst") or string.find(curattk, "wisplight")) then
  mtw.balance_lose("offhand")
  tempTimer(20, [[if mtw.afflictions.aff_blackout.state ~= "healed" then mtw.balance.offhand = true end]])
 end
--Replace line with outgoing attack echo, if necessary
 if mtw.toggles.atkecho then
  deleteLine()
  cecho("<magenta>\nYou: START "..curattk.." "..hitting.."!")
  if demonnic ~= nil then
   if demonnic.chat.windows["Combat"] ~= nil then
    demonnic.chat.windows["Combat"]:cecho("<magenta>\nYou: START "..curattk.." "..hitting.."!")
   end
  end
 end
--Start outgoing attack timer
 startStopWatch(mtw.attacks[curattk].timer)
--Remove blackout, since outgoing attacks don't display while under it
 mtw.aff_remove("blackout")
--Store who's attacking who for future reference
  mtw.people[mtw.my.name] = hitting
end

--Run on outgoing attack misses
function mtw.attack_miss(hitting, curattk)
 if not string.find(curattk, "atk_") then
  curattk = "atk_"..curattk
 end
--Make sure you started the attack, to work around generic miss lines
 if mtw.attacks[curattk]["hitting_with"] or mtw.attacks[curattk].def == "instant" then
--Replace line with outgoing attack echo, if necessary
  if mtw.toggles.atkecho then
   deleteLine()
   cecho("<magenta>\nYou: <red>MISS <magenta>"..curattk.." "..hitting.."!")
   if demonnic ~= nil then
    if demonnic.chat.windows["Combat"] ~= nil then
     demonnic.chat.windows["Combat"]:cecho("<magenta>\nYou: <red>MISS <magenta>"..curattk.." "..hitting.."!")
    end
   end
  end
  if curattk ~= "barrage" then
   mtw.my_time = stopStopWatch(mtw.attacks[curattk].timer)-getNetworkLatency()
   echo(" "..mtw.my_time)
   resetStopWatch(mtw.attacks[curattk].timer)
  end
 end
 mtw.attack_end(curattk)
end

--Run on outgoing attack successful hits
function mtw.attack_hit(hitting, curattk, weapon)
 if not string.find(curattk, "atk_") then
  curattk = "atk_"..curattk
 end
 if curattk:find("burst",1,true) or curattk:find("wisp",1,true) then
  mtw.balance_lose("offhand")
 end
 if mtw.attacks[curattk]["hitting_with"] or mtw.attacks[curattk].def == "instant" then
--Replace line with outgoing attack echo, if necessary
  if mtw.toggles.atkecho then
   deleteLine()
   cecho("<magenta>\nYou: <green>HIT <magenta>"..curattk.." "..hitting.."!")
   if demonnic ~= nil then
    if demonnic.chat.windows["Combat"] ~= nil then
     demonnic.chat.windows["Combat"]:cecho("<magenta>\nYou: <green>HIT <magenta>"..curattk.." "..hitting.."!")
    end
   end
  end
--Display any afflictions given, if necessary
  if mtw.toggles.affdisplay then
   cecho("<magenta> <")
   echo(mtw.attacks[curattk].aff)
   if mtw.attacks[curattk].aff_def ~= nil then
    echo(" "..mtw.attacks[curattk].aff_def)
   end
--Display poisons given by rogues, too
   if mtw.my.class == "rogue" and mtw.my.rogue_weapon ~= nil and not string.find(hitting, " ") and curattk ~= "atk_balestra" and curattk ~= "atk_disarm" and curattk ~= "atk_glint" and curattk ~= "atk_backhand" then
    for i in pairs(mtw.poisons) do
     if string.find(weapon, i) or (string.find(weapon, "poniard") and i == "dagger") then
      if mtw.poison_affs[mtw.poisons[i][1]] ~= nil then
       setItalics(true)
       echo(" "..mtw.poison_affs[mtw.poisons[i][1]])
       resetFormat()
       table.remove(mtw.poisons[i], 1)
      end
     end
    end 
   end
   cecho("<magenta>>")
  end
  mtw.my_time = stopStopWatch(mtw.attacks[curattk].timer)-getNetworkLatency()
  echo(" "..mtw.my_time)
  resetStopWatch(mtw.attacks[curattk].timer)
 end
 if mtw.vitals.adrenaline == -1 then
  mtw.vitals.adrenaline = 10
 end
 mtw.attack_end(curattk)
end

function mtw.attack_defend(hitting, weapon, curattk, defense)
 if not string.find(curattk, "atk_") then
  curattk = "atk_"..curattk
 end
 for i in pairs(mtw.first_defendings) do
  if string.find(defense, mtw.first_defendings[i]) then
   if mtw.attacks[curattk]["hitting_with"] then
    if mtw.toggles.atkecho then
     deleteLine()
     cecho("<magenta>\nYou: <red>FAIL <magenta>"..curattk.." "..hitting.."!")
     if demonnic ~= nil then
      if demonnic.chat.windows["Combat"] ~= nil then
       demonnic.chat.windows["Combat"]:cecho("<magenta>\nYou: <red>FAIL <magenta>"..curattk.." "..hitting.."!")
      end
     end
    end
    if mtw.attacks[curattk].aff_def ~= nil or mtw.have_def("vileblade") then
     if mtw.toggles.affdisplay then
      cecho("<magenta> <")
      if mtw.attacks[curattk].aff_def ~= nil then
       echo(mtw.attacks[curattk].aff_def)
      end
      if mtw.have_def("vileblade") and mtw.my.class == "rogue" and mtw.my.rogue_weapon ~= nil and not string.find(hitting, " ") and curattk ~= "atk_balestra" and curattk ~= "atk_disarm" and curattk ~= "atk_glint" then
       for i in pairs(mtw.poisons) do
        if string.find(weapon, i) or (string.find(weapon, "poniard") and i == "dagger") then
         if mtw.poison_affs[mtw.poisons[i][1]] ~= nil then
          setItalics(true)
          echo(mtw.poison_affs[mtw.poisons[i][1]])
          resetFormat()
          table.remove(mtw.poisons[i], 1)
          mtw.def_remove("vileblade")
         end
        end
       end 
      end
      cecho("<magenta>>")
     end
    end
    mtw.my_time = stopStopWatch(mtw.attacks[curattk].timer)-getNetworkLatency()
    echo(" "..mtw.my_time)
    resetStopWatch(mtw.attacks[curattk].timer)
   end
   mtw.attack_end(curattk)
   mtw.first_defended(hitting, string.upper(i))
  end
 end
 if mtw.vitals.adrenaline == -1 then
  mtw.vitals.adrenaline = 10
 end
end

function mtw.attack_end(curattk)
 mtw.attacks[curattk]["hitting_with"] = false
 mtw.attacks[curattk]["targeting"] = "none"
end

function mtw.first_defended(hitting, defense)
 if mtw.toggles.atkecho then
  deleteLine()
  cecho("<magenta>\n"..hitting..": <red>"..defense.." <magenta>you!")
  if demonnic ~= nil then
   if demonnic.chat.windows["Combat"] ~= nil then
    demonnic.chat.windows["Combat"]:cecho("<magenta>\n"..hitting..": <red>"..defense.." <magenta>you!")
   end
  end
 end
 for i in pairs(mtw.attacks) do
  mtw.attack_end(i)
 end
end


--defended

mtw.first_defendings = {
dodge = "(.*) twirls to the side, partially dodging your attack.",
duck = "(.*) partially ducks under your attack.",
jump = "(.*) leaps away, avoiding the full brunt of your aggression.",
parry = "Your attack is deftly parried by (.*).",
block = "(.*) skillfully blocks, mitigating the full assault.",
repulse = "Your attack is strategically repulsed by (.*).",
shield = "A scintillating shield of light blossoms before (.*), protecting (.*).",
warlord = "With preternatural grace, (.*) darts fluidly to one side.",
perfect = "(.*) whirls around in a blur of motion, (.*) perfect defense impossible to penetrate."
}
