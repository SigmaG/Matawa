-- MTW : create the various bars at the bottom of the screen

mtw.gui.location_bar = mtw.gui.location_bar or mtw.gui.new(Geyser.Label,
 [[function()
  if mtw.cgui.gauges_enabled then
   lby = "50%"
   lbh = "50%"
  else
   lby = 0
   lbh = "100%"
  end
  return { name = "mtw_location",
   x = 0,
   y = lby,
   width = "100%",
   height = lbh,
  } end]],
 mtw.cgui.location_enabled,
 mtw.gui.cont.b)
-- I know how dirty it is, but this is what allows to not have empty bars

mtw.gui.status_b = mtw.gui.status_b or mtw.gui.new(Geyser.HBox,
 [[function()
  if mtw.cgui.location_enabled then
   lbh = "50%"
  else
   lbh = "100%"
  end
  return { name = "mtw_statusbars",
   x = 0,
   y = 0,
   width = "100%",
   height = lbh,
  } end]],
 mtw.cgui.gauges_enabled,
 mtw.gui.cont.b)

mtw.gui.status_bars = mtw.gui.status_bars or {}
mtw.gui.status_bars.hp = mtw.gui.status_bars.hp or mtw.gui.new(Geyser.Gauge,
 { name = "mtw_hpbar" },
 mtw.cgui.hp_gauge_enabled,
 mtw.gui.status_b)
mtw.gui.status_bars.pp = mtw.gui.status_bars.pp or mtw.gui.new(Geyser.Gauge,
 { name = "mtw_ppbar" },
 mtw.cgui.pp_gauge_enabled,
 mtw.gui.status_b)
mtw.gui.status_bars.ep = mtw.gui.status_bars.ep or mtw.gui.new(Geyser.Gauge,
 { name = "mtw_epbar" },
 mtw.cgui.ep_gauge_enabled,
 mtw.gui.status_b)
mtw.gui.status_bars.ap = mtw.gui.status_bars.ap or mtw.gui.new(Geyser.Gauge,
 { name = "mtw_apbar" },
 mtw.cgui.ap_gauge_enabled,
 mtw.gui.status_b)
mtw.gui.status_bars.xp = mtw.gui.status_bars.xp or mtw.gui.new(Geyser.Gauge,
 { name = "mtw_xpbar" },
 mtw.cgui.xp_gauge_enabled,
 mtw.gui.status_b)

function mtw.gui.update_location_bar()
 local cw = [[<font color="white">]]
 local cy = [[<font color="yellow">]]
 local s = cw.."Area: "..cy..gmcp.Room.Info.area..cw.." | Room: "..cy..gmcp.Room.Info.num..cw.." ("..cy..gmcp.Room.Info.name:gsub("%.$","")..cw..") | Exits: "..cy
 for k,_ in pairs(gmcp.Room.Info.exits) do
  s = s..k..cw..","..cy
 end                 
 s = s:gsub(","..cy.."$","")
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
