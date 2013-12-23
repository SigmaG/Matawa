-- MTW : chat alignment functions?

function align(str,options) --str is a string, options is a table
--[[ If they sent anything but a table as the second argument, return useful
info. But if they didn't send a second argument then that's ok, the defaults
will be enough to get by and just center the txt
]]--
  if (type(options) ~= "table") and (options ~= nil) then return "You call this with align(\"some text to format\", <table of options>. Pls check comments for what options and usage information" end
  options = options or {} --if they sent options, don't overwrite them
  options.width = options.width or 80 --default line length of 80
  options.alignment = options.alignment or "center" --if we don't specify, it's centered
  options.cap = options.cap or "" --default endcap of nothing (an empty string, technically)
  options.spacer = options.spacer or " " --default spacer is.. well.. space
  options.inside = options.inside or false --by default, when centering, formation as spacers|cap|text|cap|spacers
  if not options.mirror == false then options.mirror = options.mirror or true end--by default, we do want to use mirroring for the caps
  local strLen = string.len(str)
  local leftCap = options.cap
  local rightCap = options.cap
  local leftPadLen = math.floor((options.width - strLen)/2,1) - 1
  local rightPadLen = leftPadLen + ((options.width - strLen)%2)
  local maxPad = 0
  local capLen = string.len(options.cap)
  if capLen > leftPadLen then --if the cap is bigger than the left total padding
    options.cap = options.cap:sub(1, leftPadLen) -- trim it up right!
    capLen = string.len(options.cap)
  end --otherwise, don't mess with it

 
  if options.alignment == "center" then --we're going to center something
    leftPadLen = math.floor((options.width - strLen)/2,1) - 1 --get the padding needed on the left
    rightPadLen = leftPadLen + ((options.width - strLen)%2) --and on the right
    if options.mirror then --if we're reversing the left cap and the right cap (IE {{[[ turns into ]]}} )
      rightCap = string.gsub(rightCap, "<", ">")
      rightCap = string.gsub(rightCap, "%[", "%]")
      rightCap = string.gsub(rightCap, "{", "}")
      rightCap = string.gsub(rightCap, "%(", "%)")
      rightCap = string.reverse(rightCap)
    end --otherwise, they'll be the same, so don't do anything
    str = string.format(" %s ", str)
   
  elseif options.alignment == "right" then --we'll right-align the text
    leftPadLen = options.width - strLen - 1
    rightPadLen = 0
    rightCap = ""
    str = string.format(" %s", str)
   
  else --Ok, so if it's not center or right, we assume it's left. We don't do justified. Sorry.
    leftPadLen = 0
    rightPadLen = options.width - strLen -1
    leftCap = ""
    str = string.format("%s ", str)
  end--that's it, took care of both left, right, and center formattings, now to output the durn thing.
 
  if options.inside then
  --if we're placing the repated spacer inside
  --"=====endcap some text endcap====="
  --"=====endcap some text pacdne====="
  --"=================endcap some text"
  --"some text endcap================="
    return leftCap .. string.rep(options.spacer, (leftPadLen - capLen)) .. str ..string.rep(options.spacer, (rightPadLen - capLen)).. rightCap
  else
  --otherwise, it''s be the spaces on the 'inside'
  -- "endcap===== some text =====endcap"
  -- "endcap===== some text =====pacdne"
  -- "endcap================= some text"
  -- "some text =================endcap"
    return string.rep(options.spacer, (leftPadLen - capLen)) .. leftCap .. str .. rightCap .. string.rep(options.spacer, (rightPadLen - capLen))
  end
end


