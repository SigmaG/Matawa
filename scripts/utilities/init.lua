-- MTW : random utilities

-- crits

mtw.crits = {
hits = 0,
normal = 0,
crushing = 0,
obliterating = 0,
annihilating = 0,
shattering = 0,
total = 0,
rate = 0
}

-- chat things?

mtw.channels = {
citytells = {},
ordertells = {},
guildtells = {},
novicetells = {},
markettells = {},
newbietells = {},
leaderstells = {}
}

function mtw.chat_thingy(matches)
 local m = matches[1]
 if m == "ctells" then
  display(mtw.channels.citytells)
 elseif m == "otells" then
  display(mtw.channels.ordertells)
 elseif m == "gtells" then
  display(mtw.channels.guildtells)
 elseif m == "mtells" then
  display(mtw.channels.markettells)
 elseif m == "ntells" then
  display(mtw.channels.newbietells)
 elseif m == "sctells" then
  display(mtw.channels[mtw.current_society])
 elseif m == "gntells" then
  display(mtw.channels.novicetells)
 elseif m == "ltells" then
  display(mtw.channels.leaderstells)
 end
 send(" ")
end

function mtw.parse_chat(channel, message)
 if #mtw.channels[channel] >= 20 then
  table.remove(mtw.channels[channel], 1)
 end
 table.insert(mtw.channels[channel], message)
end

-- alchemy

mtw.alchemy = {
duroxin = {"balsam", "elderberry", "larkspur", "dropwort"},
somnulin = {"buckthorn", "hyacinth", "mistletoe", "jasmine"},
citralin = {"dropwort", "elderberry", "larkspur", "oleander"},
salenin = {"dropwort", "lovage", "poppy", "henbane"},
pericite = {"monkshood", "jasmine", "hemlock", "elderberry"},
curonin = {"oleander", "henbane", "wormwood", "poinsettia"},
botulinum = {"balsam", "lovage", "thornapple", "primrose"},
cruorare = {"primrose", "poinsettia", "daphne", "moonseed"},
caecunim = {"thornapple", "yew", "calabar", "baneberry"},
fidoxin = {"nightshade", "mistletoe", "foxglove", "moonseed"},
penitin = {"hellebore", "calabar", "monkshood", "foxglove"},
surdulin = {"stavesacre", "buckthorn", "bloodroot", "larkspur"},
norare = {"baneberry", "hellebore", "wisteria", "stavesacre"},
spironin = {"hyacinth", "snakeroot", "laurel", "wisteria"},
adustoxin = {"poppy", "laurel", "henbane", "wormwood"},
audaxite = {"hyacinth", "jasmine", "daphne", "bloodroot"},
venefin = {"moonseed", "hemlock", "daphne", "bloodroot"},
lassoxin = {"yew", "poinsettia", "wormwood", "snakeroot"},
mortoxis = {"baneberry", "nightshade", "stavesacre", "wisteria"},
demensare = {"laurel", "oleander", "poppy", "calabar"},
credoxia = {"foxglove", "thornapple", "calabar", "primrose"},
--antidote = {"silverthorn", "poinsettia"},
silverthorn = {"nightshade", "hemlock", "monkshood", "silverthorn", "silverthorn"}
}

function mtw.do_alchemy(poison)
 send("flush alembic")
 for i in pairs(mtw.alchemy[poison]) do
  send("vout 5 "..mtw.alchemy[poison][i])
  send("add 5 "..mtw.alchemy[poison][i].." to alembic")
 end
 send("amalgamate "..poison)
end

-- tattoos
mtw.tattoos = {
lantern = {"yellow", "yellow", "yellow"},
sun = {"red", "red", "purple"},
censer = {"blue", "gold", "yellow"},
jewel = {"green", "green", "blue"},
moon = {"red", "blue", "blue", "yellow"},
thirdeye = {"blue", "blue", "green"},
heart = {"green", "red", "red", "blue"},
shield = {"red", "red", "green"},
crown = {"yellow", "green", "blue"},
sceptre = {"yellow", "red", "blue"},
arrow = {"blue", "red", "red", "yellow", "yellow"},
glacier = {"red", "purple", "blue"},
star = {"gold", "red", "blue", "yellow"},
serpent = {"red", "red", "purple"},
dragon = {"blue", "red", "red", "red", "yellow"},
skull = {"purple", "purple", "blue"},
lotus = {"blue", "blue", "red", "red", "green", "green", "gold"},
hourglass = {"red", "blue", "green"},
compass = {"blue", "gold", "purple"},
rose = {"yellow", "yellow", "blue"},
owl = {"blue", "purple", "green"},
wheel = {"gold", "purple", "purple", "blue"},
tree = {"red", "yellow", "blue", "green", "green", "purple", "gold"}
}

function mtw.do_tattoo(tattoo)
 for i in pairs(mtw.tattoos[tattoo]) do
  send("vout "..mtw.tattoos[tattoo][i].."ink")
 end
end

-- scrying
mtw.scry = {
target = "none",
found = "none",
call = "none",
env = "none",
hidden = "none",
distance = "none"
}

mtw.scry_likely = {}
mtw.scry_possible = {}
mtw.scry_string = ""

