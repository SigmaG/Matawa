-- MTW: turnins function

function mtw.do_turnin()
 if gmcp.Room.Info.num == 4718 and not table.contains(mtw.skills, "demonology") then
--  send("give imp to tracker", false)
 elseif gmcp.Room.Info.num == 6009 then
  send("give ore to galdur", false)
 elseif gmcp.Room.Info.num == 9139 then
  send("give draugr to foreman", false)
 end
end
