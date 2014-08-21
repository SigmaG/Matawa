-- MTW : add a map to the GUI

mtw.gui.c_mapper = Geyser.Container:new({
 name = "mtw_mapper_cont",
 x = "60%",
 y = 0,
 width = "100%",
 height = "40%",
}, mtw.gui.r_cont)
mtw.gui.mapper = Geyser.Mapper:new({
 name = "mtw_mapper",
 x = 0,
 y = 0,
 width = "100%",
 height = "100%",
}, mtw.gui.c_mapper)
