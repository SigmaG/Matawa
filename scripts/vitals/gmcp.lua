-- MTW: functions related to GMCP


function gmcp_vitals()

 mtw.dead = false
--Set and calculate various vital stats
 if gmcp.Char.Vitals.ap == "1000" and mtw.vitals.adrenaline == -1 then
  if mtw.not_aff("recklessness") then
   mtw.vitals.adrenaline = tonumber(gmcp.Char.Vitals.ap)/10
  end
 else
  mtw.vitals.adrenaline = tonumber(gmcp.Char.Vitals.ap)/10
 end

 mtw.vitals.current.health = tonumber(gmcp.Char.Vitals.hp)
 mtw.vitals.current.endurance = tonumber(gmcp.Char.Vitals.ep)
 mtw.vitals.max.health = tonumber(gmcp.Char.Vitals.maxhp)
 mtw.vitals.max.endurance = tonumber(gmcp.Char.Vitals.maxep)
 mtw.vitals.percent.health = math.floor((mtw.vitals.current.health/mtw.vitals.max.health)*100)
 mtw.vitals.percent.endurance = math.floor((mtw.vitals.current.endurance/mtw.vitals.max.endurance)*100)
 mtw.vitals.loss.health = mtw.vitals.current.health - mtw.vitals.old.health
 mtw.vitals.loss.endurance = mtw.vitals.current.endurance - mtw.vitals.old.endurance
 mtw.vitals.old.health = mtw.vitals.current.health
 mtw.vitals.old.endurance = mtw.vitals.current.endurance
 if mtw.my.class == "magician" or (table.contains(mtw.skills, "swordmastery")) then
  mtw.vitals.current.magic = tonumber(gmcp.Char.Vitals.mp)
  mtw.vitals.max.magic = tonumber(gmcp.Char.Vitals.maxmp)
  mtw.vitals.percent.magic = math.floor((mtw.vitals.current.magic/mtw.vitals.max.magic)*100)
  mtw.vitals.loss.magic = mtw.vitals.current.magic - mtw.vitals.old.magic
  mtw.vitals.old.magic = mtw.vitals.current.magic
 elseif mtw.my.class == "rogue" then
  mtw.vitals.current.guile = tonumber(gmcp.Char.Vitals.gp)
  mtw.vitals.max.guile = tonumber(gmcp.Char.Vitals.maxgp)
  mtw.vitals.percent.guile = math.floor((mtw.vitals.current.guile/mtw.vitals.max.guile)*100)
 elseif mtw.my.class == "priest" then
  mtw.vitals.current.faith = tonumber(gmcp.Char.Vitals.fp)
  mtw.vitals.max.faith = tonumber(gmcp.Char.Vitals.maxfp)
  mtw.vitals.percent.faith = math.floor((mtw.vitals.current.faith/mtw.vitals.max.faith)*100)
  mtw.vitals.loss.faith = mtw.vitals.current.faith - mtw.vitals.old.faith
  mtw.vitals.old.faith = mtw.vitals.current.faith
-- elseif mtw.my.class == "soldier" and (table.contains(mtw.skills, "warmongering")) then
--  mtw.vitals.current.spirit = tonumber(gmcp.Char.Vitals.sp)
--  mtw.vitals.max.spirit = tonumber(gmcp.Char.Vitals.maxsp)
--  mtw.vitals.percent.spirit = math.floor((mtw.vitals.current.spirit/mtw.vitals.max.spirit)*100)
--  mtw.vitals.loss.spirit = mtw.vitals.current.spirit - mtw.vitals.old.spirit
--  mtw.vitals.old.spirit = mtw.vitals.current.spirit
 end

 if mtw.have_aff("recklessness") and mtw.toggles.bashing then
  mtw.reckless_bashing = true
  mtw.vitals.percent.health = 75
 else
  mtw.reckless_bashing = false
 end

--Give low vitals afflictions, if necessary
 if mtw.vitals.percent.health <= 10 then
  mtw.aff_have("health_10")
 elseif mtw.vitals.percent.health <= 35 then
  mtw.aff_remove("health_10")
  mtw.aff_have("health_35")
 elseif mtw.vitals.percent.health <= 55 then
  mtw.aff_remove("health_10")
  mtw.aff_remove("health_35")
  mtw.aff_have("health_55")
 elseif mtw.vitals.percent.health <= 75 then
  mtw.aff_remove("health_10")
  mtw.aff_remove("health_35")
  mtw.aff_remove("health_55")
  mtw.aff_have("health_75")
 else
  mtw.aff_remove("health_10")
  mtw.aff_remove("health_35")
  mtw.aff_remove("health_55")
  mtw.aff_remove("health_75")
 end

 if mtw.my.class == "magician" then
  if mtw.vitals.percent.magic <= 10 then
   mtw.aff_have("magic_10")
  elseif mtw.vitals.percent.magic <= 35 then
   mtw.aff_remove("magic_10")
   mtw.aff_have("magic_35")
  elseif mtw.vitals.percent.magic <= 55 then
   mtw.aff_remove("magic_10")
   mtw.aff_remove("magic_35")
   mtw.aff_have("magic_55")
  elseif mtw.vitals.percent.magic <= 75 then
   mtw.aff_remove("magic_10")
   mtw.aff_remove("magic_35")
   mtw.aff_remove("magic_55")
   mtw.aff_have("magic_75")
  else
   mtw.aff_remove("magic_10")
   mtw.aff_remove("magic_35")
   mtw.aff_remove("magic_55")
   mtw.aff_remove("magic_75")
  end
 end

 mtw.gui.update_status_bars()

