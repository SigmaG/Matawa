-- MTW: healing aliases

function mtw.toggle_defense(matches)
if not string.find(matches[2], "def_") then
 matches[2] = "def_"..matches[2]
end
for i in pairs(mtw.defenses) do
 if string.find(i, matches[2]) then
  if mtw.defenses[i].needit then
   mtw.defenses[i].needit = false
   echo("No longer keeping "..i)
   send(" ")
  else
   mtw.defenses[i].needit = true
   echo("Now keeping "..i)
   send(" ")
  end
  return
 end
end
end


