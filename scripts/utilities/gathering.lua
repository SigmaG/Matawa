-- MTW: functions about gathering

function mtw.load_mining_targets(matches)
 mtw.mining.targets = {}
 if matches[2] == "all" then
  cecho("<green>Will mine any ore\n")
  return
 end
 for i in string.gmatch(matches[2], "(%w+)") do
  i = i:gsub("ore$","")
  if i == "trees" or i == "tree" then
   i = "wood"
  end
  table.insert(mtw.mining.targets, i)
 end
 cecho("<green>Will mine the following ore:")
 for _,v in ipairs(mtw.mining.targets) do
  cecho("\n "..v)
 end
 send(" ")
end

function mtw.found_ore(matches)
 if mtw.toggles.mining then
  if matches[1]:match("^You unearth") then
   deleteLine()
   cecho("\n<yellow>-----------------------")
   cecho("\n<yellow>    FOUND: "..matches[3])
   cecho("\n<yellow>-----------------------")
  else
   cecho("\n<yellow> FOUND "..matches[3].." here!")
  end
  if #(mtw.mining.targets) == 0 or table.contains(mtw.mining.targets, matches[3]) then
   mtw.mining.found = true
   mtw.mining.material = matches[3]
  else 
   cecho("\n<yellow>Not mining that! (<green>h all<yellow> or <green>h "..matches[3].."<yellow> to change it)")
  end
 end
end

function mtw.vein_depleted(matches,multimatches)
if mtw.toggles.mining then
 deleteLine()
 cecho("\n<red>-----------------------")
 cecho("\n<red>   "..matches[2].." depleted")
 cecho("\n<red>-----------------------")
 send("vin 10 "..mtw.mining.material)
 mtw.mining.found = false
 mtw.mining.material = "none"
end
end

function mtw.do_mining()
 if mtw.toggles.mining and mtw.mining.found and mtw.balance.balance and not mtw.waiting.balance and (not mtw.have_aff("prone")) then
  mtw.waiting.balance = true
  tempTimer(0.5, [[mtw.waiting.balance = false]])
  if mtw.mining.material == "trees" then
   send("chop trees")
  else
   send("mine "..mtw.mining.material)
  end
 end
end

function mtw.found_tree(matches)
 if mtw.toggles.mining then
  if matches[1]:match("^You unearth") then
   deleteLine()
   cecho("\n<yellow>-----------------------")
   cecho("\n<yellow>    FOUND: trees")
   cecho("\n<yellow>-----------------------")
  else
   cecho("\n<yellow> FOUND trees here!")
  end
  if #(mtw.mining.targets) == 0 or table.contains(mtw.mining.targets, "wood") then
   mtw.mining.found = true
   mtw.mining.material = "trees"
  else
   cecho("\n<yellow>Not chopping the trees! (<green>h all<yellow> or <green>h wood<yellow> to change that)")
  end
 end
end

function mtw.trees_depleted(matches,multimatches)
 if mtw.toggles.mining then
  deleteLine()
  cecho("\n<red>-----------------------")
  cecho("\n<red>   trees depleted")
  cecho("\n<red>-----------------------")
  send("vin 10 wood")
  mtw.mining.found = false
  mtw.mining.material = "none"
 end
end

function mtw.toggle_mining()
 if mtw.toggles.mining then
  mtw.mining.found = false
  mtw.mining.material = "none"
 end
 mtw.toggle("mining")
end
