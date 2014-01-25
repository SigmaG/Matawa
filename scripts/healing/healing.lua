-- MTW: healing functions

--stand

function mtw.do_stand(current)
 if mtw.have_aff(current) then
  if mtw.toggles.standing and (not mtw.waiting.stand) and not mtw.stand_queued and table.contains(mtw.skills, "Balance Queue") and mtw.not_slow() then
   echo("(stand)")
   mtw.last_type = "stand"
   mtw.last_item = "send"
   mtw.send("bq insert 1 stand")
   if mtw.have_aff("blackout") then
    mtw.send("bq insert 1 wake")
   end
   mtw.waiting.stand = true
   tempTimer(mtw.delay(), [[mtw.waiting.stand = false]])
   mtw.afflictions[current].state = "waiting"
   startStopWatch(mtw.afflictions[current].timer)
  elseif mtw.toggles.standing and (not mtw.waiting.stand) and mtw.balance.balance and not mtw.waiting.balance then
   if mtw.have_aff("blackout") then
    mtw.send("wake")
   end
   mtw.send("stand")
   if mtw.not_slow() then
    echo("(stand)")
    mtw.last_type = "stand"
    mtw.last_item = "send"
    mtw.waiting.stand = true
    tempTimer(mtw.delay(), [[mtw.waiting.stand = false]])
    mtw.afflictions[current].state = "waiting"
    startStopWatch(mtw.afflictions[current].timer)
   end
  end
 end
end

--balance, equilibrium

function mtw.do_special(current)
 mtw.send(mtw.defenses[current].balance.special)
 if mtw.not_slow() then
  echo(" ("..mtw.defenses[current].balance.special..")")
  mtw.defenses[current].state = "waiting"
  startStopWatch(mtw.defenses[current].timer)
 end
end

function mtw.do_balance_need(current)
 if mtw.balance.balance and (not mtw.waiting.balance) then
  mtw.send(mtw.defenses[current].balance.balanceneed)
  if mtw.not_slow() then
   echo(" ("..mtw.defenses[current].balance.balanceneed..")")
   mtw.defenses[current].state = "waiting"
   startStopWatch(mtw.defenses[current].timer)
  end
 end
end

function mtw.do_equilibrium_need(current)
 if mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  mtw.send(mtw.defenses[current].balance.equilibriumneed)
  if mtw.not_slow() then
   echo(" ("..mtw.defenses[current].balance.equilibriumneed..")")
   mtw.defenses[current].state = "waiting"
   startStopWatch(mtw.defenses[current].timer)
  end
 end
end

function mtw.do_balance_equilibrium_need(current)
 if mtw.balance.balance and (not mtw.waiting.balance) and mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  echo(" ("..mtw.defenses[current].balance.balanceequilibriumneed..")")
  mtw.send(mtw.defenses[current].balance.balanceequilibriumneed)
  mtw.defenses[current].state = "waiting"
  startStopWatch(mtw.defenses[current].timer)
 end
end

function mtw.do_balance_take(current)
 if mtw.balance.balance and (not mtw.waiting.balance) then
  if current == "def_hiding" then
   if mtw.status.combat or mtw.toggles.bashing then
    return
   end
   if mtw.toggles.fishing then
    if mtw.fishing.stat ~= "waiting" then
     return
    end
   end
  end
  echo(" ("..mtw.defenses[current].balance.balancetake..")")
  mtw.send(mtw.defenses[current].balance.balancetake)
  mtw.defenses[current].state = "waiting"
  mtw.waiting.balance = true
  startStopWatch(mtw.defenses[current].timer)
  tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
 end
end

function mtw.do_equilibrium_take(current)
 if mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  if current == "def_enrage" then
   if not mtw.balance.rage then
    return
   end
  end
  if current == "def_immunity" then
   if not mtw.balance.immunity then
    return
   end
  end
  echo(" ("..mtw.defenses[current].balance.equilibriumtake..")")
  mtw.send(mtw.defenses[current].balance.equilibriumtake)
  mtw.defenses[current].state = "waiting"
  startStopWatch(mtw.defenses[current].timer)
  mtw.waiting.equilibrium = true
  tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
 end
end

function mtw.do_needy_balance_take(current)
 if mtw.balance.balance and (not mtw.waiting.balance) and mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  if current == "def_last_stand" then
   if mtw.balance.last_stand then
    echo(" ("..mtw.defenses[current].balance.needybalancetake..")")
    mtw.send(mtw.defenses[current].balance.needybalancetake)
    mtw.defenses[current].state = "waiting"
    startStopWatch(mtw.defenses[current].timer)
    mtw.waiting.balance = true
    tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
   end
  else
   echo(" ("..mtw.defenses[current].balance.needybalancetake..")")
   mtw.send(mtw.defenses[current].balance.needybalancetake)
   mtw.defenses[current].state = "waiting"
   startStopWatch(mtw.defenses[current].timer)
   mtw.waiting.balance = true
   tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
  end
 end
