-- MTW : chat window source code

--[[
If the label callbacks ever decide to start taking a function which is part of a table, 0then this will change.
Or if it's modified to take actual functions. Anonymouse function clickcallback would be awfully nice.
]]

function demonnicChatSwitch(chat)
  local r = demonnic.chat.config.inactiveColors.r
  local g = demonnic.chat.config.inactiveColors.g
  local b = demonnic.chat.config.inactiveColors.b
  local newr = demonnic.chat.config.activeColors.r
  local newg = demonnic.chat.config.activeColors.g
  local newb = demonnic.chat.config.activeColors.b
  local oldchat = demonnic.chat.currentTab
  if demonnic.chat.currentTab ~= chat then
    demonnic.chat.windows[oldchat]:hide()
    demonnic.chat.tabs[oldchat]:setColor(r,g,b)
    demonnic.chat.tabs[oldchat]:echo(oldchat, demonnic.chat.config.inactiveTabText, "c")
    if demonnic.chat.config.blink and demonnic.chat.tabsToBlink[chat] then
      demonnic.chat.tabsToBlink[chat] = nil
    end
    if demonnic.chat.config.blink and chat == demonnic.chat.config.Alltab then
      demonnic.chat.tabsToBlink = {}
    end
  end
  demonnic.chat.tabs[chat]:setColor(newr,newg,newb)
  demonnic.chat.tabs[chat]:echo(chat, demonnic.chat.config.activeTabText, "c")
  demonnic.chat.windows[chat]:show()
  demonnic.chat.currentTab = chat  
end

function demonnic.chat:resetUI()
  demonnic.chat.container = Geyser.Container:new(demonnic.chat[demonnic.chat.config.location]())
  demonnic.chat.tabBox = Geyser.HBox:new({
    x=0,
    y=0,
    width = "100%",
    height = "25px",
    name = "DemonChatTabs",
  },demonnic.chat.container)

end

function demonnic.chat:create()
  --reset the UI
  demonnic.chat:resetUI()
  --Set some variables locally to increase readability
  local r = demonnic.chat.config.inactiveColors.r
  local g = demonnic.chat.config.inactiveColors.g
  local b = demonnic.chat.config.inactiveColors.b
  local winr = demonnic.chat.config.windowColors.r
  local wing = demonnic.chat.config.windowColors.g
  local winb = demonnic.chat.config.windowColors.b

  --iterate the table of channels and create some windows and tabs
  for i,tab in ipairs(demonnic.chat.config.channels) do
    demonnic.chat.tabs[tab] = Geyser.Label:new({
      name=string.format("tab%s", tab),
    }, demonnic.chat.tabBox)
    demonnic.chat.tabs[tab]:echo(tab, demonnic.chat.config.inactiveTabText, "c")
    demonnic.chat.tabs[tab]:setColor(r,g,b)
    demonnic.chat.tabs[tab]:setClickCallback("demonnicChatSwitch", tab)
    demonnic.chat.windows[tab] = Geyser.MiniConsole:new({
--      fontSize = demonnic.chat.config.fontSize,
      x = 0,
      y = 25,
      height = "100%",
      width = "100%",
      name = string.format("win%s", tab),
    }, demonnic.chat.container)
    demonnic.chat.windows[tab]:setFontSize(demonnic.chat.config.fontSize)
    demonnic.chat.windows[tab]:setColor(winr,wing,winb)
    demonnic.chat.windows[tab]:setWrap(demonnic.chat.config.width)
    demonnic.chat.windows[tab]:hide()
  end
  local showme = demonnic.chat.config.Alltab or demonnic.chat.config.channels[1]
  demonnicChatSwitch(showme)
  --start the blink timers, if enabled
  if demonnic.chat.config.blink and not demonnic.chat.blinkTimerOn then
    demonnic.chat:blink()
  end
end

function demonnic.chat:append(chat)
  local r = demonnic.chat.config.windowColors.r
  local g = demonnic.chat.config.windowColors.g
  local b = demonnic.chat.config.windowColors.b
  if chat ~= "Combat" then
   selectCurrentLine()
  end
  if demonnic.chat.config.preserveBackground then
    setBgColor(r,g,b)
  end
  copy()
  demonnic.chat.windows[chat]:append()
  if demonnic.chat.config.gag then 
    deleteLine() 
    tempLineTrigger(1,1, [[if isPrompt() then deleteLine() end]])
  end
  if demonnic.chat.config.Alltab then appendBuffer(string.format("win%s", demonnic.chat.config.Alltab)) end
  if demonnic.chat.config.blink and chat ~= demonnic.chat.currentTab then 
    if (demonnic.chat.config.Alltab == demonnic.chat.currentTab) and not demonnic.chat.config.blinkOnAll then
      return
    else
      demonnic.chat.tabsToBlink[chat] = true
    end
  end
end



function demonnic.chat:blink()
  if demonnic.chat.blinkID then killTimer(demonnic.chat.blinkID) end
  if not demonnic.chat.config.blink then 
    demonnic.chat.blinkTimerOn = false
    return 
  end
  for tab,_ in pairs(demonnic.chat.tabsToBlink) do
    demonnic.chat.tabs[tab]:flash()
  end
  demonnic.chat.blinkID = tempTimer(demonnic.chat.config.blinkTime, function () demonnic.chat:blink() end)
end

--function demonnic.chat:topright()
--  return {
--    fontSize = demonnic.chat.config.fontSize,
--    x=string.format("-%sc",demonnic.chat.config.width + 2),
--    y=0,
--    width="-15px",
--    height=string.format("%ic", demonnic.chat.config.lines + 2),
--  }
--end

function demonnic.chat:topright()
  return {
    fontSize = demonnic.chat.config.fontSize,
    x="59%",
    y=0,
    width="40%",
    height="35%",
  }
end

function demonnic.chat:topleft()
  return {
    fontSize = demonnic.chat.config.fontSize,
    x=0,
    y=0,
    width=string.format("%sc",demonnic.chat.config.width),
    height=string.format("%ic", demonnic.chat.config.lines + 2),
  }
end

function demonnic.chat:bottomright()
  return {
    fontSize = demonnic.chat.config.fontSize,
    x=string.format("-%sc",demonnic.chat.config.width + 2),
    y=string.format("-%sc",demonnic.chat.config.lines + 2),
    width="-15px",
    height=string.format("%ic", demonnic.chat.config.lines + 2),
  }
end

function demonnic.chat:bottomleft()
  return {
    fontSize = demonnic.chat.config.fontSize,
    x=0,
    y=string.format("-%sc",demonnic.chat.config.lines + 2),
    width=string.format("%sc",demonnic.chat.config.width),
    height=string.format("%ic", demonnic.chat.config.lines + 2),
  }
end
