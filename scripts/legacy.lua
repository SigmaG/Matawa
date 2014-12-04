-- MTW: handling backward compatibility

mtw.version = { "10.0" }

function mtw.legacy()

 --get version number
 local get_v = getMudletHomeDir() .. mtw_struct.sep .. "matawa_options" .. mtw_struct.sep .. "version"
 local previous_version = nil
 local pv = {}
 if lfs.attributes(get_v) then
  pcall(table.load, get_v, pv)
  previous_version = pv[1]
 end


 if previous_version ~= mtw.version[1] then
 cecho("\n<yellow> Handling backward compatibility ...")

 if previous_version == nil then
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
 end

 cecho(" <green>Done!")


 end
end

mtw.legacy()