end

function mtw.do_needy_equilibrium_take(current)
 if mtw.balance.balance and (not mtw.waiting.balance) and mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  echo(" ("..mtw.defenses[current].balance.needyequilibriumtake..")")
  mtw.send(mtw.defenses[current].balance.needyequilibriumtake)
  mtw.defenses[current].state = "waiting"
  startStopWatch(mtw.defenses[current].timer)
  mtw.waiting.equilibrium = true
  tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
 end
end

function mtw.do_balance_equilibrium_take(current)
 if mtw.balance.balance and (not mtw.waiting.balance) and mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
  echo(" ("..mtw.defenses[current].balance.balanceequilibrium..")")
  mtw.send(defenses[current].balance.balanceequilibrium)
  mtw.defenses[current].state = "waiting"
  startStopWatch(mtw.defenses[current].timer)
  mtw.waiting.balance = true
  tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
  mtw.waiting.equilibrium= true
  tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]])
 end
end

--writhe
function mtw.do_writhe(current)
 if mtw.have_aff(current) then
  if (not mtw.status.writhing) and (not mtw.waiting.writhe) and mtw.not_aff("dystrophy") then
   if table.contains(mtw.skills, "Contort") and mtw.vitals.adrenaline >= 20 and mtw.balance.equilibrium and not mtw.waiting.equilibrium then
    if mtw.not_slow() then
     echo("(contort)")
    end
    mtw.send("contort")
   else
    if mtw.not_slow() then
     echo("(writhe)")
    end
    mtw.send("writhe")
   end
   if mtw.not_slow() then
    mtw.last_type = "writhe"
    mtw.last_item = "send"
    mtw.waiting.writhe = true
    tempTimer(mtw.delay(), [[mtw.waiting.writhe = false]])
    mtw.afflictions[current].state = "waiting"
    startStopWatch(mtw.afflictions[current].timer)
   end
  end
 end
end

--focus
function mtw.do_focus(current)
 if mtw.afflictions[current].state == "afflicted" and mtw.toggles.focusing then
  if mtw.balance.focus and not mtw.waiting.focus and mtw.vitals.adrenaline > 5 then
   if mtw.have_aff("malaise") and mtw.vitals.adrenaline < 10 then
    return
   end
   if mtw.afflictions[current].cures.focus == "body" and mtw.not_aff("impatience") then
    if string.find(current, "aff_burns_1") then
     if mtw.status.vampire and not mtw.status.combat then
      return
     end
    end
    mtw.focus(current)
   elseif mtw.afflictions[current].cures.focus == "mind" and mtw.not_aff("concussion") then
    mtw.focus(current)
   elseif mtw.afflictions[current].cures.focus == "spirit" and mtw.not_aff("epilepsy") and not (mtw.have_aff("mindmeld") and mtw.have_aff("astral_tether") and mtw.have_aff("astral_warp")) then
    if string.find(current, "ill_omen") then
     if mtw.have_aff("blood_omen") then
      return
     end
    end
    mtw.focus(current)
   end
  end
 end
end

function mtw.focus(current)
 mtw.send("focus "..mtw.afflictions[current].cures.focus)
 if mtw.not_slow() then
  echo("("..mtw.afflictions[current].cures.focus..")")
  mtw.last_type = "focus"
  mtw.last_item = mtw.afflictions[current].cures.focus
  startStopWatch(mtw.afflictions[current].timer)
  mtw.afflictions[current].state = "waiting"
  mtw.waiting.focus = true
  tempTimer(mtw.delay(), [[mtw.waiting.focus = false]] )
 end
end

--overdrive
function mtw.do_overdrive(current)
 if mtw.balance.overdrive and not mtw.waiting.overdrive and mtw.toggles.overdriving and mtw.can_overdrive() then
  if mtw.have_def("spellshield") then
   if mtw.vitals.percent.magic < 80 and (mtw.vitals.adrenaline > 10 or (mtw.vitals.adrenaline > 5 and mtw.toggles.bashing)) then
    mtw.send("overdrive")
    mtw.waiting.overdrive = true
    tempTimer(mtw.delay(), [[mtw.waiting.overdrive = false]])
   end
  else
   if mtw.vitals.percent.health < 80 and (mtw.vitals.adrenaline > 10 or (mtw.vitals.adrenaline > 5 and mtw.toggles.bashing)) then
    mtw.send("overdrive")
    mtw.waiting.overdrive = true
    tempTimer(mtw.delay(), [[mtw.waiting.overdrive = false]] )
   elseif mtw.vitals.percent.magic < 80 and mtw.my.class == "magician" and (mtw.vitals.adrenaline > 10 or (mtw.vitals.adrenaline > 5 and mtw.toggles.bashing)) then
    mtw.send("overdrive magic")
    mtw.waiting.overdrive = true
    tempTimer(mtw.delay(), [[mtw.waiting.overdrive = false]] )
   end
  end
 end
