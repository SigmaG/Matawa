-- MTW GUI : handle the left side border

-- one VBox for small labels, one for larger windows
function mtw.gui.calculate_infobar_constraints(which)
 local sbs = 0
 if mtw.cgui.system_info_enabled then sbs = sbs + 1 end
 if mtw.cgui.game_info_enabled then sbs = sbs + 1 end
 if mtw.cgui.target_enabled then sbs = sbs + 1 end
 sbs = sbs * 15 -- maybe needs to be calculated

 if which == "infobar" then
  return { name = "mtw_lsmallbox",
  x = 0,
  y = 0,
  width = "100%",
  height = sbs }
 else
  local lbs = mtw.gui.h - mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h) - sbs
  local ihh = mtw.gui.value_to_px("ih_size", lbs)
  local afh = mtw.gui.value_to_px("aff_size", lbs)
  local whh = lbs - ihh - afh

  if not mtw.cgui.aff_enabled then
   if mtw.cgui.ih_enabled and mtw.cgui.who_enabled then
    ihh = math.floor((lbs * whh)/(lbs - afh))
    whh = lbs - ihh
   else
    ihh = lbs
    whh = 0
   end
   afh = 0
  else
   if not mtw.cgui.ih_enabled then
    if mtw.cgui.who_enabled then
     afh = math.floor((lbs * whh)/(lbs - ihh))
     whh = lbs - afh
    else
     afh = lbs
     whh = 0
    end
    ihh = 0
   else
    if not mtw.cgui.who_enabled then
     afh = math.floor((lbs * ihh)/(lbs - whh))
     ifh = lbs - afh
     whh = 0
    end
   end
  end

  local iy = sbs
  local wy = iy + ihh
  local ay = wy + whh

  if which == "ih" then
   return { name = "mtw_ihbox",
    x = 0,
    y = iy,
    height = ihh,
    width = "100%" }
  elseif which == "aff" then
   return { name = "mtw_affbox",
    x = 0,
    y = ay,
    height = afh,
    width = "100%" }
  elseif which == "who" then
   return { name = "mtw_whobox",
    x = 0,
    y = wy,
    height = whh,
    width = "100%" }
  end
  return {}
 end
end

mtw.gui.small_info_box = mtw.gui.small_info_box or mtw.gui.new(Geyser.VBox,
 [[ mtw.gui.calculate_infobar_constraints("infobar") ]],
 mtw.cgui.system_info_enabled or mtw.cgui.game_info_enabled or mtw.cgui.target_enabled,
 mtw.gui.cont.l)

mtw.gui.matawa_label = mtw.gui.matawa_label or mtw.gui.new(Geyser.Label,
 { name = "mtw_infobox" },
 mtw.cgui.system_info_enabled,
 mtw.gui.small_info_box)

mtw.gui.random_info_box = mtw.gui.random_info_box or mtw.gui.new(Geyser.HBox,
 { name = "mtwrandominfobox" },
 mtw.cgui.game_info_enabled,
 mtw.gui.small_info_box)

mtw.gui.targbox = mtw.gui.targbox or mtw.gui.new(Geyser.Label,
 {name = "mtw_target",
  message = "Target: "..mtw.target,},
 mtw.cgui.target_enabled,
 mtw.gui.small_info_box)

function mtw.gui.matawa()
 if mtw.cgui.system_info_enabled then
  if mtw.upgrade then
   mtw.gui.matawa_label:echo("Matawa "..mtw.version[1].." upgrade available!", "yellow", "c")
   mtw.gui.matawa_label:setClickCallback("openUrl", "http://mko.kadarniad.fr/matawa/master/matawa.mpackage.zip")
  else
   mtw.gui.matawa_label:echo("Matawa "..mtw.version[1], "white", "c")
   mtw.gui.matawa_label:setClickCallback("openUrl", "http://mko.kadarniad.fr/matawa")
  end
 end
end

mtw.gui.newsbox = mtw.gui.newsbox or mtw.gui.new(Geyser.Label,
 { name = "mtwnewsbox" },
 true,
 mtw.gui.random_info_box)
