-- MTW: prompt handling

function mtw.prompt_function()

--Set some initial values
 mtw.vitals.xp=gmcp.Char.Status.level
 mtw.xp_percent_index=string.find(mtw.vitals.xp,"%%")
 mtw.xp_space_index=string.find(mtw.vitals.xp," ")
 mtw.vitals.xp=tonumber(string.sub(mtw.vitals.xp,mtw.xp_space_index+2,mtw.xp_percent_index-1))

 if string.find(mtw.my.stats, "A:") then
  mtw.status.combat = true
 else
  mtw.status.combat = false
 end

 if mtw.balance.balance and gmcp.Char.Vitals.bal ~= "1" then mtw.balance_lose("balance") end
 mtw.balance.balance = (gmcp.Char.Vitals.bal == "1" )

 if mtw.balance.equilibrium and gmcp.Char.Vitals.eq ~= "1" then mtw.balance_lose("equilibrium") end
 mtw.balance.equilibrium = ( gmcp.Char.Vitals.eq == "1" )

 if string.find(mtw.my.stats, "@") then
  mtw.def_have("spellshield")
 elseif mtw.defenses.def_spellshield.state ~= "waiting" then
  mtw.def_remove("spellshield")
 end

 if string.find(mtw.my.stats, "p") then
  if mtw.balance.balance then
   mtw.stand_queued = false
  end
  mtw.aff_have("prone")
 else
  mtw.stand_queued = false
  mtw.aff_remove("prone")
 end

 mtw.status.riding = string.find(mtw.my.stats, "r")

 if string.find(mtw.my.stats, "%*%*%*") then
  mtw.vitals.cadence = 3
 elseif string.find(mtw.my.stats, "%*%*") then
  mtw.vitals.cadence = 2
 elseif string.find(mtw.my.stats, "%*") then
  mtw.vitals.cadence = 1
 else
  mtw.vitals.cadence = 0
 end

--Check for important commands without ending lines
 if mtw.sent.assess then
  mtw.enemy_afflictions()
 end
 if mtw.sent.ih then
  if not mtw.bashing.targeted then
   mtw.toggles.bashing = false
   if mtw.toggles.shadowmending and mtw.my.class == "rogue" then
    if mtw.bashing.shadowmend and mtw.have_def("shadowmend") then
     mtw.set_equil("shadowmend")
     mtw.bashing.shadowmend = false
    end
    if mtw.balance.balance and not mtw.waiting.balance and mtw.defenses.def_hiding.state ~= "deffed" and (mtw.vitals.percent.guile <= 80 or mtw.toggles.hiding) then
     mtw.send("hide")
    end
   end
  end
 end

--Reset important commands without ending lines
 for i in pairs(mtw.sent) do
  mtw.sent[i] = false
 end

--Check for possible afflictions
 if mtw.check.bloodboil then
  mtw.aff_have("blackout")
  mtw.check.bloodboil = false
 end
 if mtw.vitals.percent.health == 100 and mtw.vitals.percent.endurance == 100 and mtw.vitals.adrenaline == 100 then
  if mtw.check.reckless then 
   mtw.aff_have("recklessness")
  end
 else
  mtw.aff_remove("recklessness")
 end
 mtw.check.reckless = false

 for i in pairs(mtw.afflictions) do
  if mtw.afflictions[i].state == "possible" then
   if mtw.check.illusion then
    mtw.afflictions[i].state = "healed"
   else
    mtw.afflictions[i].state = "afflicted"
   end
  end
 end
--Display prompt if necessary
 if not mtw.delete_prompt then
  mtw.prompt_display()
 else
  mtw.delete_prompt = false
 end
--Set some dynamic values
 mtw.vitals.old.health = mtw.vitals.current.health
 mtw.vitals.old.endurance = mtw.vitals.current.endurance
 if mtw.my.class == "magician" then
  mtw.vitals.old.magic = mtw.vitals.current.magic
 elseif mtw.my.class == "priest" then
  mtw.vitals.old.faith = mtw.vitals.current.faith
 end

