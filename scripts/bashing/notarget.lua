-- MTW: what to do when there's no target

function mtw.no_target()
 deleteLine()
 cecho("\n<green>Need new targets!")
 mtw.untarget()
 mtw.waiting.ih = false
 mtw.waiting.balance = false
 mtw.bashing.target_priority = 10000
end

function mtw.untarget()
 mtw.bashing.engaged = false
 mtw.bashing.targeted = false
 if mtw.toggles.looping then
  mtw.toggle("looping")
 end
 for i in pairs(mtw.used) do
  mtw.used[i] = false
 end
 if mtw.next.balance ~= "flee" then
  mtw.next.balance = "none"
 end
 if mtw.bashing.stopping then
  cecho("\n<green>Bashing OFF!")
  mtw.toggles.bashing = false
  mtw.bashing.stopping = false
 end
end
