-- MTW : GUI configuration

mtw_struct.set_metatable_custom("cgui") -- mtw.cgui will be the table containing the configuration choices
--default config below
mtw.default.cgui = {
 enabled = true,
 bottom_bar_height = "5%",
 left_bar_width = "15%",
 right_bar_width = "30%",

-- chat config
 chat_enabled = true,
 chat_font_size = 8,
 chat_labels_per_line = 5,
 chat_label_inactive_color = "grey",
 chat_label_active_color = "green",
 chat_label_text = "white",
 chat_label_font = "",
 chat_height = "60%",

-- mapper config
 mapper_enabled = true,
 geyser_mapper = true, --if not the geyser mapper, it's a miniwindow that you obtain by extracting the map data
 
-- left panel config
 target_enabled = true,
 system_info_enabled = true,
 game_info_enabled = true,
 ih_enabled = true,
 ih_expandable = true,
 aff_enabled = true,
 who_enabled = true,
 action_who = "honors %s",
 ih_size = "40%",
 aff_size = "50%",
 --who here takes what's left

-- gauges config
 gauges_enabled = true,
 hp_gauge_enabled = true,
 pp_gauge_enabled = true,
 ep_gauge_enabled = true,
 ap_gauge_enabled = true,
 xp_gauge_enabled = true,

-- lower bar
 location_enabled = true,

}
