-- MTW: mage aliases

function mtw.al.compulsion(matches)
 if matches[2] == "" then
  mtw.set_balance("cast compulsion "..mtw.target)
 else
  mtw.set_balance("compel "..mtw.target..matches[2])
 end
end

function mtw.al.scry(matches)
if mtw.my.class == "magician" then
 mtw.set_balance("cast scry "..matches[2])
else
 send(matches[1])
end
for h in pairs(mtw.scry) do
 mtw.scry[h] = "none"
end
end

function mtw.al.teleport(matches)
if mtw.defenses.def_spellshield.needit then
 mtw.defenses.def_spellshield.needit = false
 echo("No longer keeping spellshield")
 send(" ")
end
mtw.set_balance("cast teleport "..matches[2])
end

function mtw.al.scry_announce(matches)
if mtw.my.class == "magician" then
 mtw.scry.target = matches[2]
 mtw.scry.call = matches[3]
 mtw.set_balance("cast scry "..matches[2])
end
end

--[[
function mtw.gale_alias(matches)
if mtw.my.class == "magician" then
 if matches[3] == "" then
  mtw.set_balance("cast gale "..mtw.target.." "..matches[2])
 else
  mtw.set_balance("cast gale "..matches[3].." "..matches[2])
 end
end
end

function mtw.wild_hunt_alias(matches)
 mtw.atkbal("Wild Hunt", "demoncall hunt", matches[2])
end

function mtw.summon_alias(matches)
if table.contains(mtw.skills, "demonology") then
 if matches[2] == "lurker" or "battle demon" or "demon lord" then
  set_send("vout heartstone")
 end
 mtw.set_balance("summon "..matches[2])
end
end

function mtw.order_demon_attack(matches)
if matches[2] == nil then
 send("order demon attack "..mtw.target)
else
 send("order demon attack "..matches[2])
end
end

function mtw.blood_command_attack(matches)
 mtw.atkbal_alias("Blood command", "blood command demon attack", matches[2])
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

--]]