--Run the core functions
 mtw.do_core()

end


function mtw.prompt_display()

 if mtw.current_prompt == mtw.last_prompt then
  return
 end

 if table.contains(mtw.skills, "Desperate Strike") and mtw.vitals.percent.health < 50 and mtw.vitals.adrenaline < 20 and mtw.balance.desperate then
  echo("\n==========STRIKE NOW, DST!!=============")
 end

 echo("\n")

--Display timestamps on the left
 if mtw.toggles.lefttimestamp then
  cecho("<dark_green>"..tostring(getTime(true,"hh:mm:ss:zzz| ")))
 end

--Display vitals (health, endurance, magic, guile, faith, xp)
 if mtw.toggles.percents then
  cecho(mtw.coloring(mtw.vitals.percent.health)..mtw.vitals.percent.health.."%h, ")
 else
  cecho(mtw.coloring(mtw.vitals.percent.health)..mtw.vitals.current.health.."h, ")
 end
 cecho(mtw.coloring(mtw.vitals.percent.endurance)..mtw.vitals.current.endurance.."e, ")
 if mtw.my.class == "magician" then
  if mtw.toggles.percents then
   cecho(mtw.coloring(mtw.vitals.percent.magic)..mtw.vitals.percent.magic.."%m, ")
  else
   cecho(mtw.coloring(mtw.vitals.percent.magic)..mtw.vitals.current.magic.."m, ")
  end
 elseif mtw.my.class == "rogue" then
  cecho(mtw.coloring(mtw.vitals.percent.guile)..mtw.vitals.current.guile.."g, ")
 elseif mtw.my.class == "priest" then
  cecho(mtw.coloring(mtw.vitals.percent.faith)..mtw.vitals.current.faith.."f, ")
 elseif table.contains(mtw.skills, "swordmastery") then
  cecho(mtw.coloring(mtw.vitals.percent.magic)..mtw.vitals.current.magic.."m, ")
 end
 cecho("<dark_green>"..mtw.vitals.xp.."x ")

--Display cadence or stormfury charges
 for i = 1,mtw.vitals.cadence do
  if mtw.my.class == "rogue" then
   cecho("<purple>*")
  elseif mtw.my.class == "magician" then
   cecho("<blue>*")
  end
 end

--Display balances
 if mtw.balance.equilibrium then
  echo("x")
 else
  echo("-")
 end
 if mtw.balance.balance then
  echo("b")
 else
  echo("-")
 end
 if mtw.my.class == "soldier" then
  if table.contains(mtw.skills, "swordmastery") then
   if mtw.balance.offhand then
    echo("2")
   else
    echo("-")
   end
  end
  if table.contains(mtw.skills, "brutality") then
   if mtw.balance.roar then
    echo("r")
   else
    echo("-")
   end
  end
 end
 if mtw.my.class == "rogue" then
  if mtw.have_def("hiding") then
   echo("h")
  else
   echo("-")
  end
 end
 if mtw.my.class == "magician" then
  if mtw.defenses.def_spellshield.state == "deffed" then
   echo("@")
  else
   echo("-")
  end
  if table.contains(mtw.skills, "psionics") then
   if mtw.balance.psi then
    echo("#")
   else
    echo("-")
   end
  end
  if table.contains(mtw.skills, "Anachronize") then
   if mtw.balance.anachronize then
    echo("A")
   elseif mtw.defenses.def_anachronize.state == "deffed" then
    cecho("<cyan>A<white>")
   else
    echo("-")
   end
  end
  if table.contains(mtw.skills, "Eldritch Barrage") then
   if mtw.balance.barrage then
    echo("B")
   else
    echo("-")
   end
  end
 end

--Display other statuses
 if mtw.status.riding then
  echo("m")
 else
  echo("-")
 end
 if mtw.have_aff("prone") then
  echo("p")
 end
 if mtw.have_aff("stun") then
  echo("s")
 end
 if mtw.have_aff("sleep") then
  echo("l")
 end
 if mtw.have_aff("unconscious") then
  echo("u")
 end
 if mtw.not_entangled() then
  else
  echo("w")
 end