-- songs
--SONGS TABLE
mtw.songs = {
caress = {id = "", long = "Maiden's Caress", time = 0},
feast = {id = "", long = "Feast of Banapis", time = 0},
lay = {id = "", long = "Lay of the Blessed Isles", time = 0},
legacy = {id = "", long = "Legacy of the Riftwar", time = 0},
hymn = {id = "", long = "Hymn of Piety", time = 0},
lullaby = {id = "", long = "Dryad's Lullaby", time = 0},
balm = {id = "", long = "Longbow's Balm", time = 0},
rains = {id = "", long = "rains of Darkmoor", time = 0},
air = {id = "", long = "Air of the Black Sorcerer", time = 0},
rage = {id = "", long = "Mythar's Rage", time = 0},
prelude = {id = "", long = "Prelude of Harmony", time = 0},
oath = {id = "", long = "Oath of the Stoneborn", time = 0},
romance = {id = "", long = "Romance of the Elf Queen", time = 0},
fugue = {id = "", long = "Fugue of Forgetting", time = 0},
pyres = {id = "", long = "Pyres of Armengar", time = 0},
vigil = {id = "", long = "Song of Eldar's Vigil", time = 0},
lament = {id = "", long = "Rhuagh's Lament", time = 0},
ballad = {id = "", long = "Ballad of the Hand", time = 0},
verse = {id = "", long = "Verse of Ages", time = 0},
bolero = {id = "", long = "Sanguine Bolero", time = 0},
silence = {id = "", long = "Silence of Sethanon", time = 0},
nocturne = {id = "", long = "Nocturne of Shadow", time = 0},
anthem = {id = "", long = "Battaglia Anthem", time = 0},
serenade = {id = "", long = "Serenade of the Void", time = 0},
squall = {id = "", long = "Squall of Storms", time = 0},
}


mtw.song_list = {
"nocturne",
"serenade",
"anthem"
}

mtw.song_options = {

none = {
},

adr = {
"nocturne",
"serenade",
"anthem"
},

bsh = {
"prelude",
"nocturne",
"serenade"
},

lust = {
"romance",
"nocturne",
"serenade"
},

}

function mtw.load_songs(option)
 if mtw.song_options[option] ~= nil then
  cecho("<green>Loading song options for: "..option)
  send(" ")
  mtw.song_list = mtw.song_options[option]
  display(mtw.song_list)
 else
  cecho("<red>No such defense option as "..option.."!")
  send(" ")
 end
end

-- mount aliases

function mtw.mount_alias()
if table.contains(mtw.skills, "Vault") then
 send("vault "..mtw.options.mount, false)
else
 send("mount "..mtw.options.mount, false)
end
end

function mtw.mymount()
mtw.options.mount = matches[2]
echo("Mount: "..matches[2])
end

-- anti-theft

function mtw.unwield_alias(matches)
mtw.unwielding = true
tempTimer(1, [[mtw.unwielding = false]])
send(matches[1], false)
end

function mtw.get_from_pack(matches)
if string.find(mtw.options.container, matches[3]) then
 mtw.do_pack(matches[1])
else
 send(matches[1], false)
end
end

function mtw.put_in_pack(matches)
if string.find(mtw.options.container, matches[3]) then
 mtw.do_pack(matches[1])
else
 send(matches[1], false)
end
end

function mtw.probe_alias(matches)
if string.find(mtw.options.container, matches[3]) then
 mtw.do_pack(matches[1])
else
 send(matches[1], false)
end
end

function mtw.open_pack(matches)
if string.find(mtw.options.container, matches[2]) then
 mtw.opening = true
 send(matches[1], false)
 tempTimer(1, [[mtw.opening = false]])
else
 send(matches[1], false)
end
end

function mtw.remove_pack(matches)
if string.find(mtw.options.container, matches[3]) then
 mtw.removing = true
 send(matches[1], false)
 tempTimer(1, [[mtw.removing = false]])
else
 send(matches[1], false)
end
end



-- misc aliases

function mtw.landmarks_alias(matches)
if mtw.landmarks[matches[2]] ~= nil then
 send("path find "..mtw.landmarks[matches[2]], false)
else
 cecho("<green>No such landmark!")
 send(" ")
end
end

function mtw.fleeing_alias()
if mtw.toggles.bashing then
 mtw.toggle("bashing")
end
if mtw.toggles.fasthunt then
 mtw.toggle("fasthunt")
end
if mtw.defenses.def_spellshield.needit then
 mtw.defenses.def_spellshield.needit = false
 echo("No longer keeping spellshield")
 send(" ")
end
mtw.set_balance("flee")
end

function mtw.moving_alias()
if mtw.toggles.marching and table.contains(mtw.skills, "Marching") then
 mtw.send("march "..matches[1])
elseif mtw.toggles.retreating and table.contains(mtw.skills, "Tactical Retreat") then
 mtw.send("retreat "..matches[1])
elseif mtw.toggles.misdirecting and table.contains(mtw.skills, "Misdirect") then
 mtw.send("misdirect "..matches[1])
