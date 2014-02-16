-- MTW: code to pick the right option between default or user-defined one

function mtw_struct.set_metatable_custom(table)
 local mt = {
  __index = function(t,k)
   if mtw.unset[table] and mtw.unset[table][k] then
    return nil
   elseif mtw.custom[table] and mtw.custom[table][k] then
    return mtw.custom[table][k]
   elseif mtw.default[table] and mtw.default[table][k] then
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
  end,
 }
 setmetatable(table,mt)
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
 setmetatable(table,mt)
end
