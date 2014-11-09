-- MTW GUI : construct left/right/bottom bars

mtw.gui.cont = mtw.gui.cont or {}

mtw.gui.cont.l = mtw.gui.cont.l or mtw.gui.new(Geyser.Container,
 [[{ name = "mtw_left_cont",
  x = 0,
  y = 0,
  width = mtw.gui.value_to_px("left_bar_width", mtw.gui.w),
  height = mtw.gui.h - mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
 }]],
 mtw.cgui.target_enabled or mtw.cgui.system_info_enabled or mtw.cgui.ih_enabled or mtw.cgui.game_info_enabled or mtw.cgui.aff_enabled or mtw.cgui.who_enabled,
 mtw.gui.root)

mtw.gui.cont.r = mtw.gui.cont.r or mtw.gui.new(Geyser.Container,
 [[{ name = "mtw_right_cont",
  x = -mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
  y = 0,
  width = mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
  height = "100%",
 }]],
 mtw.cgui.chat_enabled or mtw.cgui.mapper_enabled,
 mtw.gui.root)

mtw.gui.cont.b = mtw.gui.cont.b or mtw.gui.new(Geyser.Container,
 [[{ name = "mtw_bottom_cont",
  x = 0,
  y = -mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
  width = mtw.gui.w - mtw.gui.value_to_px("right_bar_width", mtw.gui.w),
  height = mtw.gui.value_to_px("bottom_bar_height", mtw.gui.h),
 }]],
 mtw.cgui.gauges_enabled or mtw.cgui.location_enabled,
 mtw.gui.root)

