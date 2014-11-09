--MTW: functions to track inv/vault/room with GMCP

--Note 1: this will probably freak out if you have lots of herbs in your inv, and maybe also lots of coin. I'ma fix that soon.
--Note 2: this doesn't track the items in your containers. It's def possible to do so and I've done so in the past,
--    I simply am not entirely sure of some things off the top of my head. So I need to experiment a bit before I add that.

function gmcp_inv_list()
    local home = gmcp.Char.Items.List

    --if the item isn't in your inventory then it's not an item we care about
    if home.location ~= "inv" then return end

    --this is a full list of your inventory, so any previous info we have is irrelevant
    mtw.inventory = {}

    --Record each item in our own list
    for _, thing in ipairs(home.items) do
        mtw.inventory[thing.name] = mtw.inventory[thing.name] or {}
        if thing.attrib then
            mtw.inventory[thing.name][thing.id] = thing.attrib
        else
            mtw.inventory[thing.name][thing.id] = "-"
        end
    end
end

--Sample result, if you have 2 octopi in your inventory, are wielding a steel battleaxe, and 3 steel helms one of which you are wearing:
--mtw.inventory = { 
--    ["an octopus"] = {
--        12345 = "",
--        67890 = ""
--    },
--    ["a steel battleaxe"] = {
--        345678 = "l",
--    },
--    ["a steel helm"] = {
--        2345 = "w", <-that's the one you're wearing
--        3456 = "W",
--        4567 = "W"
--    }
--}

function gmcp_inv_add()
    local home = gmcp.Char.Items.Add

    if home.location ~= "inv" then return end

    mtw.inventory = mtw.inventory or {}

    local thing = home.item
    mtw.inventory[thing.name] = mtw.inventory[thing.name] or {}
    if thing.attrib then
        mtw.inventory[thing.name][thing.id] = thing.attrib
    else
        mtw.inventory[thing.name][thing.id] = "-"
    end
end

function gmcp_inv_remove()
    local home = gmcp.Char.Items.Remove

    if home.location ~= "inv" then return end

    mtw.inventory = mtw.inventory or {}

    local thing = home.item

    if not ( mtw.inventory[thing.name] and mtw.inventory[thing.name][thing.id] ) then return end
    mtw.inventory[thing.name][thing.id] = nil
    if #(mtw.inventory[thing.name]) == 0 then
        mtw.inventory[thing.name] = nil
    end
end

function gmcp_inv_update()
    local home = gmcp.Char.Items.Update

    if home.location ~= "inv" then return end

    mtw.inventory = mtw.inventory or {}

    local thing = home.item

    mtw.inventory[thing.name] = mtw.inventory[thing.name] or {}
    mtw.inventory[thing.name][thing.id] = thing.attrib
end

function gmcp_vault_list()
    mtw.vault = {}
    for _, thing in ipairs(gmcp.IRE.Rift.List) do
        mtw.vault[thing.name] = tonumber(thing.amount)
    end
end

--Sample result if you have 3 myrrh and 4 purpleink in your vault
--mtw.vault = {
--    myrrh = 3,
--    purpleink = 4,
--}

function gmcp_vault_change()
    mtw.vault = mtw.vault or {}

    local thing, amount, desc = gmcp.IRE.Rift.Change.name, tonumber(gmcp.IRE.Rift.Change.amount), gmcp.IRE.Rift.Change.desc

    if amount == 0 then mtw.vault[thing] = nil return end

    if (not mtw.vault[thing]) or amount > mtw.vault[thing] then -- that means that some comms have been removed from inventory (there is no Char.Items.Remove message for this at the moment)
        local toremove
        if mtw.vault[thing] then toremove = amount - mtw.vault[thing] else toremove = amount end
        for k,_ in pairs(mtw.inventory[desc]) do
            mtw.inventory[desc][k] = nil
            toremove = toremove - 1
            if toremove == 0 then break end
        end
        local remaining = false
        for _,_ in pairs(mtw.inventory[desc]) do
            remaining = true
            break
        end
        if not remaining then mtw.inventory[desc] = nil end
    end

    mtw.vault[thing] = amount
end

