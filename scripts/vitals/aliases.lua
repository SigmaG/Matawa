-- MTW: vitals aliases

function mtw.help_alias()
 cecho("<green>\nBasic Commands:")
 echo("\n ?help: this, obviously")
 echo("\n ?info: display version info")
 echo("\n ?import: list the matawa options you can import from another profile")
 echo("\n ?search X: search through the system files")
 echo("\n ?setup: sends all the CONFIG commands the system needs")
 echo("\n ?toggles: display toggle commands")
 echo("\n ?bashing: display bashing commands")
 echo("\n ?fish: display fishing commands")
 echo("\n ?conv: display conversion commands")
 echo("\n ?variables: display system variables (mount id, type of container...)")
 echo("\n ?gui: display GUI configuration commands")
 echo("\n rst: reset most variables to default")
 echo("\n reload: reload system scripts")
 echo("\n reload hard: reload system scripts without keeping toggles/options/...")
 echo("\n t X: set combat target X")
 echo("\n ldd X: load defense option X")
 echo("\n chd X Y on/once/off: enable or disable the defense Y from defense option X")
 echo("\n sdd X: print defense option X")
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
 mtw.get_options() 
 send(" ")
end

function mtw.info_alias()
 cecho("\n<blue>Welcome to Matawa "..mtw.version[1].."!")
 cecho("\n<green> Send ?help to get some help.")
 cecho("\n<blue>Forum Thread:")
 cecho("\n http://forums.midkemiaonline.com/discussion/19/free-mudlet-system#latest")
 cecho("\n<blue>Official webpage:")
 cecho("\n http://mko.kadarniad.fr/matawa")
 echo("\nThe system lua files are stored in: ")
 local file = getMudletHomeDir() .. "/Matawa/scripts"
 local fileinfo = lfs.attributes(file)
 if not fileinfo then
  file = getMudletHomeDir() .. "/matawa/scripts"
  fileinfo = lfs.attributes(file)
 end
 if not fileinfo then
  file = getMudletHomeDir() .. "/scripts" 
 end
 cecho("<yellow>"..file)
 send(" ")
end

function mtw.disp_toggle(toggle, desc)
 if mtw.toggles[toggle] then
  cecho("\n <green>"..desc)
 else
  cecho("\n <red>"..desc)
 end
end

