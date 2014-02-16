-- MTW: handling backward compatibility

function mtw.legacy()

 cecho("\n<yellow> Handling backward compatibility ...")

 -- matawa 9.4 and 9.5 - options saved in Mudlet profile
 cecho("\nFetching saved options from matawa 9.4 and 9.5...")
 local custom_opts = {}
 local tables_94_95 = {
  options = "options",
  toggles = "toggles",
  fishing = "fishing",
  def_options = "def_options",
 }
 local get_dir_95 = getMudletHomeDir() ..mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
 local get_dir_94 = getMudletHomeDir() ..mtw_struct.sep
 for k,v in pairs(tables_94_95) do
  tab = {}
  if lfs.attributes(get_dir_95 .. v) then
   pcall(table.load, get_dir_95 .. v, tab)
   os.remove(get_dir_95 .. v)
  elseif lfs.attributes(get_dir_94 .. v) then
   pcall(table.load, get_dir_94 .. v, tab)
   os.remove(get_dir_94 .. v)
  end
  custom_opts[k] = tab
 end
 tables_94_95 = {
  attack_times = "times",
  crits = "crits",
 }
 local saved_values = {}
 for k,v in pairs(tables_94_95) do
  tab = {}
  if lfs.attributes(get_dir_95 .. v) then
   pcall(table.load, get_dir_95 .. v, tab)
   os.remove(get_dir_95 .. v)
  elseif lfs.attributes(get_dir_94 .. v) then
   pcall(table.load, get_dir_94 .. v, tab)
   os.remove(get_dir_94 .. v)
  end
  saved_values[k] = tab
 end
 local save_dir = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep
 if not lfs.attributes(save_dir) then
  lfs.mkdir(save_dir)
 end
 table.save(save_dir .. "custom", custom_opts) -- settable
 table.save(save_dir .. "saved", saved_values) -- non settable
 cecho(" <green>Done!")

 -- to not load it repeatedly
 os.remove(mtw_struct.get_matawa_file("legacy.lua")) 
end