function calign(str,options) --str is a string, options is a table
--[[ If they sent anything but a table as the second argument, return useful 
info. But if they didn't send a second argument then that's ok, the defaults 
will be enough to get by and just center the txt
]]--
  if (not type(options) == "table") and (not options == nil) then return "You call this with align(\"some text to format\", <table of options>. Pls check comments for what options and usage information" end 
  options = options or {} --if they sent options, don't overwrite them
  options.width = options.width or 80 --default line length of 80
  options.alignment = options.alignment or "center" --if we don't specify, it's centered
  options.cap = options.cap or "" --default endcap of nothing (an empty string, technically)
  options.spacer = options.spacer or " " --default spacer is.. well.. space
  options.inside = options.inside or false --by default, when centering, formation as spacers|cap|text|cap|spacers
  options.capColor = options.capColor or "<white>"--by default, don't change the color of the caps
  options.spacerColor = options.spacerColor or "<white>"
  options.textColor = options.textColor or "<white>"--or the text
  if not options.mirror == false then options.mirror = options.mirror or true end--by default, we do want to use mirroring for the caps
  local strLen = string.len(str)
  local leftCap = options.cap
  local rightCap = options.cap
  local leftPadLen = math.floor((options.width - strLen)/2,1) - 1
  local rightPadLen = leftPadLen + ((options.width - strLen)%2)
  local maxPad = 0
  local capLen = string.len(options.cap)
  if capLen > leftPadLen then --if the cap is bigger than the left total padding
    options.cap = options.cap:sub(1, leftPadLen) -- trim it up right!
    capLen = string.len(options.cap)
  end --otherwise, don't mess with it

  
  if options.alignment == "center" then --we're going to center something
    leftPadLen = math.floor((options.width - strLen)/2,1) - 1 --get the padding needed on the left
    rightPadLen = leftPadLen + ((options.width - strLen)%2) --and on the right
    if options.mirror then --if we're reversing the left cap and the right cap (IE {{[[ turns into ]]}} )
      rightCap = string.gsub(rightCap, "<", ">")
      rightCap = string.gsub(rightCap, "%[", "%]")
      rightCap = string.gsub(rightCap, "{", "}")
      rightCap = string.gsub(rightCap, "%(", "%)")
      rightCap = string.reverse(rightCap)
    end --otherwise, they'll be the same, so don't do anything
    str = string.format(" %s ", str)
    
  elseif options.alignment == "right" then --we'll right-align the text
    leftPadLen = options.width - strLen - 1
    rightPadLen = 0
    rightCap = ""
    str = string.format(" %s", str)
    
  else --Ok, so if it's not center or right, we assume it's left. We don't do justified. Sorry.
    leftPadLen = 0
    rightPadLen = options.width - strLen -1
    leftCap = ""
    str = string.format("%s ", str)
  end--that's it, took care of both left, right, and center formattings, now to output the durn thing. 
  
  if options.inside then 
  --if we're placing the repated spacer inside
  --"=====endcap some text endcap=====" 
  --"=====endcap some text pacdne====="
  --"=================endcap some text" 
  --"some text endcap================="
    return options.capColor .. leftCap .. options.spacerColor.. string.rep(options.spacer, (leftPadLen - capLen)) .. options.textColor .. str .. options.spacerColor ..string.rep(options.spacer, (rightPadLen - capLen)) .. options.capColor .. rightCap
  else 
  --otherwise, it''s be the spaces on the 'inside'
  -- "endcap===== some text =====endcap"
  -- "endcap===== some text =====pacdne" 
  -- "endcap================= some text" 
  -- "some text =================endcap"
    return options.spacerColor .. string.rep(options.spacer, (leftPadLen - capLen)) .. options.capColor .. leftCap .. options.textColor .. str .. options.capColor .. rightCap .. options.spacerColor .. string.rep(options.spacer, (rightPadLen - capLen))
  end
end

function dalign(str,options) --str is a string, options is a table
--[[ If they sent anything but a table as the second argument, return useful 
info. But if they didn't send a second argument then that's ok, the defaults 
will be enough to get by and just center the txt
]]--
  if (not type(options) == "table") and (not options == nil) then return "You call this with align(\"some text to format\", <table of options>. Pls check comments for what options and usage information" end 
  options = options or {} --if they sent options, don't overwrite them
  options.width = options.width or 80 --default line length of 80
  options.alignment = options.alignment or "center" --if we don't specify, it's centered
  options.cap = options.cap or "" --default endcap of nothing (an empty string, technically)
  options.spacer = options.spacer or " " --default spacer is.. well.. space
  options.inside = options.inside or false --by default, when centering, formation as spacers|cap|text|cap|spacers
  options.capColor = options.capColor or "<255,255,255>"--by default, don't change the color of the caps
  options.spacerColor = options.spacerColor or "<255,255,255>" 
  options.textColor = options.textColor or "<255,255,255>"--or the text
  if not options.mirror == false then options.mirror = options.mirror or true end--by default, we do want to use mirroring for the caps
  local strLen = string.len(str)
  local leftCap = options.cap
  local rightCap = options.cap
  local leftPadLen = math.floor((options.width - strLen)/2,1) - 1
  local rightPadLen = leftPadLen + ((options.width - strLen)%2)
  local maxPad = 0
  local capLen = string.len(options.cap)
  if capLen > leftPadLen then --if the cap is bigger than the left total padding
    options.cap = options.cap:sub(1, leftPadLen) -- trim it up right!
    capLen = string.len(options.cap)
  end --otherwise, don't mess with it

  
  if options.alignment == "center" then --we're going to center something
    leftPadLen = math.floor((options.width - strLen)/2,1) - 1 --get the padding needed on the left
    rightPadLen = leftPadLen + ((options.width - strLen)%2) --and on the right
    if options.mirror then --if we're reversing the left cap and the right cap (IE {{[[ turns into ]]}} )
      rightCap = string.gsub(rightCap, "<", ">")
      rightCap = string.gsub(rightCap, "%[", "%]")
      rightCap = string.gsub(rightCap, "{", "}")
      rightCap = string.gsub(rightCap, "%(", "%)")
      rightCap = string.reverse(rightCap)
    end --otherwise, they'll be the same, so don't do anything
    str = string.format(" %s ", str)
    
  elseif options.alignment == "right" then --we'll right-align the text
    leftPadLen = options.width - strLen - 1
    rightPadLen = 0
    rightCap = ""
    str = string.format(" %s", str)
    
  else --Ok, so if it's not center or right, we assume it's left. We don't do justified. Sorry.
    leftPadLen = 0
    rightPadLen = options.width - strLen -1
    leftCap = ""
    str = string.format("%s ", str)
  end--that's it, took care of both left, right, and center formattings, now to output the durn thing. 
  
  if options.inside then 
  --if we're placing the repated spacer inside
  --"=====endcap some text endcap=====" 
  --"=====endcap some text pacdne====="
  --"=================endcap some text" 
  --"some text endcap================="
    return options.capColor .. leftCap .. options.spacerColor.. string.rep(options.spacer, (leftPadLen - capLen)) .. options.textColor .. str .. options.spacerColor ..string.rep(options.spacer, (rightPadLen - capLen)) .. options.capColor .. rightCap
  else 
  --otherwise, it''s be the spaces on the 'inside'
  -- "endcap===== some text =====endcap"
  -- "endcap===== some text =====pacdne" 
  -- "endcap================= some text" 
  -- "some text =================endcap"
    return options.spacerColor .. string.rep(options.spacer, (leftPadLen - capLen)) .. options.capColor .. leftCap .. options.textColor .. str .. options.capColor .. rightCap .. options.spacerColor .. string.rep(options.spacer, (rightPadLen - capLen))
  end
