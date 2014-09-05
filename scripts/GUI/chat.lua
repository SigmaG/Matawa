-- MTW : chat window

mtw.gui.chat_selected = "All"

mtw.gui.label_fg = "white" -> mtw.cgui.chat_label_text
mtw.gui.chat_active = "green" -> mtw.cgui.chat_label_active_color
mtw.gui.chat_inactive = "grey" -> mtw.cgui.chat_label_inactive_color
mtw.gui.chat_labels_per_line = 4 -> mtw.cgui.chat_labels_per_line
mtw.gui.chat_font_size = 9 -> mtw.cgui.chat_font_size

local w,h = getMainWindowSize() -> mtw.gui.w,h
local cw,ch = calcFontSize(mtw.cgui.chat_font_size)
local w = math.floor(mtw.gui.value_to_px("right_bar_width",mtw.gui.w)/cw)

local cont = nil
if mtw.cgui.chat_enabled then
 cont = mtw.gui.r_cont
else
 cont = mtw.gui.disabled_win
end
mtw.gui.chat_window = mtw.gui.chat_window or Geyser.Container:new({
 name = "mtw_chat_windows",
 x = 0,
 y = 0,
 width = "100%",
 height = mtw.gui.value_to_px("chat_height", mtw.gui.w),
}, cont)

local tabList = {"All", "Tells", "Says", "City", "Guild", "Order", "Societies", "OOC", "Misc", "Combat"}
local lines = #tabList / mtw.cgui.chat_labels_per_line
if lines > math.floor(lines) then
 lines = math.floor(lines) + 1
end

mtw.gui.chat_ctabs = mtw.gui.chat_ctabs or Geyser.VBox:new({
 name = "mtw_chattabs",
 x = 0,
 y = 0,
 width = "100%",
 height = 15*lines, --fixed for now
}, mtw.gui.r_cont)

mtw.gui.chat_ltabs = mtw.gui.chat_ltabs or {}
for i = 1, lines do
 mtw.gui.chat_ltabs[i] = mtw.gui.chat_ltabs[i] or Geyser.HBox:new({
  name = "mtw_chatlinetab"..i,
 }, mtw.gui.chat_ctabs)
end

mtw.gui.chat_tabs = mtw.gui.chat_tabs or {}
mtw.gui.chat_cwin = mtw.gui.chat_win or {}
mtw.gui.chat_win = mtw.gui.chat_win or {}

local cw = 60 - ch


local i = 0
local n = 1
for _,v in pairs(tabList) do
 mtw.gui.chat_tabs[v] = mtw.gui.chat_tabs[v] or Geyser.Label:new({
  name = "mtw_lchat_"..v,
  fgColor = mtw.cgui.chat_label_text,
  color = mtw.cgui.chat_label_inactive_color,
  message = string.format([[<center>%s</center>]], v),
 }, mtw.gui.chat_ltabs[n])
 i = i + 1
 if (i == mtw.cgui.chat_labels_per_line) then
  i = 0
  n = n + 1
 end
 mtw.gui.chat_tabs[v]:setClickCallback("chat_label_click", v)

 mtw.gui.chat_cwin[v] = mtw.gui.chat_cwin[v] or Geyser.Container:new({
  name = "mtw_chatwin",
  x = 0,
  y = 15*lines,
  width = "100%",
  height = mtw.gui.value_to_px("chat_height",mtw.gui.h)-15*lines,
 }, mtw.gui.r_cont)

 mtw.gui.chat_win[v] = mtw.gui.chat_win[v] or Geyser.MiniConsole:new({
  name = "mtw_chatW"..v,
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  color = "black",
 }, mtw.gui.chat_cwin[v])
 mtw.gui.chat_win[v]:setFontSize(mtw.cgui.chat_font_size)
 mtw.gui.chat_win[v]:setWrap(w)
 mtw.gui.chat_cwin[v]:hide()
end

--cannot put a callback function in a table...
function chat_label_click(name) 
 if name ~= mtw.gui.chat_selected then
 mtw.gui.chat_cwin[mtw.gui.chat_selected]:hide()
 mtw.gui.chat_tabs[mtw.gui.chat_selected]:setColor(mtw.cgui.chat_label_inactive_color)
 mtw.gui.chat_cwin[name]:show()
 mtw.gui.chat_tabs[name]:setColor(mtw.cgui.chat_label_active_color)
 mtw.gui.chat_selected = name
 end
end

function mtw.gui.chat(win)
 if win ~= "Combat" then
  selectCurrentLine()
 end
 copy()
 mtw.gui.chat_win[win]:append()
 mtw.gui.chat_win["All"]:append()
end


function mtw.gui.chat_init()
 for _,v in pairs(mtw.gui.chat_cwin) do
  v:hide()
 end
 mtw.gui.chat_cwin["All"]:show()
 mtw.gui.chat_tabs["All"]:setColor(mtw.cgui.chat_label_active_color)
 mtw.gui.chat_selected = "All"
end

function mtw.gui.chat_tells(matches)
 if not string.find(matches[1], "OOC") and not string.find(matches[1], "%/%/") and not string.find(matches[1], "%(%(") then
  mtw.gui.chat("Tells")
 end
end

function mtw.gui.chat_says(matches)
 if string.find(multimatches[2][2], "\"") then
  if not string.find(multimatches[2][1], "\"U\"") and not string.find(multimatches[2][1], "OOC") and not string.find(multimatches[2][1], "%/%/") and not string.find(multimatches[2][1], "%(%(") and not string.find(multimatches[2][1], "graffiti") then
   mtw.gui.chat("Says")
  end
 end
end

function mtw.gui.chat_misc(matches)
 if not string.find(matches[1], "OOC") and not string.find(matches[1], "%/%/") and not string.find(matches[1], "%(%(") then
  mtw.gui.chat("Misc")
 end
end

function mtw.gui.chat_deathsense(matches)
 selectString(matches[1], 1)
 fg("purple")
 bg("black")
 resetFormat()
 mtw.gui.chat("Misc")
end

function mtw.gui.chat_shouts(matches)
 selectString(matches[1], 1)
 fg("CadetBlue")
 bg("black")
 resetFormat()
 mtw.gui.chat("Misc")
end
