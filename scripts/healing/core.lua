-- MTW: core 'healing' functions


function mtw.do_core()
 mtw.balance_check()
 mtw.defending_check()
 mtw.aff_check()
 mtw.def_check()
 if not mtw.toggles.paused and not mtw.channeling() then
  if mtw.have_slow() then
   mtw.do_slow()
  else
   if mtw.am_functional() and mtw.not_aff("sleep") then
--    mtw.do_action()
    mtw.do_balance()
    mtw.do_equil()
    if table.contains(mtw.skills, "psionics") then
     mtw.do_psi()
    end
    if table.contains(mtw.skills, "swordmastery") then
     mtw.do_offhand()
    end
   end
   if mtw.toggles.healing then
    mtw.do_healing()
   end
   if mtw.toggles.bashing then
    mtw.do_bashing()
   end
   if mtw.toggles.fishing then
    mtw.do_fishing()
   end
   if mtw.toggles.mining then
    mtw.do_mining()
   end
  end
 end
end

--healing

function mtw.do_healing()
 if mtw.toggles.healing and mtw.am_functional() then
  if mtw.have_aff("sleep") and mtw.toggles.standing and (not mtw.status.waking) and (not mtw.waiting.wake) then
   echo("(wake)")
   mtw.send("wake")
   mtw.waiting.wake = true
   tempTimer( mtw.delay(), [[mtw.waiting.wake = false]] )
  end
  if mtw.not_aff("sleep") then
   if mtw.need_wield and mtw.balance.balance and (not mtw.waiting.wield) and mtw.fleeing == false then
    mtw.send("wield "..mtw.my.weapon.." right")
    mtw.waiting.wield = true
    tempTimer(mtw.delay(), [[mtw.waiting.wield = false]])
   end
   if mtw.need_offwield and mtw.balance.balance and (not mtw.waiting.offwield) and (not mtw.waiting.wield and not mtw.need_wield) and mtw.fleeing == false then
    mtw.send("wield "..mtw.my.offweapon.." left")
    mtw.waiting.offwield = true
    tempTimer(mtw.delay(), [[mtw.waiting.offwield = false]])
   end
   if mtw.need_loot and mtw.toggles.gathering and mtw.fleeing == false then
    mtw.do_loot()
   end
   mtw.do_diag()
   mtw.do_counter()
   mtw.do_queue()
   mtw.do_stuff()
   if mtw.balance.equilibrium and not mtw.waiting.equilibrium then
    if mtw.have_aff("blackout") then
     if table.contains(mtw.skills, "Repulse") then
      if mtw.next.equil ~= "repulse" then
       mtw.set_equil("repulse")
      end
     else
      if mtw.next.equil ~= "block" then
       mtw.set_equil("block")
      end
     end
--    elseif mtw.have_aff("commanded") then
--     mtw.queue_diag()
    end
   end
  end
 end
end

--bashing

function mtw.do_bashing()
 if (not mtw.bashing.targeted) and (not mtw.waiting.ih) then
  mtw.corpses = {}
  mtw.gathering = {}
  mtw.send("ih")
  mtw.waiting.ih = true
 end
 if mtw.balance.equilibrium and not mtw.waiting.equilibrium and mtw.bashing.engaged then
  mtw.do_bashing_eq()
 end
 if mtw.balance.balance and not mtw.waiting.balance and not mtw.waiting.bash then
  if mtw.bashing.targeted then
   mtw.waiting.balance = true
   mtw.waiting.bash = true
   tempTimer((0.5-math.floor(getNetworkLatency())), [[mtw.waiting.balance = false]])
   resetStopWatch(mtw.waiting_bashcheck)
   startStopWatch(mtw.waiting_bashcheck)
   --tempTimer((mtw.delay()-math.floor(getNetworkLatency())), [[mtw.waiting.bash = false]])
   mtw.bashing_function()
  end
 end
 if mtw.balance.psi and not mtw.waiting.psi and table.contains(mtw.skills, "Mindblast") and mtw.bashing.targeted and mtw.bashing.engaged and mtw.enemy_health ~= "<red> 0-10%" and mtw.enemy_health ~= "<red> 10-25%" and mtw.toggles.mindblasting then
  mtw.waiting.psi = true
  tempTimer(1, [[mtw.waiting.psi = false]])
  mtw.send("psi mindblast "..mtw.bashing.target)
 end
 if mtw.balance.focus and not mtw.waiting.focus and mtw.vitals.adrenaline >= 90 and mtw.bashing.targeted and mtw.toggles.dominating and table.contains(mtw.skills, "Dominating Strike") then
  mtw.waiting.focus = true
  tempTimer(1, [[mtw.waiting.focus = false]])
  mtw.send("warcall dominate "..mtw.bashing.target)
 end
end

function mtw.do_bashing_eq()
  if mtw.my.class == "rogue" and table.contains(mtw.skills, "Shadowmend") and mtw.defenses.def_shadowmend.state ~= "deffed" and mtw.toggles.shadowmending and (tonumber(gmcp.Char.Vitals.gp) >= 50) then
  mtw.send("shadowmend")
  mtw.bashing.shadowmend = true
  mtw.waiting.equilibrium = true
  tempTimer(1, [[mtw.waiting.equilibrium = false]])
 end
end