function mtw.toggles_alias()
 echo("\nBasic Toggles:")
 mtw.disp_toggle("healing", "hl: freeze the system")
 mtw.disp_toggle("standing", "ss: standing and waking")
 mtw.disp_toggle("defending", "dfnd: defending incoming attacks")
 mtw.disp_toggle("focusing", "tfs: focusing afflictions")
 mtw.disp_toggle("overdriving", "tod: overdriving for health")
 mtw.disp_toggle("killing", "tkil: executing queued attacks")
 mtw.disp_toggle("mining", "tmin: mine resource nodes you appraise (use 'h X Y (...)' to only chop/mine X Y and so on)")
 mtw.disp_toggle("bleeding", "tbld: curing bleeding")
 mtw.disp_toggle("closing", "tcl: closing pack")
 mtw.disp_toggle("looping", "tlp: looping a single attack")
 mtw.disp_toggle("countering", "tcoun: use of counter or inquartata")
 echo("\nDisplay Toggles:")
 mtw.disp_toggle("percents", "tpr: numbers/percents on prompt")
 mtw.disp_toggle("fullprompt", "tfp: display 0 as change in vital stats on prompt")
 mtw.disp_toggle("lefttimestamp", "ltime: display timestamps to left of prompt")
 mtw.disp_toggle("righttimestamp", "rtime: display timestamps to right of prompt")
 mtw.disp_toggle("affdisplay", "taffs: display afflictions given on attack echoes")
 mtw.disp_toggle("diageffect", "tdiag: display affliction effects on diag/assess")
 mtw.disp_toggle("defeffect", "tdeff: display defense effects on def")
 mtw.disp_toggle("defecho", "tdef: colored echoes for incoming attacks")
 mtw.disp_toggle("atkecho", "tatk: colored echoes for outgoing attacks")
 mtw.disp_toggle("affecho", "taff: colored echoes for afflictions")
 mtw.disp_toggle("defendecho", "tdefend: colored echoes for defenses")
 mtw.disp_toggle("passecho", "tpass: colored echoes for passive effects")
 mtw.disp_toggle("balecho", "tbal: colored echoes for balance alerts")
 mtw.disp_toggle("cdecho", "tcd: colored echoes for cooldown alerts")
 mtw.disp_toggle("charprompt", "tch: print the char name in the prompt")
 if mtw.cgui.enabled then
  cecho("\n <green>tgui: GUI with chat/mapper/... windows")
 else
  cecho("\n <red>tgui: GUI with chat/mapper/... windows")
 end
 echo("\nClass Toggles:")
 if mtw.my.class == "soldier" then
  mtw.disp_toggle("marching", "tmch: marching instead of move")
  mtw.disp_toggle("retreating", "tret: retreating instead of move")
  mtw.disp_toggle("counterstroke", "tcstroke: toggle for counterstroke mastery")
 elseif mtw.my.class == "rogue" then
  mtw.disp_toggle("hiding", "thid: hide when out of combat")
  mtw.disp_toggle("poisondisplay", "tpoi: display next poison layer on prompt")
 elseif mtw.my.class == "magician" then
  mtw.disp_toggle("warding", "tward: maintain warding when out of combat")
  mtw.disp_toggle("antirogue", "trog: maintain lodestone/lightball when out of combat")
  mtw.disp_toggle("rewall", "twall: maintain icewall when out of combat")
  mtw.disp_toggle("freezing", "tfrz: maintain freezing the ground")
 elseif mtw.my.class == "priest" then
  mtw.disp_toggle("liturgy", "tlit: liturgy when available")
 end
 send(" ")
end

function mtw.bashing_aliases()
 cecho("<green>\nBashing Commands:")
 mtw.disp_toggle("fasthunt", "ff: toggle fasthunting")
 echo("\n ?area: display the toggles related to target list customization")
 echo("\n aa: start bashing current room")
 echo("\n ast: stop bashing")
 echo("\n asp: stop bashing after next kill")
 echo("\n aap: start bashing and stop in one kill")
 echo("\n flee: toggle bashing/fasthunting off and queue flee")
 mtw.disp_toggle("gathering", "tgg: toggle gathering gold and items")
 mtw.disp_toggle("generics", "gen: toggle generic/numeric targeting")
 echo("\n wbs: load mana wyrm bashing 'area'")
 echo("\n q X Y Z: manually load a prioritized target list of X, Y, and Z")
 echo("\n offr: check II CORPSE and then offer all the corpses you hold")
 echo("\n offrs: check II CORPSE and then offer all the corpses to sanctify")
 if mtw.my.class == "soldier" then
  mtw.disp_toggle("berserking", "tbrk: toggle berserking")
  mtw.disp_toggle("threatening", "trt: toggle threatening - requires the mastery Terrifying Presence to THREATEN EVERYONE")
  mtw.disp_toggle("obliterating", "tobt: toggle obliterating")
  mtw.disp_toggle("sundering", "tsnd: toggle sundering")
  if table.contains(mtw.skills, "swordmastery") then
   mtw.disp_toggle("starfurying", "tsf: toggle starfurying")
  end
    if table.contains(mtw.skills, "brutality") then
   mtw.disp_toggle("raking", "trk: toggle raking")
  end
 elseif mtw.my.class == "rogue" then
  mtw.disp_toggle("fleching", "tflh: toggle fleching")
  mtw.disp_toggle("hiding", "thid: toggle hiding")
  mtw.disp_toggle("inquartataing", "tinq: toggle inquartata")
  mtw.disp_toggle("balestrating", "tblr: toggle balestra")
  if table.contains(mtw.skills, "thievery") then
   mtw.disp_toggle("shadowmending", "tsm: toggle shadowmending")
  end
  if table.contains(mtw.skills, "performance") then
   mtw.disp_toggle("cantoing", "tcnt: toggle cantoing")
   mtw.disp_toggle("requieming", "treq: toggle requieming")
   mtw.disp_toggle("prelude", "tprl: toggle prelude")
  end
 elseif mtw.my.class == "priest" then
  mtw.disp_toggle("hereticing", "thrt: toggle heretic")
  mtw.disp_toggle("swording", "tswd: toggle holy sword")
  mtw.disp_toggle("mandate", "tmnd: toggle zealous mandate")
  mtw.disp_toggle("revitalizing", "trv: toggle revitalizing")
  if table.contains(mtw.skills, "bloodlore") then
   mtw.disp_toggle("savaging", "tsv: toggle savaging")
  end
  if table.contains(mtw.skills, "shadoweaving") then
   mtw.disp_toggle("lashing", "tlsh: toggle lashing")
  end
  if table.contains(mtw.skills, "crusading") then
   mtw.disp_toggle("dominating", "tdom: toggle dominating strike")
  end
 elseif mtw.my.class == "magician" then
  mtw.disp_toggle("igniting", "tigt: toggle igniting")
  mtw.disp_toggle("anachronizing", "tana: toggle anachronizing")
  mtw.disp_toggle("barraging", "tbrg: toggle eldritch barrage")
  mtw.disp_toggle("immolating", "timm: toggle immolating")
  mtw.disp_toggle("spiking", "tis: toggle icespikes")
  mtw.disp_toggle("balefiring", "tblf: toggle balefire instead of stormlance")
  if table.contains(mtw.skills, "psionics") then
   mtw.disp_toggle("mindblasting", "tmbl: toggle mindblasting")
  end
 end
 send(" ")
