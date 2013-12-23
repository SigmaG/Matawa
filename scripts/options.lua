-- MTW: loading options

mtw.attack_times = mtw.times or {}
mtw.attack_timers = {}
if string.char(getMudletHomeDir():byte()) == "/" then
 sep = "/"
else
 sep = "\\"
end
if getMudletHomeDir()..sep.."times" ~= nil then
 local DB = getMudletHomeDir()..sep.."times"
 pcall(table.load,DB, mtw.attack_times)
end
if getMudletHomeDir()..sep.."options" ~= nil then
 local DB = getMudletHomeDir()..sep.."options"
 pcall(table.load,DB, mtw.options)
end
if getMudletHomeDir()..sep.."toggles" ~= nil then
 local DB = getMudletHomeDir()..sep.."toggles"
 pcall(table.load,DB, mtw.toggles)
end
if getMudletHomeDir()..sep.."crits" ~= nil then
 local DB = getMudletHomeDir()..sep.."crits"
 pcall(table.load,DB, mtw.crits)
end
