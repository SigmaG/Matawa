-- MTW: load bashing targets


function mtw.load_targets(area)
 mtw.my.area = area
 mtw.area_found = false
 mtw.possible_targets = {}
 mtw.possible_items = {}
 if mtw.areas[area] then
   mtw.area_found = true
   mtw.bashing.target_type = "long"
   mtw.possible_targets = mtw.areas[area].targets
   echo("\n Level Range: "..mtw.areas[area].level)
   cecho("\n<green>Possible Targets:")
   for h in ipairs(mtw.possible_targets) do
    echo("\n "..mtw.possible_targets[h])
   end
   if mtw.areas[area].items then
    mtw.possible_items = mtw.areas[i].items
    cecho("\n<green>Gathering Items:")
    for k in ipairs(mtw.possible_items) do
     echo("\n "..mtw.possible_items[k])
    end
   end
 else
  cecho("\n<green>Unknown Area.")
 end
end
