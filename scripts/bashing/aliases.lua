-- MTW: bashing aliases

function mtw.start_bashing()
mtw.toggles.bashing = true
cecho("<green>Bashing ON!")
send(" ")
mtw.waiting.ih = false
mtw.do_bashing()
end

function mtw.stop_bashing()
mtw.toggles.bashing = false
mtw.inquartata = false
cecho("<green>Bashing OFF!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
if cnvrt then killTrigger(cnvrt) end
end

function mtw.load_targets_alias(matches)
mtw.possible_targets = {}
mtw.bashing.target_type = "short"
mtw.bashing.target_priority = 10000
for i in string.gmatch(matches[2], "(%w+)") do
 table.insert(mtw.possible_targets, i)
end
cecho("<green>Targets Received:")
for h in ipairs(mtw.possible_targets) do
 cecho("\n "..mtw.possible_targets[h])
end
send(" ")
end

function mtw.stop_bashing_after_next_kill()
mtw.bashing.stopping = true
cecho("<green>Bashing OFF after next kill!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
end

function mtw.hunt_pumpkins()
mtw.my.area = "pumpkins"
mtw.load_targets("pumpkins")
send(" ")
end

function mtw.hunt_wyrms()
mtw.my.area = "MoteHunt"
mtw.load_targets("MoteHunt")
send(" ")
end

function mtw.bash_one()
mtw.toggles.bashing = true
cecho("<green>Bashing ON!")
send(" ")
mtw.waiting.ih = false
mtw.do_bashing()

mtw.bashing.stopping = true
cecho("<green>Bashing OFF after next kill!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
end

function mtw.area_check_name(name)
 local s = name:gsub("^%s*(.-)%s*$", "%1")
 if s == "" then
  return mtw.my.area
 else
  return s
 end
end

function mtw.area_check_mob(mob)
 local s = mob:gsub("-","%%-")
 return s
end

function mtw.add_area(name)
 name = mtw.area_check_name(name)
 local exists = false
 for k,v in pairs(mtw.areas) do
  if v.area == name then
   b = true
   break
  end
 end
 if b then
  cecho("\n<yellow>Area "..name.." already exists!")
 else
  mtw.areas[name] = {targets = {}, items = {}}
  cecho("\n<yellow>Added area "..name)
 end
end

function mtw.add_mob_area(name,mob)
 name = mtw.area_check_name(name)
 mob = mtw.area_check_mob(mob)
 if mtw.areas[name] then
  local area = mtw.areas[name]
  local nm = tonumber(mob)
  if nm and gmcp.Char.Items.List.location == "room" then
   local b = true
   for k,v in pairs(gmcp.Char.Items.List.items) do
    if (tonumber(v.id) == nm) and (v.attrib == "m") then
     local s = mtw.area_check_mob(v.name)
     table.insert(area.targets, s)
	 cecho("\n<yellow>Mob #"..nm.." "..v.name.." added to area "..name)
     b = false
     break
    end
   end
   if b then
    cecho("\n<yellow>No mob #"..nm.." in this room! (Or, it arrived after you in the room, move out and back in to add it)")
   end
  else
   table.insert(area.targets, mob)
   cecho("\n<yellow>Mob "..mob.." added to area "..name)
  end
  mtw.areas[name] = area
  -- this is required to store it in mtw.custom instead of mtw.default
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.add_prize_area(name,prize)
 name = mtw.area_check_name(name)
 prize = mtw.area_check_mob(prize)
 if mtw.areas[name] then
  local area = mtw.areas[name]
  table.insert(area.items, prize)
  mtw.areas[name] = area
  cecho("\n<yellow>Item "..prize.." added to area "..name)
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.area_level(name,level)
 name = mtw.area_check_name(name)
 if mtw.areas[name] then
  local area = mtw.areas[name]
  area.level = level
  mtw.areas[name] = area
  cecho("\n<yellow>Area "..name.." set to level ".. level)
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.rm_area(name)
 name = mtw.area_check_name(name)
 if mtw.areas[name] then
  mtw.areas[name] = nil
  cecho("\n<yellow>Area "..name.." removed")
 else
  cecho("\n<yellow>Area "..name.." doesn't exist.")
 end
end

function mtw.rm_mob_area(name,mob)
 name = mtw.area_check_name(name)
 mob = mtw.area_check_mob(mob)
 if mtw.areas[name] then
  local area = mtw.areas[name]
  local targets = {}
  local nm = tonumber(mob)
  if nm and gmcp.Char.Items.List.location == "room" then
   local b = true
   for k,v in pairs(gmcp.Char.Items.List.items) do
    if (tonumber(v.id) == nm) and (v.attrib == "m") then
     mob = mtw.area_check_mob(v.name)
     b = false
     break
    end
   end
   if b then
    cecho("\n<yellow>No mob #"..nm.." in this room! (Or, it arrived after you in the room, move out and back in to add it)")
   end   
  end
  for k,v in pairs(area.targets) do
   if v ~= mob then
    table.insert(targets,v)
   end
  end
  area.targets = targets
  mtw.areas[name] = area
  -- this is required to store it in mtw.custom instead of mtw.default
  cecho("\n<yellow>Mob "..mob.." removed from area "..name)
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.rm_item_area(name,item)
 name = mtw.area_check_name(name)
 item = mtw.area_check_mob(item)
 if mtw.areas[name] then
  local area = mtw.areas[name]
  local items = {}
  for k,v in pairs(area.items) do
   if v ~= item then
    table.insert(items,v)
   end
  end
  area.items = items
  mtw.areas[name] = area
  -- this is required to store it in mtw.custom instead of mtw.default
  cecho("\n<yellow>Item "..item.." removed from area "..name)
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.print_area(name)
 name = mtw.area_check_name(name)
 if mtw.areas[name] then
  cecho("\nArea <green>"..name..":")
  if mtw.areas[name].level then
   cecho("\n Level <green>"..mtw.areas[name].level)
  else
   cecho("\n Unknown level")
  end
  if mtw.areas[name].targets then
   cecho("\n Possible targets:")
   for k,v in pairs(mtw.areas[name].targets) do
    cecho("\n "..k.." - "..v)
   end
  else
   cecho("\n No target known")
  end
  if mtw.areas[name].items then
   cecho("\n Items to be gathered:")
   for k,v in pairs(mtw.areas[name].items) do
    echo("\n  - "..v)
   end
  end
 else
  cecho("\n<Yellow>No such area: "..name)
 end
end

function mtw.area_sort_targets(matches)
 local name = matches[2]
 name = mtw.area_check_name(name)
 local targets = {}
 local area = mtw.areas[name]
 if area then
  local s = matches[3]:gsub("^%s*(.-)%s*$", "%1")
  matches = string.split(s," ")
  for i = 1, #matches do
   local j = tonumber(matches[i])
   table.insert(targets,area.targets[j])
  end
  area.targets = targets
  mtw.areas[name] = area
  cecho("\n<yellow>Targets sorted in area "..name..". Use <green>!area print "..name.."<yellow> to check the list.")
 else
  cecho("\n<yellow>Area "..name.." doesn't exist! <green>!area add "..name.." <yellow> to add it.")
 end
end

function mtw.area_aliases()
 cecho("\n<green>Area-related aliases")
 cecho("\n <green>!area add [name]<white> - Create a new area")
 cecho("\n <green>!area rm [name]<white> - Remove an existing area")
 cecho("\n <green>!area reset [name]<white> - Reset an area to its default value")
 cecho("\n <green>!area [name] level [range]<white> - Assign a level range to the area")
 cecho("\n <green>!area [name] addmob [mob name]<white> - Add a mob to the area")
 cecho("\n <green>!area [name] rmmob [mob name]<white> - Remove a mob from the area")
 cecho("\n <green>!area [name] additem [item name]<white> - Add an item that can be gathered in the area")
 cecho("\n <green>!area [name] rmitem [item name]<white> - Remove an item that can be gathered in the area")
 cecho("\n <green>!area print [name]<white> - Outputs the characteristics of an area")
 cecho("\n <green>!area [name] sort targets [numbers]<white> - Sort the order of the different targets of the area, uses the numbers from <green>!area print")
end

function mtw.reset_area(name)
 name = mtw.area_check_name(name)
 mtw.reset_table(mtw.areas, name)
 cecho("\n<yellow> Area "..name.." reset to its default value.")
end