elseif mtw.toggles.squading then
 if matches[1] == "u" then
  mtw.unitdir = "up"
 elseif matches[1] == "d" then
  mtw.unitdir = "down"
 elseif matches[1] == "n" then
  mtw.unitdir = "north"
 elseif matches[1] == "s" then
  mtw.unitdir = "south"
 elseif matches[1] == "e" then
  mtw.unitdir = "east"
 elseif matches[1] == "w" then
  mtw.unitdir = "west"
 elseif matches[1] == "ne" then
  mtw.unitdir = "northeast"
 elseif matches[1] == "nw" then
  mtw.unitdir = "northwest"
 elseif matches[1] == "se" then
  mtw.unitdir = "southeast"
 elseif matches[1] == "sw" then
  mtw.unitdir = "southwest"
 elseif matches[1] == "in" then
  mtw.unitdir = "in"
 elseif matches[1] == "out" then
  mtw.unitdir = "out"
 end
 for i in pairs(mtw.units) do
  send("bqa say "..mtw.units[i]..", march "..mtw.unitdir, false)
 end
 send("bqa "..matches[1], false)
else
 send(matches[1], false)
end
end

function mtw.target_alias()
mtw.target = string.title(string.lower(matches[2]))
target = matches[2]
echo("Target: "..mtw.target)
if mtw.toggles.calling then
 send("sct Attacking **"..mtw.target.."** !")
end
send(" ")
if id then killTrigger(id) end
id = tempTrigger(mtw.target, [[selectString("]] .. mtw.target .. [[", 1) fg("DarkOrchid") resetFormat()]])
if idlow then killTrigger(idlow) end
idlow = tempTrigger(string.lower(mtw.target), [[selectString("]] .. string.lower(mtw.target) .. [[", 1) fg("DarkOrchid") resetFormat()]])
end

function mtw.order_guard_move(matches)
for i = 1,tonumber(matches[2]) do
 send("order constable move "..matches[3])
end
end

function mtw.stop_alias()
send("stop", false)
if mtw.toggles.bashing then
 mtw.toggle("bashing")
end
if mtw.toggles.fasthunt then
 mtw.toggle("fasthunt")
end
next.balance = "none"
next.psi = "none"
end

function mtw.date_conversion(matches)
if matches[3] == "" then
 echo("You inquired about "..matches[2].." Midkemian days from now.")
 local time_str = os.date("%c", os.time() + 3 * 60 * 60 * tonumber(matches[2]))
 cecho(("\n<white>This will be %s \177 3 hours, your local time."):format(time_str))
 send(" ")
else
 for i in pairs(mtw.mko_months) do
  if matches[3] == i then
  end
 end
end
end

function mtw.clear_crits()
mtw.crits = {
hits = 0,
normal = 0,
crushing = 0,
obliterating = 0,
annihilating = 0,
shattering = 0,
total = 0,
rate = 0
}
cecho("<green>\nResetting Crit Tracker!")
send(" ")
end

function mtw.counter_target(matches)
mtw.tar = matches[2]
echo("\nAuto-Counter Target: "..matches[2].."\n")
end

function mtw.prepare_poison(matches)
for i in pairs(mtw.alchemy) do
 if string.find(i, matches[2]) then
  mtw.do_alchemy(i)
  return
 end
end
cecho("<green>\nNo such poison "..matches[2].."!")
send(" ")
end

function mtw.tattoo_alias(matches)
mtw.do_tattoo(matches[2])
send(matches[1])
end

function mtw.lose_all()
mtw.losingall = true
tempTimer(2, [[mtw.losingall = false]])
sendGMCP("Comm.Channel.Players")
send(" ")
end

function mtw.sit_alias(matches)
if mtw.toggles.standing then
 mtw.toggle("standing")
end
send(matches[1])
end

function mtw.set_squad(matches)
mtw.units = {}
for i in string.gmatch(matches[2], "(%w+)") do
 table.insert(mtw.units, i)
end
cecho("<green>\nUnits received:")
for h in ipairs(mtw.units) do
 cecho("\n "..mtw.units[h])
end
send(" ")
end

function mtw.use_door(matches)
send("unlock door "..matches[2])
send("open door "..matches[2])
send(matches[2])

if matches[2] == "n" then
 doordir = "south"
elseif matches[2] == "s" then
 doordir = "north"
elseif matches[2] == "e" then
 doordir = "west"
elseif matches[2] == "w" then
 doordir = "east"
elseif matches[2] == "in" then
 doordir = "out"
elseif matches[2] == "out" then
 doordir = "in"
elseif matches[2] == "ne" then
 doordir = "southwest"
elseif matches[2] == "sw" then
 doordir = "northeast"
elseif matches[2] == "nw" then
 doordir = "southeast"
elseif matches[2] == "se" then
 doordir = "northwest"
elseif matches[2] == "up" or matches[2] == "u" then
 doordir = "down"
elseif matches[2] == "d" then
 doordir = "up"
end

send("close door "..doordir)
send("lock door "..doordir)
end


-- roulette alias?

function mtw.roulette_bet(matches)
mtw.roulette.betting = matches[2]
echo("Now betting on: "..mtw.roulette.betting)
send(" ")
end
