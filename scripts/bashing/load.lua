-- MTW: load bashing targets


function mtw.load_targets(area)
 mtw.my.area = area
 mtw.area_found = false
 mtw.possible_targets = {}
 mtw.possible_items = {}
 for i in ipairs(mtw.areas) do
  if mtw.areas[i].area == area then
   mtw.area_found = true
   mtw.bashing.target_type = "long"
   mtw.possible_targets = mtw.areas[i].targets
--   table.insert(mtw.possible_targets, 1, "an ethereal mana wyrm")
   echo("\n Level Range: "..mtw.areas[i].level)
   cecho("\n<green>Possible Targets:")
   for h in ipairs(mtw.possible_targets) do
    echo("\n "..mtw.possible_targets[h])
   end
   if mtw.areas[i].items then
    mtw.possible_items = mtw.areas[i].items
   end
--   table.insert(mtw.possible_items, "a mote of glowing%, blue mana")
   if mtw.areas[i].items then
    mtw.possible_items = mtw.areas[i].items
    cecho("\n<green>Gathering Items:")
    for k in ipairs(mtw.possible_items) do
     echo("\n "..mtw.possible_items[k])
    end
   end
  end
 end
 if not mtw.area_found then
  cecho("\n<green>Unknown Area.")
 end
end