mtw.gui.msgbox = mtw.gui.msgbox or mtw.gui.new(Geyser.Label,
 { name = "mtwmsgbox", },
 true,
 mtw.gui.random_info_box)
mtw.gui.goldbox = mtw.gui.goldbox or mtw.gui.new(Geyser.Label,
 { name = "mtwgoldbox", },
 true,
 mtw.gui.random_info_box)
mtw.gui.newsbox:setClickCallback("send", "RN")
mtw.gui.msgbox:setClickCallback("send", "RM")
mtw.gui.goldbox:setClickCallback("send", "score")

function mtw.gui.update_random_boxes()
 if mtw.cgui.game_info_enabled then
  if gmcp.Char.Status.unread_news == "0" then
   mtw.gui.newsbox:echo("No news", "white")
  else
   mtw.gui.newsbox:echo("News: "..gmcp.Char.Status.unread_news, "yellow")
  end
  if gmcp.Char.Status.unread_msgs == "0" then
   mtw.gui.msgbox:echo("No message", "white")
  else
   mtw.gui.msgbox:echo("MSG: "..gmcp.Char.Status.unread_msgs, "yellow")
  end
  mtw.gui.goldbox:echo(gmcp.Char.Status.gold, "yellow")
 end
end

function mtw.gui.update_target()
 if mtw.cgui.target_enabled then
  mtw.gui.targbox:echo("Target: "..mtw.target)
 end
end

mtw.gui.IH_box = mtw.gui.IH_box or mtw.gui.new(Geyser.MiniConsole,
 [[ mtw.gui.calculate_infobar_constraints("ih") ]],
 mtw.cgui.ih_enabled,
 mtw.gui.cont.l)

mtw.gui.aff_box = mtw.gui.aff_box or mtw.gui.new(Geyser.MiniConsole,
 [[ mtw.gui.calculate_infobar_constraints("aff") ]],
 mtw.cgui.aff_enabled,
 mtw.gui.cont.l)

mtw.gui.who_box = mtw.gui.who_box or mtw.gui.new(Geyser.MiniConsole,
 [[ mtw.gui.calculate_infobar_constraints("who") ]],
 mtw.cgui.who_enabled,
 mtw.gui.cont.l)

function mtw.gui.expand_IH(thing)
 if mtw.gui.expanded == thing then
  mtw.gui.expanded = nil
 else
  mtw.gui.expanded = thing
 end
 mtw.gui.update_IH()
end

function mtw.gui.update_IH()
 if mtw.cgui.ih_enabled then
  mtw.gui.IH_box:clear()
  local c = 1
  for thing, ids in pairs(mtw.roomitems) do
   local n = 0
   for _,_ in pairs(ids) do n = n+1 end
   local str = thing.." x"..tostring(n).."\n"
   if mtw.cgui.ih_expandable then
    echoLink(mtw.gui.IH_box.name, str, string.format([[mtw.gui.expand_IH("%s")]], thing), "Expand", true)
    if mtw.gui.expanded == thing then
     for k,_ in pairs(ids) do
      echoLink(mtw.gui.IH_box.name, " "..k.."\n", string.format([[send("probe %s")]], k), "Probe", true)
     end
    end
   else
    mtw.gui.IH_box:echo(str)
   end
  end
 end
end

function mtw.gui.update_affs()
 if mtw.cgui.aff_enabled then
  mtw.gui.aff_box:clear()
  for k,v in pairs(mtw.afflictions) do
   if (v.state ~= "healed") and not (v.cures.overdrive) then -- we want to avoid the health_xx and magic_xx here
    local c = "orange"
    if v.cures.focus == "body" then c = "red" end
    if v.cures.focus == "mind" then c = "green" end
    if v.cures.focus == "spirit" then c = "blue" end
    mtw.gui.aff_box:cecho(string.format([[<%s>%s]].."\n", c, k:gsub("aff_","")))
   end
  end
 end
end

function mtw.gui.update_who_here()
 if mtw.cgui.who_enabled then
  mtw.gui.who_box:clear()
  for _,v in pairs(gmcp.Room.Players) do
   echoLink(mtw.gui.who_box.name, v.name.."\n", string.format([[send("honors %s")]], v.name), v.fullname, true)
  end
 end
end
