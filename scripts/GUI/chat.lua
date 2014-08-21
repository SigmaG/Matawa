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
 height = "5%",
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
  height = "55%",
 }, mtw.gui.r_cont)

 mtw.gui.chat_win[v] = mtw.gui.chat_win[v] or Geyser.MiniConsole:new({
  name = "mtw_chatW"..v,
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
 }, mtw.gui.chat_cwin[v])
 mtw.gui.chat_cwin[v]:hide()
end

--cannot put a callback function in a table...
function chat_label_click(name) {
 mtw.gui.chat_cwin[mtw.gui.chat_selected]:hide()
 mtw.gui.chat_tabs[mtw.gui.chat_selected]:setColor(mtw.gui.chat_inactive)
 mtw.gui.chat_cwin[name]:show()
 mtw.gui.chat_tabs[name]:setColor(mtw.gui.chat_active)
 mtw.gui.chat_selected = name
}

chat_label_click("All")
