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
 local b = true
 for _,k in ipairs(opt) do
  if not mtw.options[k] then
   b = false
   local s = string.format("\nOption <red>%s<white> not set. Use <green>?set option %s [%s id]<white> to set it, or <green>?set option %s -<white> if you don't want it set.",k,k,k,k)
   cecho(s)
  else
   local s = string.format("\nOption <red>%s<white> = <red>%s<white>.", k, mtw.options[k])
   cecho(s)
  end
 end
 cecho("\n<green>?set option [option] [id]<white> lets you reset the options")
 return b
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
 local b = mtw.check_options()
 if not b then
  cecho("\n<green>?set option [name] [id]<white> to reset")
 end
end