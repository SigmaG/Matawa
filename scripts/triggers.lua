
function mtw.trigger_1(matches,multimatches)

--Set some values
mtw.see_illusion = false
mtw.my.stats = matches[8]
mtw.waitingforprompt = false
if matches[7] == "" then
 mtw.status.vampire = false
else
 mtw.status.vampire = true
end
if string.find(matches[9], "-VOTE!-") then
 if not mtw.vote then
  tempTimer(600, [[if mtw.vote then mtw.voted = false end]])
 end
 mtw.vote = true
else
 mtw.vote = false
 mtw.voted = true
end

mtw.vitals.blood = tonumber(matches[7])

mtw.enemy_health = ""
for i in pairs(mtw.health_table) do
 if string.find(matches[9], i) then
  mtw.enemy_health = mtw.health_table[i]
 end
end

deleteLine()
mtw.prompt_function()

if mtw.new.area then
 cecho("\n<green>Entering: "..gmcp.Room.Info.area)
 mtw.load_targets(gmcp.Room.Info.area)
 mtw.new.area = false
 mtw.prompt_display()
end
if mtw.new.room then
 mtw.waiting.ih = false
 mtw.sent.whohere = true
 tempTimer(mtw.delay(), [[mtw.sent.whohere = false]])
 send("who here", false)
 mtw.new.room = false
end

if mtw.have_aff("blackout") then 
 tempLineTrigger(1,1,[[if not isPrompt() then mtw.afflictions.aff_blackout.state = "healed" mtw.queue_diag() mtw.soft_reset() end]])
end
end

function mtw.trigger_2(matches,multimatches)
mtw.balance_regain("balance")
mtw.waiting.balance = false
mtw.do_core()
end

function mtw.trigger_3(matches,multimatches)
mtw.balance_regain("offhand")
mtw.balance.offhand = true
end

function mtw.trigger_4(matches,multimatches)
if not mtw.toggles.looping then
 mtw.waiting.balance = false
end
end

function mtw.trigger_5(matches,multimatches)
mtw.balance_regain("equilibrium")
mtw.waiting.equilibrium = false
mtw.do_core()
end

function mtw.trigger_6(matches,multimatches)
if mtw.toggles.balecho then
 deleteLine()
 cecho("<brown>\nYou: OVERDRIVE")
end
mtw.balance_lose("overdrive")
end

function mtw.trigger_7(matches,multimatches)
mtw.balance.od = false
end

function mtw.trigger_8(matches,multimatches)
mtw.balance_regain("overdrive")
mtw.do_core()
end

function mtw.trigger_9(matches,multimatches)
mtw.balance_lose("focus")
mtw.aff_remove("blackout")
end

function mtw.trigger_10(matches,multimatches)
mtw.balance.focus = false
mtw.aff_remove("blackout")
end

function mtw.trigger_11(matches,multimatches)
mtw.balance_regain("focus")
mtw.do_core()
mtw.aff_remove("blackout")
end

function mtw.trigger_12(matches,multimatches)
mtw.recent_defend = false
end

function mtw.trigger_13(matches,multimatches)
mtw.balance_regain("psi")
mtw.do_core()
end

function mtw.trigger_14(matches,multimatches)
mtw.balance_lose("psi")
end

function mtw.trigger_15(matches,multimatches)
mtw.balance.psi = false
end

function mtw.trigger_16(matches,multimatches)
mtw.bashing.target_type = "long"
mtw.load_targets(matches[2])
end

function mtw.trigger_17(matches,multimatches)
mtw.no_target()
mtw.next.balance = "none"
for h in pairs(mtw.scry) do
 mtw.scry[h] = "none"
end
end

function mtw.trigger_18(matches,multimatches)
if mtw.toggles.fasthunt then
 mtw.toggles.bashing = true
 mtw.waiting.balance = false
 mtw.do_bashing()
end

--if mtw.toggles.fastappraise then
 --mtw.toggles.appraising = true
 --mtw.waiting.balance = false
 --mtw.do_apparaising()
--end

end

function mtw.trigger_19(matches,multimatches)
mtw.sent.ih = true
tempTimer(mtw.delay(), [[mtw.sent.ih = false]])
--tempTimer(1, [[if mtw.toggles.bashing then mtw.do_bashing() end]])
mtw.waiting.ih = false
mtw.have_items = true
mtw.corpses = {}
mtw.gathering = {}
end

function mtw.trigger_20(matches,multimatches)
if mtw.toggles.bashing then
 mtw.need_loot = true
end
end

function mtw.trigger_21(matches,multimatches)
if mtw.balance.balance and not mtw.waiting.balance and mtw.options.container then
 if string.find(matches[2], "silver") then
  mtw.do_pack("put coins in "..mtw.options.container)
 elseif string.find(matches[2], "copper") then
  mtw.do_pack("put coins in "..mtw.options.container)
 elseif string.find(matches[2], "gold") then
  mtw.do_pack("put coins in "..mtw.options.container)
 end
end
end

function mtw.trigger_22(matches,multimatches)
if mtw.options.container then
mtw.do_pack("put coins in "..mtw.options.container)
end
end

function mtw.trigger_23(matches,multimatches)
mtw.bashing.target_word = matches[2]
mtw.bashing.target_number = matches[3]
mtw.bashing.target_desc = matches[4]
for i in ipairs(mtw.possible_targets) do
 if ((mtw.bashing.target_type == "long") and string.find(mtw.bashing.target_desc, mtw.possible_targets[i])) or ((mtw.bashing.target_type == "short") and string.find(mtw.bashing.target_word, mtw.possible_targets[i])) then
  if not string.find(mtw.bashing.target_desc, "the corpse of") then
   if not mtw.bashing.targeted then
    if mtw.toggles.generics then
     mtw.bashing.target = mtw.bashing.target_word
    else
     mtw.bashing.target = mtw.bashing.target_number
    end
    mtw.bashing.targeted = true
    mtw.bashing.target_priority = i
   elseif i < mtw.bashing.target_priority then
    if mtw.toggles.generics then
     mtw.bashing.target = mtw.bashing.target_word
    else
     mtw.bashing.target = mtw.bashing.target_number
    end
    mtw.bashing.target_priority = i
    mtw.bashing.targeted = true
   end
  end
 end
end
if not mtw.bashing.targeted and string.find(mtw.bashing.target_desc, "fighting "..mtw.my.name) and mtw.bashing.target_word ~= "pumpkin" then
 if mtw.toggles.generics then
  mtw.bashing.target = mtw.bashing.target_word
 else
  mtw.bashing.target = mtw.bashing.target_number
 end
 mtw.bashing.targeted = true
 mtw.bashing.target_priority = -1
end

if mtw.possible_items ~= {} then
 for k in ipairs(mtw.possible_items) do
  if string.find(mtw.bashing.target_desc, mtw.possible_items[k]) then
   mtw.item_found = false
   for v in ipairs(mtw.gathering) do
    if mtw.gathering[v] == mtw.bashing.target_number then
     mtw.item_found = true
    end
   end
   if not mtw.item_found then
    table.insert(mtw.gathering, mtw.bashing.target_number)
   end
  end
 end
end
if mtw.bashing.target_word == "coins" then
 table.insert(mtw.gathering, "coins")
end
if #mtw.gathering > 0 then
 mtw.need_loot = true
end


end

function mtw.trigger_24(matches,multimatches)
mtw.corpse_word = matches[2]
mtw.corpse_number = matches[3]
mtw.corpse_desc = matches[4]
mtw.corpse_found = false
for i in ipairs(mtw.corpses) do
 if mtw.corpses[i] == mtw.corpse_number then
  mtw.corpse_found = true
 end
end
if not mtw.corpse_found then
 table.insert(mtw.corpses, mtw.corpse_word)
end
end

function mtw.trigger_25(matches,multimatches)
send("give imp to tracker", false)
end

function mtw.trigger_26(matches,multimatches)
if matches[2] == mtw.my.name then
 send("give ore to galdur", false)
end
end

function mtw.trigger_27(matches,multimatches)
if mtw.galdur then
 send("give ore to galdur", false)
else
 send("greet galdur")
end
mtw.galdur = false
end

function mtw.trigger_28(matches,multimatches)
send("give priest to baru", false)
end

function mtw.trigger_29(matches,multimatches)
if matches[2] == mtw.my.name then
 send("give priest to baru", false)
end
end

function mtw.trigger_30(matches,multimatches)
if matches[2] == mtw.my.name then
-- tempTimer(1, [[send("say cult", false)]])
 for i = 1,5 do
  tempTimer(1, [[send("give wraith to baru", false)]])
 end
end
end

function mtw.trigger_31(matches,multimatches)
mtw.galdur = true
end

function mtw.trigger_32(matches,multimatches)
if mtw.options.container then
mtw.do_pack("put coins in "..mtw.options.container)
end
end

function mtw.trigger_33(matches,multimatches)
send("give draugr to foreman", false)
end

function mtw.trigger_34(matches,multimatches)
send("give kilt to shigga", false)
end

function mtw.trigger_35(matches,multimatches)
send("give chieftain to sopliak", false)
end

function mtw.trigger_36(matches,multimatches)
if matches[2] == mtw.my.name then
 tempTimer(1, [[send("say I have more cultists yet, Baru.", false)]])
end
end

function mtw.trigger_37(matches,multimatches)
send("give chieftain to sopliak", false)
end

function mtw.trigger_38(matches,multimatches)
send("get chieftain", false)
end

function mtw.trigger_39(matches,multimatches)
send("say daughter", false)
end

function mtw.trigger_40(matches,multimatches)
send("say chieftains", false)
end

function mtw.trigger_41(matches,multimatches)
if matches[2] == mtw.my.name then
 send("say runestones", false)
end
end

function mtw.trigger_42(matches,multimatches)
mtw.untarget()
end

function mtw.trigger_43(matches,multimatches)
mtw.untarget()
end

function mtw.trigger_44(matches,multimatches)
mtw.inquartata = false
mtw.recent_defend = false
mtw.waiting.balance = false
end

function mtw.trigger_45(matches,multimatches)
mtw.used.balestra = true
end

function mtw.trigger_2031(matches,multimatches)
mtw.used.balefire = true
mtw.casted.balefire = false
end

function mtw.trigger_2032(matches,multimatches)
mtw.casted.balefire = true
end

function mtw.trigger_2033(matches,multimatches)
mtw.used.rake = true
end

function mtw.trigger_46(matches,multimatches)
mtw.used.fleche = true
end

function mtw.trigger_47(matches,multimatches)
mtw.used.fleche = false
mtw.used.savage = false
mtw.used.rake = false
end

function mtw.trigger_48(matches,multimatches)
mtw.used.ignite = true
end

function mtw.trigger_49(matches,multimatches)
mtw.used.ignite = false
end

function mtw.trigger_50(matches,multimatches)
mtw.used.savage = true
end

function mtw.trigger_51(matches,multimatches)
mtw.used.heretic = true
end

function mtw.trigger_52(matches,multimatches)
mtw.used.sunder = true
end

function mtw.trigger_53(matches,multimatches)
mtw.used.starfury = true
end

function mtw.trigger_54(matches,multimatches)
mtw.used.starfury = false
end

function mtw.trigger_55(matches,multimatches)
mtw.used.balestra = false
end

function mtw.trigger_56(matches,multimatches)
mtw.balance_lose("canto")
end

function mtw.trigger_57(matches,multimatches)
mtw.balance_take("canto")
end

function mtw.trigger_58(matches,multimatches)
--mtw.balance_regain("canto")
end

function mtw.trigger_59(matches,multimatches)
mtw.balance_lose("requiem")
end

function mtw.trigger_60(matches,multimatches)
mtw.balance_take("requiem")
end

function mtw.trigger_61(matches,multimatches)
mtw.balance_regain("requiem")
end

function mtw.trigger_62(matches,multimatches)
mtw.balance_lose("barrage")
end

function mtw.trigger_63(matches,multimatches)
mtw.balance_take("barrage")
end

function mtw.trigger_64(matches,multimatches)
mtw.balance_regain("barrage")
end

function mtw.trigger_80(matches,multimatches)
if matches[2] == "CRITICAL" then
 if not mtw.crits.normal then mtw.crits.normal = 0 end
 mtw.crits.normal = mtw.crits.normal+1
elseif matches[2] == "CRUSHING CRITICAL" then
 if not mtw.crits.crushing then mtw.crits.crushing = 0 end
 mtw.crits.crushing = mtw.crits.crushing+1
elseif matches[2] == "OBLITERATING CRITICAL" then
 if not mtw.crits.obliterating then mtw.crits.obliterating = 0 end
 mtw.crits.obliterating = mtw.crits.obliterating+1
elseif matches[2] == "ANNIHILATINGLY POWERFUL CRITICAL" then
 if not mtw.crits.annihilating then mtw.crits.annihilating = 0 end
 mtw.crits.annihilating = mtw.crits.annihilating+1
elseif matches[2] == "WORLD-SHATTERING CRITICAL" then
 if not mtw.crits.shattering then mtw.crits.shattering = 0 end
 mtw.crits.shattering = mtw.crits.shattering+1
end
if not mtw.crits.total then mtw.crits.total = 0 end
mtw.crits.total = mtw.crits.total+1
mtw.crits.rate = math.floor((mtw.crits.total/mtw.crits.hits)*10000)
mtw.crits.rate = mtw.crits.rate/100
echo(" "..mtw.crits.rate.."%")
mtw.inquartata = true
end

function mtw.trigger_81(matches,multimatches)
if not mtw.crits.hits then mtw.crits.hits = 0 end
if string.find(matches[2], " ") then
 mtw.crits.hits = mtw.crits.hits+1
 mtw.bashing.engaged = true
end
if mtw.toggles.bashing and (not mtw.toggles.bleeding) and mtw.vitals.adrenaline <= 15 then
 send("clot;clot;clot;clot;clot")
end
end

function mtw.trigger_82(matches,multimatches)
if matches[2] == "Krondor" or matches[2] == "Elvandar" or matches[2] == "Sar-Sargoth" then
 mtw.parse_chat("citytells", matches[1])
elseif matches[2] == "Pathfinders" or matches[2] == "Mockers" or matches[2] == "Queensguard" or matches[2] == "Spellweavers" or matches[2] == "Clan Dragon" or matches[2] == "Clan Raven" or matches[2] == "Stardock" then
 mtw.parse_chat("guildtells", matches[1])
elseif matches[2] == "Order" then
 mtw.parse_chat("ordertells", matches[1])
elseif matches[2] == "Cadets" or matches[2] == "Students" or matches[2] == "Neophytes" or matches[2] == "Wyrmlings" or matches[2] == "Hatchlings" or matches[2] == "Urchins" or matches[2] == "Novices" then
 mtw.parse_chat("novicetells", matches[1])
elseif matches[2] == "Market" then
 mtw.parse_chat("markettells", matches[1])
elseif matches[2] == "Newbie" then
 mtw.parse_chat("newbietells", matches[1])
elseif matches[2] == "Leaders" then
 mtw.parse_chat("leaderstells", matches[1])
else
 if mtw.channels[matches[2]] == nil then
  mtw.channels[matches[2]] = {}
 end
 mtw.parse_chat(matches[2], matches[1])
end
end

function mtw.trigger_83(matches,multimatches)
mtw.current_society = matches[2]
end

function mtw.trigger_84(matches,multimatches)
selectString(matches[1], 1)
setLink([[send("warpslice")]], "Click to WARPSLICE")
end

function mtw.trigger_85(matches,multimatches)
assess_value = math.floor(matches[5]/matches[6]*100)
assess_color = mtw.coloring(assess_value)
cecho(assess_color.." "..assess_value.."%")
end

function mtw.trigger_86(matches,multimatches)
deleteLine()
cecho("<brown>\nYou: brutal strike!")
end

function mtw.trigger_87(matches,multimatches)
--send("backhand grin")
end

function mtw.trigger_88(matches,multimatches)
deleteLine()
if matches[2] == mtw.target then
cecho("\n<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>= TARGET IS CASTING <green>!!!!!<brown>ANACHRONIZE<green>!!!!! <red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=\n")
else
cecho("\n<green>=====<cyan>"..matches[2].." <green>IS CASTING <red>ANACHRONIZE!\n")
end
end

function mtw.trigger_89(matches,multimatches)
deleteLine()
if matches[2] == mtw.target then
cecho("\n<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>= TARGET IS <green>!!!!!<brown>ANACHRONIZED<green>!!!!! <red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=<cyan>~<red>=\n")
else
cecho("\n<green>=====<cyan>"..matches[2].." <green>IS <red>ANACHRONIZED!!!!!\n")
end
end

function mtw.trigger_90(matches,multimatches)
if mtw.toggles.cdecho then 
 if matches[2] == mtw.target then
  deleteLine()
  cecho("\n<green>=====<white>"..matches[2].."<brown>=====<red>TOUCHING <cyan>::<red>SHIELD<cyan>:: <red>TATTOO!<brown>=====<green>=====\n")
 end
end
end

function mtw.trigger_91(matches,multimatches)
if matches[2] == mtw.target then
 set_attack("touch serpent "..mtw.target)
end
if mtw.toggles.cdecho then 
 if matches[2] == mtw.target then
  deleteLine()
  cecho("\n<green>=====<white>"..matches[2].."<brown>=====<cyan>::<red>SHIELD TATTOO UP<cyan>::<brown>=====<green>=====\n")
 end
end
end

function mtw.trigger_92(matches,multimatches)
if mtw.toggles.cdecho then 
 if matches[2] == mtw.target then
  deleteLine()
  cecho("\n<green>=====<white>"..matches[2].." <cyan>SHIELD BROKEN. ATTACK AT WILL.<green>=====\n")
 end
end
end

