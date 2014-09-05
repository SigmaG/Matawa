-- MTW : add a map to the GUI

local cont
if mtw.cgui.mapper_enabled then
 cont = mtw.gui.r_cont
else
 cont = mtw.gui.disabled_window
end

mtw.gui.c_mapper = mtw.gui.c_mapper or Geyser.Container:new({
 name = "mtw_mapper_cont",
 x = "0%",
 y = "60%",
 width = "100%",
 height = "40%",
}, cont)

local cont2
if mtw.cgui.geyser_mapper then
 cont = mtw.gui.c_mapper
 cont2 = mtw.gui.disabled_win
else
 cont = mtw.gui.disabled_win
 cont2 = mtw.gui.c_mapper
end

mtw.gui.mapper_g = mtw.gui.mapper_g or Geyser.Mapper:new({
 name = "mtw_mapper_g",
 x = 0,
 y = 0,
 width = "100%",
 height = "100%",
}, cont)
mtw.gui.mapper_m = mtw.gui.mapper_m or Geyser.MiniConsole:new({
 name = "mtw_mapper_mc",
 x = 0,
 y = 0,
 width = "100%",
 height = "100%",
}, cont2)

mtw.gui.c_mapper:show()
