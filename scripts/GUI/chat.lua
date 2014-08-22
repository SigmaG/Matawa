-- MTW : chat window

mtw.gui.label_fg = "white"
mtw.gui.chat_active = "green"
mtw.gui.chat_inactive = "grey"
mtw.gui.chat_selected = "All"

local tabList = {"All", "Tells", "Says", "City", "Guild", "Order", "Societies", "OOC", "Misc", "Combat"}

mtw.gui.chat_ctabs = mtw.gui.chat_ctabs or Geyser.Container:new({
 name = "mtw_chattabs",
 x = 0,
 y = 0,
 width = "100%",
 height = "3%",
}, mtw.gui.r_cont)
mtw.gui.chat_tabs = mtw.gui.chat_tabs or {}


mtw.gui.chat_cwin = mtw.gui.chat_win or {}
mtw.gui.chat_win = mtw.gui.chat_win or {}


local tabWidth = math.floor(100/#tabList)
local i = 0
for _,v in pairs(tabList) do
 mtw.gui.chat_tabs[v] = mtw.gui.chat_tabs[v] or Geyser.Label:new({
  name = "mtw_lchat_"..v,
  x = ""..i.."%",
  y = 0,
  width = ""..tabWidth.."%",
  height = "100%",
  fgColor = mtw.gui.label_fg,
  color = mtw.gui.chat_inactive,
  message = string.format([[<center>%s</center>]], v),
 }, mtw.gui.chat_ctabs)
 i = i + tabWidth
 mtw.gui.chat_tabs[v]:setClickCallback("chat_label_click", v)

 mtw.gui.chat_cwin[v] = mtw.gui.chat_cwin[v] or Geyser.Container:new({
  name = "mtw_chatwin",
  x = 0,
  y = "5%",
  width = "100%",
  height = "57%",
 }, mtw.gui.r_cont)

 mtw.gui.chat_win[v] = mtw.gui.chat_win[v] or Geyser.MiniConsole:new({
  name = "mtw_chatW"..v,
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  color = "black",
 }, mtw.gui.chat_cwin[v])
 mtw.gui.chat_cwin[v]:hide()
end

--cannot put a callback function in a table...
function chat_label_click(name) 
 mtw.gui.chat_cwin[mtw.gui.chat_selected]:hide()
 mtw.gui.chat_tabs[mtw.gui.chat_selected]:setColor(mtw.gui.chat_inactive)
 mtw.gui.chat_cwin[name]:show()
 mtw.gui.chat_tabs[name]:setColor(mtw.gui.chat_active)
 mtw.gui.chat_selected = name
end

function mtw.gui.chat(win)
 if win ~= "Combat" then
  selectCurrentLine()
 end
 copy()
 mtw.gui.chat_win[win]:append()
 mtw.gui.chat_win["All"]:append()
end

for _,v in pairs(mtw.gui.chat_cwin) do
 v:hide()
end
chat_label_click("All")

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
