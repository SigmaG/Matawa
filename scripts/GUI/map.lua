-- MTW : add a map to the GUI

mtw.gui.c_mapper = mtw.gui.c_mapper or Geyser.Container:new({
 name = "mtw_mapper_cont",
 x = "0%",
 y = "60%",
 width = "100%",
 height = "40%",
}, mtw.gui.r_cont)
mtw.gui.mapper = mtw.gui.mapper or Geyser.Mapper:new({
 name = "mtw_mapper",
 x = 0,
 y = 0,
 width = "100%",
 height = "100%",
}, mtw.gui.c_mapper)

mtw.gui.c_mapper:show()