--Start running actions
 if mtw.have_slow() then

 else
  mtw.do_core()
 end
end


function gmcp_room()
--send("get candy from crib;get candy from bassinet;get candy from basket;get candy from cradle", false)
--mtw.send("stalk "..mtw.target)
--mtw.send("get chalice")

--Check current room
 if mtw.my.room ~= gmcp.Room.Info.num then
--Clear room effects
  mtw.aff_remove("timewarp")
  mtw.aff_remove("bolero")
  mtw.def_remove("prelude")
  mtw.status.combat = false
  --Remove Inquartata
  --mtw.inquartata = false
  --remove Balefire
  mtw.casted.balefire = false
--Initiate fasthunt if necessary
  mtw.need_loot = false
  mtw.toggles.bashing = false
  if mtw.toggles.fasthunt then
   mtw.new.room = true
  end
  if mtw.toggles.fastappraise then
   mtw.new.room = true
  end
--Check map if fleeing
  if mtw.fleeing then
   send("map", false)
   mtw.fleeing = false
  end
--Initiate auto turnin if necessary
  mtw.do_turnin()
--Set current room
  mtw.my.room = gmcp.Room.Info.num
 end
--Check current area
 if mtw.my.area ~= gmcp.Room.Info.area then
  if mtw.my.area ~= "MoteHunt" and mtw.my.area ~= "pumpkins" then
--Initiate new area targets, if necessary
   mtw.my.area = gmcp.Room.Info.area
--Set current area
   mtw.new.area = true
  end
 end

 mtw.gui.update_location_bar()
 player_resetIgnore()
end


function gmcp_status()

--Set character class
 if string.find(gmcp.Char.Status.class, "Soldier") then
  mtw.my.class = "soldier"
 elseif string.find(gmcp.Char.Status.class, "Rogue") then
  mtw.my.class = "rogue"
 elseif string.find(gmcp.Char.Status.class, "Magician") then
  mtw.my.class = "magician"
 elseif string.find(gmcp.Char.Status.class, "Priest") then
  mtw.my.class = "priest"
 else
  mtw.my.class = "none"
 end

--Set character name
 mtw.my.name = gmcp.Char.Status.name

 mtw.gui.update_random_boxes()
end



function gmcp_skills_groups()
  mtw.skills = {}
  for _, skillset in ipairs(gmcp.Char.Skills.Groups) do
    local name = string.lower(skillset.name)
	mtw.skills[name] = mtw.skills[name] or {}
	local table = { group = name }
    sendGMCP("Char.Skills.Get " .. yajl.to_string(table))
  end
end


function gmcp_skills_list()
  local name = gmcp.Char.Skills.List.group
  mtw.skills = mtw.skills or {}
  mtw.skills[name] = {}
  for i,v in ipairs(gmcp.Char.Skills.List.list) do
    table.insert(mtw.skills[name], i, v)
  end
end


function gmcp_players()
 if mtw.losingall then
  for i,v in ipairs(gmcp.Comm.Channel.Players) do
   if not mtw.losingall[v.name] then
    mtw.send("lose "..v.name)
   end
  end
  cecho("\n<green>Lost everyone!")
 end
end

function gmcp_players_in_room()
 mtw.gui.update_who_here()
 --work in progress below--
 in_room_players = {}
  for i, playertable in ipairs(gmcp.Room.Players) do
   in_room_players[i] = playertable.name
  end
end

function gmcp_add_player_in_room()
 mtw.remove_player(gmcp.Room.AddPlayer.name)
 table.insert(gmcp.Room.Players, gmcp.Room.AddPlayer)
 mtw.gui.update_who_here()
 --work in progress blow--
  for id,name in ipairs(in_room_players) do
    if name ~= gmcp.Room.AddPlayer then
      table.insert(in_room_players, gmcp.Room.AddPlayer.name)
      return
    end
  end
end

function gmcp_rm_player_in_room()
 mtw.remove_player(gmcp.Room.RemovePlayer)
 mtw.gui.update_who_here()
--work in progress below--
  skiproom = false
 for _, v in ipairs(in_room_players) do
  if not ignore_players[v] then
   skiproom = true
  end
 end
end

function mtw.remove_player(name)
 for k,v in pairs(gmcp.Room.Players) do
  if v.name == name then
   table.remove(gmcp.Room.Players, k)
  end
 end
--work in progress below--
 for id,name in ipairs(in_room_players) do
  if name == gmcp.Room.RemovePlayer then
   table.remove(in_room_players, id)
  end
 end
end
