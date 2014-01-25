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

function mtw.al.illusion(matches)
 mtw.set_balance("cast illusion "..matches[2])
end

function mtw.al.summon(matches)
 if matches[2] == "lurker" or "battle demon" or "demon lord" then
  mtw.set_send("vout heartstone")
 end
 mtw.set_balance("summon "..matches[2])
end

function mtw.al.blood_command(matches)
 mtw.set_balance("blood command "..matches[2])
end

function mtw.al.summon_pact(matches)
toggle("demon")
demon.stat = "prepare"
demon.type = matches[2]
demon.augury = false
end

function mtw.al.augury()
toggle("demon")
demon.stat = "prepare"
demon.type = "imp"
demon.augury = true
end
