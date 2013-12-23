-- MTW: bashing aliases

function mtw.start_bashing()
mtw.toggles.bashing = true
cecho("<green>Bashing ON!")
send(" ")
mtw.waiting.ih = false
mtw.do_bashing()
end

function mtw.stop_bashing()
mtw.toggles.bashing = false
mtw.inquartata = false
cecho("<green>Bashing OFF!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
if cnvrt then killTrigger(cnvrt) end
end

function mtw.load_targets_alias(matches)
mtw.possible_targets = {}
mtw.bashing.target_type = "short"
mtw.bashing.target_priority = 10000
for i in string.gmatch(matches[2], "(%w+)") do
 table.insert(mtw.possible_targets, i)
end
cecho("<green>Targets Received:")
for h in ipairs(mtw.possible_targets) do
 cecho("\n "..mtw.possible_targets[h])
end
send(" ")
end

function mtw.stop_bashing_after_next_kill()
mtw.bashing.stopping = true
cecho("<green>Bashing OFF after next kill!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
end

function mtw.hunt_pumpkins()
mtw.my.area = "pumpkins"
mtw.load_targets("pumpkins")
send(" ")
end

function mtw.hunt_wyrms()
mtw.my.area = "MoteHunt"
mtw.load_targets("MoteHunt")
send(" ")
end

function mtw.bash_one()
mtw.toggles.bashing = true
cecho("<green>Bashing ON!")
send(" ")
mtw.waiting.ih = false
mtw.do_bashing()

mtw.bashing.stopping = true
cecho("<green>Bashing OFF after next kill!")
if mtw.toggles.fasthunt then
 mtw.toggles.fasthunt = false
 echo("\nFasthunt OFF!")
 send(" ")
else
 send(" ")
end
end


