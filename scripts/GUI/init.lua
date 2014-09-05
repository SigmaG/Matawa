-- MTW : GUI functions

mtw_struct.load_external("GUI/geyser")

-- here we will create the layout.
mtw_struct.load_external("GUI/config")
if mtw.cgui.enabled then
local cont = nil

mtw.gui = mtw.gui or {}

function mtw.gui.value_to_px(str, scale)
 local v = mtw.cgui[str]
 local s = 0
 local negative = false
 if type(v) == "string" then
  if v:match("^-") then
   negative = true
   v = v:gsub("^-", "")
  end
  if v:match("%%") then
   s = tonumber(v:gsub("%%.*",""), 10) / 100 * scale
   if math.floor(s) < s then
    s = math.floor(s) + 1
   else
    s = math.floor(s)
   end
  elseif v:match("p") then
   s = tonumber(v:gsub("p.*", ""), 10)
  else
   s = tonumber(v:match("%d*"), 10)
  end
 elseif type(v) == "number" then
  if v < 0 then
   negative = true
   v = -v
  end
  if v < 1 then
   s = v * scale
   if math.floor(s) < s then
    s = math.floor(s) + 1
   else
    s = math.floor(s)
   end
  else
   s = v
  end
 else
  s = mtw.default.cgui[str]
 end
 if negative and s then
  return -s
 else
  return s
 end
end

-- make room around the screen
mtw.gui.w,mtw.gui.h = getMainWindowSize()

if mtw.cgui.chat_enabled or mtw.cgui.mapper_enabled then
 setBorderRight(mtw.gui.value_to_px("right_bar_width", mtw.gui.w))
end

if mtw.cgui.target_enabled or mtw.cgui.system_info_enabled or mtw.cgui.ih_enabled or mtw.cgui.game_info_enabled or mtw.cgui.aff_enabled or mtw.cgui.who_enabled then
 setBorderLeft(mtw.gui.value_to_px("left_bar_width", mtw.gui.w))
end

if mtw.cgui.gauges_enabled or mtw.cgui.location_enabled then
 setBorderBottom(mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h))
end

-- container to store the disabled windows
mtw.gui.disabled_win = mtw.gui.disabled_win or Geyser.Container:new({
 name = "mtw_disabled",
 x = 0,
 y = 0,
 width = "100%",
 height = "100%",
})
mtw.gui.disabled_win:hide()

-- right side windows
mtw.gui.r_cont = mtw.gui.r_cont or Geyser.Container:new({
 name = "mtw_right",
 x = -mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
 y = 0,
 width = mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
 height = "100%",
})

-- bottom windows
mtw.gui.b_cont = mtw.gui.b_cont or Geyser.Container:new({
 name = "mtw_bottom",
 x = 0,
 y = -mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
 width = mtw.gui.w - mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
 height = mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
})

-- left side windows
mtw.gui.l_cont = mtw.gui.l_cont or Geyser.Container:new({
 name = "mtw_left",
 x = 0,
 y = 0,
 width = mtw.gui.value_to_px("left_bar_width", mtw.gui.w),
 height = mtw.gui.h - mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
})

mtw.gui.r_cont:show()
mtw.gui.l_cont:show()
mtw.gui.b_cont:show()

mtw_struct.load_external("GUI/chat")
mtw_struct.load_external("GUI/map")
mtw_struct.load_external("GUI/bars")
mtw_struct.load_external("GUI/infos")

else
 mtw.gui = {}
 local mt = {
  __index = function(k,v)
   local f = function() return false end
   return f
  end,
  __newindex = function(k,v,t)
  end,
 }
 setmetatable(mtw.gui, mt)
end
