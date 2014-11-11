-- MTW GUI : code to be able to enable or disable the windows

mtw.gui.win_list = mtw.gui.win_list or {
 who = mtw.gui.who_box,
 aff = mtw.gui.aff_box,
 ih = mtw.gui.IH_box,
 gauges = mtw.gui.status_b,
 ap_gauge = mtw.gui.status_bars.ap,
 pp_gauge = mtw.gui.status_bars.pp,
 xp_gauge = mtw.gui.status_bars.xp,
 hp_gauge = mtw.gui.status_bars.hp,
 ep_gauge = mtw.gui.status_bars.ep,
 location = mtw.gui.location_bar,
 chat = mtw.gui.chat_window,
 system_info = mtw.gui.matawa_label,
 game_info = mtw.gui.random_info_box,
 target = mtw.gui.targbox,
 mapper = mtw.gui.c_mapper,
}

function mtw.gui.disable_window(what)
 mtw.cgui[what.."_enabled"] = false
 mtw.gui.win_list[what]:disable()
end

function mtw.gui.enable_window(what)
 mtw.cgui[what.."_enabled"] = true
 mtw.gui.win_list[what]:enable()
end

function mtw.gui.toggle(what)
 if what then
  local s = what.."_enabled"
  if mtw.cgui[s] then --we disable
   mtw.cgui[s] = false
   mtw.gui.win_list[what]:disable()
  else
   mtw.cgui[s] = true
   mtw.gui.win_list[what]:enable()
  end
 end
end