function mtw.trigger_93(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>PERFECT DEFENSE<green> READY=====\n\n")
end
end

function mtw.trigger_94(matches,multimatches)
deleteLine()
cecho("<brown>\nYou: FOCUS BODY")
end

function mtw.trigger_95(matches,multimatches)
deleteLine()
cecho("<brown>\nYou: FOCUS MIND")
end

function mtw.trigger_96(matches,multimatches)
deleteLine()
cecho("<brown>\nYou: FOCUS SPRIIT")
end

function mtw.trigger_97(matches,multimatches)
mtw.soldier_shielding = true
mtw.soldier_shielded = matches[2]
end

function mtw.trigger_98(matches,multimatches)
mtw.soldier_shielding = false
mtw.soldier_shielded = "none"
end

function mtw.trigger_99(matches,multimatches)
mtw.balance_regain("immunity")
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>IMMUNITY<green> READY=====\n\n")
end
end

function mtw.trigger_100(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>Last Stand<green> READY=====\n\n")
end
end

function mtw.trigger_101(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>ENRAGE<green> READY=====\n")
end
mtw.balance_regain("rage")
end

function mtw.trigger_102(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>RALLY/EXHORT<green> READY=====\n")
end
end

function mtw.trigger_103(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>CHARGE<green> READY=====\n")
end
end

function mtw.trigger_104(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>INTERCEPT<green> READY=====\n")
end
end

function mtw.trigger_105(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<white>"..matches[2].." <cyan>IMMUNITY DOWN!<green>=====\n")
end
end

function mtw.trigger_106(matches,multimatches)
mtw.cur_weapon = multimatches[1][2]
mtw.poisons[mtw.cur_weapon] = {}
--if mtw.cur_weapon ~= "dagger" then
-- mtw.my.rogue_weapon = mtw.cur_weapon
--end
mtw.sent.wp = true
end

function mtw.trigger_107(matches,multimatches)
if mtw.sent.wp then
 table.insert(mtw.poisons[mtw.cur_weapon], matches[3])
end
end

function mtw.trigger_108(matches,multimatches)
mtw.cur_weapon = multimatches[1][2]
mtw.poisons[mtw.cur_weapon] = {}
--if mtw.cur_weapon ~= "dagger" then
-- mtw.my.rogue_weapon = mtw.cur_weapon
--end
mtw.sent.wp = true
end

function mtw.trigger_109(matches,multimatches)
for i in pairs(mtw.poisons) do
 if string.find(matches[3], i) or (string.find(matches[3], "poniard") and i == "dagger") then
  table.insert(mtw.poisons[i], 1, matches[2])
 end
end
end

function mtw.trigger_110(matches,multimatches)
for i in pairs(mtw.poisons) do
 if string.find(matches[2], i) or (string.find(matches[2], "poniard") and i == "dagger") then
  mtw.poisons[i] = {}
 end
end
end

function mtw.trigger_111(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<white>"..matches[2].." <red>SHRUGGED POISON!<green>=====\n")
end
end

function mtw.trigger_112(matches,multimatches)
--echo("works")
for i in pairs(mtw.songs) do
 mtw.songs[i].time = 0
end
end

function mtw.trigger_113(matches,multimatches)
for i in pairs(mtw.songs) do
 if string.find(matches[3], mtw.songs[i].long) and string.find(matches[3], mtw.my.name) then
  if matches[5] == "minutes" or matches[5] == "minute" then
   mtw.song_time = tonumber(matches[4])*60
  else
   mtw.song_time = tonumber(matches[4])
  end
  if mtw.song_time > mtw.songs[i].time then
   mtw.songs[i].id = matches[2]
   mtw.songs[i].time = mtw.song_time
  end
  echo("\n Captured: "..i.." as ID "..mtw.songs[i].id.." with "..mtw.songs[i].time.." seconds remaining!")
 end
end
end

function mtw.trigger_114(matches,multimatches)
mtw.def_gain("prelude")
end

function mtw.trigger_115(matches,multimatches)
mtw.def_take("prelude")
mtw.songs.prelude.id = ""
end

function mtw.trigger_116(matches,multimatches)
 mtw.def_have("prelude")
end

function mtw.trigger_117(matches,multimatches)
 mtw.songs.prelude.id = ""
end

function mtw.trigger_118(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Serenade<cyan>: <red>===CONCUSSION===<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_119(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Serenade<cyan>: <red>SEVERED NERVE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_120(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Serenade<cyan>: <red>BLEEDING<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_121(matches,multimatches)
if toggles.mpassecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>ATAXIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_122(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>ATAXIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_123(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>ANEMIC<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_124(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>BLIND<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_125(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>CHILLS<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_126(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Nocturne<cyan>: <red>--FEAR--<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_127(matches,multimatches)
mtw.balance_regain("canto")
if mtw.toggles.cdecho then 
 cecho("\n\n<green>=====<red>CANTO<green> READY=====\n\n")
end
end

function mtw.trigger_128(matches,multimatches)
mtw.send("songs")
end

function mtw.trigger_129(matches,multimatches)
deleteLine()
cecho("\n\n<cyan>=======================================")
cecho("\n<green>*************PLAY REFRAIN**************")
cecho("\n<cyan>=======================================\n\n")
end

function mtw.trigger_130(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>BACKHAND<green> READY=====\n")
end
end

function mtw.trigger_131(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>SHIV<green> READY=====\n")
end
end

function mtw.trigger_132(matches,multimatches)
deleteLine()
cecho("\n<green>====Poison: -<red>"..matches[2].."<green>- on <blue>"..matches[3])
end

function mtw.trigger_133(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>FLOURISH<green> READY=====\n")
end
mtw.balance_regain("flourish")
end

function mtw.trigger_133b(matches,multimatches)
if mtw.prechanneling.deepshrouding then
 mtw.channeling.deepshrouding = true
 tempTimer(9, [[mtw.channeling.deepshrouding = false]])
end
end

function mtw.trigger_133c(matches,multimatches)
if mtw.channeling.deepshrouding then
 mtw.channeling.deepshrouding = false
end
end

function mtw.trigger_134(matches,multimatches)
send( "bqa demoncall harvest demon" )
end

function mtw.trigger_135(matches,multimatches)
send("vin heartstone" )
end

function mtw.trigger_136(matches,multimatches)
send( "bqa cast timeshift " ..matches[2])
expandAlias( "t " ..matches[2])
end

function mtw.trigger_137(matches,multimatches)
mtw.pacting = 1
mtw.waiting.balance = true
tempTimer(mtw.delay(), [[mtw.waiting.balance = false]])
mtw.set_balance("pact demon with threats")
end

function mtw.trigger_138(matches,multimatches)
if mtw.pacting == 1 then
 mtw.set_balance("pact demon with manipulation")
end
end

function mtw.trigger_139(matches,multimatches)
if mtw.pacting == 1 then
 mtw.set_balance("pact demon with power")
end
end

function mtw.trigger_140(matches,multimatches)
if mtw.pacting == 1 then
 mtw.set_balance("pact demon with threats")
end
end

function mtw.trigger_141(matches,multimatches)
mtw.pacting = 0
send("vin 50 heartstone")
mtw.set_balance("vin 50 heartstone;demoncall soullink")
end

function mtw.trigger_142(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Imp<cyan>: <red>RECKLESS<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_143(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Imp<cyan>: <red>DYSONIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_144(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Imp<cyan>: <red>ASTHMA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_145(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Imp<cyan>: <red>AMNESIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_146(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Imp<cyan>: <red>DAMAGE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_147(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Darkhound<cyan>: <red>SENSITIVITY<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_148(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Darkhound<cyan>: <red>CATAPLEXY<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_149(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Darkhound<cyan>: <red>ANEMIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_150(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Darkhound<cyan>: <red>!!!IMPATIENCE!!!<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_151(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Darkhound<cyan>: <red>HEADACHE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_152(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Succubus<cyan>: <red>WAKING DREAMS<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_153(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Succubus<cyan>: <red>CONFUSION<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_154(matches,multimatches)
if mtw.toggles.passecho then
deleteLine()
cecho("\n<cyan>=====:<green>Succubus<cyan>: <red>ATAXIA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_155(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Succubus<cyan>: <red>MALADROITNESS<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_156(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Succubus<cyan>: <red>SLEEP<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_157(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Battle Demon<cyan>: <red>DAMAGE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_158(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Battle Demon<cyan>: <red>FIRE DAMAGE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_159(matches,multimatches)
if mtw.toggles.passecho then
deleteLine()
cecho("\n<cyan>=====:<green>Battle Demon<cyan>: <red>IGNITE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_160(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Battle Demon<cyan>: <red>!!!CONCUSSION!!!<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_161(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Battle Demon<cyan>: <red>!!!EPILEPSY!!!<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_162(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Demon Lord<cyan>: <red>TAINTED AURA<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_163(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Demon Lord<cyan>: <red>BROKEN LIMB<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_164(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Demon Lord<cyan>: <red>BLACKOUT<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_165(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Demon Lord<cyan>: <red>SENSITIVITY<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_166(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:<green>Demon Lord<cyan>: <red>FIRE DAMAGE<cyan> "..matches[2].."\n")
end
end

function mtw.trigger_167(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<cyan>=====<red>DEMONLORD GONE<cyan>=====\n\n")
end
end

function mtw.trigger_168(matches,multimatches)
deleteLine()
cecho("\n\n<RED>==========<white>"..matches[2].."<red> HIT WITH MARIONETTE========")
end

function mtw.trigger_169(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<white>==========<green> "..matches[3].."<red> HIT WITH MARIONETTE!<white>==========\n")
end
end

function mtw.trigger_170(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:Kelton's Knives: "..matches[2].." <red>ON-FIRE\n")
end
end

function mtw.trigger_171(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:Kelton's Knives: "..matches[2].." <red>IONIZED\n")
end
end

function mtw.trigger_172(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:Kelton's Knives: "..matches[2].." <red>ATAXIA\n")
end
end

function mtw.trigger_173(matches,multimatches)
if mtw.toggles.passecho then 
deleteLine()
cecho("\n<cyan>=====:Kelton's Knives: "..matches[2].." <red>!!!CONCUSSION!!!\n")
end
end

function mtw.trigger_174(matches,multimatches)
if mtw.toggles.passecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>REJECTED<green>=====\n\n")
end
end

function mtw.trigger_175(matches,multimatches)
if mtw.toggles.passecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>MELDED <white>"..matches[2].."<green>=====\n\n")
end
end

function mtw.trigger_176(matches,multimatches)
if mtw.toggles.passecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>MELD <red>REJECTED<green>=====\n\n")
end
end

function mtw.trigger_177(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>PSI<green> READY=====\n\n")
end
end

function mtw.trigger_178(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>ANACHRONIZE<green> READY=====\n\n")
end
end

function mtw.trigger_179(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>BARRAGE<green> READY=====\n\n")
end
end

function mtw.trigger_180(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>TORTURE<green> READY=====\n\n")
end
end

function mtw.trigger_181(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>BLACK AUGURY<green> READY=====\n\n")
end
end

function mtw.trigger_182(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>DEMON LORD<green> READY=====\n\n")
end
end

function mtw.trigger_183(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<green>=====<red>FROZEN TOMB<green> READY=====\n\n")
end
end

function mtw.trigger_184(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>TELEPORT<green> READY=====\n")
end
end

function mtw.trigger_185(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n\n<cyan>=====<red>DEMONLORD GONE<cyan>=====\n\n")
end
end

function mtw.trigger_186(matches,multimatches)
if mtw.prechanneling.rifting then
 mtw.channeling.rifting = true
 tempTimer(15, [[mtw.channeling.rifting = false]])
end
end

function mtw.trigger_187(matches,multimatches)
if mtw.toggles.warding and table.contains(mtw.skills, "Warding") then
 mtw.set_balance("cast warding")
end
end

function mtw.trigger_188(matches,multimatches)
if mtw.toggles.warding and table.contains(mtw.skills, "Lightball") then
 mtw.set_balance("cast lightball")
end
end

function mtw.trigger_189(matches,multimatches)
if mtw.channeling.rifting then
 mtw.channeling.rifting = false
end
end

function mtw.trigger_190(matches,multimatches)
if mtw.toggles.freezing then
 mtw.set_balance("cast freeze")
end
end

function mtw.trigger_191(matches,multimatches)
cecho("\n\n<red>===SUPERNOVA===\n\n")
end

function mtw.trigger_192(matches,multimatches)
if mtw.toggles.warding and table.contains(mtw.skills, "Icewall") then
 send("bqa cast icewall "..matches[2])
end
end

function mtw.trigger_193(matches,multimatches)
if mtw.toggles.warding and table.contains(mtw.skills, "Lodestone") then
 mtw.set_balance("cast lodestone")
end
end

function mtw.trigger_194(matches,multimatches)
mtw.scry.found = matches[3]
end

function mtw.trigger_195(matches,multimatches)
mtw.scry.target = matches[2]
mtw.scry.env = matches[3]
mtw.scry.distance = matches[4]
mtw.scry_string = ""
mtw.scry_likely = {}
mtw.scry_possible = {}
if mtw.scry.found == "someone" then
 mtw.scry.hidden = "hidden"
elseif mtw.scry.found ~= mtw.scry.target then
 mtw.scry.hidden = "wearing the Shadow of "..mtw.scry.found
else
 mtw.scry.hidden = "unhidden"
end
if mtw.scry.call ~= "none" then
 mtw.scry_string = mtw.scry.call
end
if mtw.scry.distance == "somewhere close" then
 mtw.scry_string = mtw.scry_string.." "..mtw.scry.target.." is "..mtw.scry.hidden.." in "..mtw.scry.env.." environment in or near "..gmcp.Room.Info.area.."."
else
 mtw.scry_string = mtw.scry_string.." "..mtw.scry.target.." is "..mtw.scry.hidden.." in "..mtw.scry.env.." environment "..mtw.scry.distance.." of "..gmcp.Room.Info.area.."."
end

if gmcp.Room.Info.area == "Krondor" then
 for i in mtw.pairs("areas") do
  if mtw.areas[i].krondor == mtw.scry.distance then
if mtw.areas[i].prime ~= nil then
   for x in pairs(mtw.areas[i].prime) do
    if string.find(mtw.scry.env, mtw.areas[i].prime[x]) then
     table.insert(mtw.scry_likely, i)
    end
   end
end
   if mtw.areas[i].env ~= nil then
    for y in pairs(mtw.areas[i].env) do
     if string.find(mtw.scry.env, mtw.areas[i].env[y]) then
      table.insert(mtw.scry_possible, i)
     end
    end
   end
  end
 end

 if mtw.scry_likely[1] ~= nil then
  mtw.scry_string = mtw.scry_string.." This is most likely "..mtw.scry_likely[1]
  table.remove(mtw.scry_likely, 1)
  for z in pairs(mtw.scry_likely) do
   mtw.scry_string = mtw.scry_string.." or "..mtw.scry_likely[z]
  end
  if mtw.scry_string ~= "" then
   mtw.scry_string = mtw.scry_string.."."
  end
 end
 if mtw.scry_possible[1] ~= nil then
  if mtw.scry_string == "" then
   mtw.scry_string = mtw.scry.call
  end
  mtw.scry_string = mtw.scry_string.." This may be "..mtw.scry_possible[1]
  table.remove(mtw.scry_possible, 1)
  for q in pairs(mtw.scry_possible) do
   mtw.scry_string = mtw.scry_string.." or "..mtw.scry_possible[q]
  end
 end
 mtw.scry_likely = {}
 mtw.scry_possible = {}
end

if mtw.scry_string ~= "" then
 cecho("\n<blue>"..mtw.scry_string)
 if mtw.scry.call ~= "none" then
  mtw.send(mtw.scry_string)
 end
end

for h in pairs(mtw.scry) do
 mtw.scry[h] = "none"
end
end

function mtw.trigger_196(matches,multimatches)
if mtw.scry.found ~= "none" then
 if mtw.scry.call ~= "none" then
  mtw.scry_string = mtw.scry.call
 end
 mtw.scry_string = mtw.scry_string.." "..matches[2].." has Divine Grace and may not be scryed."
 if mtw.scry_string ~= "" then
  cecho("\n<blue>"..mtw.scry_string)
  if mtw.scry.call ~= "none" then
   mtw.send(mtw.scry_string)
  end
 end
end
end

function mtw.trigger_197(matches,multimatches)
cecho("<red>-----Summoning guardian-----")
end

function mtw.trigger_198(matches,multimatches)
cecho("<red>-----guardian summoned-----")
end

function mtw.trigger_199(matches,multimatches)
if mtw.toggles.passecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>GUARDIAN <red>GONE<green>=====\n\n")
end
end

function mtw.trigger_200(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>AVATAR OF WAR<green> READY=====\n")
end
end

function mtw.trigger_201(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>VERDICT/KNEEL<green> READY=====\n")
end
end

function mtw.trigger_202(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>LITURGY<green> READY=====\n")
end
if mtw.toggles.healing and not mtw.toggles.fishing and mtw.toggles.warding then
 mtw.set_equil("pray for liturgy")
end
end

function mtw.trigger_203(matches,multimatches)
if mtw.toggles.passecho then 
 deleteLine()
 cecho("\n\n<green>=====<cyan>ONSLAUGHT <red>DOWN<green>=====\n\n")
end
end

function mtw.trigger_204(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>ONSLAUGHT/EFFIGIES<green> READY=====\n")
end
end

function mtw.trigger_205(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>==========<cyan>AVATAR<green> AVATAR<cyan> AVATAR<green> AVATAR<cyan> AVATAR<green> AVATAR==========\n")
end
end

function mtw.trigger_206(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<red>FAITHBURN<green> READY=====\n")
end
end

function mtw.trigger_207(matches,multimatches)
if mtw.my.class == "priest" then
 if mtw.toggles.passecho then 
  deleteLine()
  cecho("\n\n<green>=====<green>HOURGLASS <brown>DOWN on <white>"..matches[2].."<green>=====\n\n")
 end
end
end

function mtw.trigger_208(matches,multimatches)
if mtw.my.class == "priest" then
 if mtw.toggles.passecho then 
  deleteLine()
  cecho("\n\n<green>=====<white>"..matches[2].."<red> touching <green>HOURGLASS!<green>=====\n\n")
 end
end
end

function mtw.trigger_209(matches,multimatches)
if mtw.toggles.passecho then 
 cecho("\n\n<green>=====<cyan>SPIRITSHIELD <red>DOWN<green>=====\n\n")
end
end

function mtw.trigger_210(matches,multimatches)
if mtw.options.container and string.find(matches[2], mtw.options.container) then
 if not mtw.opening then
  mtw.send("close "..mtw.options.container, false)
 end
end
end

function mtw.trigger_211(matches,multimatches)
if mtw.options.container and string.find(matches[2], mtw.options.container) then
 if not mtw.removing then
  mtw.send("wear "..mtw.options.container, false)
 end
end
end

function mtw.trigger_212(matches,multimatches)
if mtw.balance.balance and not mtw.waiting.balance and not mtw.status.combat and mtw.options.container then
 if string.find(matches[2], "silver") then
  mtw.do_pack("put coins in "..mtw.options.container)
 elseif string.find(matches[2], "copper") then
  mtw.do_pack("put coins in "..mtw.options.container)
 elseif string.find(matches[2], "gold") then
  mtw.do_pack("put coins in "..mtw.options.container)
 end
end
end

function mtw.trigger_213(matches,multimatches)
if mtw.balance.balance and not mtw.waiting.balance and not mtw.status.combat and mtw.options.container then
 mtw.pack("put coins in "..mtw.options.container)
end
end

function mtw.trigger_214(matches,multimatches)
if matches[2] == mtw.target then
 deleteLine()
 cecho("\n<cyan>Target: focus <red>BODY\n")
 else
 deleteLine()
 cecho("\n"..matches[2]..": focus <red>BODY\n")
end
end

function mtw.trigger_215(matches,multimatches)
if matches[2] == mtw.target then
 deleteLine()
 cecho("\n<cyan>Target: focus <blue>MIND\n")
 else
 deleteLine()
 cecho("\n"..matches[2]..": focus <blue>MIND\n")
end
end

function mtw.trigger_216(matches,multimatches)
if matches[2] == mtw.target then
 deleteLine()
 cecho("\n<cyan>TARGET: focus <green>SPIRIT\n")
 else
 deleteLine()
 cecho("\n"..matches[2]..": focus <green>SPIRIT\n")
end
end

function mtw.trigger_217(matches,multimatches)
if matches[2] == mtw.target then
 deleteLine()
 cecho("\n<cyan>Target: <brown>OVERDRIVE\n")
end
end

function mtw.trigger_218(matches,multimatches)
if matches[2] == mtw.target then
 deleteLine()
 cecho("\n<green>==========Target Fleeing!==========\n")
 cecho("\n<green>==========Target Fleeing!==========\n")
 cecho("\n<green>==========Target Fleeing!==========\n")
end
end

function mtw.trigger_219(matches,multimatches)
if matches[3] == mtw.target then
 cecho("\n<green>==========Target Disengaging to the "..matches[2].."!==========\n")
 cecho("\n<green>==========Target Disengaging to the "..matches[2].."!==========\n")
 cecho("\n<green>==========Target Disengaging to the "..matches[2].."!==========\n")
end
end

function mtw.trigger_220(matches,multimatches)
if matches[3] == mtw.target then
 cecho("\n<green>==========Target Hobbling to the <cyan>"..matches[2].."<green>!==========\n")
 cecho("\n<green>==========Target Hobbling to the <cyan>"..matches[2].."<green>!==========\n")
 cecho("\n<green>==========Target Hobbling to the <cyan>"..matches[2].."<green>!==========\n")
end
end

function mtw.trigger_221(matches,multimatches)
if string.find(matches[2], string.title(mtw.target)) then
 echo("\n====TARGET STOOD!====")
end
end

function mtw.trigger_222(matches,multimatches)

sendGMCP("Char.Skills.Get")
enableTrigger("Skills Ping")
mtw.remembering = mtw.remembering or 0
mtw.remembering = mtw.remembering + 1
end

function mtw.trigger_223(matches,multimatches)
mtw.remembering = mtw.remembering or 1
mtw.remembering = mtw.remembering - 1
sendGMCP("Char.Skills.Get")
if mtw.remembering < 1 then
  disableTrigger("Skills Ping")
end
end

function mtw.trigger_224(matches,multimatches)
for i in pairs(mtw.tutors) do
 if string.find(matches[2], mtw.tutors[i]) then
  send("learn "..matches[3].." from "..mtw.tutors[i], false)
 end
end
end

function mtw.trigger_225(matches,multimatches)
send("learn "..matches[3].." from "..matches[2], false)
end

function mtw.trigger_226(matches,multimatches)
mtw.dead = true
mtw.reset_all()
end

function mtw.trigger_227(matches,multimatches)
mtw.dead = true
mtw.reset_all()
end

function mtw.trigger_227b(matches,multimatches)
 mtw.reset_all()
end

function mtw.trigger_228(matches,multimatches)
if mtw.dead then
 mtw.reset_all()
end
end

function mtw.trigger_228b(matches,multimatches)
if table.contains(mtw.skills, "Avatar of War") then
 mtw.reset_affwaiting()
 mtw.reset_affliction()
 mtw.reset_defenses()
end
end

function mtw.trigger_229(matches,multimatches)
 mtw.save_options()
end

function mtw.trigger_230(matches,multimatches)
send("get clover", false)
end

function mtw.trigger_231(matches,multimatches)
if string.find(matches[1], "vote") then
 selectString(matches[1], 1)
 setLink([[openUrl("www.midkemiaonline.com/vote")]], "Click to Vote Now!")
end
end

function mtw.trigger_232(matches,multimatches)
send("get "..matches[2].." clover", false)
end

function mtw.trigger_233(matches,multimatches)
if not mtw.status.combat then
 mtw.send("agree")
end
end

function mtw.trigger_234(matches,multimatches)
mtw.check_latest_version()
mtw.load_def("none")
cecho("<blue>\nWelcome to Matawa "..mtw.version[1].."!")
cecho("<green>\n Send ?help to get some help.")
mtw.check_options()
if not mtw.gmcp_enabled() then
 cecho("\nGMCP is <red>disabled<white>, please enable it in Mudlet settings and restart Mudlet.")
else
 cecho("\nGMCP is <green>enabled<white>!")
end
end

function mtw.trigger_235(matches,multimatches)
local time_str = os.date("%c", os.time() + 3 * 60 * 60 * tonumber(matches[2]))
cecho(("\n<white>This will be %s \177 3 hours, your local time."):format(time_str))
end

function mtw.trigger_236(matches,multimatches)
if mtw.vitals.adrenaline == 100 then
 mtw.aff_have("recklessness")
 mtw.vitals.adrenaline = -1
end
end

function mtw.trigger_237(matches,multimatches)
mtw.set_balance("touch serpent "..matches[2])
end

function mtw.trigger_238(matches,multimatches)
if mtw.options.container then
mtw.do_pack("put coins in "..mtw.options.container)
end
end

function mtw.trigger_239(matches,multimatches)
if tonumber(matches[3]) <= 10000 then
 echo("<-- GOOD DEAL")
end
end

function mtw.trigger_240(matches,multimatches)
if string.find(matches[3], mtw.target) then
 expandAlias("t "..matches[4])
end
end

function mtw.trigger_241(matches,multimatches)
send("open "..multimatches[1][2].." "..multimatches[1][3])
send(multimatches[1][3])

if multimatches[1][3] == "north" then
 doordir = "south"
elseif multimatches[1][3] == "south" then
 doordir = "north"
elseif multimatches[1][3] == "east" then
 doordir = "west"
elseif multimatches[1][3] == "west" then
 doordir = "east"
elseif multimatches[1][3] == "in" then
 doordir = "out"
elseif multimatches[1][3] == "out" then
 doordir = "in"
elseif multimatches[1][3] == "northeast" then
 doordir = "southwest"
elseif multimatches[1][3] == "southwest" then
 doordir = "northeast"
elseif multimatches[1][3] == "northwest" then
 doordir = "southeast"
elseif multimatches[1][3] == "southeast" then
 doordir = "northwest"
elseif multimatches[1][3] == "up" then
 doordir = "down"
elseif multimatches[1][3] == "down" then
 doordir = "up"
end

send("close "..multimatches[1][2].." "..doordir)
send("knock "..doordir)
end

function mtw.trigger_242(matches,multimatches)
if mtw.losingall then
 deleteLine()
 mtw.delete_prompt = true
end
end

function mtw.trigger_243(matches,multimatches)
send(matches[2])
deleteLine()
end

function mtw.trigger_244(matches,multimatches)
send("bqa lose spirit")
end

function mtw.trigger_245(matches,multimatches)
if string.find(matches[2], mtw.target) then
 expandAlias("t "..matches[4])
end
end

function mtw.trigger_246(matches,multimatches)
cecho("\n<cyan>===<white>You have been Prandatrolled. Have a nice day!<cyan>===\n")
end

function mtw.trigger_246b(matches,multimatches)
if mtw.prechanneling.inking then
 mtw.channeling.inking = true
 tempTimer(10, [[mtw.channeling.inking = false]])
end
end

function mtw.trigger_246c(matches,multimatches)
if mtw.channeling.inking then
 mtw.channeling.inking = false
end
end

function mtw.trigger_247(matches,multimatches)
if mtw.toggles.mining then
 deleteLine()
 cecho("\n<yellow>-----------------------")
 cecho("\n<yellow>    FOUND: "..matches[3])
 cecho("\n<yellow>-----------------------")
 mtw.mining.found = true
 if matches[3]=="gem" then
  mtw.mining.material = "gems"
 else
  mtw.mining.material = matches[3]
 end
end
end

function mtw.trigger_248(matches,multimatches)
if mtw.toggles.mining then
 deleteLine()
 cecho("\n<red>-----------------------")
 cecho("\n<red>   "..matches[2].." depleted")
 cecho("\n<red>-----------------------")
 send("vin 10 "..mtw.mining.material)
 mtw.mining.found = false
 mtw.mining.material = "none"
end
end

function mtw.trigger_249(matches,multimatches)
if mtw.toggles.mining and mtw.mining.found then
 if mtw.mining.material == "trees" then
  send("chop trees")
 else
  send("mine "..mtw.mining.material)
 end
end
end

function mtw.trigger_250(matches,multimatches)
if mtw.toggles.mining then
 deleteLine()
 cecho("\n<yellow>-----------------------")
 cecho("\n<yellow>    FOUND: trees")
 cecho("\n<yellow>-----------------------")
 mtw.mining.found = true
 mtw.mining.material = "trees"
end
end

function mtw.trigger_251(matches,multimatches)
if mtw.toggles.mining then
 deleteLine()
 cecho("\n<red>-----------------------")
 cecho("\n<red>   trees depleted")
 cecho("\n<red>-----------------------")
 send("vin 10 wood")
 mtw.mining.found = false
 mtw.mining.material = "none"
end
end

function mtw.trigger_252(matches,multimatches)
if mtw.sent.inv then
 mtw.roulette.total = tonumber(matches[2])
 if mtw.roulette.total > 50000 then
--  x = mtw.roulette.total-50000
--  mtw.send("put "..x.." coins in "..mtw.options.container)
  mtw.roulette.bet = math.floor(50000/64)
 else
--  mtw.roulette.bet = 2000
  mtw.roulette.bet = math.floor(mtw.roulette.total/64)
 end
-- mtw.do_roulette()
end
echo(" "..mtw.roulette.bet)
end

function mtw.trigger_253(matches,multimatches)
if not mtw.sent.inv then
 mtw.roulette.bet = tonumber(mtw.roulette.bet*2)
-- mtw.do_roulette()
end
end

function mtw.trigger_254(matches,multimatches)
--mtw.send("i")
mtw.sent.inv = true
end

function mtw.trigger_255(matches,multimatches)
if mtw.toggles.roulette then
 mtw.do_roulette()
end
end

function mtw.trigger_256(matches,multimatches)
if mtw.toggles.roulette then
 mtw.send("turn roulette")
end
end

function mtw.trigger_257(matches,multimatches)
for i in pairs(mtw.afflictions) do
 if mtw.afflictions[i].cures.writhe ~= nil then
  mtw.afflictions[i].state = "healed"
 end
end
mtw.status.writhing = false
end

function mtw.trigger_258(matches,multimatches)
mtw.status.writhing = true
end

function mtw.trigger_259(matches,multimatches)
mtw.status.writhing = false
end

function mtw.trigger_260(matches,multimatches)
mtw.aff_have("hostage")
end

function mtw.trigger_261(matches,multimatches)
mtw.aff_cure("hostage")
end

function mtw.trigger_262(matches,multimatches)
mtw.aff_have("hostage")
end

function mtw.trigger_263(matches,multimatches)
cecho("\n<red>==========HOSTAGE ATTEMPT==========\n<red>==========HOSTAGE ATTEMPT==========\n<red>==========HOSTAGE ATTEMPT==========\n")
mtw.defenses.def_notice.needit = true
mtw.def_remove("notice")
echo("Now keeping def_notice!")
send(" ")
mtw.do_core()
end

function mtw.trigger_264(matches,multimatches)
mtw.aff_have("grab")
end

function mtw.trigger_265(matches,multimatches)
mtw.aff_cure("grab")
end

function mtw.trigger_266(matches,multimatches)
mtw.aff_remove("grab")
end

function mtw.trigger_267(matches,multimatches)
mtw.aff_have("impale")
end

function mtw.trigger_268(matches,multimatches)
mtw.aff_have("impale")
end

function mtw.trigger_269(matches,multimatches)
mtw.aff_cure("impale")
end

function mtw.trigger_270(matches,multimatches)
mtw.aff_have("earthbind")
end

function mtw.trigger_271(matches,multimatches)
mtw.aff_cure("earthbind")
end

function mtw.trigger_272(matches,multimatches)
mtw.aff_have("hogtie")
end

function mtw.trigger_273(matches,multimatches)
mtw.aff_remove("hogtie")
end

function mtw.trigger_274(matches,multimatches)
mtw.aff_have("oubliette")
end

function mtw.trigger_275(matches,multimatches)
mtw.aff_cure("oubliette")
end

function mtw.trigger_276(matches,multimatches)
mtw.aff_have("feed")
end

function mtw.trigger_277(matches,multimatches)
mtw.aff_have("feed")
end

function mtw.trigger_278(matches,multimatches)
mtw.aff_cure("feed")
end

function mtw.trigger_279(matches,multimatches)
mtw.aff_have("lurker")
end

function mtw.trigger_280(matches,multimatches)
mtw.aff_cure("lurker")
end

function mtw.trigger_281(matches,multimatches)
mtw.aff_have("restrained")
mtw.aff_have("blackout")
end

function mtw.trigger_282(matches,multimatches)
mtw.aff_cure("restrained")
end

function mtw.trigger_283(matches,multimatches)
mtw.aff_have("restrained")
end

function mtw.trigger_284(matches,multimatches)
mtw.reject.mage = matches[2]
mtw.aff_have("compulsion")
end

function mtw.trigger_285(matches,multimatches)
mtw.reject.mage = matches[2]
mtw.aff_have("compulsion")
end

function mtw.trigger_286(matches,multimatches)
mtw.reject.mage = "none"
mtw.aff_cure("compulsion")
end

function mtw.trigger_287(matches,multimatches)
mtw.reject.priest = matches[2]
mtw.aff_have("commanded")
end

function mtw.trigger_288(matches,multimatches)
mtw.aff_remove("commanded")
end

function mtw.trigger_289(matches,multimatches)
mtw.aff_remove("commanded")
end

function mtw.trigger_290(matches,multimatches)
mtw.aff_cure("commanded")
end

function mtw.trigger_291(matches,multimatches)
mtw.reject.lust = matches[2]
mtw.aff_have("lust")
end

function mtw.trigger_292(matches,multimatches)
mtw.aff_cure("lust")
mtw.send("enemy "..matches[2])
end

function mtw.trigger_293(matches,multimatches)
mtw.reject.psion = matches[2]
mtw.aff_have("mindmeld")
end

function mtw.trigger_294(matches,multimatches)
mtw.reject.psion = "none"
mtw.aff_cure("mindmeld")
end

function mtw.trigger_295(matches,multimatches)
mtw.aff_have("mindmeld")
end

function mtw.trigger_296(matches,multimatches)
mtw.aff_cure("anemia")
end

function mtw.trigger_297(matches,multimatches)
mtw.aff_have("anemia")
end

function mtw.trigger_298(matches,multimatches)
mtw.aff_have("anemia")
end

function mtw.trigger_299(matches,multimatches)
mtw.aff_cure("asthma")
end

function mtw.trigger_300(matches,multimatches)
mtw.aff_have("asthma")
end

function mtw.trigger_301(matches,multimatches)
mtw.aff_cure("ataxia")
end

function mtw.trigger_302(matches,multimatches)
mtw.aff_have("ataxia")
end

function mtw.trigger_303(matches,multimatches)
mtw.aff_cure("battered")
end

function mtw.trigger_304(matches,multimatches)
mtw.aff_have("black_lung")
end

function mtw.trigger_305(matches,multimatches)
mtw.aff_cure("blind")
end

function mtw.trigger_306(matches,multimatches)
mtw.aff_have("blind")
end

function mtw.trigger_307(matches,multimatches)
mtw.aff_have("blind")
end

function mtw.trigger_308(matches,multimatches)
mtw.aff_cure("broken_"..matches[2].."_"..matches[3])
end

function mtw.trigger_309(matches,multimatches)
mtw.aff_have("broken_left_leg")
mtw.aff_have("broken_right_leg")
end

function mtw.trigger_310(matches,multimatches)
mtw.aff_have("broken_left_arm")
mtw.aff_have("broken_right_arm")
end

function mtw.trigger_311(matches,multimatches)
mtw.aff_have("broken_"..matches[2].."_arm")
end

function mtw.trigger_312(matches,multimatches)
mtw.aff_have("burning_"..matches[2].."_"..matches[3])
end

function mtw.trigger_313(matches,multimatches)
mtw.aff_have("burning_"..matches[4].."_"..matches[5])
end

function mtw.trigger_314(matches,multimatches)
mtw.aff_cure("burning_"..matches[2].."_"..matches[3])
end

function mtw.trigger_315(matches,multimatches)
mtw.aff_remove("burns_2")
mtw.aff_remove("burns_3")
mtw.aff_remove("burns_4")
mtw.aff_cure("burns_1")
end

function mtw.trigger_316(matches,multimatches)
if matches[2] == "first" then
 mtw.aff_gain("burns_1")
elseif matches[2] == "second" then
 mtw.aff_gain("burns_2")
elseif matches[2] == "third" then
 mtw.aff_gain("burns_3")
elseif matches[2] == "fourth" then
 mtw.aff_gain("burns_4")
end
end

function mtw.trigger_317(matches,multimatches)
if matches[2] == "first" then
 mtw.aff_remove("burns_2")
 mtw.aff_remove("burns_3")
 mtw.aff_remove("burns_4")
 mtw.aff_have("burns_1")
elseif matches[2] == "second" then
 mtw.aff_remove("burns_1")
 mtw.aff_remove("burns_3")
 mtw.aff_remove("burns_4")
 mtw.aff_have("burns_2")
elseif matches[2] == "third" then
 mtw.aff_remove("burns_2")
 mtw.aff_remove("burns_1")
 mtw.aff_remove("burns_4")
 mtw.aff_have("burns_3")
elseif matches[2] == "fourth" then
 mtw.aff_remove("burns_2")
 mtw.aff_remove("burns_3")
 mtw.aff_remove("burns_1")
 mtw.aff_have("burns_4")
end
end

function mtw.trigger_318(matches,multimatches)
mtw.aff_cure("burnt_tongue")
end

function mtw.trigger_319(matches,multimatches)
mtw.aff_cure("burst_organs")
end

function mtw.trigger_320(matches,multimatches)
mtw.aff_have("burst_organs")
end

function mtw.trigger_321(matches,multimatches)
if mtw.not_aff("chilled_2") and mtw.not_aff("chilled_3") then
 mtw.aff_have("chilled_1")
end
mtw.reset_waiting()
mtw.reset_affwaiting()
end

function mtw.trigger_322(matches,multimatches)
if mtw.have_aff("chilled_3") then
 mtw.aff_remove("chilled_3")
 mtw.aff_have("chilled_2")
elseif mtw.have_aff("chilled_2") then
 mtw.aff_remove("chilled_2")
 mtw.aff_have("chilled_1")
else
 mtw.aff_cure("chilled_1")
end
end

function mtw.trigger_323(matches,multimatches)
mtw.aff_cure("collapsed_lungs")
end

function mtw.trigger_324(matches,multimatches)
mtw.aff_have("collapsed_lungs")
end

function mtw.trigger_325(matches,multimatches)
mtw.aff_cure("concussion")
end

function mtw.trigger_326(matches,multimatches)
mtw.aff_have("concussion")
mtw.waiting.focus = false
end

function mtw.trigger_327(matches,multimatches)
if mtw.have_aff("cut_tendon_3") then
 mtw.aff_cure("cut_tendon_3")
 mtw.aff_have("cut_tendon_2")
elseif mtw.have_aff("cut_tendon_2") then
 mtw.aff_cure("cut_tendon_2")
 mtw.aff_have("cut_tendon_1")
else
 mtw.aff_cure("cut_tendon_1")
end
end

function mtw.trigger_328(matches,multimatches)
mtw.aff_cure("deaf")
end

function mtw.trigger_329(matches,multimatches)
mtw.aff_cure("exhaustion")
end

function mtw.trigger_330(matches,multimatches)
mtw.aff_cure("hamstrung")
end

function mtw.trigger_331(matches,multimatches)
mtw.aff_cure("heart_palpitations")
end

function mtw.trigger_332(matches,multimatches)
mtw.aff_have("heart_palpitations")
end

function mtw.trigger_333(matches,multimatches)
mtw.aff_cure("on_fire")
end

function mtw.trigger_334(matches,multimatches)
mtw.aff_have("on_fire")
end

function mtw.trigger_335(matches,multimatches)
mtw.aff_have("on_fire")
end

function mtw.trigger_336(matches,multimatches)
mtw.aff_cure("paralysis")
end

function mtw.trigger_337(matches,multimatches)
mtw.aff_have("paralysis")
mtw.reset_waiting()
mtw.reset_affwaiting()
end

function mtw.trigger_338(matches,multimatches)
mtw.aff_cure("plague")
end

function mtw.trigger_339(matches,multimatches)
mtw.aff_cure("scabies")
end

function mtw.trigger_340(matches,multimatches)
mtw.aff_have("scabies")
end

function mtw.trigger_341(matches,multimatches)
if mtw.have_aff("severed_nerves_5") then
 mtw.aff_cure("severed_nerves_5")
 mtw.aff_have("severed_nerves_4")
elseif mtw.have_aff("severed_nerves_4") then
 mtw.aff_cure("severed_nerves_4")
 mtw.aff_have("severed_nerves_3")
elseif mtw.have_aff("severed_nerves_3") then
 mtw.aff_cure("severed_nerves_3")
 mtw.aff_have("severed_nerves_2")
elseif mtw.have_aff("severed_nerves_2") then
 mtw.aff_cure("severed_nerves_2")
 mtw.aff_have("severed_nerves_1")
else
 mtw.aff_cure("severed_nerves_1")
end
end

function mtw.trigger_342(matches,multimatches)
mtw.aff_cure("severed_tendons")
end

function mtw.trigger_343(matches,multimatches)
mtw.aff_cure("slit_throat")
end

function mtw.trigger_344(matches,multimatches)
mtw.aff_cure("vomiting")
end

function mtw.trigger_345(matches,multimatches)
mtw.aff_have("vomiting")
end

function mtw.trigger_346(matches,multimatches)
mtw.aff_have("vomiting")
end

function mtw.trigger_347(matches,multimatches)
mtw.aff_cure("weak_legs")
end

function mtw.trigger_348(matches,multimatches)
mtw.aff_have("concussion")
end

function mtw.trigger_349(matches,multimatches)
mtw.aff_have("severed_nerves")
end

function mtw.trigger_350(matches,multimatches)
--modify_bleeding(100)
end

function mtw.trigger_351(matches,multimatches)
if mtw.toggles.affecho then
 deleteLine()
 cecho("<brown>\nYou: NO BODY")
end
mtw.last.focus = "body"
mtw.clear_afflictions("focus")
end

function mtw.trigger_352(matches,multimatches)
mtw.aff_cure("agoraphobia")
end

function mtw.trigger_353(matches,multimatches)
mtw.aff_cure("amnesia")
end

function mtw.trigger_354(matches,multimatches)
mtw.aff_cure("amnesia")
mtw.reset_waiting()
mtw.reset_affwaiting()
end

function mtw.trigger_355(matches,multimatches)
mtw.aff_cure("anorexia")
end

function mtw.trigger_356(matches,multimatches)
mtw.aff_cure("aphasia")
end

function mtw.trigger_357(matches,multimatches)
mtw.aff_have("blackout")
end

function mtw.trigger_healblackout(matches,multimatches)
mtw.aff_cure("blackout")
end

function mtw.trigger_358(matches,multimatches)
mtw.aff_cure("blurry_sight")
end

function mtw.trigger_359(matches,multimatches)
if mtw.have_aff("brain_damage_5") then
 mtw.aff_cure("brain_damage_5")
 mtw.aff_have("brain_damage_4")
elseif mtw.have_aff("brain_damage_4") then
 mtw.aff_cure("brain_damage_4")
 mtw.aff_have("brain_damage_3")
elseif mtw.have_aff("brain_damage_3") then
 mtw.aff_cure("brain_damage_3")
 mtw.aff_have("brain_damage_2")
elseif mtw.have_aff("brain_damage_2") then
 mtw.aff_cure("brain_damage_2")
 mtw.aff_have("brain_damage_1")
else
 mtw.aff_cure("brain_damage_1")
end
end

function mtw.trigger_360(matches,multimatches)
mtw.aff_cure("cataplexy")
end

function mtw.trigger_361(matches,multimatches)
mtw.aff_have("cataplexy")
end

function mtw.trigger_362(matches,multimatches)
mtw.aff_cure("claustrophobia")
end

function mtw.trigger_363(matches,multimatches)
mtw.aff_cure("clumsiness")
end

function mtw.trigger_364(matches,multimatches)
mtw.aff_cure("confusion")
end

function mtw.trigger_365(matches,multimatches)
mtw.aff_have("confusion")
end

function mtw.trigger_366(matches,multimatches)
if mtw.have_aff("dementia_3") then
 mtw.aff_cure("dementia_3")
 mtw.aff_have("dementia_2")
elseif mtw.have_aff("dementia_2") then
 mtw.aff_cure("dementia_2")
 mtw.aff_have("dementia_1")
else
 mtw.aff_cure("dementia_1")
end
end

function mtw.trigger_367(matches,multimatches)
mtw.aff_cure("depression")
end

function mtw.trigger_368(matches,multimatches)
mtw.aff_have("depression")
end

function mtw.trigger_369(matches,multimatches)
mtw.aff_have("depression")
end

function mtw.trigger_370(matches,multimatches)
mtw.aff_cure("disloyalty")
end

function mtw.trigger_371(matches,multimatches)
mtw.aff_cure("disoriented")
end

function mtw.trigger_372(matches,multimatches)
mtw.aff_cure("dizziness_1")
mtw.aff_remove("dizziness_2")
end

function mtw.trigger_373(matches,multimatches)
mtw.aff_cure("epilepsy")
end

function mtw.trigger_374(matches,multimatches)
mtw.aff_have("epilepsy")
end

function mtw.trigger_375(matches,multimatches)
mtw.aff_have("epilepsy")
mtw.waiting.focus= false
end

function mtw.trigger_376(matches,multimatches)
mtw.aff_cure("fear")
end

function mtw.trigger_377(matches,multimatches)
mtw.aff_have("fear")
end

function mtw.trigger_378(matches,multimatches)
mtw.aff_have("fear")
end

function mtw.trigger_379(matches,multimatches)
mtw.aff_cure("hardwired")
end

function mtw.trigger_380(matches,multimatches)
mtw.aff_cure("headache")
end

function mtw.trigger_381(matches,multimatches)
mtw.aff_have("headache")
end

function mtw.trigger_382(matches,multimatches)
mtw.aff_have("headache")
end

function mtw.trigger_383(matches,multimatches)
mtw.aff_cure("horror")
end

function mtw.trigger_384(matches,multimatches)
mtw.aff_have("hypersomnia")
end

function mtw.trigger_385(matches,multimatches)
mtw.aff_cure("malaise")
end

function mtw.trigger_386(matches,multimatches)
mtw.aff_cure("nightmares")
end

function mtw.trigger_387(matches,multimatches)
mtw.aff_cure("paranoia")
end

function mtw.trigger_388(matches,multimatches)
mtw.aff_have("paranoia")
end

function mtw.trigger_389(matches,multimatches)
mtw.aff_cure("feedback")
end

function mtw.trigger_390(matches,multimatches)
mtw.aff_have("stupidity")
mtw.reset_waiting()
mtw.reset_affwaiting()
end

function mtw.trigger_391(matches,multimatches)
mtw.aff_cure("stupidity")
end

function mtw.trigger_392(matches,multimatches)
mtw.aff_have("stupidity")
end

function mtw.trigger_393(matches,multimatches)
mtw.aff_cure("terror")
end

function mtw.trigger_394(matches,multimatches)
mtw.aff_have("terror")
end

function mtw.trigger_395(matches,multimatches)
mtw.aff_cure("weariness")
end

function mtw.trigger_396(matches,multimatches)
if mtw.toggles.affecho then
 deleteLine()
 cecho("<brown>\nYou: NO MIND")
end
mtw.last.focus = "mind"
mtw.clear_afflictions("focus")
end

function mtw.trigger_397(matches,multimatches)
if mtw.not_aff("arcane_fire_2") and mtw.not_aff("arcane_fire_3") then
 mtw.aff_have("arcane_fire_1")
end
end

function mtw.trigger_398(matches,multimatches)
mtw.aff_remove("arcane_fire_3")
mtw.aff_remove("arcane_fire_2")
mtw.aff_cure("arcane_fire_1")
end

function mtw.trigger_399(matches,multimatches)
mtw.aff_cure("astral_tether")
end

function mtw.trigger_400(matches,multimatches)
mtw.aff_have("astral_warp")
end

function mtw.trigger_401(matches,multimatches)
mtw.aff_have("astral_warp")
end

function mtw.trigger_402(matches,multimatches)
mtw.aff_cure("astral_warp")
end

function mtw.trigger_403(matches,multimatches)
mtw.aff_cure("atoning")
end

function mtw.trigger_404(matches,multimatches)
mtw.aff_cure("crippled")
end

function mtw.trigger_405(matches,multimatches)
mtw.aff_cure("curse_of_tongues")
end

function mtw.trigger_406(matches,multimatches)
mtw.aff_cure("divine_censure")
end

function mtw.trigger_407(matches,multimatches)
mtw.aff_have("divine_censure")
end

function mtw.trigger_408(matches,multimatches)
mtw.aff_cure("dystonia")
end

function mtw.trigger_409(matches,multimatches)
mtw.aff_have("dystonia")
end

function mtw.trigger_410(matches,multimatches)
mtw.aff_have("dystonia")
end

function mtw.trigger_411(matches,multimatches)
mtw.aff_cure("hemophilia")
end

function mtw.trigger_412(matches,multimatches)
mtw.aff_have("hemophilia")
end

function mtw.trigger_413(matches,multimatches)
mtw.aff_have("hemophilia")
end

function mtw.trigger_414(matches,multimatches)
mtw.aff_cure("holy_shock")
end

function mtw.trigger_415(matches,multimatches)
mtw.aff_cure("ill_omen_1")
mtw.aff_remove("ill_omen_2")
mtw.aff_remove("ill_omen_3")
mtw.aff_remove("ill_omen_4")
mtw.aff_remove("ill_omen_5")
end

function mtw.trigger_416(matches,multimatches)
if mtw.have_aff("ill_omen_5") then
 mtw.aff_cure("ill_omen_5")
elseif mtw.have_aff("ill_omen_4") then
 mtw.aff_cure("ill_omen_4")
elseif mtw.have_aff("ill_omen_3") then
 mtw.aff_cure("ill_omen_3")
elseif mtw.have_aff("ill_omen_2") then
 mtw.aff_cure("ill_omen_2")
end
mtw.aff_have("ill_omen_1")
end

function mtw.trigger_417(matches,multimatches)
mtw.aff_cure("impatience")
end

function mtw.trigger_418(matches,multimatches)
mtw.aff_have("impatience")
mtw.waiting.focus = false
end

function mtw.trigger_419(matches,multimatches)
mtw.aff_have("impatience")
end

function mtw.trigger_420(matches,multimatches)
if mtw.have_aff("infirmity_5") then
 mtw.aff_cure("infirmity_5")
 mtw.aff_have("infirmity_4")
elseif mtw.have_aff("infirmity_4") then
 mtw.aff_cure("infirmity_4")
 mtw.aff_have("infirmity_3")
elseif mtw.have_aff("infirmity_3") then
 mtw.aff_cure("infirmity_3")
 mtw.aff_have("infirmity_2")
elseif mtw.have_aff("infirmity_2") then
 mtw.aff_cure("infirmity_2")
 mtw.aff_have("infirmity_1")
else
 mtw.aff_cure("infirmity_1")
end
end

function mtw.trigger_421(matches,multimatches)
mtw.aff_cure("maladroitness")
end

function mtw.trigger_422(matches,multimatches)
mtw.aff_have("maladroitness")
end

function mtw.trigger_423(matches,multimatches)
mtw.aff_have("maladroitness")
end

function mtw.trigger_424(matches,multimatches)
mtw.aff_cure("manaleech")
end

function mtw.trigger_425(matches,multimatches)
mtw.aff_have("manaleech")
end

function mtw.trigger_426(matches,multimatches)
mtw.aff_cure("recklessness")
end

function mtw.trigger_427(matches,multimatches)
mtw.aff_have("recklessness")
end

function mtw.trigger_428(matches,multimatches)
if mtw.have_aff("repenting_3") then
 mtw.aff_cure("repenting_3")
 mtw.aff_have("repenting_2")
elseif mtw.have_aff("repenting_2") then
 mtw.aff_cure("repenting_2")
 mtw.aff_have("repenting_1")
else
 mtw.aff_cure("repenting_1")
end
end

function mtw.trigger_429(matches,multimatches)
mtw.aff_cure("retribution")
end

function mtw.trigger_430(matches,multimatches)
mtw.aff_have("sensitivity")
end

function mtw.trigger_431(matches,multimatches)
mtw.aff_cure("somnolence")
end

function mtw.trigger_432(matches,multimatches)
mtw.aff_have("somnolence")
end

function mtw.trigger_433(matches,multimatches)
mtw.aff_cure("sun_allergy")
end

function mtw.trigger_434(matches,multimatches)
mtw.aff_have("sun_allergy")
end

function mtw.trigger_435(matches,multimatches)
mtw.aff_cure("sundered_armor")
end

function mtw.trigger_436(matches,multimatches)
mtw.aff_cure("tainted_aura")
end

function mtw.trigger_437(matches,multimatches)
mtw.aff_have("tainted_aura")
end

function mtw.trigger_438(matches,multimatches)
mtw.aff_cure("unstable")
end

function mtw.trigger_439(matches,multimatches)
mtw.aff_have("unstable")
end

function mtw.trigger_440(matches,multimatches)
mtw.aff_have("waking_dreams")
end

function mtw.trigger_441(matches,multimatches)
if mtw.toggles.affecho then
 deleteLine()
 cecho("<brown>\nYou: NO SPIRIT")
end
mtw.last.focus = "spirit"
mtw.clear_afflictions("focus")
end

function mtw.trigger_442(matches,multimatches)
mtw.status.clotting = true
end

function mtw.trigger_443(matches,multimatches)
mtw.status.clotting = true
end

function mtw.trigger_444(matches,multimatches)
mtw.status.clotting = false
end

function mtw.trigger_445(matches,multimatches)
mtw.aff_have("bolero")
end

function mtw.trigger_446(matches,multimatches)
mtw.aff_cure("bolero")
end

function mtw.trigger_447(matches,multimatches)
mtw.aff_gain("bolero")
end

function mtw.trigger_448(matches,multimatches)
mtw.aff_have("bleeding_1")
end

function mtw.trigger_449(matches,multimatches)
mtw.aff_cure("bleeding_1")
mtw.aff_remove("bleeding_2")
mtw.aff_remove("bleeding_3")
mtw.aff_remove("bleeding_4")
mtw.aff_remove("bleeding_5")
end

function mtw.trigger_450(matches,multimatches)
mtw.aff_have("balance_loss")
end

function mtw.trigger_451(matches,multimatches)
mtw.recovering_balance = false
mtw.aff_cure("balance_loss")
end

function mtw.trigger_452(matches,multimatches)
mtw.recovering_balance = true
end

function mtw.trigger_453(matches,multimatches)
mtw.recovering_balance = false
mtw.aff_remove("balance_loss")
end

function mtw.trigger_454(matches,multimatches)
mtw.aff_remove("balance_loss")
end

function mtw.trigger_455(matches,multimatches)
mtw.aff_have("equilibrium_loss")
end

function mtw.trigger_456(matches,multimatches)
mtw.recovering_equilibrium = false
mtw.aff_cure("equilibrum_loss")
end

function mtw.trigger_457(matches,multimatches)
mtw.recovering_equilibrium = true
end

function mtw.trigger_458(matches,multimatches)
mtw.recovering_equilibrium = false
mtw.aff_remove("equilibrium_loss")
end

function mtw.trigger_459(matches,multimatches)
aff_remove("equilibrium_loss")
end

function mtw.trigger_460(matches,multimatches)
mtw.aff_have("sleep")
mtw.status.waking = true
mtw.def_remove("rose")
end

function mtw.trigger_461(matches,multimatches)
mtw.aff_have("sleep")
mtw.status.waking = true
mtw.def_remove("rose")
tempTimer(2, [[mtw.status.waking = false]])
end

function mtw.trigger_462(matches,multimatches)
mtw.aff_gain("sleep")
mtw.status.waking = false
end

function mtw.trigger_463(matches,multimatches)
mtw.aff_have("sleep")

end

function mtw.trigger_464(matches,multimatches)
mtw.aff_cure("sleep")
mtw.status.waking = false
mtw.do_core()
end

function mtw.trigger_465(matches,multimatches)
mtw.aff_gain("sleep")
mtw.status.waking = false
end

function mtw.trigger_466(matches,multimatches)
mtw.aff_remove("sleep")
mtw.aff_remove("prone")
mtw.status.waking = false
mtw.do_core()
end

function mtw.trigger_467(matches,multimatches)
mtw.aff_remove("sleep")
mtw.status.waking = false
mtw.do_core()
end

function mtw.trigger_468(matches,multimatches)
mtw.aff_have("stun")
tempTimer(5, [[mtw.aff_remove("stun")]])
end

function mtw.trigger_469(matches,multimatches)
mtw.aff_cure("stun")
mtw.reset_waiting()
mtw.do_core()
end

function mtw.trigger_470(matches,multimatches)
mtw.aff_gain("unconscious")
end

function mtw.trigger_471(matches,multimatches)
mtw.aff_have("unconscious")
end

function mtw.trigger_472(matches,multimatches)
mtw.aff_cure("unconscious")
mtw.do_core()
end

function mtw.trigger_473(matches,multimatches)
--mtw.reset_waiting()
mtw.aff_have("timewarp")
mtw.waiting.slow = true
tempTimer(1.1, [[mtw.waiting.slow = false]])
tempTimer(1.2, mtw.do_core)
end

function mtw.trigger_474(matches,multimatches)
mtw.aff_gain("timewarp")
end

function mtw.trigger_475(matches,multimatches)
mtw.aff_cure("timewarp")
end

function mtw.trigger_476(matches,multimatches)
cecho("\n<red>*************************************")
cecho("\n<red>********<blue>INCOMING TIMEWARP!<red>***********")
cecho("\n<red>*************************************")
 if string.find(mtw.target, matches[3]) and mtw.my.class == "rogue" and mtw.status.combat and mtw.toggles.flourishing then
  mtw.set_balance("flourish "..matches[3])
 end
end

function mtw.trigger_477(matches,multimatches)
mtw.aff_have("tomb")
tempTimer(5, [[mtw.aff_remove("tomb")]])
end

function mtw.trigger_478(matches,multimatches)
mtw.aff_cure("tomb")
mtw.do_core()
end

function mtw.trigger_479(matches,multimatches)
mtw.aff_have("blood_omen")
end

function mtw.trigger_480(matches,multimatches)
mtw.aff_have("blood_betrayal")
end

function mtw.trigger_481(matches,multimatches)
mtw.aff_cure("blood_betrayal")
end

function mtw.trigger_482(matches,multimatches)
mtw.atk_hit(matches[2], nil, "shadowstorm")
mtw.aff_have("blind")
mtw.aff_have("disoriented")
mtw.aff_have("fear")
mtw.aff_have("epilepsy")
mtw.aff_have("maladroitness")
mtw.aff_have("terror")
mtw.aff_have("sun_allergy")
mtw.aff_have("paralysis")
mtw.aff_have("dystrophy")
end

function mtw.trigger_483(matches,multimatches)
selectString(matches[2], 1)
if isAnsiFgColor( 3 ) or isAnsiFgColor( 4 ) or isAnsiFgColor( 14 ) or isAnsiFgColor( 6 ) or isAnsiFgColor( 8 ) then
 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].msg == matches[2] then
   mtw.aff_gain(i)
  end
 end
end
end

function mtw.trigger_484(matches,multimatches)
for i in pairs(mtw.afflictions) do
 if mtw.afflictions[i].msg == matches[2] then
  mtw.aff_cure(i)
 end
end
end

function mtw.trigger_485(matches,multimatches)
if mtw.have_aff("hypochondria") then
 setTriggerStayOpen("sent diagnose", 0)
else
 if mtw.did_diag then
  for i in pairs(mtw.afflictions) do
   if mtw.afflictions[i].msg ~= nil then
    mtw.aff_remove(i)
   end
  end
  mtw.sent.diag = true
 end
 mtw.need_diag = false
end
end

function mtw.trigger_486(matches,multimatches)
for i in pairs(mtw.afflictions) do
 if mtw.afflictions[i].msg ~= nil then
  if mtw.afflictions[i].msg == matches[2] then
   mtw.aff_diag(i)
  end
 end
end
end

function mtw.trigger_487(matches,multimatches)
mtw.reject.priest = matches[2]
mtw.aff_diag("commanded")
end

function mtw.trigger_488(matches,multimatches)
mtw.reject.mage = matches[2]
mtw.aff_diag("compulsion")
end

function mtw.trigger_489(matches,multimatches)
mtw.reject.psion = matches[2]
mtw.aff_diag("mindmeld")
end

function mtw.trigger_490(matches,multimatches)
setTriggerStayOpen("sent diagnose", 0)
end

function mtw.trigger_491(matches,multimatches)
mtw.sent.assess = true
for i in pairs(mtw.afflictions) do
 mtw.afflictions[i].assess = false
end

end

function mtw.trigger_492(matches,multimatches)
for i in pairs(mtw.afflictions) do
 if mtw.afflictions[i].msg ~= nil then
  if mtw.afflictions[i].msg == matches[2] then
   mtw.aff_diag(i)
  end
 end
end
end

function mtw.trigger_493(matches,multimatches)
setTriggerStayOpen("sent assess", 0)
end

function mtw.trigger_494(matches,multimatches)
mtw.reject.mage = matches[2]
mtw.aff_gain("compulsion")
end

function mtw.trigger_495(matches,multimatches)
mtw.aff_cure("compulsion")
end

function mtw.trigger_496(matches,multimatches)
mtw.stand_queued = true
end

function mtw.trigger_497(matches,multimatches)
mtw.stand_queued = false
mtw.next.balance = "none"
end

function mtw.trigger_498(matches,multimatches)
for i in pairs(mtw.defenses) do
 mtw.def_remove(i)
end
end

function mtw.trigger_499(matches,multimatches)
setTriggerStayOpen("def", 0)
end

function mtw.trigger_500(matches,multimatches)
mtw.def_def("myrrh")
end

function mtw.trigger_501(matches,multimatches)
mtw.def_def("highcastle")
end

function mtw.trigger_502(matches,multimatches)
mtw.def_def("notice")
end

function mtw.trigger_503(matches,multimatches)
mtw.def_def("skywatch")
end

function mtw.trigger_504(matches,multimatches)
mtw.def_def("deathsense")
end

function mtw.trigger_505(matches,multimatches)
mtw.def_def("awareness")
end

function mtw.trigger_506(matches,multimatches)
mtw.def_def("nightvision")
end

function mtw.trigger_507(matches,multimatches)
mtw.def_def("insomnia")
end

function mtw.trigger_508(matches,multimatches)
mtw.def_def("forboding")
end

function mtw.trigger_509(matches,multimatches)
mtw.def_def("premonition")
end

function mtw.trigger_510(matches,multimatches)
mtw.def_def("selfishness")
end

function mtw.trigger_511(matches,multimatches)
mtw.def_def("combatfocus")
end

function mtw.trigger_512(matches,multimatches)
mtw.def_def("sun")
end

function mtw.trigger_513(matches,multimatches)
mtw.def_def("moon")
end

function mtw.trigger_514(matches,multimatches)
mtw.def_def("thirdeye")
end

function mtw.trigger_515(matches,multimatches)
mtw.def_def("glacier")
end

function mtw.trigger_516(matches,multimatches)
mtw.def_def("star")
end

function mtw.trigger_517(matches,multimatches)
mtw.def_def("dragon")
end

function mtw.trigger_518(matches,multimatches)
mtw.def_def("skull")
end

function mtw.trigger_519(matches,multimatches)
mtw.def_def("hourglass")
end

function mtw.trigger_520(matches,multimatches)
mtw.def_def("compass")
end

function mtw.trigger_521(matches,multimatches)
mtw.def_def("rose")
end

function mtw.trigger_522(matches,multimatches)
mtw.def_def("owl")
end

function mtw.trigger_523(matches,multimatches)
mtw.def_def("shield")
end

function mtw.trigger_524(matches,multimatches)
mtw.def_def("hiding")
mtw.status.combat = false
end

function mtw.trigger_525(matches,multimatches)
mtw.def_def("arrowsense")
end

function mtw.trigger_526(matches,multimatches)
mtw.def_def("shadowmend")
end

function mtw.trigger_527(matches,multimatches)
mtw.def_def("windweave")
end

function mtw.trigger_528(matches,multimatches)
mtw.def_def("waterbreathing")
end

function mtw.trigger_529(matches,multimatches)
mtw.def_def("levitate")
end

function mtw.trigger_530(matches,multimatches)
mtw.def_def("fire_shield")
end

function mtw.trigger_531(matches,multimatches)
mtw.def_def("frost_shield")
end

function mtw.trigger_532(matches,multimatches)
mtw.def_def("electric_shield")
end

function mtw.trigger_533(matches,multimatches)
mtw.def_def("arcane_shield")
end

function mtw.trigger_534(matches,multimatches)
mtw.def_def("stormfury")
end

function mtw.trigger_535(matches,multimatches)
mtw.def_def("mirror_image")
end

function mtw.trigger_536(matches,multimatches)
mtw.def_def("spellshield")
end

function mtw.trigger_537(matches,multimatches)
mtw.def_def("invisibility")
end

function mtw.trigger_538(matches,multimatches)
mtw.def_def("arcane_power")
end

function mtw.trigger_539(matches,multimatches)
mtw.def_def("anachronize")
end

function mtw.trigger_540(matches,multimatches)
mtw.def_def("mesencephalon")
end

function mtw.trigger_541(matches,multimatches)
mtw.def_def("cerebellum")
end

function mtw.trigger_542(matches,multimatches)
mtw.def_def("meninges")
end

function mtw.trigger_543(matches,multimatches)
mtw.def_def("thalamus")
end

function mtw.trigger_544(matches,multimatches)
mtw.def_def("hypothalamus")
end

function mtw.trigger_545(matches,multimatches)
mtw.def_def("pons")
end

function mtw.trigger_546(matches,multimatches)
mtw.def_def("medulla_oblongata")
end

function mtw.trigger_547(matches,multimatches)
mtw.def_def("corpus_callosum")
end

function mtw.trigger_548(matches,multimatches)
mtw.def_def("hippocampus")
end

function mtw.trigger_549(matches,multimatches)
mtw.def_def("cerebral cortex")
end

function mtw.trigger_550(matches,multimatches)
mtw.def_def("psi_barrier")
end

function mtw.trigger_551(matches,multimatches)
mtw.def_def("grip")
end

function mtw.trigger_552(matches,multimatches)
mtw.def_def("warcry")
end

function mtw.trigger_553(matches,multimatches)
mtw.def_def("tenacity")
end

function mtw.trigger_554(matches,multimatches)
mtw.def_def("immunity")
end

function mtw.trigger_555(matches,multimatches)
mtw.def_def("lightning_stance")
end

function mtw.trigger_556(matches,multimatches)
mtw.def_def("defensive_stance")
end

function mtw.trigger_557(matches,multimatches)
mtw.def_def("aggressive_stance")
end

function mtw.trigger_558(matches,multimatches)
mtw.def_def("divine_armor")
end

function mtw.trigger_559(matches,multimatches)
mtw.def_def("revitalization")
end

function mtw.trigger_560(matches,multimatches)
mtw.def_def("glorious_word")
end

function mtw.trigger_561(matches,multimatches)
mtw.def_def("refuge")
end

function mtw.trigger_562(matches,multimatches)
mtw.def_def("radiant_word")
end

function mtw.trigger_563(matches,multimatches)
mtw.def_def("sanctification")
end

function mtw.trigger_564(matches,multimatches)
mtw.def_def("spiritshield")
end

function mtw.trigger_565(matches,multimatches)
mtw.def_def("inspiring_mantle")
end

function mtw.trigger_566(matches,multimatches)
mtw.def_def("illuminated_word")
end

function mtw.trigger_567(matches,multimatches)
mtw.def_def("righteous_word")
end

function mtw.trigger_568(matches,multimatches)
mtw.def_def("vengeful_mantle")
end

function mtw.trigger_569(matches,multimatches)
mtw.def_def("blessed_word")
end

function mtw.trigger_570(matches,multimatches)
mtw.def_def("deathsight")
end

function mtw.trigger_571(matches,multimatches)
mtw.def_def("witchsight")
end

function mtw.trigger_572(matches,multimatches)
mtw.def_def("deathwhisper")
end

function mtw.trigger_573(matches,multimatches)
mtw.def_def("deathsdoor")
end

function mtw.trigger_574(matches,multimatches)
mtw.def_def("vileblade")
end

function mtw.trigger_575(matches,multimatches)
mtw.def_def("greenburst")
end

function mtw.trigger_576(matches,multimatches)
mtw.def_def("censer")
end

function mtw.trigger_577(matches,multimatches)
mtw.def_def("enrage")
end

function mtw.trigger_578(matches,multimatches)
mtw.def_def("serenity")
end

function mtw.trigger_579(matches,multimatches)
mtw.def_def("veilgarden")
end

function mtw.trigger_579b(matches,multimatches)
mtw.def_def("sunspear")
end

function mtw.trigger_580(matches,multimatches)
mtw.def_def("berserking")
end

function mtw.trigger_581(matches,multimatches)
mtw.def_gain("myrrh")
end

function mtw.trigger_582(matches,multimatches)
mtw.def_gain("notice")
end

function mtw.trigger_583(matches,multimatches)
mtw.def_take("notice")
end

function mtw.trigger_584(matches,multimatches)
mtw.def_gain("skywatch")
end

function mtw.trigger_585(matches,multimatches)
mtw.def_have("skywatch")
end

function mtw.trigger_586(matches,multimatches)
mtw.def_take("skywatch")
end

function mtw.trigger_587(matches,multimatches)
mtw.def_gain("deathsense")
end

function mtw.trigger_588(matches,multimatches)
mtw.def_have("deathsense")
end

function mtw.trigger_589(matches,multimatches)
mtw.def_take("deathsense")
end

function mtw.trigger_590(matches,multimatches)
mtw.def_gain("awareness")
end

function mtw.trigger_591(matches,multimatches)
mtw.def_take("awareness")
end

function mtw.trigger_592(matches,multimatches)
mtw.def_have("awareness")
end

function mtw.trigger_593(matches,multimatches)
mtw.def_gain("nightvision")
end

function mtw.trigger_594(matches,multimatches)
mtw.def_take("nightvision")
end

function mtw.trigger_595(matches,multimatches)
mtw.def_have("nightvision")
end

function mtw.trigger_596(matches,multimatches)
mtw.def_take("insomnia")
mtw.aff_remove("sleep")
mtw.status.waking = false
end

function mtw.trigger_597(matches,multimatches)
mtw.def_gain("insomnia")
end

function mtw.trigger_598(matches,multimatches)
mtw.def_gain("forboding")
end

function mtw.trigger_599(matches,multimatches)
mtw.def_take("forboding")
end

function mtw.trigger_600(matches,multimatches)
mtw.def_have("forboding")
end

function mtw.trigger_601(matches,multimatches)
mtw.def_gain("premonition")
end

function mtw.trigger_602(matches,multimatches)
mtw.def_take("premonition")
end

function mtw.trigger_603(matches,multimatches)
mtw.def_have("premonition")
end

function mtw.trigger_604(matches,multimatches)
mtw.def_gain("selfishness")
end

function mtw.trigger_605(matches,multimatches)
mtw.def_have("selfishness")
end

function mtw.trigger_606(matches,multimatches)
mtw.def_take("selfishness")
end

function mtw.trigger_607(matches,multimatches)
mtw.def_gain("combatfocus")
end

function mtw.trigger_608(matches,multimatches)
mtw.def_take("combatfocus")
end

function mtw.trigger_609(matches,multimatches)
mtw.balance_regain("perfect")
end

function mtw.trigger_610(matches,multimatches)
mtw.def_gain("perfect_defense")
mtw.balance_lose("perfect")
end

function mtw.trigger_611(matches,multimatches)
mtw.def_take("perfect_defense")
end

function mtw.trigger_612(matches,multimatches)
mtw.def_gain("censer")
end

function mtw.trigger_613(matches,multimatches)
mtw.def_gain("thirdeye")
end

function mtw.trigger_614(matches,multimatches)
mtw.def_gain("shield")
end

function mtw.trigger_615(matches,multimatches)
mtw.def_take("shield")
end

function mtw.trigger_616(matches,multimatches)
mtw.def_gain("dragon")
end

function mtw.trigger_617(matches,multimatches)
mtw.def_gain("skull")
end

function mtw.trigger_618(matches,multimatches)
mtw.def_gain("hourglass")
end

function mtw.trigger_619(matches,multimatches)
mtw.def_take("hourglass")
end

function mtw.trigger_620(matches,multimatches)
mtw.def_gain("compass")
end

function mtw.trigger_621(matches,multimatches)
mtw.def_gain("rose")
end

function mtw.trigger_622(matches,multimatches)
mtw.def_gain("owl")
end

function mtw.trigger_623(matches,multimatches)
mtw.def_take("owl")
end

function mtw.trigger_624(matches,multimatches)
mtw.def_gain("wheel")
end

function mtw.trigger_625(matches,multimatches)
mtw.def_take("wheel")
end

function mtw.trigger_626(matches,multimatches)
mtw.def_gain("hiding")
mtw.status.combat = false
end

function mtw.trigger_627(matches,multimatches)
mtw.def_take("hiding")
end

function mtw.trigger_628(matches,multimatches)
mtw.def_have("hiding")
mtw.status.combat = false
end

function mtw.trigger_629(matches,multimatches)
mtw.def_gain("arrowsense")
end

function mtw.trigger_630(matches,multimatches)
mtw.def_gain("shadowmend")
end

function mtw.trigger_631(matches,multimatches)
mtw.def_take("shadowmend")
mtw.waiting.equilibrium = false
mtw.do_core()
end

function mtw.trigger_632(matches,multimatches)
mtw.def_have("shadowmend")
end

function mtw.trigger_633(matches,multimatches)
mtw.def_gain("vileblade")
end

function mtw.trigger_634(matches,multimatches)
mtw.def_take("vileblade")
end

function mtw.trigger_635(matches,multimatches)
mtw.def_gain("windweave")
end

function mtw.trigger_636(matches,multimatches)
mtw.def_gain("waterbreathing")
end

function mtw.trigger_637(matches,multimatches)
mtw.def_gain("levitate")
end

function mtw.trigger_638(matches,multimatches)
mtw.def_gain("fire_shield")
end

function mtw.trigger_639(matches,multimatches)
mtw.def_gain("frost_shield")
end

function mtw.trigger_640(matches,multimatches)
mtw.def_gain("electric_shield")
end

function mtw.trigger_641(matches,multimatches)
mtw.def_gain("arcane_shield")
end

function mtw.trigger_642(matches,multimatches)
mtw.def_gain("stormfury")
end

function mtw.trigger_643(matches,multimatches)
mtw.def_take("stormfury")
end

function mtw.trigger_644(matches,multimatches)
mtw.def_have("stormfury")
end

function mtw.trigger_645(matches,multimatches)
mtw.def_gain("mirror_image")
end

function mtw.trigger_646(matches,multimatches)
mtw.def_take("mirror_image")
end

function mtw.trigger_647(matches,multimatches)
mtw.def_take("spellshield")
end

function mtw.trigger_648(matches,multimatches)
mtw.def_gain("spellshield")
end

function mtw.trigger_649(matches,multimatches)
mtw.def_gain("invisibility")
end

function mtw.trigger_650(matches,multimatches)
mtw.def_take("invisibility")
end

function mtw.trigger_651(matches,multimatches)
mtw.def_gain("arcane_power")
end

function mtw.trigger_652(matches,multimatches)
mtw.def_take("arcane_power")
end

function mtw.trigger_653(matches,multimatches)
mtw.def_gain("anachronize")
mtw.balance_lose("anachronize")
--tempTimer(90, [[balance.anachronize = true]])
end

function mtw.trigger_654(matches,multimatches)
mtw.def_take("anachronize")
end

function mtw.trigger_655(matches,multimatches)
mtw.balance_regain("anachronize")
end

function mtw.trigger_656(matches,multimatches)
mtw.balance_lose("anachronize")
end

function mtw.trigger_657(matches,multimatches)
mtw.def_gain("mesencephalon")
end

function mtw.trigger_658(matches,multimatches)
mtw.def_take("mesencephalon")
end

function mtw.trigger_659(matches,multimatches)
mtw.def_gain("cerebellum")
end

function mtw.trigger_660(matches,multimatches)
mtw.def_take("cerebellum")
end

function mtw.trigger_661(matches,multimatches)
mtw.def_gain("meninges")
end

function mtw.trigger_662(matches,multimatches)
mtw.def_take("meninges")
end

function mtw.trigger_663(matches,multimatches)
mtw.def_gain("thalamus")
end

function mtw.trigger_664(matches,multimatches)
mtw.def_take("thalamus")
end

function mtw.trigger_665(matches,multimatches)
mtw.def_gain("hypothalamus")
end

function mtw.trigger_666(matches,multimatches)
mtw.def_take("hypothalamus")
end

function mtw.trigger_667(matches,multimatches)
mtw.def_gain("pons")
end

function mtw.trigger_668(matches,multimatches)
mtw.def_take("pons")
end

function mtw.trigger_669(matches,multimatches)
mtw.def_gain("medulla_oblongata")
end

function mtw.trigger_670(matches,multimatches)
mtw.def_take("medulla_oblongata")
end

function mtw.trigger_671(matches,multimatches)
mtw.def_gain("corpus_callosum")
end

function mtw.trigger_672(matches,multimatches)
mtw.def_take("corpus_callosum")
end

function mtw.trigger_673(matches,multimatches)
mtw.def_gain("hippocampus")
end

function mtw.trigger_674(matches,multimatches)
mtw.def_take("hippocampus")
end

function mtw.trigger_675(matches,multimatches)
mtw.def_gain("cerebral_cortex")
end

function mtw.trigger_676(matches,multimatches)
mtw.def_take("cerebral_cortex")
end

function mtw.trigger_677(matches,multimatches)
mtw.def_gain("psi_barrier")
end

function mtw.trigger_678(matches,multimatches)
mtw.def_gain("witchsight")
end

function mtw.trigger_679(matches,multimatches)
mtw.def_have("witchsight")
end

function mtw.trigger_680(matches,multimatches)
mtw.def_gain("grip")
end

function mtw.trigger_681(matches,multimatches)
mtw.def_take("grip")
end

function mtw.trigger_682(matches,multimatches)
mtw.def_gain("berserking")
end

function mtw.trigger_683(matches,multimatches)
mtw.def_take("berserking")
end

function mtw.trigger_684(matches,multimatches)
mtw.def_have("berserking")
end

function mtw.trigger_685(matches,multimatches)
mtw.balance_lose("rage")
mtw.def_gain("enrage")
end

function mtw.trigger_686(matches,multimatches)
mtw.balance.rage = false
mtw.balance_lose("rage")
end

function mtw.trigger_687(matches,multimatches)
mtw.def_take("enrage")
end

function mtw.trigger_688(matches,multimatches)
mtw.def_gain("warcry")
end

function mtw.trigger_689(matches,multimatches)
mtw.def_gain("aggressive_stance")
mtw.def_remove("lightning_stance")
mtw.def_remove("defensive_stance")
end

function mtw.trigger_690(matches,multimatches)
mtw.def_gain("defensive_stance")
mtw.def_remove("lightning_stance")
mtw.def_remove("aggressive_stance")
end

function mtw.trigger_691(matches,multimatches)
mtw.def_gain("lightning_stance")
mtw.def_remove("aggressive_stance")
mtw.def_remove("defensive_stance")
end

function mtw.trigger_692(matches,multimatches)
mtw.def_gain("tenacity")
end

function mtw.trigger_693(matches,multimatches)
mtw.def_take("tenacity")
end

function mtw.trigger_694(matches,multimatches)
mtw.balance_lose("immunity")
mtw.def_gain("immunity")
end

function mtw.trigger_695(matches,multimatches)
mtw.def_have("immunity")
end

function mtw.trigger_696(matches,multimatches)
mtw.def_have("immunity")
end

function mtw.trigger_697(matches,multimatches)
mtw.def_take("immunity")
end

function mtw.trigger_698(matches,multimatches)
mtw.balance.immunity = false
mtw.balance_lose("immunity")
end

function mtw.trigger_699(matches,multimatches)
mtw.balance_lose("last_stand")
mtw.def_gain("last_stand")
end

function mtw.trigger_700(matches,multimatches)
mtw.balance.last_stand = false
mtw.def_take("last_stand")
end

function mtw.trigger_701(matches,multimatches)
mtw.balance.last_stand = false
mtw.reset_waiting()
end

function mtw.trigger_702(matches,multimatches)
mtw.balance_regain("last_stand")
end

function mtw.trigger_703(matches,multimatches)
mtw.def_take("greenburst")
end

function mtw.trigger_704(matches,multimatches)
mtw.def_have("greenburst")
end

function mtw.trigger_705(matches,multimatches)
mtw.def_gain("greenburst")
end

function mtw.trigger_706(matches,multimatches)
if table.contains(mtw.skills.warcraft,"Quickdraw") and mtw.defenses.def_lightning_stance.state == 'deffed' then
	mtw.send("quickdraw "..mtw.options.scabbard1)
end
mtw.def_gain("phoenix_crouching")
end

function mtw.trigger_707(matches,multimatches)
mtw.def_take("phoenix_crouching")
end

function mtw.trigger_708(matches,multimatches)
mtw.def_def("phoenix_crouching")
end

function mtw.trigger_709(matches,multimatches)
mtw.def_gain("serenity")
end

function mtw.trigger_710(matches,multimatches)
mtw.def_take("serenity")
end

function mtw.trigger_711(matches,multimatches)
mtw.def_gain("divine_armor")
end

function mtw.trigger_712(matches,multimatches)
mtw.def_gain("revitalization")
end

function mtw.trigger_713(matches,multimatches)
mtw.def_take("revitalization")
end

function mtw.trigger_714(matches,multimatches)
mtw.def_gain("glorious_word")
end

function mtw.trigger_715(matches,multimatches)
mtw.def_gain("refuge")
end

function mtw.trigger_716(matches,multimatches)
mtw.def_take("refuge")
end

function mtw.trigger_717(matches,multimatches)
mtw.def_gain("radiant_word")
end

function mtw.trigger_718(matches,multimatches)
mtw.def_gain("sanctification")
end

function mtw.trigger_719(matches,multimatches)
mtw.def_gain("spiritshield")
end

function mtw.trigger_720(matches,multimatches)
mtw.def_take("spiritshield")
end

function mtw.trigger_721(matches,multimatches)
mtw.def_gain("inspiring_mantle")
end

function mtw.trigger_722(matches,multimatches)
mtw.def_take("inspiring_mantle")
end

function mtw.trigger_723(matches,multimatches)
mtw.def_gain("illuminated_word")
end

function mtw.trigger_724(matches,multimatches)
mtw.def_gain("righteous_word")
end

function mtw.trigger_725(matches,multimatches)
mtw.def_gain("vengeful_mantle")
end

function mtw.trigger_726(matches,multimatches)
mtw.def_gain("blessed_word")
end

function mtw.trigger_727(matches,multimatches)
mtw.def_gain("deathsight")
end

function mtw.trigger_728(matches,multimatches)
mtw.def_gain("witchsight")
end

function mtw.trigger_729(matches,multimatches)
mtw.def_gain("deathwhisper")
end

function mtw.trigger_730(matches,multimatches)
mtw.def_take("deathwhisper")
end

function mtw.trigger_731(matches,multimatches)
mtw.def_gain("deathsdoor")
end

function mtw.trigger_732(matches,multimatches)
mtw.def_gain("conviction")
end

function mtw.trigger_733(matches,multimatches)
mtw.def_def("conviction")
end

function mtw.trigger_734(matches,multimatches)
mtw.def_take("conviction")
end

function mtw.trigger_735(matches,multimatches)
for i in pairs(mtw.defenses) do
 if mtw.defenses[i].defense == matches[2] then
  cecho("<brown>\nStripped "..i)
  mtw.def_remove(i)
 end
end
end

function mtw.trigger_736(matches,multimatches)
for i in ipairs(mtw.weapons) do
 if string.find(matches[2], mtw.weapons[i]) then
  mtw.my.weapon = mtw.weapons[i]
  mtw.need_wield = true
 end
 if mtw.toggles.gripping and mtw.defenses.def_grip.needit then
  mtw.defenses.def_grip.needit = false
 end
end
for i in ipairs(mtw.offweapons) do
 if string.find(matches[2], mtw.offweapons[i]) then
  mtw.my.offweapon = mtw.offweapons[i]
  mtw.need_offwield = true
 end
 if mtw.toggles.gripping and mtw.defenses.def_grip.needit then
  mtw.defenses.def_grip.needit = false
 end
end
end

function mtw.trigger_737(matches,multimatches)
--if matches[2] == mtw.my.weapon then
 mtw.need_wield = false
 mtw.need_offwield = false
--end
if mtw.toggles.gripping and mtw.defenses.def_grip.needit then
 mtw.defenses.def_grip.needit = false
end
mtw.waiting.balance = false
mtw.do_core()
end

function mtw.trigger_738(matches,multimatches)
for i in ipairs(mtw.weapons) do
 if string.find(matches[2], mtw.weapons[i]) then
  mtw.my.weapon = mtw.weapons[i]
  mtw.need_wield = false
 end
end
for i in ipairs(mtw.offweapons) do
 if string.find(matches[2], mtw.offweapons[i]) then
  mtw.my.offweapon = mtw.offweapons[i]
  mtw.need_offwield = false
 end
end
 mtw.waiting.balance = false
 if mtw.toggles.gripping and mtw.defenses.def_grip.needit == false then
  mtw.defenses.def_grip.needit = true
  send(" ")
 end
 mtw.do_core()
end

function mtw.trigger_739(matches,multimatches)
if not mtw.unwielding then
 for i in ipairs(mtw.weapons) do
   if string.find(matches[2], mtw.weapons[i]) then
     mtw.my.weapon = mtw.weapons[i]
     mtw.need_wield = true
   end
 end
 for i in ipairs(mtw.offweapons) do
   if string.find(matches[2], mtw.offweapons[i]) then
     mtw.my.offweapon = mtw.offweapons[i]
     mtw.need_offwield = true
   end
 end
end
end

function mtw.trigger_740(matches,multimatches)
mtw.need_wield = true
 for i in ipairs(mtw.offweapons) do
   if string.find(matches[2], mtw.offweapons[i]) then
     mtw.my.offweapon = mtw.offweapons[i]
     mtw.need_offwield = true
   end
 end
end

function mtw.trigger_741(matches,multimatches)
--mtw.need_wield = false
 for i in ipairs(mtw.weapons) do
   if string.find(matches[2], mtw.weapons[i]) then
     mtw.my.weapon = mtw.weapons[i]
     mtw.need_wield = false
   end
 end
 for i in ipairs(mtw.offweapons) do
   if string.find(matches[2], mtw.offweapons[i]) then
     mtw.my.offweapon = mtw.offweapons[i]
     mtw.need_offwield = false
   end
 end
 if mtw.toggles.gripping and mtw.defenses.def_grip.needit == false then
  mtw.defenses.def_grip.needit = true
  send(" ")
 end
end

function mtw.trigger_742(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "slash")
end

function mtw.trigger_743(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "slash")
end

function mtw.trigger_744(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "slash")
end

function mtw.trigger_745(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "slash", matches[4])
end

function mtw.trigger_746(matches,multimatches)
mtw.attack_start(matches[4], "slash")
end

function mtw.trigger_747(matches,multimatches)
mtw.attack_hit(matches[3], "slash")
end

function mtw.trigger_748(matches,multimatches)
mtw.attack_miss(matches[3], "slash")
end

function mtw.trigger_749(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "slash", matches[4])
end

function mtw.trigger_750(matches,multimatches)
mtw.third_start(matches[2], matches[3], "slash", matches[5])
end

function mtw.trigger_751(matches,multimatches)
mtw.third_hit(matches[2], matches[3], "slash", matches[4])
end

function mtw.trigger_752(matches,multimatches)
mtw.third_defend(matches[2], matches[3], "slash", matches[5], matches[4])
end

function mtw.trigger_753(matches,multimatches)
mtw.third_miss(matches[2], matches[3], "slash", matches[4])
end

function mtw.trigger_754(matches,multimatches)
mtw.atk_start(matches[3], matches[2], "obliterate")
end

function mtw.trigger_755(matches,multimatches)
mtw.atk_hit(matches[3], matches[4], "obliterate")
end

function mtw.trigger_756(matches,multimatches)
mtw.atk_defend(matches[4], matches[5], "obliterate", matches[6])
end

function mtw.trigger_757(matches,multimatches)
mtw.atk_miss(matches[4], matches[5], "obliterate")
end

function mtw.trigger_758(matches,multimatches)
mtw.attack_start(matches[3], "obliterate")
end

function mtw.trigger_759(matches,multimatches)
mtw.attack_hit(matches[2], "obliterate")
end

function mtw.trigger_760(matches,multimatches)
mtw.attack_miss(matches[2], "obliterate")
end

function mtw.trigger_761(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "obliterate", matches[4])
end

function mtw.trigger_762(matches,multimatches)
mtw.third_start(matches[3], matches[2], "obliterate", matches[5])
end

function mtw.trigger_763(matches,multimatches)
mtw.third_hit(matches[4], matches[6], "obliterate", matches[5])
end

function mtw.trigger_764(matches,multimatches)
mtw.third_defend(matches[4], matches[6], "obliterate", matches[7], matches[5])
end

function mtw.trigger_765(matches,multimatches)
mtw.third_miss(matches[4], matches[6], "obliterate", matches[5])
end

function mtw.trigger_766(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "wildstrike")
end

function mtw.trigger_767(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "wildstrike")
end

function mtw.trigger_768(matches,multimatches)
mtw.atk_defend(matches[2], matches[2], "wildstrike", matches[4])
end

function mtw.trigger_769(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "wildstrike")
end

function mtw.trigger_770(matches,multimatches)
mtw.attack_start(matches[3], "wildstrike")
end

function mtw.trigger_771(matches,multimatches)
mtw.attack_hit(matches[2], "wildstrike")
end

function mtw.trigger_772(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "wildstrike", matches[4])
end

function mtw.trigger_773(matches,multimatches)
mtw.attack_miss(matches[3], "wildstrike")
end

function mtw.trigger_774(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "sunder_armor")
end

function mtw.trigger_775(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "sunder_armor")
end

function mtw.trigger_776(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "sunder_armor", matches[4])
end

function mtw.trigger_777(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "sunder_armor")
end

function mtw.trigger_778(matches,multimatches)
mtw.attack_start(matches[2], "sunder_armor")
end

function mtw.trigger_779(matches,multimatches)
mtw.attack_hit(matches[3], "sunder_armor")
end

function mtw.trigger_780(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "sunder_armor", matches[5])

end

function mtw.trigger_781(matches,multimatches)
mtw.attack_miss(mtw.target, "sunder_armor")
end

function mtw.trigger_782(matches,multimatches)
mtw.third_start(matches[2], matches[4], "sunder_armor", matches[3])
end

function mtw.trigger_783(matches,multimatches)
mtw.third_hit(matches[2], matches[3], "sunder_armor", matches[4])
end

function mtw.trigger_784(matches,multimatches)
mtw.third_defend(matches[2], matches[3], "sunder_armor", matches[6], matches[4])
end

function mtw.trigger_785(matches,multimatches)
mtw.third_miss(matches[2], mmatches[3], "sunder_armor", "Someone")
end

function mtw.trigger_786(matches,multimatches)
--mtw.attack_hit(matches[2], "atk_throwdown")
cecho("<red>\nYour <purple>Throwdown: "..matches[2].." <green>SUCCESS<brown>!")
end

function mtw.trigger_787(matches,multimatches)
--mtw.atk_hit(matches[2], nil, "atk_throwdown")
cecho("<red>\n"..matches[2].."'s <purple>Throwdown: <red>HITS <brown>you!")
end

function mtw.trigger_788(matches,multimatches)
--mtw.attack_miss(matches[2], "atk_throwdown")
cecho("<red>\nYour <purple>Throwdown: <white>"..matches[2].." <red>FAILED<brown>!")
end

function mtw.trigger_789(matches,multimatches)
mtw.atk_start(matches[2], nil, "grab")
end

function mtw.trigger_790(matches,multimatches)
mtw.atk_hit(matches[2], nil, "grab")
end

function mtw.trigger_791(matches,multimatches)
mtw.atk_defend(matches[2], nil, "grab", matches[3])
end

function mtw.trigger_792(matches,multimatches)
mtw.atk_miss(matches[2], nil, "grab")
end

function mtw.trigger_793(matches,multimatches)
mtw.attack_start(matches[2], "grab")
end

function mtw.trigger_794(matches,multimatches)
mtw.attack_hit(matches[2], "grab")
end

function mtw.trigger_795(matches,multimatches)
mtw.attack_miss(matches[3], "grab")
end

function mtw.trigger_796(matches,multimatches)
mtw.attack_defend(matches[2], nil, "grab", matches[3])
end

function mtw.trigger_797(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "heartstrike")
end

function mtw.trigger_798(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "heartstrike")
end

function mtw.trigger_799(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "heartstrike", matches[4])
end

function mtw.trigger_800(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "heartstrike")
end

function mtw.trigger_801(matches,multimatches)
mtw.attack_start(matches[3], "heartstrike")
end

function mtw.trigger_802(matches,multimatches)
mtw.attack_hit(matches[3], "heartstrike")
end

function mtw.trigger_803(matches,multimatches)
mtw.attack_miss(matches[3], "heartstrike")
end

function mtw.trigger_804(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "heartstrike", matches[5])
end

function mtw.trigger_805(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "cleave")
end

function mtw.trigger_806(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "cleave")
end

function mtw.trigger_807(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "cleave", matches[5])
end

function mtw.trigger_808(matches,multimatches)
mtw.atk_miss(matches[2], nil, "cleave")
end

function mtw.trigger_809(matches,multimatches)
mtw.attack_start(matches[3], "cleave")
end

function mtw.trigger_810(matches,multimatches)
mtw.attack_hit(matches[2], "cleave")
end

function mtw.trigger_811(matches,multimatches)
mtw.attack_miss(matches[2], "cleave")
end

function mtw.trigger_812(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "cleave", matches[6])
end

function mtw.trigger_813(matches,multimatches)
mtw.attack_start(matches[2], "headslam")
end

function mtw.trigger_814(matches,multimatches)
mtw.attack_hit(matches[2], "headslam")
end

function mtw.trigger_815(matches,multimatches)
mtw.attack_miss(matches[2], "headslam")
end

function mtw.trigger_816(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "shield_smash")
end

function mtw.trigger_817(matches,multimatches)
mtw.atk_hit(matches[2], nil, "shield_smash")
end

function mtw.trigger_818(matches,multimatches)
mtw.atk_defend(matches[2], nil, "shield_smash", matches[4])
end

function mtw.trigger_819(matches,multimatches)
mtw.atk_miss(matches[2], nil, "shield_smash")
end

function mtw.trigger_820(matches,multimatches)
mtw.attack_start(matches[3], "shield_smash")
end

function mtw.trigger_821(matches,multimatches)
mtw.attack_hit(matches[2], "shield_smash")
end

function mtw.trigger_822(matches,multimatches)
mtw.attack_defend(mtw.target, nil, "shield_smash", matches[2])
end

function mtw.trigger_823(matches,multimatches)
mtw.attack_miss(matches[2], "shield_smash")
end

function mtw.trigger_824(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "mutilating_hack")
end

function mtw.trigger_825(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "mutilating_hack")
end

function mtw.trigger_826(matches,multimatches)
mtw.atk_defend(matches[2], nil, "mutilating_hack", matches[4])
end

function mtw.trigger_827(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "mutilating_hack")
end

function mtw.trigger_828(matches,multimatches)
mtw.attack_start(matches[2], "mutilating_hack")
end

function mtw.trigger_829(matches,multimatches)
mtw.attack_hit(matches[3], "mutilating_hack")
end

function mtw.trigger_830(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "mutilating_hack", matches[5])
end

function mtw.trigger_831(matches,multimatches)
mtw.attack_miss(matches[3], "mutilating_hack")
end

function mtw.trigger_832(matches,multimatches)
mtw.attack_hit(matches[2], "rend")
end

function mtw.trigger_833(matches,multimatches)
mtw.atk_start(matches[2], nil, "impale")
end

function mtw.trigger_834(matches,multimatches)
mtw.atk_hit(matches[2], nil, "impale")
end

function mtw.trigger_835(matches,multimatches)
mtw.atk_defend(matches[2], nil, "impale", matches[4])
end

function mtw.trigger_836(matches,multimatches)
mtw.atk_miss(matches[2], nil, "impale")
end

function mtw.trigger_837(matches,multimatches)
mtw.attack_start(matches[2], "impale")
end

function mtw.trigger_838(matches,multimatches)
mtw.attack_hit(matches[2], "impale")
for i in pairs(mtw.attacks) do
 if mtw.attacks[i].attacker == matches[2] then
  mtw.reset_attack(i)
 end
end
end

function mtw.trigger_839(matches,multimatches)
mtw.attack_miss(matches[2], "impale")
end

function mtw.trigger_840(matches,multimatches)
mtw.attack_defend(matches[2], nil, "impale", matches[3])
end

function mtw.trigger_841(matches,multimatches)
mtw.atk_start(matches[2], nil, "bind")
end

function mtw.trigger_842(matches,multimatches)
mtw.atk_hit(matches[2], nil, "bind")
end

function mtw.trigger_843(matches,multimatches)
mtw.atk_defend(matches[2], nil, "bind", matches[4])
end

function mtw.trigger_844(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "assault")
end

function mtw.trigger_845(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "assault")
end

function mtw.trigger_846(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "assault", matches[4])
end

function mtw.trigger_847(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "assault")
end

function mtw.trigger_848(matches,multimatches)
deleteLine()
end

function mtw.trigger_849(matches,multimatches)
mtw.attack_start(matches[3], "assault")
end

function mtw.trigger_850(matches,multimatches)
mtw.attack_hit(matches[2], "assault")
end

function mtw.trigger_851(matches,multimatches)
mtw.attack_miss(matches[3], "assault")
end

function mtw.trigger_852(matches,multimatches)
deleteLine()
end

function mtw.trigger_853(matches,multimatches)
deleteLine()
end

function mtw.trigger_854(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "assault", matches[4])
end

function mtw.trigger_855(matches,multimatches)
deleteLine()
end

function mtw.trigger_856(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "rupture")
end

function mtw.trigger_857(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "rupture")
end

function mtw.trigger_858(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "rupture", matches[4])
end

function mtw.trigger_859(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "rupture")
end

function mtw.trigger_860(matches,multimatches)
mtw.attack_start(matches[2], "rupture")
end

function mtw.trigger_861(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "rupture", matches[5])
end

function mtw.trigger_862(matches,multimatches)
mtw.attack_hit(matches[3], "rupture")
end

function mtw.trigger_863(matches,multimatches)
mtw.attack_miss(matches[3], "rupture")
end

function mtw.trigger_864(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "enervating_jab")
end

function mtw.trigger_865(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "enervating_jab")
end

function mtw.trigger_866(matches,multimatches)
mtw.atk_defend(matches[2], matches[2], "enervating_jab", matches[4])
end

function mtw.trigger_867(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "enervating_jab")
end

function mtw.trigger_868(matches,multimatches)
mtw.attack_start(matches[2], "enervating_jab")
end

function mtw.trigger_869(matches,multimatches)
mtw.attack_hit(matches[3], "enervating_jab")
end

function mtw.trigger_870(matches,multimatches)
mtw.attack_miss(matches[3], "enervating_jab")
end

function mtw.trigger_871(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "enervating_jab", matches[5])
end

function mtw.trigger_872(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "enfeeble")
end

function mtw.trigger_873(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "enfeeble")
end

function mtw.trigger_874(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "enfeeble", matches[4])
end

function mtw.trigger_875(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "enfeeble")
end

function mtw.trigger_876(matches,multimatches)
mtw.attack_start(matches[2], "enfeeble")
end

function mtw.trigger_877(matches,multimatches)
mtw.attack_hit(matches[3], "enfeeble")
end

function mtw.trigger_878(matches,multimatches)
--if string.find(matches[5], matches[3]) then
-- mtw.attack_defend(matches[3], "enfeeble")
--end
mtw.attack_defend(matches[3], matches[2], "enfeeble", matches[5])
end

function mtw.trigger_879(matches,multimatches)
mtw.attack_miss(matches[3], "enfeeble")
end

function mtw.trigger_880(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "terminate")
end

function mtw.trigger_881(matches,multimatches)
mtw.atk_miss(matches[2], matches[4], "terminate")
end

function mtw.trigger_882(matches,multimatches)
mtw.attack_start(matches[3], "terminate")
end

function mtw.trigger_883(matches,multimatches)
mtw.attack_miss(matches[2], "terminate")
end

function mtw.trigger_884(matches,multimatches)
mtw.attack_hit(matches[3], "terminate")
end

function mtw.trigger_885(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "terminate")
end

function mtw.trigger_886(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "batter")
end

function mtw.trigger_887(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "batter")
end

function mtw.trigger_888(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "batter")
end

function mtw.trigger_889(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "batter", matches[5])
end

function mtw.trigger_890(matches,multimatches)
mtw.attack_start(mtw.target, "desperate_strike")
end

function mtw.trigger_891(matches,multimatches)
mtw.attack_hit(matches[2], "desperate_strike")
mtw.balance_lose("desperate")
end

function mtw.trigger_892(matches,multimatches)
mtw.attack_miss(matches[2], "desperate_strike")
mtw.balance_lose("desperate")
end

function mtw.trigger_893(matches,multimatches)
mtw.balance_regain("desperate")
end

function mtw.trigger_894(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "rake")
end

function mtw.trigger_895(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "rake")
end

function mtw.trigger_896(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "rake")
end

function mtw.trigger_897(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "rake", matches[4])
end

function mtw.trigger_898(matches,multimatches)
mtw.attack_start(matches[3], "rake")
end

function mtw.trigger_899(matches,multimatches)
mtw.attack_hit(matches[3], "rake")
end

function mtw.trigger_900(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "rake", matches[5])
end

function mtw.trigger_901(matches,multimatches)
mtw.attack_miss(matches[3], "rake")
end

function mtw.trigger_902(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "gutsmash")
end

function mtw.trigger_903(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "gutsmash")
--queue_diag()
end

function mtw.trigger_904(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "gutsmash", matches[4])
end

function mtw.trigger_905(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "gutsmash")
end

function mtw.trigger_906(matches,multimatches)
mtw.attack_start(matches[3], "gutsmash")
end

function mtw.trigger_907(matches,multimatches)
mtw.attack_hit(matches[2], "gutsmash")
end

function mtw.trigger_908(matches,multimatches)
mtw.attack_miss(matches[3], "gutsmash")
end

function mtw.trigger_909(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "gutsmash", matches[5])
end

function mtw.trigger_910(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "blackeye")
end

function mtw.trigger_911(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "blackeye")
--mtw.aff_have("blind")
mtw.aff_have("blackout")
end

function mtw.trigger_912(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "blackeye")
end

function mtw.trigger_913(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "blackeye", matches[4])
end

function mtw.trigger_914(matches,multimatches)
mtw.attack_start(matches[3], "blackeye")
end

function mtw.trigger_915(matches,multimatches)
mtw.attack_hit(matches[3], "blackeye")
end

function mtw.trigger_916(matches,multimatches)
mtw.attack_miss(matches[3], "blackeye")
end

function mtw.trigger_917(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "blackeye", matches[6])
end

function mtw.trigger_918(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "slit_throat")
end

function mtw.trigger_919(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "slit_throat")
end

function mtw.trigger_920(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "slit_throat", matches[4])
end

function mtw.trigger_921(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "slit_throat")
end

function mtw.trigger_922(matches,multimatches)
mtw.attack_start(matches[3], "slit_throat")
end

function mtw.trigger_923(matches,multimatches)
mtw.attack_hit(matches[3], "slit_throat")
end

function mtw.trigger_924(matches,multimatches)
mtw.attack_miss(matches[3], "slit_throat")
end

function mtw.trigger_925(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "slit_throat", matches[5])
end

function mtw.trigger_926(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "legslice")
end

function mtw.trigger_927(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "legslice")
end

function mtw.trigger_928(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "legslice", matches[4])
end

function mtw.trigger_929(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "legslice")
end

function mtw.trigger_930(matches,multimatches)
mtw.attack_start(matches[3], "legslice")
end

function mtw.trigger_931(matches,multimatches)
mtw.attack_hit(matches[3], "legslice")
end

function mtw.trigger_932(matches,multimatches)
mtw.attack_miss(matches[3], "legslice")
end

function mtw.trigger_933(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "legslice", matches[5])
end

function mtw.trigger_934(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "nerve_strike")
end

function mtw.trigger_935(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "nerve_strike")
end

function mtw.trigger_936(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "nerve_strike")
end

function mtw.trigger_937(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "nerve_strike", matches[4])
end

function mtw.trigger_938(matches,multimatches)
mtw.attack_start(matches[3], "nerve_strike")
end

function mtw.trigger_939(matches,multimatches)
mtw.attack_hit(matches[3], "nerve_strike")
end

function mtw.trigger_940(matches,multimatches)
mtw.attack_miss(matches[3], "nerve_strike")
end

function mtw.trigger_941(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "nerve_strike", matches[5])
end

function mtw.trigger_942(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "crunch_arms")
end

function mtw.trigger_943(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "crunch_arms")
end

function mtw.trigger_944(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "crunch_arms", matches[4])
end

function mtw.trigger_945(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "crunch_arms")
end

function mtw.trigger_946(matches,multimatches)
mtw.attack_start(matches[3], "crunch_arms")
end

function mtw.trigger_947(matches,multimatches)
mtw.attack_hit(matches[3], "crunch_arms")
end

function mtw.trigger_948(matches,multimatches)
mtw.attack_miss(matches[3], "crunch_arms")
end

function mtw.trigger_949(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "crunch_arms", matches[5])
end

function mtw.trigger_950(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "headsmash")
end

function mtw.trigger_951(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "headsmash")
end

function mtw.trigger_952(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "headsmash", matches[4])
end

function mtw.trigger_953(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "headsmash")
end

function mtw.trigger_954(matches,multimatches)
mtw.attack_start(matches[3], "headsmash")
end

function mtw.trigger_955(matches,multimatches)
mtw.attack_hit(matches[3], "headsmash")
end

function mtw.trigger_956(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "headsmash", matches[5])
end

function mtw.trigger_957(matches,multimatches)
mtw.attack_miss(matches[3], "headsmash")
end

function mtw.trigger_958(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "shatter_"..matches[4].."_"..matches[5])
end

function mtw.trigger_959(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "shatter_"..matches[4].."_"..matches[5])
end

function mtw.trigger_960(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "shatter_right_leg")
mtw.atk_miss(matches[2], matches[3], "shatter_left_leg")
mtw.atk_miss(matches[2], matches[3], "shatter_right_arm")
mtw.atk_miss(matches[2], matches[3], "shatter_left_arm")
end

function mtw.trigger_961(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "shatter_"..matches[4].."_"..matches[5], matches[6])
end

function mtw.trigger_962(matches,multimatches)
mtw.attack_start(matches[3], "shatter_"..matches[5].."_"..matches[6])
end

function mtw.trigger_963(matches,multimatches)
mtw.attack_hit(matches[3], "shatter_"..matches[5].."_"..matches[6])
end

function mtw.trigger_964(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "shatter_"..matches[5].."_"..matches[6], matches[7])
end

function mtw.trigger_965(matches,multimatches)
mtw.attack_miss(matches[3], "shatter_right_leg")
mtw.attack_miss(matches[3], "shatter_left_leg")
mtw.attack_miss(matches[3], "shatter_right_arm")
mtw.attack_miss(matches[3], "shatter_left_arm")
end

function mtw.trigger_966(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "knockdown")
end

function mtw.trigger_967(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "knockdown")
end

function mtw.trigger_968(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "knockdown")
end

function mtw.trigger_969(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "knockdown", matches[4])
end

function mtw.trigger_970(matches,multimatches)
mtw.attack_start(matches[3], "knockdown")
end

function mtw.trigger_971(matches,multimatches)
mtw.attack_hit(matches[3], "knockdown")
end

function mtw.trigger_972(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "knockdown", matches[5])
end

function mtw.trigger_973(matches,multimatches)
mtw.attack_miss(matches[3], "knockdown")
end

function mtw.trigger_974(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "earbash")
end

function mtw.trigger_975(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "earbash")
end

function mtw.trigger_976(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "earbash", matches[4])
end

function mtw.trigger_977(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "earbash")
end

function mtw.trigger_978(matches,multimatches)
mtw.attack_start(matches[3], "earbash")
end

function mtw.trigger_979(matches,multimatches)
mtw.attack_hit(matches[3], "earbash")
end

function mtw.trigger_980(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "earbash", matches[5])
end

function mtw.trigger_981(matches,multimatches)
mtw.attack_miss(matches[3], "earbash")
end

function mtw.trigger_982(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "burst_lungs")
end

function mtw.trigger_983(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "burst_lungs")
end

function mtw.trigger_984(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "burst_lungs", matches[4])
end

function mtw.trigger_985(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "burst_lungs")
end

function mtw.trigger_986(matches,multimatches)
mtw.attack_start(matches[3], "burst_lungs")
end

function mtw.trigger_987(matches,multimatches)
mtw.attack_hit(matches[3], "burst_lungs")
end

function mtw.trigger_988(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "burst_lungs", matches[5])
end

function mtw.trigger_989(matches,multimatches)
mtw.attack_miss(matches[3], "burst_lungs")
end

function mtw.trigger_990(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "crush_skull")
end

function mtw.trigger_991(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "crush_skull")
end

function mtw.trigger_992(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "crush_skull", matches[4])
end

function mtw.trigger_993(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "crush_skull")
end

function mtw.trigger_994(matches,multimatches)
mtw.attack_start(matches[3], "crush_skull")
end

function mtw.trigger_995(matches,multimatches)
mtw.attack_hit(matches[3], "crush_skull")
end

function mtw.trigger_996(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "crush_skull", matches[4])
end

function mtw.trigger_997(matches,multimatches)
mtw.attack_miss(matches[3], "crush_skull")
end

function mtw.trigger_998(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "brainbash")

end

function mtw.trigger_999(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "brainbash")
--queue_diag()
end

function mtw.trigger_1000(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "brainbash", matches[4])
end

function mtw.trigger_1001(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "brainbash")
end

function mtw.trigger_1002(matches,multimatches)
mtw.attack_start(matches[3], "brainbash")
end

function mtw.trigger_1003(matches,multimatches)
mtw.attack_hit(matches[3], "brainbash")
end

function mtw.trigger_1004(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "brainbash", matches[4])
end

function mtw.trigger_1005(matches,multimatches)
mtw.attack_miss(matches[3], "brainbash")
end

function mtw.trigger_1006(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "chestbash")
end

function mtw.trigger_1007(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "chestbash")
end

function mtw.trigger_1008(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "chestbash", matches[4])
end

function mtw.trigger_1009(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "chestbash")
end

function mtw.trigger_1010(matches,multimatches)
mtw.attack_start(matches[3], "chestbash")
end

function mtw.trigger_1011(matches,multimatches)
mtw.attack_hit(matches[3], "chestbash")
end

function mtw.trigger_1012(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "chestbash", matches[5])
end

function mtw.trigger_1013(matches,multimatches)
mtw.attack_miss(matches[3], "chestbash")
end

function mtw.trigger_1014(matches,multimatches)
mtw.atk_start(matches[2], nil, "stomp")
end

function mtw.trigger_1015(matches,multimatches)
mtw.atk_hit(matches[2], nil, "stomp")
mtw.aff_have("blackout")
end

function mtw.trigger_1016(matches,multimatches)
mtw.atk_miss(matches[2], nil, "stomp")
end

function mtw.trigger_1017(matches,multimatches)
mtw.attack_start(matches[2], "stomp")
end

function mtw.trigger_1018(matches,multimatches)
mtw.attack_hit(matches[2], "stomp")
end

function mtw.trigger_1019(matches,multimatches)
mtw.attack_miss(matches[2], "stomp")
end

function mtw.trigger_1020(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "pulverize")
end

function mtw.trigger_1021(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "pulverize")
end

function mtw.trigger_1022(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "pulverize", matches[4])
end

function mtw.trigger_1023(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "pulverize")
end

function mtw.trigger_1024(matches,multimatches)
mtw.attack_start(matches[3], "pulverize")
end

function mtw.trigger_1025(matches,multimatches)
mtw.attack_hit(matches[3], "pulverize")
end

function mtw.trigger_1026(matches,multimatches)
mtw.attack_miss(matches[3], "pulverize")
end

function mtw.trigger_1027(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "pulverize", matches[5])
end

function mtw.trigger_1028(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "burst_organs")
end

function mtw.trigger_1029(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "burst_organs")
end

function mtw.trigger_1030(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "burst_organs", matches[4])
end

function mtw.trigger_1031(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "burst_organs")
end

function mtw.trigger_1032(matches,multimatches)
mtw.attack_start(matches[3], "burst_organs")
end

function mtw.trigger_1033(matches,multimatches)
mtw.attack_miss(matches[3], "burst_organs")
end

function mtw.trigger_2035(matches,multimatches)
mtw.attack_hit(matches[3], "burst_organs")
end

function mtw.trigger_1034(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "burst_organs", matches[5])
end

function mtw.trigger_1035(matches,multimatches)
mtw.atk_hit(matches[2], nil, "roar_"..matches[4])
end

function mtw.trigger_1036(matches,multimatches)
mtw.atk_defend(matches[2], nil, "roar_"..matches[4], matches[5])
end

function mtw.trigger_1037(matches,multimatches)
balance.roar = false
end

function mtw.trigger_1038(matches,multimatches)
mtw.balance_regain("roar")
end

function mtw.trigger_1039(matches,multimatches)
mtw.lose_balance("roar")
end

function mtw.trigger_1040(matches,multimatches)
mtw.lose_balance("roar")
end

function mtw.trigger_1041(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "starfury")
end

function mtw.trigger_1042(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "starfury")
end

function mtw.trigger_1043(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "starfury", matches[4])
end

function mtw.trigger_1044(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "starfury")
end

function mtw.trigger_1045(matches,multimatches)
mtw.attack_start(matches[2], "starfury")
end

function mtw.trigger_1046(matches,multimatches)
mtw.attack_hit(matches[2], "starfury")
end

function mtw.trigger_1047(matches,multimatches)
mtw.attack_miss(matches[3], "starfury")
end

function mtw.trigger_1048(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "starfury", matches[5])
end

function mtw.trigger_1049(matches,multimatches)
mtw.atk_hit(matches[4], nil, "wisplight")
end

function mtw.trigger_1050(matches,multimatches)
mtw.attack_hit(matches[4], "wisplight")
mtw.balance_lose("offhand")
cecho("\n<brown> You gave: <green>")
if matches[3] == "indigo" then
 cecho("HEADACHE")
else
 cecho("IMPATIENCE")
end
cecho("<brown>!")
end

function mtw.trigger_1051(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "hummingbird")
end

function mtw.trigger_1052(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "hummingbird")
end

function mtw.trigger_1053(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "hummingbird", matches[4])
end

function mtw.trigger_1054(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "hummingbird")
end

function mtw.trigger_1055(matches,multimatches)
mtw.attack_start(matches[3], "hummingbird")
end

function mtw.trigger_1056(matches,multimatches)
mtw.attack_hit(matches[3], "hummingbird")
end

function mtw.trigger_1057(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "hummingbird", matches[5])
end

function mtw.trigger_1058(matches,multimatches)
mtw.attack_miss(matches[3], "hummingbird")
end

function mtw.trigger_1059(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "icehowl")
end

function mtw.trigger_1060(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "icehowl")
end

function mtw.trigger_1061(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "icehowl", matches[4])
end

function mtw.trigger_1062(matches,multimatches)
mtw.atk_miss(matches[2], nil, "icehowl")
end

function mtw.trigger_1063(matches,multimatches)
mtw.attack_start(matches[3], "icehowl")
end

function mtw.trigger_1064(matches,multimatches)
mtw.attack_hit(matches[2], "icehowl")
end

function mtw.trigger_1065(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "icehowl", matches[5])
end

function mtw.trigger_1066(matches,multimatches)
mtw.attack_miss(matches[2], "icehowl")
end

function mtw.trigger_1067(matches,multimatches)
if not string.find(matches[2], "Gripping") then
 mtw.atk_start(matches[2], nil, "spinkick")
end
end

function mtw.trigger_1068(matches,multimatches)
mtw.atk_hit(matches[2], nil, "spinkick")
end

function mtw.trigger_1069(matches,multimatches)
mtw.atk_start(matches[3], matches[2], "spinkick_slash")
end

function mtw.trigger_1070(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "spinkick_slash")
end

function mtw.trigger_1071(matches,multimatches)
mtw.atk_defend(matches[2], nil, "spinkick", matches[3])
mtw.atk_defend(matches[2], nil, "spinkick_slash", matches[3])
end

function mtw.trigger_1072(matches,multimatches)
mtw.atk_miss(matches[2], nil, "spinkick")
mtw.atk_miss(matches[2], nil, "spinkick_slash")
end

function mtw.trigger_1073(matches,multimatches)
mtw.attack_start(matches[2], "spinkick")
end

function mtw.trigger_1074(matches,multimatches)
mtw.attack_hit(matches[2], "spinkick")
end

function mtw.trigger_1075(matches,multimatches)
mtw.attack_defend(matches[2], nil, "spinkick", matches[4])
end

function mtw.trigger_1076(matches,multimatches)
mtw.attack_start(matches[3], "spinkick_slash")
end

function mtw.trigger_1077(matches,multimatches)
mtw.attack_hit(matches[2], "spinkick_slash")
end

function mtw.trigger_1078(matches,multimatches)
mtw.attack_miss(matches[2], "spinkick")
end

function mtw.trigger_1079(matches,multimatches)
mtw.attack_miss(matches[2], "spinkick_slash")
end

function mtw.trigger_1080(matches,multimatches)
mtw.atk_hit(matches[2], nil, "lunarburst")
end

function mtw.trigger_1081(matches,multimatches)
mtw.attack_hit(matches[3], "lunarburst")
mtw.balance_lose("offhand")
cecho("\n<brown> You gave: <green>")
if matches[2] == "pale" then
 cecho("CONFUSION")
else
 cecho("DEPRESSION")
end
cecho("<brown>!")
end

function mtw.trigger_1082(matches,multimatches)
mtw.atk_hit(matches[2], nil, "thunderburst")
mtw.aff_have("balance_loss")
end

function mtw.trigger_1083(matches,multimatches)
mtw.attack_hit(matches[2], "thunderburst")
mtw.balance_lose("offhand")
end

function mtw.trigger_1084(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "rainfall_arc")
end

function mtw.trigger_1085(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "rainfall_arc")
end

function mtw.trigger_1086(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "rainfall_arc", matches[4])
end

function mtw.trigger_1087(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "rainfall_arc")
end

function mtw.trigger_1088(matches,multimatches)
mtw.attack_start(matches[3], "rainfall_arc")
end

function mtw.trigger_1089(matches,multimatches)
mtw.attack_hit(matches[3], "rainfall_arc")
end

function mtw.trigger_1090(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "rainfall_arc", matches[4])
end

function mtw.trigger_1091(matches,multimatches)
mtw.attack_miss(matches[3], "rainfall_arc")
end

function mtw.trigger_1092(matches,multimatches)
mtw.atk_start(matches[2], nil, "leaf_breeze")
end

function mtw.trigger_1093(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "leaf_breeze")
end

function mtw.trigger_1094(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "leaf_breeze", matches[4])
end

function mtw.trigger_1095(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "leaf_breeze")
end

function mtw.trigger_1096(matches,multimatches)
mtw.attack_start(matches[2], "leaf_breeze")
end

function mtw.trigger_1097(matches,multimatches)
mtw.attack_hit(matches[2], "leaf_breeze")
end

function mtw.trigger_1098(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "leaf_breeze", matches[4])
end

function mtw.trigger_1099(matches,multimatches)
mtw.attack_miss(matches[3], "leaf_breeze")
end

function mtw.trigger_1100(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "mooncrescent")
end

function mtw.trigger_1101(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "mooncrescent")
end

function mtw.trigger_1102(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "mooncrescent", matches[4])
end

function mtw.trigger_1103(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "mooncrescent")
end

function mtw.trigger_1104(matches,multimatches)
mtw.attack_start(matches[3], "mooncrescent")
end

function mtw.trigger_1105(matches,multimatches)
mtw.attack_hit(matches[2], "mooncrescent")
end

function mtw.trigger_1106(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "mooncrescent", matches[5])
end

function mtw.trigger_1107(matches,multimatches)
mtw.attack_miss(matches[2], "mooncrescent")
end

function mtw.trigger_1108(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "whirlwind")
end

function mtw.trigger_1109(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "whirlwind")
end

function mtw.trigger_1110(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "whirlwind", matches[4])
end

function mtw.trigger_1111(matches,multimatches)
mtw.attack_start(matches[2], "whirlwind")
end

function mtw.trigger_1112(matches,multimatches)
mtw.attack_hit(matches[2], "whirlwind")
end

function mtw.trigger_1113(matches,multimatches)
mtw.atk_hit(matches[2], nil, "sunburst")
end

function mtw.trigger_1114(matches,multimatches)
mtw.attack_hit(matches[4], "sunburst")
mtw.balance_lose("offhand")
cecho("\n<brown> You gave: <green>")
if matches[3] == "orange" then
 cecho("EPILEPSY")
else
 cecho("BRAIN DAMAGE")
end
cecho("<brown>!")
end

function mtw.trigger_1115(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "cutting_clouds")
end

function mtw.trigger_1116(matches,multimatches)
if not string.find(matches[3], "but slices only thin air") then
mtw.atk_hit(matches[2], matches[3], "cutting_clouds")
end
end

function mtw.trigger_1117(matches,multimatches)
--mtw.atk_defend(matches[2], matches[3], "cutting_clouds", matches[4])
if string.find(matches[4], matches[2]) and not string.find(matches[3], "but slices only thin air") then
 mtw.atk_defend(matches[2], matches[3], "cutting_clouds", matches[4])
end
end

function mtw.trigger_1118(matches,multimatches)
mtw.attack_start(matches[3], "cutting_clouds")
end

function mtw.trigger_1119(matches,multimatches)
--mtw.attack_hit(matches[2], "cutting_clouds")
if not string.find(matches[3], "but slice only thin air") then
 mtw.attack_hit(matches[2], "cutting_clouds")
end


end

function mtw.trigger_1120(matches,multimatches)
mtw.attack_miss(matches[2], "cutting_clouds")
end

function mtw.trigger_1121(matches,multimatches)
--mtw.attack_defend(matches[2], matches[3], "cutting_clouds", matches[4])
if string.find(matches[4], matches[2]) and not string.find(matches[3], "but slice only thin air") then
 mtw.attack_defend(matches[2], matches[3], "cutting_clouds", matches[4])
end
end

function mtw.trigger_1122(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "cutting_clouds")
end

function mtw.trigger_1123(matches,multimatches)
mtw.atk_start(matches[2], nil, "thornrose")
end

function mtw.trigger_1124(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "thornrose")
end

function mtw.trigger_1125(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "thornrose", matches[4])
end

function mtw.trigger_1126(matches,multimatches)
mtw.atk_miss(matches[2], nil, "thornrose")
end

function mtw.trigger_1127(matches,multimatches)
mtw.attack_start(matches[2], "thornrose")
end

function mtw.trigger_1128(matches,multimatches)
mtw.attack_hit(matches[2], "thornrose")
end

function mtw.trigger_1129(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "thornrose", matches[4])
end

function mtw.trigger_1130(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "phoenix_unfurls")
end

function mtw.trigger_1131(matches,multimatches)
mtw.atk_hit(matches[2], matches[4], "phoenix_unfurls")
end

function mtw.trigger_1132(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "phoenix_unfurls")
end

function mtw.trigger_1133(matches,multimatches)
mtw.attack_start(matches[2], "phoenix_unfurls")
mtw.def_take("phoenix_crouching")
end

function mtw.trigger_1134(matches,multimatches)
mtw.attack_hit(matches[2], "phoenix_unfurls")
end

function mtw.trigger_1135(matches,multimatches)
mtw.atk_start(matches[3], matches[2], "eclipse_over_water")
end

function mtw.trigger_1136(matches,multimatches)
mtw.atk_hit(matches[2], nil, "eclipse_over_water")
end

function mtw.trigger_1137(matches,multimatches)
mtw.atk_miss(matches[2], nil, "eclipse_over_water")
end

function mtw.trigger_1138(matches,multimatches)
mtw.attack_start(matches[3], "eclipse_over_water")
end

function mtw.trigger_1139(matches,multimatches)
mtw.attack_hit(matches[2], "eclipse_over_water")
end

function mtw.trigger_1140(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "thrust")
end

function mtw.trigger_1141(matches,multimatches)
mtw.atk_hit(matches[2], matches[4], "thrust")
end

function mtw.trigger_1142(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "thrust")
end

function mtw.trigger_1143(matches,multimatches)
mtw.atk_defend(matches[2], matches[4], "thrust", matches[5])
end

function mtw.trigger_1144(matches,multimatches)
mtw.attack_start(matches[3], "thrust")
end

function mtw.trigger_1145(matches,multimatches)
mtw.attack_hit(matches[3], "thrust", matches[2])
end

function mtw.trigger_1146(matches,multimatches)
mtw.attack_miss(matches[3], "thrust")
end

function mtw.trigger_1147(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "thrust", matches[5])
end

function mtw.trigger_1148(matches,multimatches)
mtw.atk_start(matches[2], matches[5], "fleche")
end

function mtw.trigger_1149(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "fleche")
end

function mtw.trigger_1150(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "fleche")
end

function mtw.trigger_1151(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "fleche", matches[4])
end

function mtw.trigger_1152(matches,multimatches)
mtw.attack_start(matches[3], "fleche")
end

function mtw.trigger_1153(matches,multimatches)
mtw.attack_hit(matches[2], "fleche", matches[4])
end

function mtw.trigger_1154(matches,multimatches)
mtw.attack_miss(matches[2], "fleche")
end

function mtw.trigger_1155(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "fleche", matches[7])
end

function mtw.trigger_1156(matches,multimatches)
mtw.atk_start(matches[2], nil, "hamstring")
end

function mtw.trigger_1157(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "hamstring")
end

function mtw.trigger_1158(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "hamstring")
end

function mtw.trigger_1159(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "hamstring", matches[4])
end

function mtw.trigger_1160(matches,multimatches)
mtw.attack_start(matches[2], "hamstring")
end

function mtw.trigger_1161(matches,multimatches)
mtw.attack_hit(matches[3], "hamstring", matches[2])
end

function mtw.trigger_1162(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "hamstring", matches[5])
end

function mtw.trigger_1163(matches,multimatches)
mtw.attack_miss(matches[3], "hamstring")
end

function mtw.trigger_1164(matches,multimatches)
mtw.third_start(matches[2], nil, "hamstring", matches[3])
end

function mtw.trigger_1165(matches,multimatches)
mtw.third_hit(matches[2], matches[3], "hamstring", matches[4])
end

function mtw.trigger_1166(matches,multimatches)
mtw.third_defend(matches[2], matches[3], "hamstring", matches[6], matches[4])
end

function mtw.trigger_1167(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "puncture")
end

function mtw.trigger_1168(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "puncture")
 for i in pairs(mtw.defenses) do
  if mtw.defenses[i].defense == matches[4] then
   cecho("<brown>\nStripped "..i)
   mtw.def_remove(i)
  end
 end
end

function mtw.trigger_1169(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "puncture")
end

function mtw.trigger_1170(matches,multimatches)
mtw.atk_defend(matches[2], nil, "puncture", matches[3])
end

function mtw.trigger_1171(matches,multimatches)
mtw.attack_start(matches[3], "puncture")
end

function mtw.trigger_1172(matches,multimatches)
mtw.attack_hit(matches[2], "puncture", nil)
cecho("<brown>\nYou: STRIPPED <green>"..matches[6])
end

function mtw.trigger_1173(matches,multimatches)
mtw.attack_hit(matches[2], "puncture")
cecho("<green>\nNothing to strip!")
end

function mtw.trigger_1174(matches,multimatches)
mtw.attack_defend(matches[2], nil, "puncture", matches[4])
end

function mtw.trigger_1175(matches,multimatches)
mtw.attack_miss(matches[2], "puncture")
end

function mtw.trigger_1176(matches,multimatches)
mtw.atk_start(matches[2], nil, "wristflick")
end

function mtw.trigger_1177(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "wristflick")
end

function mtw.trigger_1178(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "wristflick")
end

function mtw.trigger_1179(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "wristflick", matches[4])
end

function mtw.trigger_1180(matches,multimatches)
mtw.attack_start(matches[2], "wristflick")
end

function mtw.trigger_1181(matches,multimatches)
mtw.attack_hit(matches[3], "wristflick", matches[2])
end

function mtw.trigger_1182(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "wristflick", matches[5])
end

function mtw.trigger_1183(matches,multimatches)
mtw.attack_miss(matches[3], "wristflick")
end

function mtw.trigger_1184(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "lowblow")
end

function mtw.trigger_1185(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "lowblow")
end

function mtw.trigger_1186(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "lowblow")
end

function mtw.trigger_1187(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "lowblow", matches[4])
end

function mtw.trigger_1188(matches,multimatches)
mtw.attack_start(matches[3], "lowblow")
end

function mtw.trigger_1189(matches,multimatches)
mtw.attack_hit(matches[3], "lowblow", matches[2])
end

function mtw.trigger_1190(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "lowblow", matches[5])
end

function mtw.trigger_1191(matches,multimatches)
mtw.attack_miss(matches[3], "lowblow")
end

function mtw.trigger_1192(matches,multimatches)
mtw.atk_start(matches[2], nil, "backslice")
end

function mtw.trigger_1193(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "backslice")
end

function mtw.trigger_1194(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "backslice")
end

function mtw.trigger_1195(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "backslice", matches[4])
end

function mtw.trigger_1196(matches,multimatches)
mtw.attack_start(matches[2], "backslice")
end

function mtw.trigger_1197(matches,multimatches)
mtw.attack_hit(matches[3], "backslice", matches[2])
end

function mtw.trigger_1198(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "backslice", matches[5])
end

function mtw.trigger_1199(matches,multimatches)
mtw.attack_miss(matches[3], "backslice")
end

function mtw.trigger_1200(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "pommel")
end

function mtw.trigger_1201(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "pommel")
end

function mtw.trigger_1202(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "pommel")
end

function mtw.trigger_1203(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "pommel", matches[4])
end

function mtw.trigger_1204(matches,multimatches)
mtw.attack_start(matches[2], "pommel")
end

function mtw.trigger_1205(matches,multimatches)
mtw.attack_hit(matches[3], "pommel")
end

function mtw.trigger_1206(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "pommel", matches[5])
end

function mtw.trigger_1207(matches,multimatches)
mtw.attack_miss(matches[2], "pommel")
end

function mtw.trigger_1208(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." START beat you!")
end

function mtw.trigger_1209(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." HIT beat you!")
end

function mtw.trigger_1210(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." MISS beat you!")
--mtw.atk_miss(matches[2], nil, "beat")
end

function mtw.trigger_1211(matches,multimatches)
mtw.attack_start(matches[3], "beat")
end

function mtw.trigger_1212(matches,multimatches)
mtw.attack_hit(matches[2], "beat", matches[5])
end

function mtw.trigger_1213(matches,multimatches)
mtw.attack_defend(matches[2], matches[5], "hemorrhage", matches[7])
end

function mtw.trigger_1214(matches,multimatches)
mtw.attack_miss(matches[2], "beat")
end

function mtw.trigger_1215(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "balestra")
end

function mtw.trigger_1216(matches,multimatches)
mtw.atk_hit(matches[2], matches[4], "balestra")
end

function mtw.trigger_1217(matches,multimatches)
mtw.atk_miss(matches[2], nil, "balestra")
end

function mtw.trigger_1218(matches,multimatches)
mtw.atk_defend(matches[2], matches[5], "balestra", matches[6])
end

function mtw.trigger_1219(matches,multimatches)
mtw.attack_start(matches[2], "balestra")
end

function mtw.trigger_1220(matches,multimatches)
mtw.attack_hit(matches[2], "balestra", matches[5])
end

function mtw.trigger_1221(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "balestra", matches[5])
end

function mtw.trigger_1222(matches,multimatches)
mtw.attack_miss(matches[2], "balestra")
end

function mtw.trigger_1223(matches,multimatches)
mtw.attack_start(matches[3], "beguile")
end

function mtw.trigger_1224(matches,multimatches)
mtw.attack_hit(matches[2], "beguile", matches[4])
end

function mtw.trigger_1225(matches,multimatches)
mtw.attack_miss(matches[2], "beguile")
end

function mtw.trigger_1226(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "beguile", matches[6])
end

function mtw.trigger_1227(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "flourish")
end

function mtw.trigger_1228(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "flourish")
end

function mtw.trigger_1229(matches,multimatches)
mtw.atk_miss(matches[2], nil, "flourish")
end

function mtw.trigger_1230(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "flourish", matches[5])
end

function mtw.trigger_1231(matches,multimatches)
mtw.attack_start(matches[3], "flourish")
end

function mtw.trigger_1232(matches,multimatches)
mtw.attack_hit(matches[3], "flourish", matches[2])
for i in pairs(mtw.attacks) do
 if mtw.attacks[i].attacker == matches[3] then
  mtw.reset_attack(i)
 end
end
mtw.balance_lose("flourish")
end

function mtw.trigger_1233(matches,multimatches)
mtw.attack_defend(matches[3], matches[2], "flourish", matches[4])
mtw.balance_lose("flourish")
end

function mtw.trigger_1234(matches,multimatches)
mtw.attack_miss(matches[2], "flourish")
mtw.balance_lose("flourish")
end

function mtw.trigger_1235(matches,multimatches)
mtw.atk_start(matches[2], nil, "disarm")
end

function mtw.trigger_1236(matches,multimatches)
mtw.atk_hit(matches[2], nil, "disarm")
end

function mtw.trigger_1237(matches,multimatches)
mtw.atk_miss(matches[2], nil, "disarm")
end

function mtw.trigger_1238(matches,multimatches)
mtw.atk_defend(matches[2], nil, "disarm", matches[3])
end

function mtw.trigger_1239(matches,multimatches)
mtw.attack_start(matches[2], "disarm")
end

function mtw.trigger_1240(matches,multimatches)
mtw.attack_hit(matches[2], "disarm")
end

function mtw.trigger_1241(matches,multimatches)
mtw.attack_defend(matches[2], nil, "disarm", matches[3])
end

function mtw.trigger_1242(matches,multimatches)
mtw.attack_miss(matches[2], "disarm")
end

function mtw.trigger_1243(matches,multimatches)
mtw.atk_hit(matches[2], nil, "disarm")
mtw.def_remove("def_grip")
end

function mtw.trigger_1244(matches,multimatches)
mtw.atk_start(matches[2], nil, "press")
end

function mtw.trigger_1245(matches,multimatches)
mtw.atk_hit(matches[2], matches[4], "press")
end

function mtw.trigger_1246(matches,multimatches)
mtw.atk_miss(matches[2], nil, "press")
end

function mtw.trigger_1247(matches,multimatches)
mtw.attack_start(matches[2], "press")
end

function mtw.trigger_1248(matches,multimatches)
mtw.attack_hit(matches[2], "press")
end

function mtw.trigger_1249(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "glint")
end

function mtw.trigger_1250(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "glint")
end

function mtw.trigger_1251(matches,multimatches)
mtw.atk_miss(matches[2], nil, "glint")
end

function mtw.trigger_1252(matches,multimatches)
mtw.attack_start(matches[3], "glint")
end

function mtw.trigger_1253(matches,multimatches)
mtw.attack_hit(matches[4], "glint")
end

function mtw.trigger_1254(matches,multimatches)
mtw.atk_start(matches[2], nil, "inquartata")
end

function mtw.trigger_1255(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "inquartata")
end

function mtw.trigger_1256(matches,multimatches)
mtw.atk_miss(matches[2], nil, "inquartata")
end

function mtw.trigger_1257(matches,multimatches)
mtw.atk_defend(matches[2], nil, "inquartata", matches[4])
end

function mtw.trigger_1258(matches,multimatches)
mtw.attack_start(matches[2], "inquartata")
mtw.recent_defend = false
end

function mtw.trigger_1259(matches,multimatches)
mtw.attack_hit(matches[2], "inquartata", matches[3])

end

function mtw.trigger_1260(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "inquartata", matches[4])
end

function mtw.trigger_1261(matches,multimatches)
mtw.recent_defend = false
end

function mtw.trigger_1262(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." HIT backhand you!")
end

function mtw.trigger_1262b(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." FAILED backhand you!")
end

function mtw.trigger_1263(matches,multimatches)
deleteLine()
cecho("<green>\n"..matches[2].." MISS backhand you!")
end

function mtw.trigger_1264(matches,multimatches)
mtw.attack_hit(matches[2], "backhand")
end

function mtw.trigger_1265(matches,multimatches)
mtw.attack_miss(matches[2], "backhand")
end

function mtw.trigger_1266(matches,multimatches)
attack_defend(matches[2], nil, "backhand", matches[4])
end

function mtw.trigger_1267(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "hemorrhage")
end

function mtw.trigger_1268(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "hemorrhage")
end

function mtw.trigger_1269(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "hemorrhage", matches[4])
end

function mtw.trigger_1270(matches,multimatches)
mtw.atk_miss(matches[2], nil, "hemorrhage")
end

function mtw.trigger_1271(matches,multimatches)
mtw.attack_start(matches[2], "hemorrhage")
end

function mtw.trigger_1272(matches,multimatches)
mtw.attack_hit(matches[2], "hemorrhage", matches[4])
end

function mtw.trigger_1273(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "hemorrhage", matches[5])
end

function mtw.trigger_1274(matches,multimatches)
mtw.attack_miss(matches[3], "hemorrhage")
end

function mtw.trigger_1275(matches,multimatches)
mtw.attack_start(matches[3], "coup_de_grace")
end

function mtw.trigger_1276(matches,multimatches)
mtw.attack_miss(matches[3], "coup_de_grace")
end

function mtw.trigger_1277(matches,multimatches)
mtw.attack_hit(matches[2], "coup_de_grace")
end

function mtw.trigger_1278(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "crossbow")
end

function mtw.trigger_1279(matches,multimatches)
mtw.atk_hit("Someone", nil, "crossbow")
end

function mtw.trigger_1280(matches,multimatches)
mtw.atk_defend("Someone", nil, "crossbow", matches[2])
end

function mtw.trigger_1281(matches,multimatches)
mtw.atk_start("Someone", nil, "crossbowed")
end

function mtw.trigger_1282(matches,multimatches)
mtw.atk_hit("Someone", nil, "crossbowed")
end

function mtw.trigger_1283(matches,multimatches)
mtw.atk_defend("Someone", nil, "crossbowed", matches[2])
end

function mtw.trigger_1284(matches,multimatches)
mtw.attack_hit(matches[2], "backstab", matches[3])
end

function mtw.trigger_1285(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "vileblade")
end

function mtw.trigger_1286(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "vileblade")
end

function mtw.trigger_1287(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "vileblade")
end

function mtw.trigger_1288(matches,multimatches)
mtw.atk_defend(matches[2], nil, "vileblade", matches[4])
end

function mtw.trigger_1289(matches,multimatches)
mtw.attack_start(matches[3], "vileblade")
end

function mtw.trigger_1290(matches,multimatches)
mtw.attack_hit(matches[2], "vileblade", matches[3])
end

function mtw.trigger_1291(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "vileblade", matches[4])
end

function mtw.trigger_1292(matches,multimatches)
mtw.attack_miss(matches[3], "vilebade")
end

function mtw.trigger_1293(matches,multimatches)
mtw.atk_start(matches[2], nil, "cheap_shot")
end

function mtw.trigger_1294(matches,multimatches)
mtw.atk_hit(matches[2], nil, "cheap_shot")
mtw.aff_have("blackout")
mtw.aff_have("vomiting")
end

function mtw.trigger_1295(matches,multimatches)
mtw.atk_defend(matches[2], nil, "cheap_shot", matches[3])
mtw.aff_have("blackout")
end

function mtw.trigger_1296(matches,multimatches)
mtw.atk_miss(matches[2], nil, "cheap_shot")
end

function mtw.trigger_1297(matches,multimatches)
mtw.attack_start(matches[2], "cheap_shot")
end

function mtw.trigger_1298(matches,multimatches)
mtw.attack_hit(matches[2], "cheap_shot")
end

function mtw.trigger_1299(matches,multimatches)
mtw.attack_defend(matches[2], nil, "cheap_shot", matches[3])
end

function mtw.trigger_1300(matches,multimatches)
mtw.attack_miss(matches[2], "cheap_shot")
end

function mtw.trigger_1301(matches,multimatches)
mtw.attack_start(matches[2], "hogtie")
end

function mtw.trigger_1302(matches,multimatches)
mtw.attack_hit(matches[2], "hogtie")
end

function mtw.trigger_1303(matches,multimatches)
mtw.attack_start(matches[3], "slitthroat")
end

function mtw.trigger_1304(matches,multimatches)
mtw.attack_hit(matches[2], "slitthroat")
end

function mtw.trigger_1305(matches,multimatches)
mtw.attack_miss(matches[2], "slitthroat")
end

function mtw.trigger_1306(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "lungstab")
end

function mtw.trigger_1307(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "lungstab")
end

function mtw.trigger_1308(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "lungstab")
end

function mtw.trigger_1309(matches,multimatches)
mtw.atk_defend(matches[2], nil, "lungstab", matches[4])
end

function mtw.trigger_1310(matches,multimatches)
mtw.attack_start(matches[2], "lungstab")
end

function mtw.trigger_1311(matches,multimatches)
mtw.attack_hit(matches[2], "lungstab", matches[4])
end

function mtw.trigger_1312(matches,multimatches)
mtw.attack_defend(matches[2], matches[4], "lungstab", matches[5])
end

function mtw.trigger_1313(matches,multimatches)
mtw.attack_miss(matches[3], "lungstab")
end

function mtw.trigger_1314(matches,multimatches)
mtw.attack_hit(matches[2], "shiv", matches[3])
end

function mtw.trigger_1315(matches,multimatches)
mtw.attack_miss(matches[2], "shiv")
end

function mtw.trigger_1316(matches,multimatches)
deleteLine()
cecho("<red>\n"..matches[2].." HIT shiv you!")
end

function mtw.trigger_1317(matches,multimatches)
mtw.atk_start(matches[2], nil, "sucker_punch")
end

function mtw.trigger_1318(matches,multimatches)
mtw.atk_hit(matches[2], nil, "sucker_punch")
end

function mtw.trigger_1319(matches,multimatches)
mtw.atk_defend(matches[2], nil, "sucker_punch", matches[3])
end

function mtw.trigger_1320(matches,multimatches)
mtw.atk_miss(matches[2], nil, "sucker_punch")
end

function mtw.trigger_1321(matches,multimatches)
mtw.attack_start(matches[2], "sucker_punch")
end

function mtw.trigger_1322(matches,multimatches)
mtw.attack_hit(matches[2], "sucker_punch")
end

function mtw.trigger_1323(matches,multimatches)
mtw.attack_miss(matches[2], "sucker_punch")
end

function mtw.trigger_1324(matches,multimatches)
mtw.attack_defend(matches[2], nil, "sucker_punch", matches[4])
end

function mtw.trigger_1325(matches,multimatches)
mtw.attack_start(matches[2], matches[3], "sleightofhand")
end

function mtw.trigger_1326(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "sleightofhand")
end

function mtw.trigger_1327(matches,multimatches)
mtw.atk_miss(matches[2], nil, "sleightofhand")
end

function mtw.trigger_1328(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "sleightofhand", matches[4])
end

function mtw.trigger_1329(matches,multimatches)
mtw.attack_start(matches[2], "sleightofhand")
end

function mtw.trigger_1330(matches,multimatches)
mtw.attack_hit(matches[2], "sleightofhand")
end

function mtw.trigger_1331(matches,multimatches)
mtw.attack_miss(matches[2], "sleightofhand")
end

function mtw.trigger_1332(matches,multimatches)
mtw.attack_defend(matches[2], nil, "lowblow", matches[4])
end

function mtw.trigger_atk_whypersomnia(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_whypersomnia", nil)
end

function mtw.atk_wstupidity(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wstupidity", nil)
end

function mtw.atk_wdizziness(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wdizziness", nil)
end

function mtw.atk_wrecklessness(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wrecklessness", nil)
end

function mtw.atk_wconfusion(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wconfusion", nil)
end

function mtw.atk_wparanoia(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wparanoia", nil)
end

function mtw.atk_wlull(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wlull", nil)
end

function mtw.atk_wpuncture(matches,multimatches)
  mtw.attack_hit(matches[2], "atk_wpuncture", nil)
  cecho("<brown>\nYou: STRIPPED <green>"..matches[6])
end

function mtw.trigger_1333(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "canto")
end

function mtw.trigger_1334(matches,multimatches)
mtw.atk_hit(matches[2], nil, "canto")
end

function mtw.trigger_1335(matches,multimatches)
mtw.atk_miss(matches[2], nil, "canto")
end

function mtw.trigger_1336(matches,multimatches)
mtw.attack_start(matches[2], "canto")
end

function mtw.trigger_1337(matches,multimatches)
mtw.attack_hit(matches[2], "canto")
end

function mtw.trigger_1338(matches,multimatches)
if toggles.bashing then
 trg = target
else
 trg = targ
end
mtw.attack_miss(trg, "canto")
end

function mtw.trigger_1339(matches,multimatches)
mtw.attack_defend(matches[2], nil, "canto", matches[5])
end

function mtw.trigger_1340(matches,multimatches)
mtw.attack_start(matches[2], "requiem")
end

function mtw.trigger_1341(matches,multimatches)
mtw.attack_hit(matches[2], "requiem")
end

function mtw.trigger_1342(matches,multimatches)
mtw.atk_start(matches[2], nil, "stormlance")
end

function mtw.trigger_1343(matches,multimatches)
mtw.atk_hit(matches[2], nil, "stormlance")
end

function mtw.trigger_1344(matches,multimatches)
mtw.atk_defend(matches[2], nil, "stormlance", matches[4])
end

function mtw.trigger_1345(matches,multimatches)
mtw.atk_miss(matches[2], nil, "stormlance")
end

function mtw.trigger_1346(matches,multimatches)
mtw.attack_start(matches[2], "stormlance")
end

function mtw.trigger_1347(matches,multimatches)
mtw.attack_hit(matches[2], "stormlance")
resetStopWatch(mtw.last_lance)
startStopWatch(mtw.last_lance)
end

function mtw.trigger_1348(matches,multimatches)
mtw.attack_defend(matches[2], nil, "stormlance", matches[4])
end

function mtw.trigger_1349(matches,multimatches)
mtw.attack_miss(matches[2], "stormlance")
end

function mtw.trigger_1350(matches,multimatches)
mtw.third_start(matches[2], nil, "stormlance", matches[4])
end

function mtw.trigger_1351(matches,multimatches)
mtw.third_miss(matches[2], nil, "stormlance", matches[4])
end

function mtw.trigger_1352(matches,multimatches)
mtw.third_hit(matches[2], nil, "stormlance", matches[4])
end

function mtw.trigger_1353(matches,multimatches)
mtw.third_defend(matches[2], nil, "stormlance", matches[6], matches[4])
end

function mtw.trigger_1354(matches,multimatches)
mtw.atk_start(matches[2], nil, "chill")
end

function mtw.trigger_1355(matches,multimatches)
mtw.atk_hit(matches[2], nil, "chill")
end

function mtw.trigger_1356(matches,multimatches)
mtw.atk_miss(matches[2], nil, "chill")
end

function mtw.trigger_1357(matches,multimatches)
mtw.atk_defend(matches[2], nil, "chill", matches[3])
end

function mtw.trigger_1358(matches,multimatches)
mtw.attack_start(matches[2], "chill")
end

function mtw.trigger_1359(matches,multimatches)
mtw.attack_hit(matches[2], "chill")
end

function mtw.trigger_1360(matches,multimatches)
mtw.attack_defend(matches[2], nil, "chill", matches[4])
end

function mtw.trigger_1361(matches,multimatches)
mtw.attack_miss(matches[2], "chill")
end

function mtw.trigger_1362(matches,multimatches)
mtw.atk_start(matches[2], nil, "ignite")
end

function mtw.trigger_1363(matches,multimatches)
mtw.atk_hit(matches[2], nil, "ignite")
end

function mtw.trigger_1364(matches,multimatches)
mtw.atk_defend(matches[2], nil, "ignite", matches[3])
end

function mtw.trigger_1365(matches,multimatches)
mtw.atk_miss(matches[2], nil, "ignite")
end

function mtw.trigger_1366(matches,multimatches)
mtw.attack_start(matches[2], "ignite")
end

function mtw.trigger_1367(matches,multimatches)
mtw.attack_hit(matches[2], "ignite")
end

function mtw.trigger_1368(matches,multimatches)
mtw.attack_miss(matches[2], "ignite")
end

function mtw.trigger_1369(matches,multimatches)
mtw.attack_defend(matches[2], nil, "ignite", matches[4])
end

function mtw.trigger_1370(matches,multimatches)
mtw.third_start(matches[2], nil, "ignite", matches[4])
end

function mtw.trigger_1371(matches,multimatches)
mtw.third_defend(matches[2], nil, "ignite", matches[5], matches[3])
end

function mtw.trigger_1372(matches,multimatches)
mtw.third_hit(matches[2], nil, "ignite", matches[3])
end

function mtw.trigger_1373(matches,multimatches)
mtw.third_miss(matches[2], nil, "ignite", matches[3])
end

function mtw.trigger_1374(matches,multimatches)
mtw.atk_start(matches[2], nil, "earthbind")
end

function mtw.trigger_1375(matches,multimatches)
mtw.atk_hit(matches[2], nil, "earthbind")
end

function mtw.trigger_1376(matches,multimatches)
mtw.atk_defend(matches[2], nil, "earthbind", matches[3])
end

function mtw.trigger_1377(matches,multimatches)
mtw.atk_miss(matches[2], nil, "earthbind")
end

function mtw.trigger_1378(matches,multimatches)
mtw.attack_start(matches[2], "earthbind")
end

function mtw.trigger_1379(matches,multimatches)
mtw.attack_hit(matches[2], "earthbind")
end

function mtw.trigger_1380(matches,multimatches)
mtw.attack_miss(matches[2], "earthbind")
end

function mtw.trigger_1381(matches,multimatches)
mtw.attack_defend(matches[2], nil, "earthbind", matches[3])
end

function mtw.trigger_1382(matches,multimatches)
mtw.atk_start(matches[2], nil, "icespikes")
end

function mtw.trigger_1383(matches,multimatches)
mtw.atk_hit(matches[2], nil, "icespikes")
end

function mtw.trigger_1384(matches,multimatches)
mtw.atk_defend(matches[2], nil, "icespikes", matches[4])
end

function mtw.trigger_1385(matches,multimatches)
mtw.atk_miss(matches[2], nil, "icespikes")
end

function mtw.trigger_1386(matches,multimatches)
if (mtw.toggles.bashing or mtw.toggles.fasthunt) then
  mtw.attack_start(mtw.bashing.target, "icespikes")
else
  mtw.attack_start(mtw.target, "icespikes")
 end
end

function mtw.trigger_1387(matches,multimatches)
mtw.attack_hit(matches[3], "icespikes")
if matches[2] == "melting" then
 echo(" MELTING!")
end
end

function mtw.trigger_1388(matches,multimatches)
mtw.attack_defend(matches[3], nil, "icespikes", matches[4])
end

function mtw.trigger_1389(matches,multimatches)
mtw.attack_miss(matches[3], "icespikes")
end

function mtw.trigger_1390(matches,multimatches)
mtw.third_start(matches[2], nil, "icespikes", matches[3])
end

function mtw.trigger_1391(matches,multimatches)
mtw.third_hit(matches[2], nil, "icespikes", matches[4])
end

function mtw.trigger_1392(matches,multimatches)
mtw.third_defend(matches[2], nil, "icespikes", matches[5], matches[4])
end

function mtw.trigger_1393(matches,multimatches)
mtw.third_miss(matches[2], nil, "icespikes", matches[4])
end

function mtw.trigger_1394(matches,multimatches)
mtw.atk_start(matches[2], nil, "earthquake")
end

function mtw.trigger_1395(matches,multimatches)
mtw.atk_hit(matches[2], nil, "earthquake")
end

function mtw.trigger_1396(matches,multimatches)
mtw.atk_hit("Someone", nil, "earthquake")
end

function mtw.trigger_1397(matches,multimatches)
mtw.attack_start("room", "earthquake")
end

function mtw.trigger_1398(matches,multimatches)
mtw.attack_hit("room", "earthquake")
end

function mtw.trigger_1399(matches,multimatches)
mtw.atk_start(matches[2], nil, "static_discharge")
end

function mtw.trigger_1400(matches,multimatches)
mtw.atk_hit(matches[2], nil, "static_discharge")
end

function mtw.trigger_1401(matches,multimatches)
mtw.atk_defend(matches[2], nil, "static_discharge", matches[3])
end

function mtw.trigger_1402(matches,multimatches)
mtw.atk_miss(matches[2], nil, "static_discharge")
end

function mtw.trigger_1403(matches,multimatches)
mtw.attack_start(matches[2], "static_discharge")
end

function mtw.trigger_1404(matches,multimatches)
mtw.attack_hit(matches[2], "static_discharge")
end

function mtw.trigger_1405(matches,multimatches)
mtw.attack_defend(matches[2], nil, "static_discharge", matches[3])
end

function mtw.trigger_1406(matches,multimatches)
mtw.attack_miss(matches[2], "static_discharge")
end

function mtw.trigger_1407(matches,multimatches)
mtw.atk_start(matches[2], nil, "gale")
end

function mtw.trigger_1408(matches,multimatches)
mtw.atk_hit(matches[2], nil, "gale")
end

function mtw.trigger_1409(matches,multimatches)
mtw.atk_defend(matches[2], nil, "gale", matches[3])
end

function mtw.trigger_1410(matches,multimatches)
mtw.atk_miss(matches[2], nil, "gale")
end

function mtw.trigger_1411(matches,multimatches)
mtw.attack_start(matches[2], "gale")
end

function mtw.trigger_1412(matches,multimatches)
mtw.attack_hit(matches[2], "gale")
end

function mtw.trigger_1413(matches,multimatches)
mtw.attack_defend(matches[2], nil, "gale", matches[4])
end

function mtw.trigger_1414(matches,multimatches)
mtw.attack_miss(matches[2], "gale")
end

function mtw.trigger_1415(matches,multimatches)
mtw.atk_start(matches[2], nil, "skylash")
end

function mtw.trigger_1416(matches,multimatches)
mtw.atk_hit(matches[2], nil, "skylash")
end

function mtw.trigger_1417(matches,multimatches)
mtw.atk_miss(matches[2], nil, "skylash")
end

function mtw.trigger_1418(matches,multimatches)
mtw.atk_defend(matches[2], nil, "skylash", matches[5])
end

function mtw.trigger_1419(matches,multimatches)
mtw.attack_start(matches[2], "skylash")
end

function mtw.trigger_1420(matches,multimatches)
mtw.attack_hit(matches[2], "skylash")
end

function mtw.trigger_1421(matches,multimatches)
mtw.attack_defend(matches[2], nil, "skylash", matches[4])
end

function mtw.trigger_1422(matches,multimatches)
mtw.attack_miss(matches[2], "skylash")
end

function mtw.trigger_1423(matches,multimatches)
mtw.attack_start("room", "pyroclasm")
end

function mtw.trigger_1424(matches,multimatches)
mtw.attack_hit(matches[2], "pyroclasm")
end

function mtw.trigger_1425(matches,multimatches)
mtw.attack_start("room", "keltonsknives")
end

function mtw.trigger_1426(matches,multimatches)
mtw.attack_hit("room", "keltonsknives")
end

function mtw.trigger_1427(matches,multimatches)
mtw.atk_start(matches[2], nil, "shatter")
end

function mtw.trigger_1428(matches,multimatches)
mtw.atk_hit(matches[3], nil, "shatter")
end

function mtw.trigger_1429(matches,multimatches)
mtw.atk_hit(matches[3], nil, "shatter")
end

function mtw.trigger_1430(matches,multimatches)
mtw.atk_defend(matches[3], nil, "shatter", matches[4])
end

function mtw.trigger_1431(matches,multimatches)
mtw.atk_miss(matches[3], nil, "shatter")
end

function mtw.trigger_1432(matches,multimatches)
mtw.attack_start(matches[2], "shatter")
end

function mtw.trigger_1433(matches,multimatches)
mtw.attack_hit(matches[2], "shatter")
cecho("<brown>\nHit "..matches[3].." <green>"..string.upper(matches[5]).."<brown>!")
end

function mtw.trigger_1434(matches,multimatches)
mtw.attack_hit(matches[2], "shatter")
cecho("\n<green>Hit "..matches[5].." "..matches[6].."!")
end

function mtw.trigger_1435(matches,multimatches)
if string.find(matches[3], matches[2]) and not string.find(matches[3], "winces") then
 mtw.attack_defend(matches[2], nil, "shatter", matches[3])
end
end

function mtw.trigger_1436(matches,multimatches)
mtw.attack_miss(matches[2], "shatter")
end

function mtw.trigger_1437(matches,multimatches)
mtw.attack_start(matches[2], "entomb")
end

function mtw.trigger_1438(matches,multimatches)
mtw.attack_hit(matches[2], "entomb")
end

function mtw.trigger_1439(matches,multimatches)
mtw.attack_miss(matches[2], "entomb")
end

function mtw.trigger_1440(matches,multimatches)
mtw.atk_start(matches[2], nil, "immolate")
end

function mtw.trigger_1441(matches,multimatches)
mtw.atk_hit(matches[3], nil, "immolate")
end

function mtw.trigger_1442(matches,multimatches)
if matches[2] == mtw.attacks.atk_immolate.attacker then
 mtw.atk_miss(matches[2], nil, "immolate")
end
end

function mtw.trigger_1443(matches,multimatches)
mtw.atk_defend(matches[3], nil, "immolate", matches[4])
end

function mtw.trigger_1444(matches,multimatches)
mtw.attack_start(matches[2],"immolate")
end

function mtw.trigger_1445(matches,multimatches)
mtw.attack_hit(matches[2],"immolate")
end

function mtw.trigger_1446(matches,multimatches)
--mtw.attack_miss(nil, "immolate")
mtw.attack_miss(mtw.target, "immolate")
end

function mtw.trigger_1447(matches,multimatches)
mtw.attack_defend(matches[2], nil, "immolate", matches[4])
end

function mtw.trigger_1448(matches,multimatches)
mtw.attack_start("room", "flood")
end

function mtw.trigger_1449(matches,multimatches)
mtw.attack_hit("room", "flood")
end

function mtw.trigger_1450(matches,multimatches)
mtw.attack_start("room", "freeze")
end

function mtw.trigger_1451(matches,multimatches)
mtw.attack_hit("room", "freeze")
end

function mtw.trigger_1452(matches,multimatches)
mtw.attack_miss("room", "freeze")
end

function mtw.trigger_1453(matches,multimatches)
mtw.atk_start(matches[2], nil, "sleep")
end

function mtw.trigger_1454(matches,multimatches)
mtw.atk_hit(matches[2], nil, "sleep")
end

function mtw.trigger_1455(matches,multimatches)
mtw.atk_miss(matches[2], nil, "sleep")
end

function mtw.trigger_1456(matches,multimatches)
mtw.atk_miss(matches[2], nil, "sleep")
end

function mtw.trigger_1457(matches,multimatches)
mtw.attack_start(matches[2], "sleep")
end

function mtw.trigger_1458(matches,multimatches)
mtw.attack_hit(matches[2], "sleep")
end

function mtw.trigger_1459(matches,multimatches)
mtw.attack_miss(matches[2], "sleep")
end

function mtw.trigger_1460(matches,multimatches)
mtw.attack_defend(matches[2], nil, "sleep", matches[3])
end

function mtw.trigger_1461(matches,multimatches)
mtw.atk_start(matches[2], nil, "dementia")
end

function mtw.trigger_1462(matches,multimatches)
mtw.atk_hit(matches[2], nil, "dementia")
end

function mtw.trigger_1463(matches,multimatches)
mtw.atk_miss(matches[2], nil, "dementia")
end

function mtw.trigger_1464(matches,multimatches)
mtw.attack_start(matches[2], "dementia")
end

function mtw.trigger_1465(matches,multimatches)
mtw.attack_hit(matches[2], "dementia")
end

function mtw.trigger_1466(matches,multimatches)
mtw.attack_miss(matches[2], "dementia")
end

function mtw.trigger_1467(matches,multimatches)
mtw.attack_defend(matches[2], nil, "dementia", nil)
end

function mtw.trigger_1468(matches,multimatches)
mtw.attack_start(matches[2], "counterspell")
end

function mtw.trigger_1469(matches,multimatches)
mtw.attack_hit(matches[2], "counterspell")
end

function mtw.trigger_1469b(matches,multimatches)
mtw.atk_hit(matches[2], nil, "counterspell")
end

function mtw.trigger_1469c(matches,multimatches)
mtw.atk_start(matches[2], nil, "counterspell")
end

function mtw.trigger_1470(matches,multimatches)
deleteLine()
cecho("\n<red>Nothing to counter! Counterspell failed.\n")
end

function mtw.trigger_1471(matches,multimatches)
mtw.attack_miss(matches[2], "counterspell")
end

function mtw.trigger_1472(matches,multimatches)
--mtw.attack_start("room", "illusion")
end

function mtw.trigger_1473(matches,multimatches)
--mtw.attack_hit("room", "illusion")
end

function mtw.trigger_1474(matches,multimatches)
mtw.atk_start(matches[2], nil, "instability")
end

function mtw.trigger_1475(matches,multimatches)
mtw.atk_hit(matches[2], nil, "instability")
end

function mtw.trigger_1476(matches,multimatches)
mtw.atk_hit(enemy_attacker, nil, "instability")
end

function mtw.trigger_1477(matches,multimatches)
mtw.atk_defend(matches[2], nil, "instability", matches[3])
end

function mtw.trigger_1478(matches,multimatches)
mtw.atk_miss(matches[2], nil, "instability")
end

function mtw.trigger_1479(matches,multimatches)
mtw.attack_start(matches[2], "instability")
end

function mtw.trigger_1480(matches,multimatches)
mtw.attack_miss(matches[2], "instability")
end

function mtw.trigger_1481(matches,multimatches)
mtw.attack_hit(matches[2], "instability")
end

function mtw.trigger_1482(matches,multimatches)
mtw.attack_miss(mtw.target, "instability")
end

function mtw.trigger_1483(matches,multimatches)
mtw.atk_start(matches[2], nil, "cripple")
end

function mtw.trigger_1484(matches,multimatches)
mtw.atk_hit(matches[2], nil, "cripple")
end

function mtw.trigger_1485(matches,multimatches)
mtw.atk_defend(matches[2], nil, "cripple", matches[3])
end

function mtw.trigger_1486(matches,multimatches)
mtw.atk_miss(matches[2], nil, "cripple")
end

function mtw.trigger_1487(matches,multimatches)
mtw.attack_start(matches[2], "cripple")
end

function mtw.trigger_1488(matches,multimatches)
mtw.attack_hit(matches[2], "cripple")
end

function mtw.trigger_1489(matches,multimatches)
mtw.attack_defend(matches[2], nil, "cripple", matches[3])
end

function mtw.trigger_1490(matches,multimatches)
mtw.attack_miss(mtw.target, "cripple")
end

function mtw.trigger_1491(matches,multimatches)
if mtw.toggles.defecho then
 deleteLine()
 cecho("<purple>\n"..matches[2].." <red>HIT<purple> barrage you!")
end
end

function mtw.trigger_1492(matches,multimatches)
mtw.attack_hit(matches[2], "barrage")
end

function mtw.trigger_1493(matches,multimatches)
mtw.attack_miss(matches[2], "barrage")
end

function mtw.trigger_1494(matches,multimatches)
mtw.atk_start(matches[2], nil, "disorient")
end

function mtw.trigger_1495(matches,multimatches)
mtw.atk_hit(enemy_attacker, nil, "disorient")
end

function mtw.trigger_1496(matches,multimatches)
--mtw.atk_defend(matches[2], matches[3], "disorient", matches[4])
end

function mtw.trigger_1497(matches,multimatches)
mtw.atk_miss(matches[2], nil, "disorient")
end

function mtw.trigger_1498(matches,multimatches)
mtw.attack_start(matches[2], "disorient")
end

function mtw.trigger_1499(matches,multimatches)
mtw.attack_hit(matches[3], "disorient")
end

function mtw.trigger_1500(matches,multimatches)
mtw.attack_miss(matches[2], "disorient")
end

function mtw.trigger_1501(matches,multimatches)
mtw.attack_miss(mtw.target, "disorient")
end

function mtw.trigger_1502(matches,multimatches)
mtw.atk_start(matches[2], nil, "timeshift")
end

function mtw.trigger_1503(matches,multimatches)
mtw.atk_hit(matches[3], nil, "timeshift")
end

function mtw.trigger_1504(matches,multimatches)
mtw.atk_defend(matches[3], nil, "timeshift", matches[4])
end

function mtw.trigger_1505(matches,multimatches)
mtw.atk_miss(matches[2], nil, "timeshift")
end

function mtw.trigger_1506(matches,multimatches)
mtw.attack_start(matches[2], "timeshift")
end

function mtw.trigger_1507(matches,multimatches)
mtw.attack_hit(matches[2], "timeshift")
end

function mtw.trigger_1508(matches,multimatches)
mtw.attack_defend(matches[2], nil, "timeshift", matches[4])
end

function mtw.trigger_1509(matches,multimatches)
mtw.attack_miss(mtw.target, "timeshift")
end

function mtw.trigger_1510(matches,multimatches)
mtw.atk_start(matches[2], nil, "compulsion")
end

function mtw.trigger_1511(matches,multimatches)
mtw.atk_hit(matches[2], nil, "compulsion")
end

function mtw.trigger_1512(matches,multimatches)
mtw.atk_defend(matches[2], nil, "compulsion", matches[4])
end

function mtw.trigger_1513(matches,multimatches)
mtw.attack_start(matches[2], "compulsion")
end

function mtw.trigger_1514(matches,multimatches)
mtw.attack_hit(matches[2], "compulsion")
end

function mtw.trigger_1515(matches,multimatches)
mtw.attack_defend(matches[2], nil, "compulsion", matches[3])
end

function mtw.trigger_1516(matches,multimatches)
mtw.attack_miss(mtw.target, "compulsion")
end

function mtw.trigger_1517(matches,multimatches)
mtw.anachronized[matches[2]] = matches[2]
tempTimer(20, string.format([[mtw.anachronized["%s"] = nil]], matches[2]))
end

function mtw.trigger_1518(matches,multimatches)
mtw.anachronized[matches[2]] = nil
end

function mtw.trigger_1519(matches,multimatches)
if mtw.my.class == "magician" and string.find(mtw.target, matches[2]) then
 mtw.set_balance("cast counterspell "..mtw.target)
end
if string.find(mtw.target, matches[2]) and mtw.my.class == "rogue" and mtw.toggles.flourishing then
 mtw.set_balance("flourish "..matches[2])
end
end

function mtw.trigger_1520(matches,multimatches)
mtw.attack_start("room", "timequake")
end

function mtw.trigger_1521(matches,multimatches)
mtw.attack_hit("room", "timequake")
end

function mtw.trigger_1522(matches,multimatches)
mtw.atk_start(matches[2], nil, "astral_tether")
end

function mtw.trigger_1523(matches,multimatches)
mtw.atk_hit(matches[2], nil, "astral_tether")
end

function mtw.trigger_1524(matches,multimatches)
mtw.atk_defend(matches[2], nil, "astral_tether", matches[3])
end

function mtw.trigger_1525(matches,multimatches)
mtw.atk_miss(matches[2], nil, "astral_tether")
end

function mtw.trigger_1526(matches,multimatches)
mtw.attack_start(matches[2], "astral_tether")
end

function mtw.trigger_1527(matches,multimatches)
mtw.attack_hit(matches[2], "astral_tether")
end

function mtw.trigger_1528(matches,multimatches)
mtw.attack_defend(mtw.target, nil, "astral_tether", matches[2])
end

function mtw.trigger_1529(matches,multimatches)
mtw.attack_miss(mtw.target, "astral_tether")
end

function mtw.trigger_1530(matches,multimatches)
mtw.atk_start(matches[2], nil, "astral_warp")
end

function mtw.trigger_1531(matches,multimatches)
mtw.atk_hit(matches[2], nil, "astral_warp")
end

function mtw.trigger_1532(matches,multimatches)
mtw.atk_defend(matches[2], nil, "astral_warp", matches[3])
end

function mtw.trigger_1533(matches,multimatches)
mtw.atk_miss(matches[2], nil, "astral_warp")
end

function mtw.trigger_1534(matches,multimatches)
mtw.attack_start(matches[2], "astral_warp")
end

function mtw.trigger_1535(matches,multimatches)
mtw.attack_hit(matches[2], "astral_warp")
end

function mtw.trigger_1536(matches,multimatches)
mtw.attack_defend(matches[2], nil, "astral_warp", matches[5])
end

function mtw.trigger_1537(matches,multimatches)
mtw.attack_miss(matches[2], "astral_warp")
end

function mtw.trigger_1538(matches,multimatches)
mtw.attack_miss(mtw.target, "undoing")
end

function mtw.trigger_1539(matches,multimatches)
mtw.attack_hit(matches[2], "undoing")
end

function mtw.trigger_1540(matches,multimatches)
mtw.attack_start(matches[2], "undoing")
end

function mtw.trigger_1541(matches,multimatches)
mtw.attack_start("room", "timewarp")
end

function mtw.trigger_1542(matches,multimatches)
mtw.attack_start(matches[2], "balefire")
end

function mtw.trigger_1543(matches,multimatches)
mtw.attack_hit(matches[2], "balefire")
end

function mtw.trigger_1544(matches,multimatches)
mtw.attack_defend(matches[2], nil, "balefire", matches[4])
end

function mtw.trigger_1545(matches,multimatches)
mtw.attack_miss(matches[2], "balefire")
end

function mtw.trigger_1546(matches,multimatches)
mtw.atk_start(matches[2], nil, "balefire")
end

function mtw.trigger_1547(matches,multimatches)
mtw.atk_hit(matches[2], nil, "balefire")
end

function mtw.trigger_1548(matches,multimatches)
mtw.atk_miss(matches[2], nil, "balefire")
end

function mtw.trigger_1549(matches,multimatches)
mtw.atk_defend(matches[2], nil, "balefire", matches[4])
end

function mtw.trigger_1550(matches,multimatches)
mtw.atk_start(matches[2], nil, "seduce")
end

function mtw.trigger_1551(matches,multimatches)
mtw.atk_hit(matches[2], nil, "seduce")
end

function mtw.trigger_seduce_inc_dfnd(matches,multimatches)
mtw.atk_defend(matches[2], nil, "seduce", matches[3])
end

function mtw.trigger_1552(matches,multimatches)
mtw.attack_start(matches[2], "seduce")
end

function mtw.trigger_1553(matches,multimatches)
mtw.attack_hit(matches[2], "seduce")
end

function mtw.trigger_1554(matches,multimatches)
mtw.attack_defend(matches[2], nil, "seduce", matches[5])
end

function mtw.trigger_1555(matches,multimatches)
mtw.atk_start(matches[2], nil, "curse_of_tongues")
end

function mtw.trigger_1556(matches,multimatches)
mtw.atk_hit(matches[2], nil, "curse_of_tongues")
end

function mtw.trigger_1557(matches,multimatches)
mtw.attack_start(matches[2], "curse_of_tongues")
end

function mtw.trigger_1558(matches,multimatches)
mtw.attack_hit(matches[2], "curse_of_tongues")
end

function mtw.trigger_1559(matches,multimatches)
mtw.attack_defend(matches[2], nil, "curse_of_tongues", matches[3])
end

function mtw.trigger_1560(matches,multimatches)
mtw.atk_start(matches[2], nil, "scabies")
end

function mtw.trigger_1561(matches,multimatches)
mtw.atk_hit(enemy_attacker, nil, "scabies")
end

function mtw.trigger_1562(matches,multimatches)
mtw.attack_start(matches[2], "scabies")
end

function mtw.trigger_1563(matches,multimatches)
mtw.attack_hit(matches[3], "scabies")
end

function mtw.trigger_1564(matches,multimatches)
attack_defend(matches[3], nil, "scabies", matches[7])
end

function mtw.trigger_1565(matches,multimatches)
mtw.atk_start(matches[2], nil, "nightmare")
end

function mtw.trigger_1566(matches,multimatches)
mtw.atk_hit(matches[2], nil, "nightmare")
end

function mtw.trigger_1567(matches,multimatches)
mtw.attack_start(matches[2], "nightmare")
end

function mtw.trigger_1568(matches,multimatches)
mtw.attack_hit(matches[2], "nightmare")
end

function mtw.trigger_1569(matches,multimatches)
attack_defend(matches[2], nil, "nightmare", matches[4])
end

function mtw.trigger_1570(matches,multimatches)
mtw.atk_start(matches[2], nil, "necrotic_plague")
end

function mtw.trigger_1571(matches,multimatches)
mtw.atk_hit(enemy_attacker, nil, "necrotic_plague")
end

function mtw.trigger_1572(matches,multimatches)
mtw.attack_start(matches[2], "necrotic_plague")
end

function mtw.trigger_1573(matches,multimatches)
mtw.attack_hit(matches[3], "necrotic_plague")
end

function mtw.trigger_1574(matches,multimatches)
attack_defend(matches[3], nil, "necrotic_plague", matches[7])
end

function mtw.trigger_1575(matches,multimatches)
mtw.atk_start(matches[2], nil, "torture")
end

function mtw.trigger_1576(matches,multimatches)
mtw.atk_hit(mtw.attacks.atk_torture.attacker, nil, "torture")
mtw.aff_have("blackout")
end

function mtw.trigger_1577(matches,multimatches)
mtw.atk_miss(mtw.attacks.atk_torture.attacker, nil, "torture")
end

function mtw.trigger_1578(matches,multimatches)
mtw.atk_defend(mtw.attacks.atk_torture.attacker, nil, "torture", matches[3])
end

function mtw.trigger_1579(matches,multimatches)
mtw.attack_start(matches[2], "torture")
end

function mtw.trigger_1580(matches,multimatches)
mtw.attack_hit(matches[3], "torture")
end

function mtw.trigger_1581(matches,multimatches)
mtw.atk_start(matches[2], nil, "howl_of_terror")
end

function mtw.trigger_1582(matches,multimatches)
mtw.atk_hit(enemy_attacker, nil, "howl_of_terror")
end

function mtw.trigger_1583(matches,multimatches)
mtw.attack_start(mtw.target, "howl_of_terror")
end

function mtw.trigger_1584(matches,multimatches)
mtw.attack_hit(matches[2], "bwreckless")
end

function mtw.trigger_1585(matches,multimatches)
mtw.attack_hit(matches[2], "bwdystonia")
end

function mtw.trigger_1586(matches,multimatches)
mtw.attack_hit(matches[2], "bwasthma")
end

function mtw.trigger_1587(matches,multimatches)
mtw.attack_hit(matches[2], "bqamnesia")
end

function mtw.trigger_1588(matches,multimatches)
mtw.attack_hit(matches[2], "bwfirebolt")
end

function mtw.trigger_1589(matches,multimatches)
mtw.attack_hit(matches[2], "bwsensitivity")
end

function mtw.trigger_1590(matches,multimatches)
mtw.attack_hit(matches[2], "bwcataplexy")
end

function mtw.trigger_1591(matches,multimatches)
mtw.attack_hit(matches[2], "bwanemia")
end

function mtw.trigger_1592(matches,multimatches)
mtw.attack_hit(matches[2], "bwimpatience")
end

function mtw.trigger_1593(matches,multimatches)
mtw.attack_hit(matches[2], "bwheadache")
end

function mtw.trigger_1594(matches,multimatches)
mtw.attack_hit(matches[2], "bwdreams")
end

function mtw.trigger_1595(matches,multimatches)
mtw.attack_hit(matches[2], "bwconfusion")
end

function mtw.trigger_1596(matches,multimatches)
mtw.attack_hit(matches[2], "bwataxia")
end

function mtw.trigger_1597(matches,multimatches)
mtw.attack_hit(matches[2], "bwmaladroitness")
end

function mtw.trigger_1598(matches,multimatches)
mtw.attack_hit(matches[2], "bwsleep")
end

function mtw.trigger_1599(matches,multimatches)
mtw.attack_hit(matches[2], "bwclaw")
end

function mtw.trigger_1600(matches,multimatches)
mtw.attack_hit(matches[2], "bqfireball")
end

function mtw.trigger_1601(matches,multimatches)
mtw.attack_hit(matches[2], "bwignite")
end

function mtw.trigger_1602(matches,multimatches)
mtw.attack_hit(matches[2], "bwconcussion")
end

function mtw.trigger_1603(matches,multimatches)
mtw.attack_hit(matches[2], "bwepilepsy")
end

function mtw.trigger_1604(matches,multimatches)
mtw.aff_have("neural_charges")
end

function mtw.trigger_1605(matches,multimatches)
mtw.aff_have("confusion")
end

function mtw.trigger_1606(matches,multimatches)
mtw.aff_have("paralysis")
end

function mtw.trigger_1607(matches,multimatches)
mtw.aff_have("sensitivity")
end

function mtw.trigger_1608(matches,multimatches)
mtw.aff_have("deaf")
end

function mtw.trigger_1609(matches,multimatches)
mtw.aff_have("stupidity")
end

function mtw.trigger_1610(matches,multimatches)
mtw.aff_have("malaise")
end

function mtw.trigger_1611(matches,multimatches)
mtw.aff_have("anorexia")
end

function mtw.trigger_1612(matches,multimatches)
mtw.aff_have("dystonia")
end

function mtw.trigger_1613(matches,multimatches)
mtw.aff_have("epilepsy")
end

function mtw.trigger_1614(matches,multimatches)
mtw.aff_have("blind")
end

function mtw.trigger_1615(matches,multimatches)
mtw.aff_have("clumsiness")
end

function mtw.trigger_1616(matches,multimatches)
mtw.aff_have("asthma")
end

function mtw.trigger_1617(matches,multimatches)
mtw.aff_have("dizziness_1")
end

function mtw.trigger_1618(matches,multimatches)
mtw.aff_have("fear")
end

function mtw.trigger_1619(matches,multimatches)
mtw.aff_have("terror")
end

function mtw.trigger_1620(matches,multimatches)
mtw.aff_have("dizziness_1")
mtw.aff_have("horror")
end

function mtw.trigger_1621(matches,multimatches)
mtw.aff_have("agoraphobia")
end

function mtw.trigger_2034(matches,multimatches)
mtw.aff_have("claustrophobia")
end

function mtw.trigger_1622(matches,multimatches)
mtw.aff_have("dizziness_1")
mtw.aff_have("confusion")
end

function mtw.trigger_1623(matches,multimatches)
mtw.aff_have("headache")
end

function mtw.trigger_1624(matches,multimatches)
mtw.aff_have("heart_palpitations")
end

function mtw.trigger_1625(matches,multimatches)
mtw.aff_have("neural_charges")
end

function mtw.trigger_1626(matches,multimatches)
mtw.aff_have("ataxia")
end

function mtw.trigger_1627(matches,multimatches)
mtw.aff_have("paranoia")
end

function mtw.trigger_1628(matches,multimatches)
mtw.aff_have("feedback")

end

function mtw.trigger_1629(matches,multimatches)
mtw.aff_have("dementia_1")
end

function mtw.trigger_1630(matches,multimatches)
mtw.aff_have("depression")
end

function mtw.trigger_1631(matches,multimatches)
mtw.aff_have("dystonia")
mtw.aff_have("maldroitness")
end

function mtw.trigger_1632(matches,multimatches)
mtw.aff_have("hypochondria")
end

function mtw.trigger_1633(matches,multimatches)
mtw.aff_have("impatience")
--aff_have("impatience")
end

function mtw.trigger_1634(matches,multimatches)
mtw.aff_have("aphasia")
end

function mtw.trigger_1635(matches,multimatches)
mtw.atk_start(matches[2], nil, "fury")
end

function mtw.trigger_1636(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "fury")
end

function mtw.trigger_1637(matches,multimatches)
mtw.atk_defend(matches[2], nil, "fury", matches[5])
end

function mtw.trigger_1638(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "fury")
end

function mtw.trigger_1639(matches,multimatches)
mtw.attack_defend(matches[3], nil, "fury", matches[4])
end

function mtw.trigger_1640(matches,multimatches)
mtw.attack_hit(matches[3], "fury")
end

function mtw.trigger_1641(matches,multimatches)
mtw.attack_start(matches[2], "fury")
end

function mtw.trigger_1642(matches,multimatches)
mtw.attack_miss(matches[3], "fury")
end

function mtw.trigger_1643(matches,multimatches)
mtw.third_start(matches[2], matches[5], "fury", matches[4])
end

function mtw.trigger_1644(matches,multimatches)
mtw.third_hit(matches[2], matches[3], "fury", matches[4])
end

function mtw.trigger_1645(matches,multimatches)
mtw.atk_start(matches[3], matches[2], "heretic")
end

function mtw.trigger_1646(matches,multimatches)
mtw.atk_hit(matches[2], nil, "heretic")
end

function mtw.trigger_1647(matches,multimatches)
mtw.atk_miss(matches[2], nil, "heretic")
end

function mtw.trigger_1648(matches,multimatches)
mtw.atk_defend(matches[2], nil, "heretic", matches[4])
end

function mtw.trigger_1649(matches,multimatches)
mtw.attack_defend(matches[2], nil, "heretic", matches[5])
end

function mtw.trigger_1650(matches,multimatches)
mtw.attack_hit(matches[2], "heretic")
end

function mtw.trigger_1651(matches,multimatches)
mtw.attack_start(matches[3], "heretic")
end

function mtw.trigger_1652(matches,multimatches)
mtw.attack_miss(matches[2], "heretic")
end

function mtw.trigger_1653(matches,multimatches)
mtw.atk_start(matches[2], nil, "mandate")
end

function mtw.trigger_1654(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "mandate")
end

function mtw.trigger_1655(matches,multimatches)
mtw.atk_defend(matches[2], nil, "mandate", matches[5])
end

function mtw.trigger_1656(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "mandate")
end

function mtw.trigger_1657(matches,multimatches)
mtw.attack_defend(matches[3], nil, "mandate", matches[4])
end

function mtw.trigger_1658(matches,multimatches)
mtw.attack_start(matches[3], "mandate")
end

function mtw.trigger_1659(matches,multimatches)
mtw.attack_hit(matches[3], "mandate")
end

function mtw.trigger_1660(matches,multimatches)
mtw.attack_miss(matches[3], "mandate")
end

function mtw.trigger_1661(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "kneel")
end

function mtw.trigger_1662(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "kneel")
end

function mtw.trigger_1663(matches,multimatches)
mtw.atk_defend(matches[2], nil, "kneel", matches[5])
end

function mtw.trigger_1664(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "kneel")
end

function mtw.trigger_1665(matches,multimatches)
mtw.attack_defend(matches[3], nil, "kneel", matches[6])
end

function mtw.trigger_1666(matches,multimatches)
mtw.attack_hit(matches[3], "kneel")
if mtw.my.name == "Kor" and mtw.not_aff("timewarp") and mtw.not_aff("divine_censure") then
 mtw.send("smite "..matches[3].." with verdict")
end
end

function mtw.trigger_1667(matches,multimatches)
mtw.attack_start(matches[3], "kneel")
end

function mtw.trigger_1668(matches,multimatches)
mtw.attack_miss(matches[3], "kneel")
end

function mtw.trigger_1669(matches,multimatches)
mtw.atk_start(matches[2], nil, "atonement")
end

function mtw.trigger_1670(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "atonement")
end

function mtw.trigger_1671(matches,multimatches)
mtw.atk_defend(matches[2], nil, "atonement", matches[5])
end

function mtw.trigger_1672(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "atonement")
end

function mtw.trigger_1673(matches,multimatches)
mtw.attack_defend(matches[3], nil, "atonement", matches[5])
end

function mtw.trigger_1674(matches,multimatches)
mtw.attack_miss(matches[3], "atonement")
end

function mtw.trigger_1675(matches,multimatches)
mtw.attack_hit(matches[3], "atonement")
end

function mtw.trigger_1676(matches,multimatches)
mtw.attack_start(matches[2], "atonement")
end

function mtw.trigger_1677(matches,multimatches)
mtw.atk_start(matches[2], nil, "spirit_wrack")
end

function mtw.trigger_1678(matches,multimatches)
mtw.atk_hit(matches[2], nil, "spirit_wrack")
--queue_diag()
end

function mtw.trigger_1679(matches,multimatches)
mtw.atk_defend(matches[2], nil, "spirit_wrack", matches[5])
end

function mtw.trigger_1680(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "spirit_wrack")
end

function mtw.trigger_1681(matches,multimatches)
mtw.attack_hit(matches[2], "spirit_wrack")
end

function mtw.trigger_1682(matches,multimatches)
mtw.attack_defend(matches[2], nil, "spirit_wrack", matches[4])
end

function mtw.trigger_1683(matches,multimatches)
mtw.attack_miss(matches[3], "spirit_wrack")
end

function mtw.trigger_1684(matches,multimatches)
mtw.attack_start(matches[2], "spirit_wrack")
end

function mtw.trigger_1685(matches,multimatches)
mtw.atk_start(matches[2], nil, "holy_fire")
end

function mtw.trigger_1686(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "holy_fire")
end

function mtw.trigger_1687(matches,multimatches)
mtw.atk_defend(matches[2], nil, "holy_fire", matches[4])
end

function mtw.trigger_1688(matches,multimatches)
mtw.atk_miss(matches[2], matches[3], "holy_fire")
end

function mtw.trigger_1689(matches,multimatches)
mtw.attack_defend(matches[2], nil, "holy_fire", matches[4])
end

function mtw.trigger_1690(matches,multimatches)
mtw.attack_hit(matches[2], "holy_fire")
end

function mtw.trigger_1691(matches,multimatches)
mtw.attack_start(matches[4], "holy_fire")
end

function mtw.trigger_1692(matches,multimatches)
mtw.attack_miss(matches[3], "holy_fire")
end

function mtw.trigger_1693(matches,multimatches)
mtw.third_start(matches[3], matches[5], "holy_fire", matches[2])
end

function mtw.trigger_1694(matches,multimatches)
mtw.third_hit(matches[2], matches[3], "holy_fire", matches[4])
end

function mtw.trigger_1695(matches,multimatches)
mtw.atk_start(matches[4], matches[3], "wrathful_thunder")
end

function mtw.trigger_1696(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "wrathful_thunder")
mtw.aff_have("balance_loss")
end

function mtw.trigger_1697(matches,multimatches)
mtw.atk_defend(matches[2], nil, "wrathful_thunder", matches[4])
mtw.aff_have("balance_loss")
end

function mtw.trigger_1698(matches,multimatches)
mtw.attack_start(matches[3], "wrathful_thunder")
end

function mtw.trigger_1699(matches,multimatches)
mtw.attack_hit(matches[3], "wrathful_thunder")
end

function mtw.trigger_1700(matches,multimatches)
mtw.attack_defend(matches[3], nil, "wrathful_thunder", matches[4])
end

function mtw.trigger_1701(matches,multimatches)
mtw.attack_miss(matches[3], "wrathful_thunder")
end

function mtw.trigger_1702(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "avenging_flame")
end

function mtw.trigger_1703(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "avenging_flame")

end

function mtw.trigger_1704(matches,multimatches)
mtw.atk_defend(matches[2], nil, "avenging_flame", matches[4])
end

function mtw.trigger_1705(matches,multimatches)
mtw.attack_hit(matches[3], "avenging_flame")


end

function mtw.trigger_1706(matches,multimatches)
mtw.attack_defend(matches[3], nil, "avenging_flame", matches[5])
end

function mtw.trigger_1707(matches,multimatches)
mtw.attack_miss(matches[3], "avenging_flame")
end

function mtw.trigger_1708(matches,multimatches)
mtw.attack_start(matches[3], "avenging_flame")
end

function mtw.trigger_1709(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "divine_command")
end

function mtw.trigger_1710(matches,multimatches)
mtw.atk_hit(matches[2], nil, "divine_command")
mtw.reject.priest = matches[2]
end

function mtw.trigger_1711(matches,multimatches)
mtw.attack_start(matches[3], "divine_command")
end

function mtw.trigger_1712(matches,multimatches)
mtw.attack_hit(matches[3], "divine_command")
end

function mtw.trigger_1713(matches,multimatches)
mtw.atk_start(matches[2], nil, "retribution")
end

function mtw.trigger_1714(matches,multimatches)
mtw.atk_hit(matches[2], nil, "retribution")
end

function mtw.trigger_1715(matches,multimatches)
mtw.atk_defend(matches[2], nil, "retribution", matches[5])
end

function mtw.trigger_1716(matches,multimatches)
mtw.attack_defend(matches[2], nil, "retribution", matches[4])
end

function mtw.trigger_1717(matches,multimatches)
mtw.attack_miss(matches[3], "retribution")
end

function mtw.trigger_1718(matches,multimatches)
mtw.attack_hit(matches[2], "retribution")
end

function mtw.trigger_1719(matches,multimatches)
mtw.attack_start(matches[2], "retribution")
end

function mtw.trigger_1720(matches,multimatches)
mtw.atk_start(matches[2], matches[4], "sword_spirit")
end

function mtw.trigger_1721(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "sword_spirit")
end

function mtw.trigger_1722(matches,multimatches)
mtw.atk_defend(matches[2], matches[3], "sword_spirit", matches[4])
end

function mtw.trigger_1723(matches,multimatches)
mtw.attack_start(matches[2], "sword_spirit")
end

function mtw.trigger_1724(matches,multimatches)
mtw.attack_defend(matches[3], nil, "sword_spirit", matches[4])
end

function mtw.trigger_1725(matches,multimatches)
mtw.attack_hit(matches[3], "sword_spirit")
end

function mtw.trigger_1726(matches,multimatches)
mtw.attack_miss(matches[3], "sword_spirit")
end

function mtw.trigger_1727(matches,multimatches)
mtw.atk_start(matches[4], matches[2], "righteous_lance")
end

function mtw.trigger_1728(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "righteous_lance")
end

function mtw.trigger_1729(matches,multimatches)
mtw.atk_defend(matches[2], nil, "righteous_lance", matches[4])
end

function mtw.trigger_1730(matches,multimatches)
mtw.attack_start(matches[3], "righteous_lance")
end

function mtw.trigger_1731(matches,multimatches)
mtw.attack_hit(matches[3], "righteous_lance")
cecho("<brown>\nHit "..matches[3]..matches[4].." <green>"..string.upper(matches[5]).."<brown>!")
end

function mtw.trigger_1732(matches,multimatches)
mtw.attack_miss(matches[3], "righteous_lance")
end

function mtw.trigger_1733(matches,multimatches)
mtw.attack_defend(matches[3], nil, "righteous_lance", matches[4])
end

function mtw.trigger_1734(matches,multimatches)
mtw.atk_start(matches[2], nil, "searing_arc")
end

function mtw.trigger_1735(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "searing_arc")
end

function mtw.trigger_1736(matches,multimatches)
mtw.atk_defend(matches[2], nil, "searing_arc", matches[4])
end

function mtw.trigger_1737(matches,multimatches)
mtw.attack_start(matches[2], "searing_arc")
end

function mtw.trigger_1738(matches,multimatches)
mtw.attack_hit(matches[3], "searing_arc")
end

function mtw.trigger_1739(matches,multimatches)
mtw.attack_defend(matches[3], nil, "searing_arc", matches[5])
end

function mtw.trigger_1740(matches,multimatches)
mtw.attack_miss(matches[3], "searing_arc")
end

function mtw.trigger_1741(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "holy_sword")
end

function mtw.trigger_1742(matches,multimatches)
mtw.atk_hit(matches[3], matches[2], "holy_sword")
end

function mtw.trigger_1743(matches,multimatches)
mtw.atk_defend(matches[3], matches[2], "holy_sword", matches[4])
end

function mtw.trigger_1744(matches,multimatches)
mtw.atk_miss(matches[3], matches[2], "holy_sword")
end

function mtw.trigger_1745(matches,multimatches)
mtw.attack_defend(matches[3], nil, "holy_sword", matches[4])
end

function mtw.trigger_1746(matches,multimatches)
mtw.attack_start(matches[3], "holy_sword")
end

function mtw.trigger_1747(matches,multimatches)
mtw.attack_miss(matches[3], "holy_sword")
end

function mtw.trigger_1748(matches,multimatches)
mtw.attack_hit(matches[3], "holy_sword")
end

function mtw.trigger_1749(matches,multimatches)
mtw.third_start(matches[2], matches[3], "holy_sword", matches[4])
end

function mtw.trigger_1750(matches,multimatches)
mtw.third_hit(matches[3], matches[2], "holy_sword", matches[4])
end

function mtw.trigger_1751(matches,multimatches)
mtw.atk_start(matches[2], nil, "ill_omen")
end

function mtw.trigger_1752(matches,multimatches)
mtw.atk_hit(matches[2], nil, "ill_omen")

end

function mtw.trigger_1753(matches,multimatches)
mtw.atk_defend(matches[2], nil, "ill_omen", matches[3])
end

function mtw.trigger_1754(matches,multimatches)
mtw.atk_miss(matches[2], nil, "ill_omen")
end

function mtw.trigger_1755(matches,multimatches)
mtw.attack_start(matches[2], "ill_omen")
end

function mtw.trigger_1756(matches,multimatches)
mtw.attack_hit(matches[2], "ill_omen")
end

function mtw.trigger_1757(matches,multimatches)
mtw.attack_defend(matches[2], nil, "ill_omen", matches[3])
end

function mtw.trigger_1758(matches,multimatches)
mtw.attack_miss(matches[2], "ill_omen")
end

function mtw.trigger_1759(matches,multimatches)
mtw.atk_start(matches[2], nil, "divine_censure")
end

function mtw.trigger_1760(matches,multimatches)
mtw.atk_hit(matches[2], nil, "divine_censure")
end

function mtw.trigger_1761(matches,multimatches)
mtw.atk_defend(matches[2], nil, "divine_censure", matches[4])
end

function mtw.trigger_1762(matches,multimatches)
mtw.attack_start(matches[3], "divine_censure")
end

function mtw.trigger_1763(matches,multimatches)
mtw.attack_hit(matches[3], "divine_censure")
end

function mtw.trigger_1764(matches,multimatches)
mtw.attack_defend(matches[3], nil, "divine_censure", matches[4])
end

function mtw.trigger_1765(matches,multimatches)
mtw.attack_miss(matches[3], "divine_censure")
end

function mtw.trigger_1766(matches,multimatches)
mtw.atk_miss(matches[2], nil, "divine_censure")

--^(\w+) hurls (.*) at you, but the prayer goes unanswered and the weapon flies back to (his|her) hand\.$
end

function mtw.trigger_1767(matches,multimatches)
mtw.atk_start(matches[2], nil, "repentance")
end

function mtw.trigger_1768(matches,multimatches)
mtw.atk_hit(matches[2], nil, "repentance")
end

function mtw.trigger_1769(matches,multimatches)
mtw.atk_defend(matches[2], nil, "repentance", matches[5])
end

function mtw.trigger_1770(matches,multimatches)
mtw.attack_start(matches[2], "repentance")
end

function mtw.trigger_1771(matches,multimatches)
mtw.attack_defend(matches[3], nil, "repentance", matches[6])
end

function mtw.trigger_1772(matches,multimatches)
mtw.attack_hit(matches[3], "repentance")
end

function mtw.trigger_1773(matches,multimatches)
mtw.attack_miss(matches[3], "repentance")
end

function mtw.trigger_1774(matches,multimatches)
mtw.attack_start(matches[3], "damnation")
end

function mtw.trigger_1775(matches,multimatches)
mtw.attack_hit(matches[2], "damnation")
end

function mtw.trigger_1776(matches,multimatches)
mtw.attack_miss(matches[2], "damnation")
end

function mtw.trigger_1777(matches,multimatches)
mtw.attack_start(matches[2], "judgment")
end

function mtw.trigger_1778(matches,multimatches)
mtw.attack_hit(matches[3], "judgment")
end

function mtw.trigger_1779(matches,multimatches)
mtw.attack_miss(matches[3], "judgment")
end

function mtw.trigger_1780(matches,multimatches)
mtw.atk_hit(matches[2], matches[3], "verdict")
end

function mtw.trigger_1781(matches,multimatches)
mtw.attack_hit(matches[2], "verdict")
end

function mtw.trigger_1782(matches,multimatches)
deleteLine()
cecho("\n<green>*************VERDICT**************")
end

function mtw.trigger_1783(matches,multimatches)
mtw.attack_start("self", "martyr")
end

function mtw.trigger_1784(matches,multimatches)
mtw.attack_hit("self", "martyr")
if mtw.my.class == "priest" then
 mtw.toggles.healing = true
 mtw.toggles.defending = true
end
end

function mtw.trigger_1785(matches,multimatches)
if mtw.toggles.cdecho then 
 deleteLine()
 cecho("\n<green>=====<cyan>!!!MARTYR<red>!!! STOPPED !!!<green>=====\n")
end
if mtw.my.class == "priest" then
 mtw.toggles.healing = true
 mtw.toggles.defending = true
end
end

function mtw.trigger_1786(matches,multimatches)
mtw.atk_start(matches[2], nil, "terror")
end

function mtw.trigger_1787(matches,multimatches)
mtw.atk_hit(matches[2], nil, "terror")
end

function mtw.trigger_1788(matches,multimatches)
mtw.atk_defend(matches[2], nil, "terror", matches[3])
--Not in 9.3
end

function mtw.trigger_1789(matches,multimatches)
mtw.atk_start(matches[2], nil, "soulspear")
end

function mtw.trigger_1790(matches,multimatches)
mtw.atk_hit(matches[2], nil, "soulspear")

--Not in Matawa 9.3
-- You twirl to the side, partially dodging Zur's attack.
--^(\w+) forms an ethereal soulspear of dripping violet matter, launching it to lance into you. You clutch your chest and stagger as the death energies pound your too-frail body.$
end

function mtw.trigger_1791(matches,multimatches)
mtw.atk_defend(matches[2], nil, "soulspear", matches[3])

--mtw.atk_defend("Someone", nil, "soulspear", matches[4])
--^You clutch your chest and stagger as the death energies pound your too-frail body. (.*)
--Not in 9.3
end

function mtw.trigger_1792(matches,multimatches)
mtw.atk_start(matches[2], nil, "burden_soul")
end

function mtw.trigger_1793(matches,multimatches)
mtw.atk_hit(matches[2], nil, "burden_soul")
end

function mtw.trigger_1794(matches,multimatches)
mtw.atk_defend(matches[2], nil, "burden_soul", matches[3])
--not in 9.3
end

function mtw.trigger_1795(matches,multimatches)
mtw.atk_start(matches[2], nil, "withering_touch")
end

function mtw.trigger_1796(matches,multimatches)
mtw.atk_hit(matches[2], nil, "withering_touch")

end

function mtw.trigger_1797(matches,multimatches)
mtw.atk_defend(matches[2], nil, "withering_touch", matches[4])
--not in 9.3
end

function mtw.trigger_1798(matches,multimatches)
mtw.atk_start(matches[2], nil, "exorcism")
end

function mtw.trigger_1799(matches,multimatches)
mtw.atk_hit(matches[2], nil, "exorcism")
end

function mtw.trigger_1800(matches,multimatches)
mtw.atk_start(matches[2], nil, "gravechill")
end

function mtw.trigger_1801(matches,multimatches)
mtw.atk_hit(matches[2], nil, "gravechill")
end

function mtw.trigger_1802(matches,multimatches)
mtw.atk_defend(matches[2], nil, "gravechill", matches[3])
end

function mtw.trigger_1803(matches,multimatches)
mtw.atk_miss(matches[2], nil, "gravechill")
--not in 9.3
end

function mtw.trigger_1804(matches,multimatches)
mtw.atk_start(matches[2], nil, "icy_grasp")
--not in 9.3
end

function mtw.trigger_1805(matches,multimatches)
mtw.atk_hit(matches[2], nil, "icy_grasp")
stun = true
end

function mtw.trigger_1806(matches,multimatches)
mtw.atk_defend(matches[2], nil, "icy_grasp", matches[3])
--not in 9.3
end

function mtw.trigger_1807(matches,multimatches)
mtw.atk_start(matches[2], nil, "despair")
end

function mtw.trigger_1808(matches,multimatches)
mtw.atk_hit(matches[2], nil, "despair")

end

function mtw.trigger_1809(matches,multimatches)
mtw.atk_defend(matches[2], nil, "despair", matches[4])

end

function mtw.trigger_1810(matches,multimatches)
mtw.atk_start(matches[2], nil, "funeral_mass")
end

function mtw.trigger_1811(matches,multimatches)
mtw.atk_hit(matches[2], nil, "funeral_mass")
end

function mtw.trigger_1812(matches,multimatches)
mtw.atk_start(matches[2], nil, "vision_of_death")
end

function mtw.trigger_1813(matches,multimatches)
mtw.atk_hit(matches[2], nil, "vision_of_death")
--queue_diag()
end

function mtw.trigger_1814(matches,multimatches)
mtw.atk_defend(matches[2], nil, "vision_of_death", matches[4])
end

function mtw.trigger_1815(matches,multimatches)
mtw.atk_start(matches[2], nil, "doom")
end

function mtw.trigger_1816(matches,multimatches)
mtw.atk_hit(matches[2], nil, "doom")
end

function mtw.trigger_1817(matches,multimatches)
mtw.atk_start(matches[2], nil, "entropy")
--not in 9.3
end

function mtw.trigger_1818(matches,multimatches)
mtw.atk_hit(matches[2], nil, "entropy")
--Not in 9.3
end

function mtw.trigger_1819(matches,multimatches)
mtw.atk_defend(matches[2], nil, "entropy", matches[3])
end

function mtw.trigger_1820(matches,multimatches)
mtw.atk_miss(matches[2], nil, "entropy")
--not in 9.3
end

function mtw.trigger_1821(matches,multimatches)
mtw.atk_start(matches[2], nil, "pimmolate")
end

function mtw.trigger_1822(matches,multimatches)
mtw.atk_hit(matches[2], nil, "pimmolate")
end

function mtw.trigger_1823(matches,multimatches)
mtw.atk_defend(matches[2], nil, "pimmolate", matches[4])
end

function mtw.trigger_1824(matches,multimatches)
mtw.attack_start(matches[2], "pimmolate")
end

function mtw.trigger_1825(matches,multimatches)
mtw.attack_start(matches[2], "pimmolate")
end

function mtw.trigger_1826(matches,multimatches)
if my.class == "rogue" then
 mtw.atk_start(matches[2], nil, "illuminate")
end
end

function mtw.trigger_1827(matches,multimatches)
if my.class == "rogue" then
 mtw.atk_hit(matches[2], nil, "illuminate")
end
end

function mtw.trigger_1828(matches,multimatches)
mtw.atk_start(matches[2], nil, "bloodboil")
end

function mtw.trigger_1829(matches,multimatches)
mtw.atk_hit(matches[2], nil, "bloodboil")
blood_boiled = true
--queue_diag()
end

function mtw.trigger_1830(matches,multimatches)
mtw.atk_defend(matches[2], nil, "bloodboil", matches[3])
end

function mtw.trigger_1831(matches,multimatches)
mtw.attack_start(matches[3], "bloodboil")
end

function mtw.trigger_1832(matches,multimatches)
mtw.attack_hit(matches[2], "bloodboil")
end

function mtw.trigger_1833(matches,multimatches)
mtw.atk_start(matches[2], nil, "embers")
end

function mtw.trigger_1834(matches,multimatches)
mtw.atk_hit(matches[2], nil, "embers")
--queue_diag()
end

function mtw.trigger_1835(matches,multimatches)
mtw.atk_defend(matches[2], nil, "embers", matches[4])
end

function mtw.trigger_1836(matches,multimatches)
mtw.attack_start(matches[3], "burningembers")
end

function mtw.trigger_1837(matches,multimatches)
mtw.attack_hit(matches[2], "burningembers")
end

function mtw.trigger_1838(matches,multimatches)
mtw.atk_start(matches[2], nil, "melt")
end

function mtw.trigger_1839(matches,multimatches)
mtw.atk_hit(matches[2], nil, "melt")
for i in pairs(defenses) do
 if defenses[i].defense == matches[3] then
  cecho("<brown>\nStripped "..i)
  def_remove(i)
 end
end
end

function mtw.trigger_1840(matches,multimatches)
mtw.atk_defend(matches[2], nil, "melt", matches[3])
end

function mtw.trigger_1841(matches,multimatches)
mtw.attack_start(matches[2], "melt")
end

function mtw.trigger_1842(matches,multimatches)
mtw.attack_start(matches[2], "melt")
--for i in pairs(defenses) do
 if matches[4] ~= nil then
  cecho("<brown>\nStripped "..matches[4])
 end
--end
end

function mtw.trigger_1843(matches,multimatches)
mtw.attack_start(matches[2], "eruption")
end

function mtw.trigger_1844(matches,multimatches)
mtw.attack_start(mtw.target, "eruption")
end

function mtw.trigger_1845(matches,multimatches)
mtw.attack_start(matches[2], "incinerate")
end

function mtw.trigger_1846(matches,multimatches)
mtw.attack_start(matches[2], "incinerate")
end

function mtw.trigger_1847(matches,multimatches)
mtw.queue_diag()
end

function mtw.trigger_1848(matches,multimatches)
mtw.aff_have("concussion")
end

function mtw.trigger_1849(matches,multimatches)
--ashfall = true
end

function mtw.trigger_1850(matches,multimatches)
--ashfall = false
mtw.aff_have("black_lung")
end

function mtw.trigger_1851(matches,multimatches)
mtw.queue_diag()
end

function mtw.trigger_1852(matches,multimatches)
mtw.queue_diag()
end

function mtw.trigger_1853(matches,multimatches)
mtw.atk_start(matches[2], nil, "torturous_whip")
end

function mtw.trigger_1854(matches,multimatches)
mtw.atk_hit(matches[2], nil, "torturous_whip")
end

function mtw.trigger_1855(matches,multimatches)
mtw.atk_defend(matches[2], nil, "torturous_whip", matches[3])
end

function mtw.trigger_1856(matches,multimatches)
mtw.atk_miss(matches[2],nil, "torturous_whip")
end

function mtw.trigger_1857(matches,multimatches)
mtw.attack_start(matches[2], "torturous_whip")
end

function mtw.trigger_1858(matches,multimatches)
mtw.attack_hit(matches[2], "torturous_whip")
end

function mtw.trigger_1859(matches,multimatches)
mtw.attack_defend(matches[2], nil, "torturous_whip", matches[4])
end

function mtw.trigger_1860(matches,multimatches)
mtw.attack_miss(matches[2], "torturous_whip")
end

function mtw.trigger_1861(matches,multimatches)
mtw.third_hit(matches[2], nil, "torturous_whip", matches[3])
end

function mtw.trigger_1862(matches,multimatches)
mtw.atk_start(matches[2], nil, "grotesque_visage")
end

function mtw.trigger_1863(matches,multimatches)
mtw.atk_hit(matches[2], nil, "grotesque_visage")
--aff_have("paralyzed")
end

function mtw.trigger_1864(matches,multimatches)
mtw.atk_defend(matches[2], nil, "grotesque_visage", matches[6])
end

function mtw.trigger_1865(matches,multimatches)
mtw.atk_miss(matches[2], nil, "grotesque_visage")
end

function mtw.trigger_1866(matches,multimatches)
mtw.attack_start(matches[2], "grotesque_visage")
end

function mtw.trigger_1867(matches,multimatches)
mtw.attack_hit(matches[2], "grotesque_visage")
end

function mtw.trigger_1868(matches,multimatches)
mtw.attack_defend(matches[3], nil, "grotesque_visage", matches[4])
end

function mtw.trigger_1869(matches,multimatches)
mtw.attack_miss(matches[3], "grotesque_visage")
end

function mtw.trigger_1870(matches,multimatches)
mtw.atk_start(matches[2], nil, "deceit")
end

function mtw.trigger_1871(matches,multimatches)
mtw.atk_hit(matches[2], nil, "deceit")
mtw.reject.lust = matches[2]
end

function mtw.trigger_1872(matches,multimatches)
mtw.atk_defend(matches[2], nil, "deceit", "You twirl to the side, partially dodging (.*) attack.")
end

function mtw.trigger_1873(matches,multimatches)
mtw.atk_miss(matches[2], nil, "deceit")
end

function mtw.trigger_1874(matches,multimatches)
mtw.attack_start(matches[2], "deceit")
end

function mtw.trigger_1875(matches,multimatches)
mtw.attack_hit(matches[2], "deceit")
end

function mtw.trigger_1876(matches,multimatches)
mtw.attack_defend(matches[2], nil, "deceit", nil)
end

function mtw.trigger_1877(matches,multimatches)
mtw.attack_miss(matches[2], "deceit")
end

function mtw.trigger_1878(matches,multimatches)
mtw.atk_start(matches[2], nil, "scarab_curse")
end

function mtw.trigger_1879(matches,multimatches)
mtw.atk_hit(matches[2], nil, "scarab_curse")
mtw.aff_have("hemophilia")
mtw.aff_have("scabies")
end

function mtw.trigger_1880(matches,multimatches)
mtw.atk_defend(matches[2], nil, "scarab_curse", matches[3])
end

function mtw.trigger_1881(matches,multimatches)
mtw.atk_miss(matches[2], nil, "scarab_curse")
end

function mtw.trigger_1882(matches,multimatches)
mtw.attack_start(matches[2], "scarab_curse")
end

function mtw.trigger_1883(matches,multimatches)
mtw.attack_hit(matches[2], "scarab_curse")
end

function mtw.trigger_1884(matches,multimatches)
mtw.attack_defend(matches[2], nil, "scarab_curse", matches[3])
end

function mtw.trigger_1885(matches,multimatches)
mtw.attack_miss(matches[2], "scarab_curse")
end

function mtw.trigger_1886(matches,multimatches)
mtw.atk_start(matches[2], nil, "horrify")
end

function mtw.trigger_1887(matches,multimatches)
mtw.atk_hit(matches[2], nil, "horrify")
end

function mtw.trigger_1888(matches,multimatches)
mtw.atk_defend(matches[2], nil, "horrify", matches[3])
end

function mtw.trigger_1889(matches,multimatches)
mtw.atk_miss(matches[2], nil, "horrify")
end

function mtw.trigger_1890(matches,multimatches)
mtw.atk_start(matches[2], nil, "shadow_theft")
end

function mtw.trigger_1891(matches,multimatches)
mtw.atk_hit(matches[3], nil, "shadow_theft")
mtw.aff_remove("commanded")
end

function mtw.trigger_1892(matches,multimatches)
mtw.atk_miss(matches[3], nil, "shadow_theft")
end

function mtw.trigger_1893(matches,multimatches)
mtw.attack_start(matches[2], "shadow_theft")
end

function mtw.trigger_1894(matches,multimatches)
mtw.attack_hit(matches[2], "shadow_theft")
end

function mtw.trigger_1895(matches,multimatches)
mtw.attack_miss(matches[2], "shadow_theft")
end

function mtw.trigger_1896(matches,multimatches)
mtw.atk_hit(string.upper(matches[2]), nil, "shadowlance")
mtw.aff_have("concussion")
end

function mtw.trigger_1897(matches,multimatches)
mtw.atk_miss(string.upper(matches[2]), nil, "shadowlance")
end

function mtw.trigger_1898(matches,multimatches)
mtw.attack_start(mtw.target, "shadowlance")
end

function mtw.trigger_1899(matches,multimatches)
mtw.attack_hit(string.upper(matches[2]), "shadowlance")
end

function mtw.trigger_1900(matches,multimatches)
mtw.atk_start(matches[2], nil, "oubliette")
end

function mtw.trigger_1901(matches,multimatches)
mtw.atk_miss(matches[2], nil, "oubliette")
end

function mtw.trigger_1902(matches,multimatches)
mtw.atk_hit(matches[2], nil, "oubliette")
end

function mtw.trigger_1903(matches,multimatches)
mtw.atk_defend(matches[2], nil, "oubliette", matches[4])
end

function mtw.trigger_1904(matches,multimatches)
mtw.attack_start(matches[2], "oubliette")
end

function mtw.trigger_1905(matches,multimatches)
mtw.attack_hit(matches[2], "oubliette")
end

function mtw.trigger_1906(matches,multimatches)
mtw.attack_defend(matches[2], nil, "oubliette", matches[4])
end

function mtw.trigger_1907(matches,multimatches)
mtw.attack_miss(matches[2], "shadow_theft")
end

function mtw.trigger_1908(matches,multimatches)
mtw.atk_start(matches[2], nil, "savage")
end

function mtw.trigger_1909(matches,multimatches)
mtw.atk_hit(matches[2], nil, "savage")
end

function mtw.trigger_1910(matches,multimatches)
mtw.atk_defend(matches[2], nil, "savage", matches[4])
end

function mtw.trigger_1911(matches,multimatches)
mtw.attack_start(matches[2], "savage", matches[3])
end

function mtw.trigger_1912(matches,multimatches)
mtw.attack_miss(matches[3], "savage")
end

function mtw.trigger_1913(matches,multimatches)
mtw.attack_defend(matches[2], matches[3], "savage", matches[4])
end

function mtw.trigger_1914(matches,multimatches)
mtw.attack_hit(matches[2], "savage")
end

function mtw.trigger_1915(matches,multimatches)
mtw.atk_start(matches[2], nil, "phlegm")
end

function mtw.trigger_1916(matches,multimatches)
mtw.atk_hit(matches[2], nil, "phlegm")
end

function mtw.trigger_1917(matches,multimatches)
mtw.atk_defend(matches[2], nil, "phlegm", matches[3])
end

function mtw.trigger_1918(matches,multimatches)
mtw.attack_start(matches[2], "phlegm", matches[3])
end

function mtw.trigger_1919(matches,multimatches)
mtw.attack_defend(matches[2], nil, "phlegm", matches[3])
end

function mtw.trigger_1920(matches,multimatches)
mtw.attack_hit(matches[2], "phlegm")
end

function mtw.trigger_1921(matches,multimatches)
mtw.atk_start(matches[2], nil, "mutilate")
end

function mtw.trigger_1922(matches,multimatches)
mtw.atk_hit(matches[2], nil, "mutilate")

end

function mtw.trigger_1923(matches,multimatches)
mtw.atk_defend(matches[2], nil, "mutilate", matches[4])
end

function mtw.trigger_1924(matches,multimatches)
mtw.attack_start(matches[2], "mutilate")
end

function mtw.trigger_1925(matches,multimatches)
mtw.attack_defend(matches[2], nil, "mutilate", matches[3])
end

function mtw.trigger_1926(matches,multimatches)
mtw.attack_miss(matches[3], "mutilate")
end

function mtw.trigger_1927(matches,multimatches)
mtw.attack_hit(matches[2], "mutilate")
end

function mtw.trigger_1928(matches,multimatches)
mtw.atk_start(matches[2], nil, "heart_thrum")
end

function mtw.trigger_1929(matches,multimatches)
mtw.atk_hit(matches[2], nil, "heart_thrum")
end

function mtw.trigger_1930(matches,multimatches)
mtw.atk_defend(matches[2], nil, "heart_thrum", matches[3])
end

function mtw.trigger_1931(matches,multimatches)
mtw.attack_start(matches[2], "savage", matches[3])
end

function mtw.trigger_1932(matches,multimatches)
mtw.attack_defend(matches[2], nil, "heart_thrum", matches[3])
end

function mtw.trigger_1933(matches,multimatches)
mtw.attack_hit(matches[2], "heart_thrum")
end

function mtw.trigger_1934(matches,multimatches)
mtw.atk_start(matches[3], nil, "lunar_bay")
end

function mtw.trigger_1935(matches,multimatches)
mtw.atk_hit(matches[2], nil, "lunar_bay")
end

function mtw.trigger_1936(matches,multimatches)
mtw.atk_defend(matches[2], nil, "lunar_bay", matches[5])
end

function mtw.trigger_1937(matches,multimatches)
mtw.atk_start(matches[2], nil, "gluttonous_lust")
end

function mtw.trigger_1938(matches,multimatches)
mtw.atk_hit(matches[2], nil, "gluttonous_lust")
end

function mtw.trigger_1939(matches,multimatches)
mtw.atk_defend(matches[2], nil, "gluttonous_lust", matches[3])
end

function mtw.trigger_1940(matches,multimatches)
mtw.atk_start(matches[2], nil, "sanguis")
end

function mtw.trigger_1941(matches,multimatches)
mtw.atk_hit(matches[2], nil, "sanguis")
end

function mtw.trigger_1942(matches,multimatches)
mtw.atk_defend(matches[2], nil, "sanguis", matches[3])
end

function mtw.trigger_1943(matches,multimatches)
mtw.atk_start(matches[2], nil, "feral_rake")
end

function mtw.trigger_1944(matches,multimatches)
mtw.atk_hit(matches[2], nil, "feral_rake")
end

function mtw.trigger_1945(matches,multimatches)
mtw.atk_defend(matches[2], nil, "feral_rake", matches[4])
end

function mtw.trigger_1946(matches,multimatches)
mtw.atk_start(matches[2], nil, "rending_strike")
end

function mtw.trigger_1947(matches,multimatches)
mtw.atk_hit(matches[2], nil, "rending_strike")
end

function mtw.trigger_1948(matches,multimatches)
mtw.atk_defend(matches[2], nil, "rending_strike", matches[3])
end

function mtw.trigger_1949(matches,multimatches)
mtw.atk_start(matches[2], nil, "yellow_bile")
end

function mtw.trigger_1950(matches,multimatches)
mtw.atk_hit(matches[2], nil, "yellow_bile")
end

function mtw.trigger_1951(matches,multimatches)
mtw.atk_defend(matches[2], nil, "yellow_bile", matches[3])
end

function mtw.trigger_1952(matches,multimatches)
mtw.atk_start(matches[3], nil, "knife_of_woe")
end

function mtw.trigger_1953(matches,multimatches)
mtw.atk_hit(matches[2], nil, "knife_of_woe")
end

function mtw.trigger_1954(matches,multimatches)
mtw.atk_defend(matches[2], nil, "knife_of_woe", matches[4])
end

function mtw.trigger_1955(matches,multimatches)
mtw.atk_start(matches[2], nil, "carnal_scream")
end

function mtw.trigger_1956(matches,multimatches)
mtw.atk_hit(matches[2], nil, "carnal_scream")
end

function mtw.trigger_1957(matches,multimatches)
mtw.atk_defend(matches[2], nil, "carnal_scream", matches[4])
end

function mtw.trigger_1958(matches,multimatches)
mtw.atk_start(matches[2], nil, "scarlet_horror")
end

function mtw.trigger_1959(matches,multimatches)
mtw.atk_hit(matches[2], nil, "scarlet_horror")
end

function mtw.trigger_1960(matches,multimatches)
mtw.atk_defend(matches[2], nil, "scarlet_horror", matches[4])
end

function mtw.trigger_1961(matches,multimatches)
mtw.atk_start(matches[2], nil, "black_bile")
end

function mtw.trigger_1962(matches,multimatches)
mtw.atk_hit(matches[2], nil, "black_bile")
end

function mtw.trigger_1963(matches,multimatches)
mtw.atk_defend(matches[2], nil, "black_bile", matches[3])
end

function mtw.trigger_1964(matches,multimatches)
mtw.atk_start(matches[2], nil, "betrayal_of_blood")
end

function mtw.trigger_1965(matches,multimatches)
mtw.atk_hit(matches[2], nil, "betrayal_of_blood")
end

function mtw.trigger_1966(matches,multimatches)
mtw.atk_defend(matches[2], nil, "betrayal_of_blood", matches[3])
end

function mtw.trigger_1967(matches,multimatches)
cecho("<red>-----INCOMING SANGUISHIFT-----")
end

function mtw.trigger_1968(matches,multimatches)
if mtw.vitals.adrenaline >= 50 then
	local n = 1
	while n < 10 do
		send("clot",false)
		n = n + 1
	end
end
end

function mtw.trigger_1969(matches,multimatches)
mtw.atk_start(matches[2], nil, "bold_smite")
end

function mtw.trigger_1970(matches,multimatches)
mtw.atk_hit(matches[2], nil, "bold_smite")
end

function mtw.trigger_1971(matches,multimatches)
mtw.atk_defend(matches[2], nil, "bold_smite", matches[4])
end

function mtw.trigger_1972(matches,multimatches)
mtw.attack_start(matches[3], "bold_smite")
end

function mtw.trigger_1973(matches,multimatches)
mtw.attack_miss(matches[3], "bold_smite")
end

function mtw.trigger_1974(matches,multimatches)
mtw.attack_hit(matches[2], "bold_smite")
end

function mtw.trigger_1975(matches,multimatches)
mtw.attack_defend(matches[2], nil, "bold_smite", matches[4])
end

function mtw.trigger_1976(matches,multimatches)
mtw.attack_hit(matches[3], "faithburn")
end

function mtw.trigger_1977(matches,multimatches)
mtw.atk_start(matches[2], nil, "crushing_smite")
end

function mtw.trigger_1978(matches,multimatches)
mtw.atk_hit(matches[2], nil, "crushing_smite")
end

function mtw.trigger_1979(matches,multimatches)
mtw.atk_defend(matches[2], nil, "crushing_smite", matches[4])
end

function mtw.trigger_1980(matches,multimatches)
mtw.attack_start(matches[3], "crushing_smite")
end

function mtw.trigger_1981(matches,multimatches)
mtw.attack_defend(matches[2], nil, "crushing_smite", matches[4])
end

function mtw.trigger_1982(matches,multimatches)
mtw.attack_hit(matches[2], "crushing_smite")
end

function mtw.trigger_1983(matches,multimatches)
mtw.attack_miss(matches[3], "crushing_smite")
end

function mtw.trigger_1984(matches,multimatches)
mtw.attack_hit(matches[3], "dominating_strike")
end

function mtw.trigger_1985(matches,multimatches)
mtw.atk_start(matches[2], matches[3], "virtuous_smite")
end

function mtw.trigger_1986(matches,multimatches)
mtw.atk_hit(matches[2], nil, "virtuous_smite")
end

function mtw.trigger_1987(matches,multimatches)
mtw.atk_defend(matches[2], nil, "virtuous_smite", matches[4])
end

function mtw.trigger_1988(matches,multimatches)
mtw.attack_start(matches[3], "virtuous_smite")
end

function mtw.trigger_1989(matches,multimatches)
mtw.attack_hit(matches[2], "virtuous_smite")
end

function mtw.trigger_1990(matches,multimatches)
mtw.attack_defend(matches[2], nil, "virtuous_smite", matches[4])
end

function mtw.trigger_1991(matches,multimatches)
mtw.attack_miss(matches[3], "virtuous_smite")
end

function mtw.trigger_1992(matches,multimatches)
mtw.attack_hit(matches[2], "coward")
end

function mtw.trigger_1993(matches,multimatches)
mtw.attack_start(matches[2], "revelation")
end

function mtw.trigger_1994(matches,multimatches)
mtw.attack_hit(matches[2], "revelation")
end

function mtw.trigger_1995(matches,multimatches)
mtw.atk_start(matches[2], nil, "trip")
end

function mtw.trigger_1996(matches,multimatches)
mtw.atk_hit(matches[2], nil, "trip")
end

function mtw.trigger_1997(matches,multimatches)
mtw.atk_defend(matches[2], nil, "trip", matches[3])
end

function mtw.trigger_1998(matches,multimatches)
mtw.attack_start(matches[2], "trip")
end

function mtw.trigger_1999(matches,multimatches)
mtw.attack_hit(matches[2], "trip")
end

function mtw.trigger_2000(matches,multimatches)
mtw.attack_defend(matches[2], nil, "trip", matches[3])
end

function mtw.trigger_2001(matches,multimatches)
mtw.attack_hit(matches[2], "sever")
end

function mtw.trigger_2002(matches,multimatches)
cecho("\n<red>==========================\n<yellow>"..matches[2].."<red> is DECAPITATING YOU! (1/5)\n<red>================================\n")
end

function mtw.trigger_2003(matches,multimatches)
local num = 4
if matches[4] == "aiming" then
 num = 2
elseif matches[4] == "barreling" then
 num = 3
elseif matches[4] == "drawing" then
 num = 4
end
cecho("\n<red>==========================\n<yellow>"..matches[2].."<red> is DECAPITATING YOU! ("..num.."/5)\n<red>================================\n")
end

function mtw.trigger_2004(matches,multimatches)
mtw.status.defending = true
mtw.current_defense = matches[2]
deleteLine()
cecho("<yellow>\nYou: <green>START<yellow> "..matches[2])
tempTimer(1.5, [[mtw.status.defending = false]])
end

function mtw.trigger_2005(matches,multimatches)
mtw.status.defending = false
mtw.current_defense = "none"
deleteLine()
cecho("<yellow>\nYou: <red>END<yellow> "..matches[2])
--mtw.reset_defend()
end

function mtw.trigger_2006(matches,multimatches)
if mtw.vitals.adrenaline < 10 then
 mtw.atk_kill(matches[2], "terminate")
end
end

function mtw.trigger_2007(matches,multimatches)
if mtw.have_aff("hamstrung") and (mtw.have_aff("severed_nerves_2") or mtw.have_aff("severed_nerves_3") or mtw.have_aff("severed_nerves_4") or mtw.have_aff("severed_nerves_5")) and (mtw.have_aff("bleeding_3") or mtw.have_aff("bleeding_4") or mtw.have_aff("bleeding_5")) then
 mtw.atk_kill(matches[2], "coup de grace")
end
end

function mtw.trigger_2008(matches,multimatches)
if mtw.have_aff("compulsion") and mtw.have_aff("unstable") then
 mtw.atk_kill(matches[2], "undoing")
end
end

function mtw.trigger_2009(matches,multimatches)
if mtw.have_aff("heretic") and mtw.have_aff("atonment") and mtw.have_aff("retribution") then
 mtw.atk_kill(matches[2], "judgment")
end
end

function mtw.trigger_2010(matches,multimatches)
if mtw.have_aff("burns_4") then
 mtw.atk_kill(matches[2], "incinerate")
end
end

function mtw.trigger_2011(matches,multimatches)
for i in pairs(mtw.attacks) do
 mtw.reset_attack(i)
end
end

function mtw.trigger_2012(matches,multimatches)
for i in pairs(mtw.attacks) do
 if mtw.attacks[i]["attacker"] == matches[2] then
  mtw.reset_attack(i)
 end
end
end

function mtw.trigger_2013(matches,multimatches)
for i in pairs(mtw.attacks) do
 mtw.attack_end(i)
end
end

function mtw.trigger_2014(matches,multimatches)
mtw.see_illusion = true
end

function mtw.trigger_2015(matches,multimatches)
mtw.gui.chat_tells(matches)
end

function mtw.trigger_2016(matches,multimatches)
mtw.gui.chat_says(matches)
end

function mtw.trigger_2017(matches,multimatches)
mtw.gui.chat("City")
end

function mtw.trigger_2018(matches,multimatches)
mtw.gui.chat("Guild")
end

function mtw.trigger_2019(matches,multimatches)
mtw.gui.chat("Societies")
end

function mtw.trigger_2020(matches,multimatches)
mtw.gui.chat("OOC")
end

function mtw.trigger_2021(matches,multimatches)
mtw.gui.chat_misc(matches)
end

function mtw.trigger_2022(matches,multimatches)
mtw.gui.chat_deathsense(matches)
end

function mtw.trigger_2023(matches,multimatches)
mtw.gui.chat_shouts(matches)
end

function mtw.trigger_2024(matches,multimatches)
mtw.aff_cure("dystrophy")
end

function mtw.trigger_2025(matches,multimatches)
mtw.learn_next(false)
end

function mtw.trigger_2026(matches,multimatches)
mtw.learn_next(true)
end

function mtw.trigger_2027(matches,multimatches)
mtw.def_def("arrow")
end

function mtw.trigger_2028(matches,multimatches)
mtw.def_gain("arrow")
end

function mtw.trigger_2029(matches,multimatches)
 cecho("\n<red>*************************************")
 cecho("\n<red>********<blue>INCOMING SHADOWSTORM!<red>***********")
 cecho("\n<red>*************************************")
 mtw.atk_start(matches[2], nil, "shadowstorm")
 if string.find(mtw.target, matches[2]) and mtw.my.class == "rogue" and mtw.status.combat and mtw.toggles.flourishing then
  mtw.set_balance("flourish "..matches[2])
 end
end

function mtw.trigger_2030(matches,multimatches)
 mtw.attack_hit(matches[2], "disarm")
 cecho("\n <red>Target lost grip defense!")
end

function mtw.trigger_2036(matches,multimatches)
if mtw.defenses.def_hiding.needit then
 mtw.defenses.def_hiding.needit = false
 echo("\nNo longer keeping hide.")
 send(" ")
end

if mtw.toggles.hiding then
 mtw.toggle("hiding")
 send(" ")
end
end

function mtw.trigger_2037(matches,multimatches)
 mtw.atk_start(matches[2], nil, "revelation")
end

function mtw.trigger_2038(matches,multimatches)
 mtw.atk_hit(matches[2], nil, "revelation")
end

function mtw.trigger_2039(matches,multimatches)
 mtw.atk_defend(matches[2], nil, "revelation")
end

function mtw.trigger_2040(matches,multimatches)
 mtw.def_def("soullink")
end

function mtw.trigger_2041(matches,multimatches)
 local comm = multimatches[2][2]
 if comm == "lazuli" then comm = "lapis" end
 send("vin "..comm)
end