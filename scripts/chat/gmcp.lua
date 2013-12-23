-- MTW : gmcp functions for chat window

function demonnic_rilist()
  local list = gmcp.Char.Items.List
  if list.location == "room" then
    demonnic.roomItems = {}
    for _,v in ipairs(list.items) do
      if not demonnic.roomItems[v.name] then demonnic.roomItems[v.name] = {} end
      table.insert(demonnic.roomItems[v.name], v.id)
    end
  end
  if list.location == "inv" then
    return
  end
end

function demonnic_riadd()
  local item = gmcp.Char.Items.Add
  if item.location == "room" then 
    item = item.item 
    if not demonnic.roomItems[item.name] then demonnic.roomItems[item.name] = {} end
    table.insert(demonnic.roomItems[item.name], item.id)
  end
end

function demonnic_rileave()
  local item = gmcp.Char.Items.Remove
  if item.location == "room" then
    for name,items in pairs(demonnic.roomItems) do
      for i,id in ipairs(items) do
        if id == tostring(item.item) then
          table.remove(demonnic.roomItems[name],i) 
          if #demonnic.roomItems[name] == 0 then
            demonnic.roomItems[name] = nil
          end
        end
      end
    end
  end
end

function demonnic_skillGroups()
  demonnic.skills = {}
  for _,extra in ipairs(gmcp.Char.Skills.Groups) do
    skillstring = string.format("Char.Skills.Get %s", yajl.to_string({group=extra.name}))
    sendGMCP(skillstring)
  end
  send("\n")
end

function demonnic_skillsList()
  local group = gmcp.Char.Skills.List.group
  local list = gmcp.Char.Skills.List.list
  if group then
    if not demonnic.skills then demonnic.skills = {} end
    demonnic.skills[group] = list
    raiseEvent("demonnicSkillFilled", group)
  end
end

gmod.registerUser("Demonnic")
gmod.enableModule("Demonnic", "IRE.Rift")