function gmcp_room_list()
    local home = gmcp.Char.Items.List

    if home.location ~= "room" then return end

    mtw.roomitems = {}

    for _, thing in ipairs(home.items) do
        mtw.roomitems[thing.name] = mtw.roomitems[thing.name] or {}
        mtw.roomitems[thing.name][thing.id] = thing.attrib or ""
    end
    mtw.gui.update_IH()
end

--Sample result if the room has 2 bulls and 1 steel helm in the room:
--mtw.roomitems = {
--    ["a black bull"] = {
--        12345 = "m",
--        67890 = "m",
--    },
--    ["a steel helm"] = {
--        5678 = "W"
--    }
--}

function gmcp_room_add()
    local home = gmcp.Char.Items.Add

    if home.location ~= "room" then return end

    mtw.roomitems = mtw.roomitems or {}

    local thing = home.item

    mtw.roomitems[thing.name] = mtw.roomitems[thing.name] or {}
    mtw.roomitems[thing.name][thing.id] = thing.attrib or ""
    mtw.gui.update_IH()
end

function gmcp_room_remove()
    local home = gmcp.Char.Items.Remove

    if home.location ~= "room" then return end

    mtw.roomitems = mtw.roomitems or {}

    local thing = home.item

    if not ( mtw.roomitems[thing.name] and mtw.roomitems[thing.name][thing.id] ) then return end
    mtw.roomitems[thing.name][thing.id] = nil
    if table.is_empty(mtw.roomitems[thing.name]) then mtw.roomitems[thing.name] = nil end

    mtw.gui.update_IH()
end

function gmcp_room_update()
    local home = gmcp.Char.Items.Update

    if home.location ~= "room" then return end

    mtw.roomitems = mtw.roomitems or {}

    local thing = home.item

    mtw.roomitems[thing.name] = mtw.roomitems[thing.name] or {}
    mtw.roomitems[thing.name][thing.id] = thing.attrib or ""
    mtw.gui.update_IH()
end

--I wanted the first three functions to take an input in the format of either "battleaxe", "12345", or "battleaxe12345".
--Since the tables of items can only really deal with the first two formats, the first line of every function
--changes any input in the format "battleaxe12345 and makes it into "12345".

function mtw.in_inv(item)
    item = item:match("%a+(%d+)") or item
    if tonumber(item) then
        return table.contains(mtw.inventory,item)
    else
        return table.contains(mtw.inventory,item) or table.contains(mtw.inventory,"a "..item) or table.contains(mtw.inventory,"the "..item) or table.contains(mtw.inventory,"an "..item) 
    end
end

function mtw.is_wielded(item)
    if not mtw.in_inv(item) then return false end
    item = item:match("%a+(%d+)") or item

    if tonumber(item) then
        for name, table in pairs(mtw.inventory) do
            if table[item] and table[item]:match("l") then return true end
        end
    else
        local it = item
        if not (mtw.inventory[item]) then
            if mtw.inventory["a "..item] then
                it = "a "..item
            elseif mtw.inventory["an "..item] then
                it = "an "..item
            elseif mtw.inventory["the "..item] then
                it = "the "..item
            end
        end
        for id, attrib in pairs(mtw.inventory[it]) do
            if attrib:match("l") then return true end
        end
    end
    return false
end

function mtw.in_room(item)
    item = item:match("%a+(%d+)") or item
    if tonumber(item) then
        return table.contains(mtw.roomitems,item)
    else
        return table.contains(mtw.roomitems,item) or table.contains(mtw.roomitems,"a "..item) or table.contains(mtw.roomitems,"the "..item) or table.contains(mtw.roomitems,"an "..item) 
    end
end

function mtw.in_vault(item, amount)
    amount = amount or 1
    return mtw.vault[item] and mtw.vault[item] > amount
end

function item_tracking_init()
    tempTimer(5, [[item_tracking_init_2()]])
end

function item_tracking_init_2()
    if gmcp.Char and gmcp.Char.Status then
     gmod.enableModule(gmcp.Char.Status.name,"IRE.Rift")
     sendGMCP("Char.Items.Inv")
     sendGMCP("IRE.Rift.Request")
     send(" ")
    end
end
