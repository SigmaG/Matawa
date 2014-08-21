-- MTW : GUI functions

-- here we will create the layout.
mtw.gui = mtw.gui or {}

-- right side windows
mtw.gui.r_cont = mtw.gui.r_cont or Geyser.Container:new({
 name = "mtw_right",
 x = "-30%",
 y = 0,
 width = "30%",
 height = "100%",
})

-- bottom windows
mtw.gui.b_cont = mtw.gui.b_cont or Geyser.Container:new({
 name = "mtw_bottom",
 x = 0,
 y = "-10%",
 width = "70%",
 height = "10%",
})

-- left side windows
mtw.gui.l_cont = mtw.gui.l_cont or Geyser.Container:new({
 name = "mtw_left",
 x = 0,
 y = 0,
 width = "20%",
 height = "90%",
})

mtw_struct.load_external("GUI/chat")
mtw_struct.load_external("GUI/map")
