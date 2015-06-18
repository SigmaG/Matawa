-- MTW: fishing aliases

function mtw.fishing_direction(matches)
mtw.fishing.dir = matches[2]
echo("Direction is: "..mtw.fishing.dir)
send(" ")
end

function mtw.toggle_fishing()
if (not mtw.fishing.min_end) then mtw.fishing.min_end = 0 end
if (not mtw.fishing.max_cast) then mtw.fishing.max_cast = 0 end
if (not mtw.fishing.max_dist) then mtw.fishing.max_dist = 0 end
if (not mtw.fishing.get) then mtw.fishing.get = "sml" end
if mtw.toggles.fishing then
 if mtw.fishing.stat == "waiting" then send("fishing reel") end
 mtw.toggle("fishing")
else
 --check if pole is wielded
 if not (mtw.is_wielded("quicksilver fishing pole") or mtw.is_wielded("fishing pole")) then
  mtw.unwielding = true
  tempTimer(1, [[mtw.unwielding = false]])
  send("unwield left")
  send("unwield right")
  send("wield pole")
  mtw.waiting.balance = true
  tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
 end
 send("probe pole")
 mtw.waiting.probe = true
end
end

function mtw.bait_type(matches)
mtw.fishing.bait = matches[2]
echo("Bait is: "..mtw.fishing.bait)
send(" ")
end

function mtw.fishing_distance(matches)
local d = matches[2]:lower()
if d == "" or d == "short" or d == "s" then
 mtw.fishing.distance = ""
 echo("Distance is: short")
elseif d == "l" or d == "long" then
 mtw.fishing.distance = "long"
 echo("Distance is: long")
elseif d == "m" or d == "medium" then
 mtw.fishing.distance = "medium"
 echo("Distance is: medium")
else
 echo("Invalid choice of distance! Short, medium or long are the options.\n")
end
send(" ")
end

function mtw.fast_fishing()
if mtw.fishing.fastfish then
 mtw.fishing.fastfish = false
 echo("Fastfish OFF!")
 send(" ")
else
 mtw.fishing.fastfish = true
 echo("Fastfish ON!")
 send(" ")
end
end

function mtw.set_max_line_length(matches)
mtw.fishing.max_dist = tonumber(matches[2])
if mtw.fishing.max_dist > 0 then
 echo("Cut line after : "..matches[2].." feet")
else
 echo("No length limit")
end
send(" ")
end

function mtw.set_max_cast_length(matches)
mtw.fishing.max_cast = tonumber(matches[2])
if mtw.fishing.max_cast > 0 then
 echo("No cast longer than : "..matches[2].." yards")
else
 echo("No casting limit")
end
send(" ")
end

function mtw.fishing_endurance(matches)
mtw.fishing.min_end = tonumber(matches[2])
echo("Minimum endurance before recast : "..matches[2])
send(" ")
end

function mtw.fishing_set_type(matches)
mtw.fishing.get = ""
local x = ""
local s = ""
local r = ""
for i = 2,4 do
 if not matches[i] then break end
 if i > 2 then
  x = string.sub(matches[i],2,2):lower()
 else
  x = string.sub(matches[2],1,1):lower()
 end
 mtw.fishing.get = mtw.fishing.get..x
end
if string.find(mtw.fishing.get,"s") then
 s = "Small"
 r = "s"
end
if string.find(mtw.fishing.get,"m") then
 if s == "" then
  s = "Medium"
  r = "m"
 else
  s = s.."/Medium"
  r = "sm"
 end
end
if string.find(mtw.fishing.get,"l") then
 if s == "" then
  s = "Large"
  r = "l"
 else
  s = s .. "/Large"
  r = r.."l"
 end
end
if r == "" then
 mtw.fishing.get = "sml"
 s = "Small/Medium/Large"
end
echo("Now getting "..s.." fish")
send(" ")
end

function mtw.fishing_set_tease_time(matches)
 mtw.fishing.tease_time = tonumber(matches[2])
 echo("Now teasing after "..matches[2].." seconds")
 send(" ")
end

function mtw.fishing_set_jerk_time(matches)
 mtw.fishing.jerk_time = tonumber(matches[2])
 echo("Now jerking after "..matches[2].." seconds")
 send(" ")
end