end

function halign(str,options) --str is a string, options is a table
--[[ If they sent anything but a table as the second argument, return useful 
info. But if they didn't send a second argument then that's ok, the defaults 
will be enough to get by and just center the txt
]]--
  if (not type(options) == "table") and (not options == nil) then return "You call this with align(\"some text to format\", <table of options>. Pls check comments for what options and usage information" end 
  options = options or {} --if they sent options, don't overwrite them
  options.width = options.width or 80 --default line length of 80
  options.alignment = options.alignment or "center" --if we don't specify, it's centered
  options.cap = options.cap or "" --default endcap of nothing (an empty string, technically)
  options.spacer = options.spacer or " " --default spacer is.. well.. space
  options.inside = options.inside or false --by default, when centering, formation as spacers|cap|text|cap|spacers
  options.capColor = options.capColor or "|cFFFFFF"--by default, don't change the color of the caps
  options.spacerColor = options.spacerColor or "|cFFFFFF" 
  options.textColor = options.textColor or "|cFFFFFF"--or the text
  if not options.mirror == false then options.mirror = options.mirror or true end--by default, we do want to use mirroring for the caps
  local strLen = string.len(str)
  local leftCap = options.cap
  local rightCap = options.cap
  local leftPadLen = math.floor((options.width - strLen)/2,1) - 1
  local rightPadLen = leftPadLen + ((options.width - strLen)%2)
  local maxPad = 0
  local capLen = string.len(options.cap)
  if capLen > leftPadLen then --if the cap is bigger than the left total padding
    options.cap = options.cap:sub(1, leftPadLen) -- trim it up right!
    capLen = string.len(options.cap)
  end --otherwise, don't mess with it

  
  if options.alignment == "center" then --we're going to center something
    leftPadLen = math.floor((options.width - strLen)/2,1) - 1 --get the padding needed on the left
    rightPadLen = leftPadLen + ((options.width - strLen)%2) --and on the right
    if options.mirror then --if we're reversing the left cap and the right cap (IE {{[[ turns into ]]}} )
      rightCap = string.gsub(rightCap, "<", ">")
      rightCap = string.gsub(rightCap, "%[", "%]")
      rightCap = string.gsub(rightCap, "{", "}")
      rightCap = string.gsub(rightCap, "%(", "%)")
      rightCap = string.reverse(rightCap)
    end --otherwise, they'll be the same, so don't do anything
    str = string.format(" %s ", str)
    
  elseif options.alignment == "right" then --we'll right-align the text
    leftPadLen = options.width - strLen - 1
    rightPadLen = 0
    rightCap = ""
    str = string.format(" %s", str)
    
  else --Ok, so if it's not center or right, we assume it's left. We don't do justified. Sorry.
    leftPadLen = 0
    rightPadLen = options.width - strLen -1
    leftCap = ""
    str = string.format("%s ", str)
  end--that's it, took care of both left, right, and center formattings, now to output the durn thing. 
  
  if options.inside then 
  --if we're placing the repated spacer inside
  --"=====endcap some text endcap=====" 
  --"=====endcap some text pacdne====="
  --"=================endcap some text" 
  --"some text endcap================="
    return options.capColor .. leftCap .. options.spacerColor.. string.rep(options.spacer, (leftPadLen - capLen)) .. options.textColor .. str .. options.spacerColor ..string.rep(options.spacer, (rightPadLen - capLen)) .. options.capColor .. rightCap
  else 
  --otherwise, it''s be the spaces on the 'inside'
  -- "endcap===== some text =====endcap"
  -- "endcap===== some text =====pacdne" 
  -- "endcap================= some text" 
  -- "some text =================endcap"
    return options.spacerColor .. string.rep(options.spacer, (leftPadLen - capLen)) .. options.capColor .. leftCap .. options.textColor .. str .. options.capColor .. rightCap .. options.spacerColor .. string.rep(options.spacer, (rightPadLen - capLen))
  end
end
