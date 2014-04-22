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
   local s = string.format("\nOption <red>%s<white> not set. Use <green>!variable %s set [%s id]<white> to set it, or <green>!variable %s set -<white> if you don't want it set.",k,k,k,k)
   cecho(s)
  else
   local s = string.format("\nOption <red>%s<white> = <red>%s<white>.", k, mtw.options[k])
   cecho(s)
  end
 end
 cecho("\n<green>!variable [name] set [id]<white> to reset, <green>!variable unset [name]<white> to unset.")
 return b
end

function mtw.set_option(opt,value)
 mtw.options[opt] = value
 echo("\n"..[[Option "]]..opt..[[" set to ]].. value..".")
end

function mtw.unset_option(opt)
 mtw.options[opt] = "-"
 echo("\n"..[[Option "]]..opt..[[" unset.]])
end

function mtw.get_options()
 cecho("\n<green>Matawa options:")
 for k,v in mtw.pairs("options") do
  cecho("\n "..k..": "..v)
 end
 local b = mtw.check_options()
end