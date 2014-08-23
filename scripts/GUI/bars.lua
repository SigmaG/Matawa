-- MTW : create the various bars at the bottom of the screen

mtw.gui.location_bar = mtw.gui.location_bar or Geyser.Label:new({
 name = "mtw_location",
 x = 0,
 y = "50%",
 width = "100%",
 height = "50%",
}, mtw.gui.b_cont)

mtw.gui.status_b = mtw.gui.status_b or Geyser.HBox:new({
 name = "mtw_statusbars",
 x = 0,
 y = 0,
 width = "100%",
 height = "50%",
}, mtw.gui.b_cont)

mtw.gui.status_bars = mtw.gui.status_bars or {}
mtw.gui.status_bars.hp = mtw.gui.status_bars.hp or Geyser.Gauge:new({
 name = "mtw_hpbar",
}, mtw.gui.status_b)
mtw.gui.status_bars.pp = mtw.gui.status_bars.pp or Geyser.Gauge:new({
 name = "mtw_ppbar",
}, mtw.gui.status_b)
mtw.gui.status_bars.ep = mtw.gui.status_bars.ep or Geyser.Gauge:new({
 name = "mtw_epbar",
}, mtw.gui.status_b)
mtw.gui.status_bars.ap = mtw.gui.status_bars.ap or Geyser.Gauge:new({
 name = "mtw_apbar",
}, mtw.gui.status_b)
mtw.gui.status_bars.xp = mtw.gui.status_bars.xp or Geyser.Gauge:new({
 name = "mtw_xpbar",
}, mtw.gui.status_b)

function mtw.gui.update_location_bar()
 local s = "<white>Area: <yellow>" .. gmcp.Room.Info.area .. "<white> | RoomID: <yellow>" .. gmcp.Room.Info.num 
 mtw.gui.location_bar:echo(s)
end

function mtw.gui.update_status_bars()
 local mv = mtw.vitals
 mtw.gui.status_bars.hp:setValue(math.min(mv.current.health, mv.max.health), mv.max.health, "H: "..mv.current.health.."/"..mv.max.health.." ("..mv.percent.health.."%)")
 if mtw.my.class == "magician" or table.contains(mtw.skills, "Swordmastery") then
  mtw.gui.status_bars.pp:setValue(math.min(mv.current.magic, mv.max.magic), mv.max.magic, "M: "..mv.current.magic.."/"..mv.max.magic.." ("..mv.percent.magic.."%)")
 elseif mtw.my.class == "rogue" then
  mtw.gui.status_bars.pp:setValue(math.min(mv.current.guile, mv.max.guile), mv.max.guile, "G: "..mv.current.guile.."/"..mv.max.guile.." ("..mv.percent.guile.."%)")
 elseif mtw.my.class == "priest" then
  mtw.gui.status_bars.pp:setValue(math.min(mv.current.faith, mv.max.faith), mv.max.faith, "F: "..mv.current.faith.."/"..mv.max.faith.." ("..mv.percent.faith.."%)")
 end
 mtw.gui.status_bars.ep:setValue(math.min(mv.current.endurance, mv.max.endurance), mv.max.endurance, "E: "..mv.current.endurance.."/"..mv.max.endurance.." ("..mv.percent.endurance.."%)")
 mtw.gui.status_bars.ap:setValue(math.min(mv.adrenaline, 100), 100, "A: "..mv.adrenaline.."%")
 mtw.gui.status_bars.xp:setValue(mv.xp, 100, "Level "..gmcp.Char.Status.level)
end
