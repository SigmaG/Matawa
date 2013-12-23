-- MTW : loading chat scripts

--Bootstrapping variables/etc. Don't touch this unless you really know what you're doing

demonnic = demonnic or {}
demonnic.config = demonnic.config or {}
demonnic.balances = demonnic.balances or {}
demonnic.balances.balance = demonnic.balances.balance or 1
demonnic.balances.equilibrium = demonnic.balances.equilibrium or 1
demonnic.debug = demonnic.debug or {}
demonnic.debug.active = demonnic.debug.active or nil
demonnic.debug.categories = demonnic.debug.categories or { }

demonnic.chat = demonnic.chat or {}
demonnic.chat.tabsToBlink = demonnic.chat.tabsToBlink or {}
demonnic.chat.config = demonnic.chat.config or {}
demonnic.chat.tabs = demonnic.chat.tabs or {}
demonnic.chat.windows = demonnic.chat.windows or {}
demonnic.chat.config.activeColors = demonnic.chat.config.activeColors or {}
demonnic.chat.config.inactiveColors = demonnic.chat.config.inactiveColors or {}

function demonnic:echo(msg)
 cecho(string.format("\n<blue>(<green>Demonnic<blue>):<white> %s", msg))
end

mtw_struct.load_external("chat/options")
mtw_struct.load_external("chat/start")
mtw_struct.load_external("chat/align")
mtw_struct.load_external("chat/debug")
mtw_struct.load_external("chat/geyser")
mtw_struct.load_external("chat/vitals")
mtw_struct.load_external("chat/chat")
mtw_struct.load_external("chat/echo")
mtw_struct.load_external("chat/gmcp")

mtw_struct.load_external("chat/triggers")
mtw_struct.load_external("chat/aliases")
