function mtw.fishing_get_endurance()
 if (mtw.fishing.stat == "wait for endurance") and (tonumber(gmcp.Char.Vitals.ep) >= mtw.fishing.min_end) then
  mtw.toggles.standing = true
  mtw.fishing.stat = "baiting"
 end
end

function mtw.do_fishing()
 if mtw.vitals.loss.endurance < -11 and mtw.fishing.count < 4 then
  mtw.fishing.count = 4
 end
 if mtw.balance.balance and mtw.balance.equilibrium and (not mtw.waiting.balance) then
  if mtw.fishing.stat == "baiting" then
   send("vout "..mtw.fishing.bait, false)
   send("fishing bait with "..mtw.fishing.bait, false)
   mtw.waiting.balance = true
   tempTimer( mtw.delay(), [[mtw.waiting.balance = false]] )
  elseif mtw.fishing.stat == "casting" then
   send("fishing cast "..mtw.fishing.dir.." "..mtw.fishing.distance, false)
   mtw.fishing.count = 0
   mtw.waiting.balance = true
   tempTimer( mtw.delay(), [[mtw.waiting.balance = false]] )
  elseif mtw.fishing.stat == "teasing" then
   send("fishing tease", false)
  elseif mtw.fishing.stat == "reeling" then
   if (mtw.fishing.count > 3) and table.contains(mtw.skills, "Anachronize") and mtw.toggles.anachronizing and mtw.balance.anachronize and mtw.vitals.current.magic >= 3000 then
    send("cast anachronize",false)
   else
    send("fishing reel", false)
    mtw.fishing.count = mtw.fishing.count + 1
   end
   mtw.waiting.balance = true
   tempTimer( mtw.delay(), [[mtw.waiting.balance = false]] )
  elseif mtw.fishing.stat == "cutting" then
   send("fishing cut", false)
  elseif mtw.fishing.stat == "sitting" then
   send("sit", false)
   mtw.toggles.standing = false
   mtw.fishing.stat = "wait for endurance"
   tempTimer((mtw.fishing.min_end-mtw.vitals.current.endurance+3)/2,[[send(" ")]])
  end
 end
end