--Display blood, if vampire
 if mtw.status.vampire then
  echo(" B:"..mtw.vitals.blood.."%")
 end

--Display adrenaline
 echo(" A:")
 cecho("<red>"..mtw.vitals.adrenaline.."%")

--Display timestamps on the right
 if mtw.toggles.righttimestamp then
  cecho("<dark_green>"..tostring(getTime(true," |hh:mm:ss:zzz| ")))
 end

--Display bashing or combat target
 if mtw.toggles.bashing then
  echo(" - ["..mtw.bashing.target.."]")
 else
  echo(" - ["..mtw.target.."]")
 end
 cecho(mtw.enemy_health)

--Display next poison, if rogue
 if mtw.toggles.poisondisplay and mtw.my.class == "rogue" and mtw.poisons[mtw.my.rogue_weapon] ~= nil then
  cecho("<purple> :<white>"..mtw.poison_affs[mtw.poisons[mtw.my.rogue_weapon][1]].."<purple>:")
 end

--Display vital toggle warnings
 if mtw.channeling() then
  cecho("<cyan>++<grey>CHANNELING<cyan>++")
 end
 if not mtw.toggles.healing then
  cecho("<blue>~-+<grey>HEALING OFF<blue>+-~")
 end
 if not mtw.toggles.standing and mtw.status.combat then
  cecho("<red>+<grey>STANDING OFF<red>+")
 end
 if not mtw.toggles.defending then
  cecho("<green>+<grey>DEFENDING OFF<green>+")
 end
 if not mtw.toggles.focusing then
  cecho("<brown>+<grey>FOCUSING OFF<brown>+")
 end
 if mtw.my.class == "magician" then
  if mtw.defenses.def_spellshield.state ~= "deffed" then
   cecho("<orange>+<grey>SPELLSHIELD DOWN<orange>+")
  elseif not mtw.defenses.def_spellshield.needit then
   cecho("<yellow>+<grey>SPELLSHIELD OFF<yellow>+")
  end
 end

--Display counterattack window
 if mtw.recent_defend then
  cecho("<blue><<white>counter<blue>>")
 end

--Display vote link: USE IT
 if mtw.vote then
  echoLink("-VOTE!-", [[openUrl("http://www.midkemiaonline.com/vote")]], "Click to Vote Now!")
 end

--Display change in vitals
 if mtw.vitals.loss.health > 0 then
  echo(" H:+"..mtw.vitals.loss.health)
 elseif mtw.vitals.loss.health < 0 then
  echo(" H:"..mtw.vitals.loss.health)
 elseif mtw.toggles.fullprompt then
  echo(" H:0")
 end
 if mtw.vitals.loss.endurance > 0 then
  echo(" E:+"..mtw.vitals.loss.endurance)
 elseif mtw.vitals.loss.endurance < 0 then
  echo(" E:"..mtw.vitals.loss.endurance)
 elseif mtw.toggles.fullprompt then
  echo(" E:0")
 end
 if mtw.my.class == "magician" then
  if mtw.vitals.loss.magic > 0 then
   echo(" M:+"..mtw.vitals.loss.magic)
  elseif mtw.vitals.loss.magic < 0 then
   echo(" M:"..mtw.vitals.loss.magic)
  elseif mtw.toggles.fullprompt then
   echo(" M:0")
  end
 end
 if mtw.my.class == "priest" then
  if mtw.vitals.loss.faith > 0 then
   echo(" F:+"..mtw.vitals.loss.faith)
  elseif mtw.vitals.loss.faith < 0 then
   echo(" F:"..mtw.vitals.loss.faith)
  elseif mtw.toggles.fullprompt then
   echo(" F:0")
  end
 end

end

function mtw.call_new_prompt()
 if (not mtw.nonewline) and (not mtw.waitingforprompt) then
  mtw.nonewline = true
  mtw.waitingforprompt = true
  tempTimer(0.05,[[send(" ",false);mtw.nonewline = false]])
 end
end