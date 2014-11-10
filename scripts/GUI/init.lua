-- MTW: GUI functions

mtw_struct.load_external("GUI/geyser")

mtw_struct.load_external("GUI/config")

if mtw.cgui.enabled then
 mtw.gui = mtw.gui or {}

 mtw_struct.load_external("GUI/utils")
 mtw.gui.update_window_size()

 mtw_struct.load_external("GUI/rootwin")

 --here happens the magic!
 mtw_struct.load_external("GUI/windows")
 mtw_struct.load_external("GUI/toggle")

 --we construct the three main containers (left/right/bottom) in there
 mtw_struct.load_external("GUI/mainwindows")

 --now we create the actual windows :)
 mtw_struct.load_external("GUI/bars")
 mtw_struct.load_external("GUI/chat")
 mtw_struct.load_external("GUI/mapper")
 mtw_struct.load_external("GUI/infobar")

 mtw.gui.root:resize_children()

else
 -- we just want to prevent any call to the GUI when it's not enabled
 mtw.gui = {}
 local mt = {
  __call = function (...) return nil end,
  __newindex = function (k,v,t)
  end,
  __index = function (k,v)
   local z = {}
   return setmetatable(z, mt)
  end,
 }
 setmetatable(mtw.gui,mt)
end
