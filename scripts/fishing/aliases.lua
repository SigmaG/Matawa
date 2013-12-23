-- MTW: fishing aliases

function mtw.fishing_direction(matches)
mtw.fishing.dir = matches[2]
echo("Direction is: "..mtw.fishing.dir)
send(" ")
end

function mtw.toggle_fishing()
if mtw.toggles.fishing then
 send("fishing reel")
end
mtw.toggle("fishing")
end

function mtw.bait_type(matches)
mtw.fishing.bait = matches[2]
echo("Bait is: "..mtw.fishing.bait)
send(" ")
end

function mtw.fishing_distance(matches)
mtw.fishing.distance = matches[2]
echo("Distance is: "..mtw.fishing.distance)
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


