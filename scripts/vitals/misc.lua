-- MTW: miscellaneous functions


--Translate prompt values to more helpful percentages

mtw.health_table = {
[": Critical"] = "<red> 0-10%",
[": Beaten"] = "<red> 10-25%",
[": Battered"] = "<brown> 25-50%",
[": Wounded"] = "<orange> 50-80%",
[": Hurt"] = "<yellow> 80-95%",
[": Scratched"] = "<dark_green> 95-100%",
[": Healthy"] = "<green> 100%",
[": Dead"] = "<brown> UNDEAD",

[": Cracking"] = "<pink> 0-10%",
[": Fading"] = "<pink> 10-25%",
[": Tiring"] = "<magenta> 25-50%",
[": Strong"] = "<purple> 50-80%",
[": Glowing"] = "<midnight_blue> 80-95%",
[": Shimmering"] = "<blue> 95-100%",
[": Scintillating"] = "<cyan> 100%"
}



--Check for various conditions and return true/false

function mtw.have_aff(affliction)
 if not string.find(affliction, "aff_") then
  affliction = "aff_"..affliction
 end
 if mtw.afflictions[affliction].state == "afflicted" or mtw.afflictions[affliction].state == "waiting" then
  return true
 else
  return false
 end
end

function mtw.not_aff(affliction)
 if not string.find(affliction, "aff_") then
  affliction = "aff_"..affliction
 end
 if mtw.afflictions[affliction].state ~= "healed" then
  return false
 else
  return true
 end
end

function mtw.have_def(defense)
 if not string.find(defense, "def_") then
  defense = "def_"..defense
 end
 if mtw.defenses[defense].state ~= "deffed" then
  return false
 else
  return true
 end
end

function mtw.have_slow()
 if mtw.have_aff("timewarp") or
    mtw.have_aff("divine_censure") then
  return true
 else
  return false
 end
end

function mtw.not_slow()
 if mtw.have_aff("timewarp") or
    mtw.have_aff("divine_censure") then
  return false
 else
  return true
 end
end

function mtw.am_functional()
 if mtw.have_aff("stun") or
    mtw.have_aff("unconscious") then
  return false
 else
  return true
 end
end

function mtw.am_hindered()
 if mtw.have_aff("stupidity") or
    mtw.have_aff("paralysis") or
    mtw.have_aff("chilled_1") or
    mtw.have_aff("chilled_2") or
    mtw.have_aff("chilled_3") then
  return true
 else
  return false
 end
end

function mtw.not_entangled()
 if (mtw.not_aff("impale") and
    mtw.not_aff("grab") and
    mtw.not_aff("earthbind") and
    mtw.not_aff("feed") and
    mtw.not_aff("oubliette") and
    mtw.not_aff("hogtie") and
    mtw.not_aff("hostage")) or
    mtw.have_aff("dystrophy")
 then
  return true
 else
  return false
 end
end

function mtw.can_overdrive()
 if mtw.not_entangled() and
    mtw.not_aff("depression") and
    mtw.not_aff("tainted_aura") and
    mtw.not_aff("blood_betrayal") then
  return true
 else
  return false
 end
end

function mtw.can_clot()
 if mtw.not_aff("hemophilia") and
    mtw.not_aff("bolero") and
    table.contains(mtw.skills, "Clotting") then
  return true
 else
  return false
 end
end


--Determine ideal pause for waiting checks to prevent spam

function mtw.delay()
 if mtw.have_slow() then
  return 2
 elseif mtw.am_hindered() then
  return 0.5
 else
  return 1
 end
end


--Check balances against cap times for resets
function mtw.balance_check()
 for i in pairs(mtw.balance_timers) do
  if mtw.balance_timers[i].cap ~= 0 and not mtw.balance[i] and getStopWatchTime(mtw.balance_timers[i].timer) >= mtw.balance_timers[i].cap then
   mtw.balance_timeout(i)
  end
 end
end

--Reset balances over cap times
function mtw.balance_timeout(type)
 mtw.balance[type] = true
 cecho("<brown>\n[Resetting balance: "..type.."!]")
 send(" ")
end

--Consume balance and begin tracking its time
function mtw.balance_lose(type)
 x = stopStopWatch(mtw.balance_timers[type].timer)
 startStopWatch(mtw.balance_timers[type].timer)
 mtw.balance_take(type)
end

--Regain balance and echo its elapsed time
function mtw.balance_regain(type)
 deleteLine()
 if type == "balance" or type == "equilibrium" then
  cecho("<dark_orange>\nYou: REGAIN "..type)
 else
  cecho("<brown>\nYou: REGAIN "..type)
 end
 x = stopStopWatch(mtw.balance_timers[type].timer)-getNetworkLatency()
 if x > 0 then
  echo(" "..x)
 end
 mtw.balance_gain(type)
 mtw.aff_remove("blackout")
end

--Take balance when unsure of time elapsed since losing it
function mtw.balance_take(type)
 mtw.balance[type] = false
end

--Regain balance when unsure of elapsed time
function mtw.balance_gain(type)
 mtw.balance[type] = true
