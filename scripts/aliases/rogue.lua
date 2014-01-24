-- MTW: rogue aliases

function mtw.al.reload_with_venom(matches)
if table.contains(mtw.skills, "Crossbows") then
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
end

function mtw.al.bard_canto(matches)
 mtw.atkbal_alias("Bard's Canto", "play bard's canto", matches[2])
end

function mtw.al.naming_of_tears(matches)
 mtw.atkbal_alias("Naming of Tears", "play naming", matches[2])
end

function mtw.al.list_allegro(matches)
for i in pairs(mtw.song_list) do
 if mtw.songs[mtw.song_list[i]].id ~= "" then
  send("bqa play allegro "..mtw.songs[mtw.song_list[i]].id)
 end
end
end

function mtw.al.load_songs(matches)
 mtw.load_songs()
end