-- MTW : add a map to the GUI

mtw.gui.c_mapper = mtw.gui.c_mapper or mtw.gui.new(Geyser.Container,
 [[function()
  if mtw.cgui.chat_enabled then
   y = mtw.gui.value_to_px("chat_height", mtw.gui.h)
   h = mtw.gui.h - y
  else
   y = 0
   h = "100%"
  end
  return {name = "mtw_mapper_cont",
   x = "0%",
   y = y,
   width = "100%",
   height = h,
  }
 end]], 
 mtw.cgui.mapper_enabled,
 mtw.gui.cont.r)

mtw.gui.mapper_g = mtw.gui.mapper_g or mtw.gui.new(Geyser.Mapper,
 {name = "mtw_mapper_g",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
 },
 mtw.cgui.geyser_mapper,
 mtw.gui.c_mapper)

mtw.gui.mapper_m = mtw.gui.mapper_m or mtw.gui.new(Geyser.MiniConsole,
 {name = "mtw_mapper_mc",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
 },
 not mtw.cgui.geyser_mapper,
 mtw.gui.c_mapper)
