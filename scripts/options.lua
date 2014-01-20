-- MTW: loading options

function mtw.option_list()
return {
 attack_times = "times",
 options = "options",
 toggles = "toggles",
 crits = "crits",
 fishing = "fishing",
}
end

function mtw.load_options()
mtw.attack_timers = {}
local sep = mtw_struct.sep
local get_dir_1 = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
local get_dir_2 = getMudletHomeDir() .. mtw_struct.sep -- compatibility with matawa < 9.5
local to_load = mtw.option_list()
local tab = {}
for k,v in pairs(to_load) do
 tab = {}
 local DB = get_dir_1 .. v
 if lfs.attributes(DB) then
  pcall(table.load, DB, tab)
 else
  pcall(table.load, get_dir_2 .. v, tab)
 end
 if mtw[k] then
  for k2,v2 in pairs(mtw[k]) do
   if tab[k2] == nil then
    tab[k2] = v2
   end
  end
 end
 mtw[k] = tab
end
end

function mtw.save_options()
cecho("<green>\nSaving Options...")
local save_dir = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
if not lfs.attributes(save_dir) then
 lfs.mkdir(save_dir)
end
local to_save = mtw.option_list()
for k,v in pairs(to_save) do
 table.save(save_dir .. v, mtw[k])
end
cecho("<green> Done!")
end

if not mtw_struct.reloading then
 mtw.load_options()
end