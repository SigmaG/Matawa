-- QS - code used to fetch saved options from older profiles.

function mtw.display_older_option_files()
 local fs = mtw_struct.sep
 local file
 local tab = {}
 for f in lfs.dir(getMudletHomeDir() .. fs .. ".." .. fs) do
  if not (f == ".." or f == ".") then
   f = getMudletHomeDir() .. fs .. ".." .. fs .. f
   if lfs.attributes(f, "mode") == "directory" then
    file = f .. fs .. "matawa_options"
    if lfs.attributes(file, "mode") == "directory" then
     --get version
     local get_v = file  .. fs .. "version"
     local previous_version = nil
     local pv = {}
     if lfs.attributes(get_v) then
      pcall(table.load, get_v, pv)
      previous_version = pv[1]
     end
     --get date
     local d = nil
     for f2 in lfs.dir(file) do
      d = os.date("%c", lfs.attributes(file..fs..f2, "modification"))
      if d then break end
     end
     table.insert(tab, {date = d, profile = f:gsub(".*profiles.*%.%..", ""), version = previous_version})
    end
   end
  end
 end
 if #tab > 0 then
  cecho("<green>Available matawa options:\n")
  for i,v in ipairs(tab) do
   local s = "<white>Profile: <yellow>"..v.profile.."<white> ["..v.date.."] - Matawa version: <red>"
   if v.version then
    s = s..v.version
   else
    s = s.."9.4 or 9.5"
   end
   cecho(s.."\n")
  end
  cecho("<green>!import [profile name]<white> to load the options saved in that profile.\nDon't worry if the matawa version isn't the same, it will be updated for you.")
 else
  cecho("<green>No available saved options!\n")
 end
end

function mtw.import_option_files(profile)
 local fs = mtw_struct.sep
 local file = getMudletHomeDir()..fs..".."..fs..profile
 local f = file .. fs .. "matawa_options"
 if lfs.attributes(file, "mode") ~= "directory" or lfs.attributes(f, "mode") ~= "directory" then
  cecho("\nNothing to load here!")
  return
 end
 lfs.mkdir(getMudletHomeDir()..fs.."matawa_options")
 for op in lfs.dir(getMudletHomeDir()..fs.."matawa_options") do
  if not (op == ".." or op == ".") then
   os.remove(getMudletHomeDir()..fs.."matawa_options"..fs..op)
  end
 end
 for op in lfs.dir(f) do
  if not (op == ".." or op == ".") then
   op = f .. fs .. op
   local bn = op:gsub(".*matawa_options.","")
   local f2 = io.open(op, "r")
   local s = f2:read("*a")
   f2:close()
   local f1 = io.open(getMudletHomeDir()..fs.."matawa_options"..fs..bn, "a")
   f1:write(s)
   f1:close()
  end
 end
 mtw.legacy()
 mtw.load_options()
 cecho("\nLoaded options from profile <red>"..profile)
end
