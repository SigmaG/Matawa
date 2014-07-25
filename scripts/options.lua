-- MTW: loading options

function mtw.option_list()
return {
 custom = "custom",
 unset = "unset",
 saved = "saved",
}
end

function mtw.load_options()
mtw.attack_timers = {}
local get_dir = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
local to_load = mtw.option_list()
local tab = {}
for k,v in pairs(to_load) do
 tab = {}
 local DB = get_dir .. v
 if lfs.attributes(DB) then
  pcall(table.load, DB, tab)
 end
 mtw[k] = tab
end
end

function mtw.save_options(donotprint)
if not donotprint then
cecho("<green>\nSaving Options...")
end
local save_dir = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
if not lfs.attributes(save_dir) then
 lfs.mkdir(save_dir)
end
local to_save = mtw.option_list()
for k,v in pairs(to_save) do
 table.save(save_dir .. v, mtw[k])
end
table.save(save_dir .. "version", mtw.version)
if not donotprint then
cecho("<green> Done!")
end
end

if not mtw_struct.reloading then
 mtw.load_options()
end
