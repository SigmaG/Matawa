function mtw.check_options()
 local opt = {
  "container",
  "mount",
  "scabbard1",
  "scabbard2",
  "baldric1",
  "baldric2",
  "crossbow",
 }
 for _,k in ipairs(opt) do
  if not mtw.options[k] then
   local s = string.format("\nOption <red>%s<white> not set. Use <green>?set option %s [%s id]<white> to set it, or <green>?set option %s -<white> if you don't want it set.",k,k,k,k)
   cecho(s)
  end
 end
 cecho("\n<green>?options<white> will let you know the value of each option and how to reset them")
end

function mtw.set_option(opt,value)
 mtw.options[opt] = value
 echo("\n"..[[Option "]]..opt..[[" set to ]].. value..".")
end

function mtw.get_options()
 cecho("\n<green>Matawa options:")
 for k,v in pairs(mtw.options) do
  cecho("\n "..k..": "..v)
 end
 cecho("\n<green>?set option [name] [id]<white> to reset")
end