-- waiting[type] = false
end


--Toggle and announce various boolean settings

function mtw.toggle(toggle)
 if mtw.toggles[toggle] then
  mtw.toggles[toggle] = false
  echo(string.title(toggle).." OFF!")
  send(" ")
 else
  mtw.toggles[toggle] = true
  echo(string.title(toggle).." ON!")
  send(" ")
 end
end


--Color percentage values for display

function mtw.coloring(percentage)
 if percentage == nil then
  return "?"
 end
 if percentage < 1 then
  mtw.color = "<brown>"
 elseif percentage <= 25 then
  mtw.color = "<red>"
 elseif percentage <= 50 then
  mtw.color = "<dark_orange>"
 elseif percentage <= 75 then
  mtw.color = "<yellow>"
 else
  mtw.color = "<dark_green>"
 end
 return mtw.color
end


--Display colored warnings when various ASSESS conditions are met

function mtw.enemy_afflictions()
 if (mtw.afflictions.aff_prone.assess) or (mtw.afflictions.aff_broken_right_arm.assess and mtw.afflictions.aff_broken_left_arm.assess) then
  cecho("\n<red>===Enemy can't ATTACK!")
 end
 if (mtw.afflictions.aff_prone.assess) or (mtw.afflictions.aff_terror.assess) or (mtw.afflictions.aff_hamstrung.assess) or (mtw.afflictions.aff_broken_right_leg.assess and mtw.afflictions.aff_broken_left_leg.assess) then
  cecho("\n<red>===Enemy can't FLEE!")
 end
 if mtw.afflictions.aff_atoning.assess and mtw.afflictions.aff_heresy and mtw.afflictions.aff_retribution.assess then
  cecho("\n<red>===Enemy CAN BE JUDGED!")
 end
 if mtw.afflictions.aff_tainted_aura.assess or mtw.afflictions.aff_depression.assess then
  cecho("\n<red>===Enemy can't OVERDRIVE!")
 end
 if mtw.afflictions.aff_hemophilia.assess then
  cecho("\n<red>===Enemy can't CLOT!")
 end
 if mtw.afflictions.aff_concussion.assess and mtw.afflictions.aff_epilepsy.assess and mtw.afflictions.aff_impatience.assess then
  cecho("\n<red>===Enemy can't FOCUS!===")
 end
end


--Manipulate a pack while auto-closing is toggled on

function mtw.do_pack(command)
 if mtw.toggles.closing then
  mtw.send("open "..mtw.options.container)
 end
 mtw.send(command)
 if mtw.toggles.closing then
  mtw.send("close "..mtw.options.container)
 end
end


--Reset various tables on command

function mtw.reset_waiting()
 for i in pairs(mtw.waiting) do
  mtw.waiting[i] = false
 end
end
function mtw.reset_balance()
 for i in pairs(mtw.balance) do
  mtw.balance[i] = true
 end
end
function mtw.reset_defend()
 for i in pairs(mtw.attacks) do
  mtw.atk_ended(i)
 end
end
function mtw.reset_attacks()
 for i in pairs(mtw.attacks) do
  mtw.attack_end(i)
 end
end
function mtw.reset_affliction()
 for i in pairs(mtw.afflictions) do
  mtw.aff_remove(i)
 end
end
function mtw.reset_affwaiting()
 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].state == "waiting" then
   mtw.afflictions[i].state = "afflicted"
  end
 end
end
function mtw.reset_defenses()
 for i in pairs(mtw.defenses) do
  mtw.def_remove(i)
 end
end

function mtw.soft_reset()

 mtw.status.riding = false
 for i in pairs(mtw.reject) do
  mtw.reject[i] = "none"
 end
 mtw.status.writhing = false
 mtw.status.clotting = false
 mtw.status.combat = false
 mtw.status.defending = false
 mtw.defending.current = "none"
 mtw.soldier_shielding = false
 mtw.soldier_shielded = "none"

 mtw.reset_waiting()
 mtw.reset_balance()
 mtw.reset_defend()
end

function mtw.reset_all()
 gmcp.Char.Vitals.ap = -1

 mtw.need_wield = false
 mtw.need_heal = false

 mtw.recovering_balance = false
 mtw.recovering_equilibrium = false

 mtw.toggles.bashing = false
 mtw.bashing.targeted = false
 mtw.bashing.engaged = false
 mtw.need_loot = false
 mtw.toggles.fasthunt = false

 mtw.toggles.fishing = false

 mtw.soft_reset()
 mtw.reset_affliction()
 mtw.load_def("none")
 mtw.reset_defenses()
end


function mtw.scripts_reload(matches)
 local trash_options = (matches[2] == " hard")
 if not trash_options then
  mtw.save_options()
 end
 mtw_struct.reload_external("init")
 if not trash_options then
  mtw.load_options()
 end
end

function mtw.gmcpcheck_alias()
 if mtw.gmcp_enabled() then
  cecho("\n<white>GMCP is <green>enabled<white>!")
 else
  cecho("\n<white>GMCP is <red>disabled<white>! Please enable it in Mudlet settings and restart Mudlet.")
 end
end