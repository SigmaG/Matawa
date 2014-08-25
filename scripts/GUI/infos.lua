-- MTW GUI : handle the left side border

-- one VBox for small labels, one for larger windows
mtw.gui.small_info_box = mtw.gui.small_info_box or Geyser.VBox:new({
 name = "mtw_lsmallbox",
 x = 0,
 y = 0,
 width = "100%",
 height = "10%",
}, mtw.gui.l_cont)

mtw.gui.matawa_label = mtw.gui.matawa_label or Geyser.Label:new({
 name = "mtw_infobox",
}, mtw.gui.small_info_box)

function mtw.gui.matawa()
 if mtw.upgrade then
  mtw.gui.matawa_label:echo("Matawa "..mtw.version[1].." upgrade available!", "yellow", "c")
  mtw.gui.matawa_label:setClickCallback("openUrl", "http://mko.kadarniad.fr/matawa/master/matawa.mpackage.zip")
 else
  mtw.gui.matawa_label:echo("Matawa "..mtw.version[1], "white", "c")
  mtw.gui.matawa_label:setClickCallback("openUrl", "http://mko.kadarniad.fr/matawa")
 end
end

mtw.gui.random_info_box = mtw.gui.random_info_box or Geyser.HBox:new({
 name = "mtwrandominfobox",
}, mtw.gui.small_info_box)

mtw.gui.newsbox = mtw.gui.newsbox or Geyser.Label:new({
 name = "mtwnewsbox",
}, mtw.gui.random_info_box)
mtw.gui.msgbox = mtw.gui.msgbox or Geyser.Label:new({
 name = "mtwmsgbox",
}, mtw.gui.random_info_box)
mtw.gui.goldbox = mtw.gui.goldbox or Geyser.Label:new({
 name = "mtwgoldbox",
}, mtw.gui.random_info_box)
mtw.gui.newsbox:setClickCallback("send", "RN")
mtw.gui.msgbox:setClickCallback("send", "RM")
mtw.gui.goldbox:setClickCallback("send", "score")

function mtw.gui.update_random_boxes()
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

mtw.gui.targbox = mtw.gui.targbox or Geyser.Label:new({
 name = "mtw_target",
 message = "Target: "..mtw.target,
}, mtw.gui.small_info_box)

function mtw.gui.update_target()
 mtw.gui.targbox:echo("Target: "..mtw.target)
end

mtw.gui.large_info_box = mtw.gui.large_info_box or Geyser.VBox:new({
 name = "mtw_llargebox",
 x = 0,
 y = "10%",
 width = "100%",
 height = "90%",
}, mtw.gui.l_cont)

mtw.gui.IH_box = mtw.gui.IH_box or Geyser.MiniConsole:new({
 name = "mtw_ihbox",
}, mtw.gui.large_info_box)

mtw.gui.aff_box = mtw.gui.aff_box or Geyser.MiniConsole:new({
 name = "mtw_affbox",
}, mtw.gui.large_info_box)

mtw.gui.who_box = mtw.gui.who_box or Geyser.MiniConsole:new({
 name = "mtw_whobox",
}, mtw.gui.large_info_box)

function mtw.gui.expand_IH(thing)
 if mtw.gui.expanded == thing then
  mtw.gui.expanded = nil
 else
  mtw.gui.expanded = thing
 end
 mtw.gui.update_IH()
end

function mtw.gui.update_IH()
 mtw.gui.IH_box:clear()
 local c = 1
 for thing, ids in pairs(mtw.roomitems) do
  local n = 0
  for _,_ in pairs(ids) do n = n+1 end
  local str = thing.." x"..tostring(n).."\n"
  echoLink(mtw.gui.IH_box.name, str, string.format([[mtw.gui.expand_IH("%s")]], thing), "Expand", true)
  if mtw.gui.expanded == thing then
   for k,_ in pairs(ids) do
    echoLink(mtw.gui.IH_box.name, " "..k.."\n", string.format([[send("probe %s")]], k), "Probe", true)
   end
  end
 end
end

function mtw.gui.update_affs()
 mtw.gui.aff_box:clear()
 for k,v in pairs(mtw.afflictions) do
  if (v.state ~= "healed") and not (v.cures.overdrive) then -- we want to avoid the health_xx and magic_xx here
   local c = "orange"
   if v.cures.focus == "body" then c = "red" end
   if v.cures.focus == "mind" then c = "green" end
   if v.cures.focus == "spirit" then c = "blue" end
   mtw.gui.aff_box:cecho(string.format([[<%s>%s\n]], c, k:gsub("aff_","")))
  end
 end
end

function mtw.gui.update_who_here()
 mtw.gui.who_box:clear()
 for _,v in pairs(gmcp.Room.Players) do
  echoLink(mtw.gui.who_box.name, v.name.."\n", string.format([[send("honors %s")]], v.name), v.fullname, true)
 end
end