end

--reject

function mtw.do_reject(current)
 if mtw.have_aff(current) then
  if mtw.balance.equilibrium and (not mtw.waiting.equilibrium) then
--Ignore mindmeld if afflicted with mental afflictions
   if current == "aff_mindmeld" then
    for i in pairs(mtw.afflictions) do
     if mtw.afflictions[i].cures.focus ~= nil then
      if mtw.afflictions[i].cures.focus == "mind" and mtw.afflictions[i].state ~= "healed" then
       return
      end
     end
    end
   end
   mtw.send("reject "..mtw.reject[mtw.afflictions[current].cures.reject])
   if mtw.not_slow() then
    startStopWatch(mtw.afflictions[current].timer)
    mtw.afflictions[current].state = "waiting"
    mtw.waiting.equilibrium = true
    tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]] )
   end
  end
 end
end

--defend
function mtw.do_def(current)
 if mtw.toggles.defending and mtw.attacks[current].defend_now then
  if getStopWatchTime(mtw.attack_timers[mtw.attacks[current]["attacker"]][current]) <= 5 then
   mtw.def(mtw.attacks[current].def)
  else
   mtw.atk_ended(current)
  end
 end
end

function mtw.def(defense)
 if defense == "parry" then
  if mtw.not_aff("dystonia") then
   mtw.defending.next = "parry"
  elseif mtw.not_aff("cataplexy") then
   mtw.defending.next = "block"
  else
   mtw.defending.next = "none"
  end
 elseif defense == "block" then
  if mtw.not_aff("cataplexy") then
   mtw.defending.next = "block"
  elseif mtw.not_aff("dystonia") then
   mtw.defending.next = "parry"
  else
   mtw.defending.next = "none"
  end
 elseif defense == "jump" then
  if mtw.not_aff("ataxia") then
   mtw.defending.next = "jump"
  elseif mtw.not_aff("maladroitness") then
   mtw.defending.next = "dodge"
  else
   mtw.defending.next = "none"
  end
 elseif defense == "duck" then
  if mtw.not_aff("anemia") then
   mtw.defending.next = "duck"
  elseif mtw.not_aff("maladroitness") then
   mtw.defending.next = "dodge"
  else
   mtw.defending.next = "none"
  end
 elseif defense == "dodge" then
  if mtw.not_aff("maladroitness") then
   mtw.defending.next = "dodge"
  elseif mtw.not_aff("dystonia") then
   mtw.defending.next = "parry"
  else
   mtw.defending.next = "none"
  end
 end
 if (mtw.defending.next == "parry" or mtw.have_def("perfect_defense")) and (mtw.my.class == "soldier") and table.contains(mtw.skills, "Repulse") then
  mtw.defending.next = "repulse"
 end
 if mtw.defending.next ~= "none" and mtw.balance.equilibrium and (not mtw.waiting.equilibrium) and mtw.not_aff("prone") and mtw.vitals.adrenaline > 1 then
  if mtw.status.defending and mtw.defending.current == mtw.defending.next then
   echo("Already defending!")
  else
   mtw.send(mtw.defending.next)
   if mtw.not_slow() then
    echo("("..mtw.defending.next..")")
    mtw.waiting.equilibrium = true
    tempTimer(mtw.delay(), [[mtw.waiting.equilibrium = false]] )
   end
  end
 end
end

--clot
function mtw.do_clot(current)
 if mtw.can_clot() and not mtw.waiting.clotting and mtw.toggles.bleeding then
  if not mtw.status.clotting and not mtw.status.combat and mtw.vitals.adrenaline >= 5 then
   mtw.send("clot")
   mtw.waiting.clotting = true
   tempTimer(mtw.delay(), [[mtw.waiting.clotting = false]] )
  elseif not mtw.status.clotting and mtw.vitals.adrenaline >= 20 then
   mtw.send("clot")
   mtw.waiting.clotting = true
   tempTimer(mtw.delay(), [[mtw.waiting.clotting = false]] )
  elseif (current ~= "aff_bleeding_1") and mtw.vitals.adrenaline >= 80 then
   mtw.send("clot")
   mtw.waiting.clotting = true
   tempTimer(mtw.delay(), [[mtw.waiting.clotting = false]] )
  end
 end
end

--recover balance/eq
function mtw.do_recover(current)
 if current == "aff_balance_loss" and not mtw.recovering_balance and not mtw.waiting.recover then
  mtw.send("recover balance")
  mtw.waiting.recover = true
  tempTimer(mtw.delay(), [[mtw.waiting.recover = false]])
 elseif current == "aff_equilibrium_loss" and not mtw.recovering_equilibrium and not mtw.waiting.recover then
  mtw.send("recover equilibrium")
  mtw.waiting.recover = true
  tempTimer(mtw.delay(), [[mtw.waiting.recover = false]])
 end
end


