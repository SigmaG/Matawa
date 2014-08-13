-- MTW - provide a way to search for a given string in the lua files

function mtw.search_element(filename, str)
 if filename:sub(-1) == "." then
  return
 end
 if lfs.attributes(filename, "mode") == "file" then
  mtw.search_file(filename, str)
 else
  for file in lfs.dir(filename) do
   mtw.search_element(filename .."/".. file, str)
  end
 end
end

function mtw.search_file(file, str)
 local f = io.open(file, "r")
 local n = 0
 for l in f:lines() do
  n = n + 1
  if l:match(str) then
   cecho("<yellow>"..file..":"..n.." <white>"..l:gsub("("..str..")", "<red>%1<white>"))
  end
 end
 f:close()
end

function mtw.search_code(str) 
 if mtw_struct.folder ~= "xml" then
  mtw.search_element(mtw_struct.folder, str)
  cecho("<white>You can also search through aliases and triggers with Mudlet editor.\n")
 else
  cecho("<yellow>Everything can be found with the Mudlet editor, using the Search function.\n")
 end
end