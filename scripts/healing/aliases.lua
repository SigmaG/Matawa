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
   if (not mtw.defenses[i].skill or table.contains(mtw.skills, mtw.defenses[i].skill)) then
    mtw.defenses[i].needit = true
    echo("Now keeping "..i)
    send(" ")
   else
    echo("\nYou don't have the skill "..mtw.defenses[i].skill..", thus can't use the defense "..i..".")
   end
  end
  return
 end
end
end


