-- MTW: looting functions

function mtw.do_loot()
 if mtw.have_items then
  if mtw.balance.balance and mtw.balance.equilibrium and not mtw.waiting.balance and not mtw.waiting.equilibrium and not mtw.need_wield and not mtw.need_offwield then
   mtw.loot_it()
   mtw.waiting.loot = true
   tempTimer(mtw.delay(), [[mtw.waiting.loot = false]])
  end
 elseif not mtw.waiting.ih and not mtw.sent.ih then
  mtw.corpses = {}
  mtw.gathering = {}
  mtw.send("ih")
  mtw.waiting.ih = true
 end
end

function mtw.loot_it()
 for i in ipairs(mtw.corpses) do
  if table.contains(mtw.skills, "Palm") and mtw.toggles.palming then
   mtw.send("palm "..mtw.corpses[i])
  else
   mtw.send("get "..mtw.corpses[i])
  end
 end
 for h in ipairs(mtw.gathering) do
  if table.contains(mtw.skills, "Palm") and mtw.toggles.palming then
   mtw.send("palm "..mtw.gathering[h])
  else
   mtw.send("get "..mtw.gathering[h])
   if string.find(mtw.gathering[h], "coins") then
    mtw.do_pack("put coins in "..mtw.options.container)
   end
  end
 end
 mtw.corpses = {}
 mtw.gathering = {}
 mtw.have_items = false
 mtw.need_loot = false
end
