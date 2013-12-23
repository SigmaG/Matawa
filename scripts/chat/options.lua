-- MTW - chat window options

--[[
This is where all of the configuration options can be set. 
Anything I've put in this script object can be changed, but please do pay attention to what you're doing.
If you change one of the values to something it shouldn't be, you could break it. 
]]

demonnic.chat.config = demonnic.chat.config or {}

--This is where you tell it to use tabbed chat.
demonnic.chat.use = true

--[[
This is where you say what corner of the screen you want the tabbed chat on
Valid settings are "topright", "topleft", "bottomright", "bottomleft"
]]--
demonnic.chat.config.location = "topright"

--[[
This is a table of channels you would like.
AKA the place you tell the script what tabs you want.
Each entry must be a string. The defaults should be a pretty effective guide.
]]

demonnic.chat.config.channels = {
  "All",
  "Tells",
  "Says",
  "City",
  "Guild",
  "SCTs",
  "OOC",
  "Misc",
  "Combat",
}


--Set this to the name of the channel you want to have everything sent to. 
--Per the default, this would be the "All" channel. If you have a different name for it:
--
--demonnic.chat.config.Alltab = "Bucket"  
--
--And if you don't want it turned on at all:
--
--demonnic.chat.config.Alltab = false

demonnic.chat.config.Alltab = "All"



---------------------------------------------------------------------------------
--                                                                             --
--The infamous blinking stuff!!!                                               --
--                                                                             --
---------------------------------------------------------------------------------

--[[
Do you want tabs to blink when you get new messages, until you click on the tab?
True if yes, false if no.
]]
demonnic.chat.config.blink = true

--How long (in seconds) between blinks? For example, 1 would mean a 1 second pause in between blinks.
demonnic.chat.config.blinkTime = 3

--Blink if the bucket tab ("All" by default, but configured above) is in focus?
demonnic.chat.config.blinkFromAll = false




--Font size for the chat messages

demonnic.chat.config.fontSize = 8

--[[
Should we preserve the formatting of the text. 
Or should we set the background of it to match the window color?
Set this to false if you want the background for all chat to match the background of the window.
Useful if you change the background from black, and don't like the way the pasted chat makes blocks in it
]]

demonnic.chat.config.preserveBackground = false

--[[
Gag the chat lines in the main window?
defaults to false, set to true if you want to gag.
]]

demonnic.chat.config.gag = false

--[[
Number of lines of chat visible at once. 
Will determine how tall the window for the chats is.
]]

demonnic.chat.config.lines = 18

--[[
Number of characters to wrap the chatlines at.
This will also determine how wide the chat windows are.
]]

demonnic.chat.config.width = 75

--[[
Set the color for the active tab. R,G,B format.
The default here is a brightish green
]]

demonnic.chat.config.activeColors = {
  r = 0,
  g = 180,
  b = 0,
}

--[[
Set the color for the inactive tab. R,G,B format.
The default here is a drab grey
]]

demonnic.chat.config.inactiveColors = {
  r = 60,
  g = 60,
  b = 60,
}

--[[
Set the color for the chat window itself. R,G,B format.
Defaulted to the black of my twisted hardened soul. Or something.
]]

demonnic.chat.config.windowColors = {
  r = 0,
  g = 0,
  b = 0,
}

--[[
Set the color for the text on the active tab. Uses color names.
Set the default to purple. So the tab you're looking at, by default will be purple on bright green. 
Did I mention I'm a bit colorblind?
]]

demonnic.chat.config.activeTabText = "purple"

--[[
Set the color for the text on the inactive tabs. Uses color names.
Defaulted this to white. So the tabs you're not looking at will be white text on boring grey background.
]]

demonnic.chat.config.inactiveTabText = "white"

--[[
have to make sure a currentTab is set... 
so we'll use the one for the bucket, or the first one in the channels table
Or, you know... what it's currently set to, if it's already set.
]]
demonnic.chat.currentTab = demonnic.chat.currentTab or demonnic.chat.config.Alltab or demonnic.chat.config.channels[1]
