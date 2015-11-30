-- MTW: load bashing targets


function mtw.load_targets(area)
 mtw.my.area = area
 mtw.area_found = false
 mtw.possible_targets = {}
 mtw.possible_items = {}
 if mtw.areas[area] then
   mtw.area_found = true
   mtw.bashing.target_type = "long"
   for i,v in ipairs(mtw.areas.generic.targets) do
    table.insert(mtw.possible_targets, v)
   end
   for i,v in ipairs(mtw.areas[area].targets) do
    table.insert(mtw.possible_targets, v)
   end
   if mtw.areas[area].level then
    echo("\n Level Range: "..mtw.areas[area].level)
   end
   cecho("\n<green>Possible Targets:")
   for h in ipairs(mtw.possible_targets) do
    echo("\n "..mtw.possible_targets[h])
   end
   mtw.possible_items = {}
   if mtw.areas[area].items then
    for i,v in ipairs(mtw.areas[area].items) do
     table.insert(mtw.possible_items, v)
    end
   end 
   for i,v in ipairs(mtw.areas.generic.items) do
    table.insert(mtw.possible_items, v)
   end
   if #mtw.possible_items > 0 then
    cecho("\n<green>Gathering Items:")
    for k in ipairs(mtw.possible_items) do
     echo("\n "..mtw.possible_items[k])
    end
   end
 else
  cecho("\n<green>Unknown Area.")
 end
end
