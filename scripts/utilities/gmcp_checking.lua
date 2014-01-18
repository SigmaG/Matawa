-- MTW: checks if GMCP is enabled by looking at the profile scripts.

function mtw.gmcp_enabled()
 local path = getMudletHomeDir() .."/current"
 local most_recent, mr_time, file
 mr_time = 0
 for file in lfs.dir(path) do
  if file ~= "." and file ~= ".." then
   local f = path .. "/" .. file
   local attr = lfs.attributes(f)
   assert (type(attr) == "table")
   if attr.mode ~= "directory" then
    local time = attr.modification
    if time > mr_time then
     most_recent = f
     mr_time = time
    end
   end
  end
 end
 print(most_recent)
 local f = io.open(most_recent, "r")
 local t = f:read("*all")
 f:close()
 local b = string.find(t,[[mEnableGMCP="yes"]])
 if not b then
  return false
 else
  return true
 end
end