end

function mtw.fishing_aliases()
cecho("<green>\nFishing Commands:")
echo("\n fsh: toggle fishing on/off")
if not mtw.fishing.dir then mtw.fishing.dir = "" end
if not mtw.fishing.bait then mtw.fishing.bait = "" end
if not mtw.fishing.distance then mtw.fishing.distance = "" end
if not mtw.fishing.max_dist then mtw.fishing.max_dist = 0 end
if not mtw.fishing.max_cast then mtw.fishing.min_end = 0 end
if not mtw.fishing.get then mtw.fishing.get = "sml" end
echo("\n fdr X: set fishing direction to X (current: "..mtw.fishing.dir..")")
echo("\n cbait X: set bait type to X (current: "..mtw.fishing.bait..")")
echo("\n fdis X: set cast distance to X [medium/long] (current: "..mtw.fishing.distance..")")
echo("\n fcut: queue to cut the line")
echo("\n frl: reel in the line")
echo("\n fc X: cast to the X")
echo("\n fbait X: vout and bait with X")
echo("\n fmdis X: set the maximum length before cutting to X (current: "..mtw.fishing.max_dist..")")
echo("\n fmcast X: set the maximum length of your line (current: "..mtw.fishing.max_cast..")")
echo("\n fmend X: set the minimum endurance before casting your line (current: "..mtw.fishing.min_end..")")
local s = ""
if string.find(mtw.fishing.get,"s") then
 s = "Small"
end
if string.find(mtw.fishing.get,"m") then
 if s == "" then
  s = "Medium"
 else
  s = s.."/Medium"
 end
end
if string.find(mtw.fishing.get,"l") then
 if s == "" then
  s = "Large"
 else
  s = s .. "/Large"
 end
end
echo("\n fget X / fget X Y / fget X Y Z: get only a specific size of fish (current: "..s..")")
echo("\n fjerk X: set the jerking time to X (current: "..mtw.fishing.jerk_time..")")
echo("\n ftease X: set the teasing time to X (current: "..mtw.fishing.tease_time..")")
end

function mtw.reset_alias()
 mtw.reset_all()
 echo("RESET!")
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
