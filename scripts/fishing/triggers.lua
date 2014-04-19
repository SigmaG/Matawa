-- MTW : functions executed by fishing triggers

function mtw.fishing_trigger_1(matches,multimatches)
if not (mtw.fishing.stat == "reeling") and string.find(mtw.fishing.get,matches[2]) then
 tempTimer( 1.5, [[send("fishing jerk")]] )
 mtw.fishing.stat = "waiting"
else
 echo("\nNot getting that one!")
 tempTimer(mtw.delay(), [[send(" ")]])
 mtw.fishing.stat = "reeling"
 mtw.fishing.recast = true
end
end

function mtw.fishing_trigger_2(matches,multimatches)
tempTimer( 1.8, [[send("fishing tease", false)]] )
end

function mtw.fishing_trigger_3(matches,multimatches)
mtw.fishing.stat = "reeling"
mtw.fishing.reels = 1
send(" ")
end

function mtw.fishing_trigger_4(matches,multimatches)
send("fishing reel")
mtw.fishing.recast = false
mtw.fishing.stat = "baiting"
end

function mtw.fishing_trigger_5(matches,multimatches)
mtw.waiting.balance = true
if mtw.vitals.current.endurance > mtw.fishing.min_end then
 mtw.fishing.stat = "baiting"
else
 mtw.fishing.stat = "sitting"
end
end

function mtw.fishing_trigger_6(matches,multimatches)
if mtw.fishing.recast then
 mtw.fishing.recast = false
 mtw.fishing.stat = "casting"
end
end

function mtw.fishing_trigger_7(matches,multimatches)
local dist = tonumber(matches[2])
mtw.fishing.failures = 0
if dist > mtw.fishing.max_cast and mtw.fishing.max_cast > 0 then
 mtw.fishing.stat = "reeling"
 mtw.fishing.recast = true
else
 mtw.fishing.stat = "teasing"
end
end

function mtw.fishing_trigger_8(matches,multimatches)
mtw.fishing.stat = "none"
echo("\nInvalid Direction! DR to set one!")
end

function mtw.fishing_trigger_9(matches,multimatches)
if mtw.toggles.fishing then
 send("unwield left")
 send("unwield right")
 send("wield pole")
end
end

function mtw.fishing_trigger_10(matches,multimatches)
mtw.fishing.stat = "none"
echo("\nNo Bait!")
end

function mtw.fishing_trigger_11(matches,multimatches)
if not (mtw.fishing.stat == "reeling" or mtw.fishing.stat == "waiting") then
 mtw.fishing.stat = "waiting"
end
end

function mtw.fishing_trigger_12(matches,multimatches)
mtw.fishing.failures = mtw.fishing.failures + 1
if mtw.fishing.failures == 2 then
 mtw.fishing.failures = 0
 send("fishing reel")
 mtw.fishing.stat = "casting"
 mtw.fishing.recast = true
end
end

function mtw.fishing_trigger_13(matches,multimatches)
if mtw.waiting.probe then
 mtw.fishing.probe = true
 mtw.fishing.recast = false
 mtw.waiting.probe = false
 mtw.fishing.stat = "baiting"
 tempTimer(0.5,[[mtw.toggle("fishing")]])
end
end

function mtw.fishing_trigger_14(matches,multimatches)
if mtw.fishing.probe then
 mtw.fishing.recast = true
 mtw.fishing.stat = "casting"
end
end

function mtw.fishing_trigger_15(matches,multimatches)
if mtw.toggles.fishing then
 echo("No more bait!\n")
 mtw.toggle("fishing")
end
end

function mtw.fishing_trigger_16(matches,multimatches)
if mtw.fishing.stat == "reeling" and tonumber(matches[3]) > mtw.fishing.max_dist and mtw.fishing.max_dist > 0 then
 mtw.fishing.stat = "cutting"
end
end

function mtw.fishing_trigger_17(matches,multimatches)
 mtw.fishing.stat = "casting"
end

function mtw.fishing_trigger_18(matches,multimatches)
 mtw.fishing.failures = -1
end
