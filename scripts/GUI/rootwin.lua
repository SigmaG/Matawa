-- MTW GUI : create the framework to start using the rest.
-- mtw.gui.root is an abstraction of the main window, mtw.gui.disabled is where the disabled windows go to die (or not).

mtw.gui.root = mtw.gui.root or {
 win = nil,
 children = {},
 type = "container",
 add = function(self,win)
 end,
 remove = function(self,win)
 end,
 resize_children = function(self)
  mtw.gui.update_window_size()
  self:r()
  self:r()
 end,
 borders = {top = 0, left = 0, right = 0, bottom = 0},
 update_borders = function(self, top, left, right, bottom)
  if top ~= self.borders.top then
   self.borders.top = top
   setBorderTop(top)
  end
  if left ~= self.borders.left then
   self.borders.left = left
   setBorderLeft(left)
  end
  if right ~= self.borders.right then
   self.borders.right = right
   setBorderRight(right)
  end
  if bottom ~= self.borders.bottom then
   self.borders.bottom = bottom
   setBorderBottom(bottom)
  end
 end,
 r = function(self)
  local top, left, right, bottom = 0, 0, 0, 0
  if mtw.cgui.target_enabled or mtw.cgui.system_info_enabled or mtw.cgui.ih_enabled or mtw.cgui.game_info_enabled or mtw.cgui.aff_enabled or mtw.cgui.who_enabled then
   left = mtw.gui.value_to_px("left_bar_width", mtw.gui.w)
  end
  if mtw.cgui.chat_enabled or mtw.cgui.mapper_enabled then
   right = mtw.gui.value_to_px("right_bar_width", mtw.gui.w)
  end
  if mtw.cgui.gauges_enabled or mtw.cgui.location_enabled then
   bottom = mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h)
  end
  self:update_borders(top, left, right, bottom)
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

function mtw.gui.resize_event()
 if mtw.gui.lastresizerequest then
  killTimer(mtw.gui.lastresizerequest)
  mtw.gui.lastresizerequest = nil
 end
 mtw.gui.lastresizerequest = tempTimer(3, [[mtw.gui.root:resize_children()]])
end