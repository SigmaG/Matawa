-- MTW : utils to help with managing the GUI

function mtw.gui.update_window_size()
 gui.w,gui.h = getMainWindowSize()
end

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

function mtw.gui.parse_constraints(cons)
 if type(cons) == "table" then
  return cons
 else
  local r = assert(loadstring(cons))()
  while type(r) == "function" do
   r = r()
  end
  return r
 end
end