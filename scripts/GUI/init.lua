-- MTW : GUI functions

mtw_struct.load_external("GUI/geyser")

-- here we will create the layout.
mtw.gui = mtw.gui or {}

-- make room around the screen
local w,h = getMainWindowSize()
setBorderLeft(math.floor(0.15*w)+1)
setBorderRight(math.floor(0.3*w)+1)
setBorderBottom(math.floor(0.05*h)+1)

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
 y = "-5%",
 width = "70%",
 height = "5%",
})

-- left side windows
mtw.gui.l_cont = mtw.gui.l_cont or Geyser.Container:new({
 name = "mtw_left",
 x = 0,
 y = 0,
 width = "15%",
 height = "95%",
})

mtw.gui.r_cont:show()
mtw.gui.l_cont:show()
mtw.gui.b_cont:show()

mtw_struct.load_external("GUI/chat")
mtw_struct.load_external("GUI/map")
mtw_struct.load_external("GUI/bars")
mtw_struct.load_external("GUI/infos")
