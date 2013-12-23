-- MTW: vitals aliases

function mtw.help_alias()
 cecho("<green>\nBasic Commands:")
 echo("\n deathbeam: shoots a deathbeam at your current target")
 echo("\n ?help: this, obviously")
 echo("\n ?info: display version info")
 echo("\n ?setup: sends all the CONFIG commands the system needs")
 echo("\n ?toggles: display toggle commands")
 echo("\n ?bashing: display bashing commands")
 echo("\n ?fish: display fishing commands")
 echo("\n ?options: display toggle settings")
 echo("\n rst: reset most variables to default")
 echo("\n t X: set combat target X")
 echo("\n ldd X: load defense option X")
 echo("\n kd X: toggle individual defense X")
 cecho("<green>\nUtility Commands:")
 echo("\n mnt: mount/vault your mount")
 echo("\n dm: dismount")
 echo("\n folm: lead your mount")
 echo("\n lm X: PATH FIND to landmark X")
 echo("\n cfs: credits for sale")
 send(" ")
end

function mtw.options_alias()
 display(mtw.toggles)
 send(" ")
end

function mtw.info_alias()
 cecho("\n<blue>Welcome to Matawa 9.4!")
 cecho("\n<green> Send ?help to get some help.")
 cecho("\n<blue>Forum Thread:")
 cecho("\n http://forums.midkemiaonline.com/discussion/19/free-mudlet-system#latest")
 send(" ")
end

function mtw.toggles_alias()
 cecho("<green>\nBasic Toggles:")
 echo("\n hl: freeze the system")
 echo("\n ss: standing and waking")
 echo("\n dfnd: defending incoming attacks")
 echo("\n tfs: focusing afflictions")
 echo("\n tod: overdriving for health")
 echo("\n tkil: executing queued attacks")
 echo("\n tmin: mine resource nodes you appraise")
 echo("\n tbld: curing bleeding")
 echo("\n tcl: closing pack")
 echo("\n tlp: looping a single attack")
 echo("\n tcoun: use of counter or inquartata")
 cecho("<green>\nDisplay Toggles:")
 echo("\n tpr: numbers/percents on prompt")
 echo("\n tfp: display 0 as change in vital stats on prompt")
 echo("\n ltime: display timestamps to left of prompt")
 echo("\n rtime: display timestamps to right of prompt")
 echo("\n taffs: display afflictions given on attack echoes")
 echo("\n tdiag: display affliction effects on diag/assess")
 echo("\n tdeff: display defense effects on def")
 echo("\n tdef: colored echoes for incoming attacks")
 echo("\n tatk: colored echoes for outgoing attacks")
 echo("\n taff: colored echoes for afflictions")
 echo("\n tdefend: colored echoes for defenses")
 echo("\n tpass: colored echoes for passive effects")
 echo("\n tbal: colored echoes for balance alerts")
 echo("\n tcd: colored echoes for cooldown alerts")
 cecho("<green>\nClass Toggles:")
 if mtw.my.class == "soldier" then
  echo("\n tmch: marching instead of move")
  echo("\n tret: retreating instead of move")
 elseif mtw.my.class == "rogue" then
  echo("\n thid: hide when out of combat")
  echo("\n tpoi: display next poison layer on prompt")
 elseif mtw.my.class == "magician" then
  echo("\n tward: maintain warding/lightball")
  echo("\n tfrz: maintain freezing the ground")
 elseif mtw.my.class == "priest" then
  echo("\n tward: liturgy when available")
 end
 send(" ")
end

function mtw.bashing_aliases()
 cecho("<green>\nBashing Commands:")
 echo("\n ff: toggle fasthunting")
 echo("\n aa: start bashing current room")
 echo("\n ast: stop bashing")
 echo("\n asp: stop bashing after next kill")
 echo("\n aap: start bashing and stop in one kill")
 echo("\n flee: toggle bashing/fasthunting off and queue flee")
 echo("\n tgg: toggle gathering gold and items")
 echo("\n gen: toggle generic/numeric targeting")
 echo("\n wbs: load mana wyrm bashing 'area'")
 echo("\n q X Y Z: manually load a prioritized target list of X, Y, and Z")
 echo("\n offr: check II CORPSE and then offer all the corpses you hold")
 echo("\n offrs: check II CORPSE and then offer all the corpses to sanctify")
 if mtw.my.class == "soldier" then
  echo("\n tbrk: toggle berserking")
  echo("\n trt: toggle threatening")
  echo("\n tobt: toggle obliterating")
  echo("\n tsnd: toggle sundering")
  if table.contains(mtw.skills, "swordmastery") then
   echo("\n tsf: toggle starfurying")
  end
 elseif mtw.my.class == "rogue" then
  echo("\n tflh: toggle fleching")
  echo("\n thid: toggle hiding")
  echo("\n tinq: toggle inquartata")
  if table.contains(mtw.skills, "thievery") then
   echo("\n tsm: toggle shadowmending")
  end
  if table.contains(mtw.skills, "performance") then
   echo("\n tcnt: toggle cantoing")
   echo("\n treq: toggle requieming")
   echo("\n tprl: toggle prelude")
  end
 elseif mtw.my.class == "priest" then
  echo("\n thrt: toggle heretic")
  echo("\n tswd: toggle holy sword")
  if table.contains(mtw.skills, "bloodlore") then
   echo("\n tsv: toggle savaging")
  end
   if table.contains(mtw.skills, "shadoweaving") then
   echo("\n tlsh: toggle lashing")
  end
  if table.contains(mtw.skills, "crusading") then
   echo("\n tdom: toggle dominating strike")
  end
 elseif mtw.my.class == "magician" then
  echo("\n tigt: toggle igniting")
  echo("\n tana: toggle anachronizing")
  echo("\n tbrg: toggle eldritch barrage")
  echo("\n timm: toggle immolating")
  echo("\n tis: toggle icespikes")
  echo("\n tblf: toggle balefire instead of stormlance")
  if table.contains(mtw.skills, "psionics") then
   echo("\n tmbl: toggle mindblasting")
  end
 end
 send(" ")
end

function mtw.fishing_aliases()
 cecho("<green>\nFishing Commands:")
 echo("\n fsh: toggle fishing on/off")
 echo("\n tff: toggle fastfish on/off")
 echo("\n fdr X: set fishing direction to X")
 echo("\n cbait X: set bait type to X")
 echo("\n fdis X: set cast distance to X")
 echo("\n fcut: queue to cut the line")
 echo("\n frl: reel in the line")
 echo("\n fc X: cast to the X")
 echo("\n fbait X: vout and bait with X")
 send(" ")
end

function mtw.reset_alias()
 mtw.reset_all()
 echo("RESET!")
 send(" ")
end

function mtw.deathbeam() --like, srsly?
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#@@@@@@@@#@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#######@@@@@#@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+''++###@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##+':,;'+##@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##+;``,;+#@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##+'::'+##@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#++++##@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+@###@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'#@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@'#@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@@'@#@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@@'#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@@'@;@#@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@@;@@'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@@'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@@@'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@#@@@@@@@@@@@@@@'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@@'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@#@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@@#+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@@#+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+@@@@@@@")
echo("\n@@@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
echo("\n@@@##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
send(" ")
end

function mtw.setup_alias()
send("config voting prompt", false)
send("config prompt all", false)
send("config prompt remove verbose", false)
send("config prompt remove adrenaline", false)
send("config afflines on", false)
send("config screenwidth off", false)
send("config mxp on", false)
send("config color deathsense 5 2", false)
end

function mtw.fix_alias()
mtw.skills = {}
sendGMCP("Char.Skills.Get")
end
