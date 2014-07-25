-- MTW: code to pick the right option between default or user-defined one

function mtw_struct.set_metatable_custom(table)
 local mt = {
  __index = function(t,k)
   if mtw.unset[table] and mtw.unset[table][k] then
    return nil
   elseif mtw.custom[table] and (not (mtw.custom[table][k] == nil)) then
    return mtw.custom[table][k]
   elseif mtw.default[table] and (not (mtw.default[table][k] == nil)) then
    return mtw.default[table][k]
   else
    return nil
   end
  end,
  __newindex = function (t,k,v)
   if v == nil then
    mtw.unset[table] = mtw.unset[table] or {}
    mtw.unset[table][k] = true
    mtw.custom[table] = mtw.custom[table] or {}
    mtw.custom[table][k] = nil
   else
    mtw.unset[table] = mtw.unset[table] or {}
    mtw.unset[table][k] = nil
    mtw.custom[table] = mtw.custom[table] or {}
    mtw.custom[table][k] = v
   end
   mtw.save_options(true)
  end,
  __mod = function(t,k) --that function will be used to reset a value to its default (mtw.area % "Elvandar" would reset mtw.area["Elvandar"] to its default value, written in the code)
   mtw.unset[table] = mtw.unset[table] or {}
   mtw.unset[table][k] = nil
   mtw.custom[table] = mtw.custom[table] or {}
   mtw.custom[table][k] = nil
   return nil
  end,
 }
 mtw[table] = {}
 setmetatable(mtw[table],mt)
end

function mtw_struct.set_metatable_saved(table)
 local mt = {
  __index = function(t,k)
   if mtw.saved[table] then
    return mtw.saved[table][k]
   else
    return nil
   end
  end,
  __newindex = function(t,k,v)
   if not mtw.saved[table] then
    mtw.saved[table] = {}
   end
   mtw.saved[table][k] = v
  end
 }
 mtw[table] = mtw[table] or {}
 setmetatable(mtw[table],mt)
end

function mtw.reset_table(table,v)
 local reset = table % v --only works when there is the appropriate metatable set
end

function mtw.pairs(table)
 if mtw.default[table] then
  local tab = {}
  if mtw.custom[table] then
  for k,v in pairs(mtw.custom[table]) do
   tab[k] = v
  end
  end
  for k,v in pairs(mtw.default[table]) do
   if not ((mtw.custom[table] and mtw.custom[table][k]) or (mtw.unset[table] and mtw.unset[table][k])) then
    tab[k] = v
   end
  end
  return pairs(tab)
 end
end

function mtw.ipairs(table)
 if mtw.default[table] then
  local tab = {}
  if mtw.custom[table] then
  for k,v in pairs(mtw.custom[table]) do
   tab[k] = v
  end
  end
  for k,v in pairs(mtw.default[table]) do
   if not ((mtw.custom[table] and mtw.custom[table][k]) or (mtw.unset[table] and mtw.unset[table][k])) then
    tab[k] = v
   end
  end
  return ipairs(tab)
 end
end
