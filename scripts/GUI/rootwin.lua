-- MTW GUI : create the framework to start using the rest.
-- mtw.gui.root is an abstraction of the main window, mtw.gui.disabled is where the disabled windows go to die (or not).

mtw.gui.root = mtw.gui.root or {
 win = nil,
 children = {},
 add = function(self,win)
 end,
 remove = function(self,win)
 end,
 resize_children = function(self)
  if mtw.cgui.target_enabled or mtw.cgui.system_info_enabled or mtw.cgui.ih_enabled or mtw.cgui.game_info_enabled or mtw.cgui.aff_enabled or mtw.cgui.who_enabled then
   setBorderLeft(mtw.gui.value_to_px("left_bar_width", mtw.gui.w))
  end
  if mtw.cgui.chat_enabled or mtw.cgui.mapper_enabled then
   setBorderRight(mtw.gui.value_to_px("right_bar_width", mtw.gui.w))
  end
  if mtw.cgui.gauges_enabled or mtw.cgui.location_enabled then
   setBorderBottom(mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h))
  end
  for _,v in pairs(self.children) do
   v:reload()
  end
 end,
}

mtw.gui.disabled = mtw.gui.disabled or Geyser.Container:new({
 name = "mtw_disabled",
 x = 0,
 y = 0,
 width = 0,
 height = 0,
})
