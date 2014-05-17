-- MTW: variables

--OPTIONS
mtw_struct.set_metatable_custom("options")
mtw.default.options = {
 container = "pack",
 mount = "-",
 scabbard1 = "-",
 scabbard2 = "-",
 baldric1 = "-",
 baldric2 = "-",
 crossbow = "-",
}

--TIMES
mtw_struct.set_metatable_saved("attack_times")

--TOGGLES
mtw_struct.set_metatable_custom("toggles")

mtw.default.toggles = {
roulette = false,
--Vital toggles
paused = false,
healing = true,
defending = true,
focusing = true,
overdriving = true,
standing = true,
debug = false,

bashing = false,
fishing = false,
--Queuing attacks
killing = true,
--Gathering coins/corpses/items
gathering = true,
--Mining
mining = false,
--Healing bleeding
bleeding = true,
--Using counter/inquartata
countering = false,
--Bashing skill toggles
berserking = false,
sundering = false,
starfurying = false,
fleching = false,
cantoing = false,
requieming = false,
savaging = false,
lashing = false,
mandate = false,
shadowmending = true,
hereticing = false,
igniting = false,
flourishing = true,
anachronizing = false,
immolating = false,
mindblasting = true,
spiking = false,
barraging = true,
obliterating = true,
dominating = true,
prelude = false,
inquartataing = true,
balestrating = false,
swording = true,
balefiring = false,
palming = false,
revitalizing = true,
--Name/numeric targeting
generics = false,
--Bashing options
fasthunt = false,
ratting = false,
--Misc. skill toggles
threatening = false,
retreating = false,
hiding = false,
misdirecting = false,
marching = false,
squading = false,
warding = false,
freezing = false,
scrying = false,
gripping = false,
--Keep pack closed
closing = true,
--Repeat the same queued attack
looping = false,
--Prompt display options
percents = true,
fullprompt = false,
lefttimestamp = true,
righttimestamp = false,
--Display next poison (rogues)
poisondisplay = true,
--Replace passive effects
passecho = true,
--Display afflictions from attacks
affdisplay = true,
--Display affliction effects on diag/assess
diageffect = true,
--Display defense effects on def
defeffect = true,
--Replace affliction give/cure lines
affecho = true,
--Replace defense give/take lines
defendecho = true,
--Replace incoming attack lines
defecho = true,
--Replace outgoing attack lines
atkecho = true,
--Replace balance lines
balecho = true,
--Replace cooldown lines
cdecho = true,
--Print the name of the current char in the prompt
charprompt = false,
}

--channeling
mtw.prechanneling = {
 rifting = false,
 inking = false,
 deepshrouding = false,
}
-- mtw.channeling[x] lets you get/set the corresponding element, mtw.channeling() tells you if you're channeling or not.
mtw.channeling = {
 rifting = false,
 inking = false,
 deepshrouding = false,
}
setmetatable(mtw.channeling, {
 __call = function (t)
  for k,v in pairs(t) do
   if v then
    return true
   end
  end
  return false
 end,
})

--misc

mtw.see_illusion = false

mtw.last_type = "none"
mtw.last_item = "none"
mtw.units = {}

mtw.last_lance = createStopWatch()

mtw.losingall = false
mtw.people_online = {}
mtw.people = {}

mtw.soldier_shielding = false
mtw.soldier_shielded = "none"
mtw.vote = false
mtw.voted = true
mtw.target = "none"
mtw.ally = "none"
mtw.blessed = "none"
mtw.delete_prompt = false
mtw.current_society = "none"
mtw.cur_weapon = "none"
mtw.item_found = false
mtw.corpse_found = false
mtw.tele_time = 0
mtw.did_diag = false
mtw.stand_queued = false
mtw.anach = false
mtw.my_time = 0
mtw.aff_color = ""

--GATHERING STUFF
mtw.mining = {
material = "none",
found = false
}


--DEFENDING STUFF
mtw.enemy = {
attack = "none",
attacker = "none",
}

mtw.defending = {
next = "dodge",
current = "none",
delay = 0
}

mtw.next = {
action = "none",
balance = "none",
equil = "none",
psi = "none",
offhand = "none"
}

mtw.repulsed = {}
mtw.anachronized = {}

--Bashing stuff
mtw.bashing = {
target = "none",
targeted = false,
engaged = false,
target_word = "",
target_number = "",
target_desc = "",
target_type = "long",
target_priority = 10000,
stopping = false,
shadowmend = false
}

mtw.area_found = false
mtw.have_offerings = false
mtw.possible_targets = {}
mtw.corpses = {}
mtw.gathering = {}
mtw.need_loot = false

mtw.used = {
threaten = false,
sunder = false,
starfury = false,
fleche = false,
balefire = false,
balestra = false,
savage = false,
ignite = false,
heretic = false,
}

mtw.casted = {
balefire = false,
}

mtw.inquartata = false

mtw.new = {
area = false,
room = false
}

--Fishing stuff
mtw_struct.set_metatable_custom("fishing")

mtw.default.fishing = {
fastfish = false,
stat = "baiting",
bait = "octopus",
baited = false,
distance = "",
dir = "n",
count = 0,
get = "sml",
max_cast = 0,
max_dist = 0,
min_end = 0,
reels = 0,
recast = false,
failures = 0,
probe = false,
}

--Poison stuff
mtw.poisons = {

}

--Poison effects list
mtw.poison_affs = {
duroxin = "impatience",
somnulin = "hypersomnia",
citralin = "agoraphobia",
salenin = "epilepsy",
pericite = "headache",
curonin = "paranoia",
botulinum = "nausea",
cruorare = "hemophillia",
caecunim = "blindness",
fidoxin = "faithrot",
penitin = "claustrophobia",
surdulin = "deafness",
norare = "anorexia",
spironin = "astma",
adustoxin = "sun_allergy",
audaxite = "recklessness",
venefin = "manaleech",
lassoxin = "depression",
mortoxis = "paralysis",
demensare = "stupidity",
credoxia = "indiscriminate_trust",
silverthorn = "deadly"
}


--Auto-learning list
mtw.tutors = {
"Tovan",
"Niobe",
"Tileh",
"Edram",
"Cocoamel",
"Narul",
"Gravis",
"Jingo",
"Calin",
"Fingers",
"Orina",
"Lathfain",
"Vhati",
"Aislyn",
"Elliandre",
"Kelly",
"Enric",
"Baru",
"Ellisande",
"Robert",
"Nikalo",
"Kafir",
"Cailin",
"Galain",
}

--Weapon types list
mtw.weapons = {
"saber",
"longsword",
"rapier",
"flail",
"mace",
"morning star",
"claymore",
"greatsword",
"axe",
"spear",
"maul",
"warhammer",
"club",
"athame",
}

mtw.offweapons = {
"dagger",
"poniard",
"shield",
}

--status

--Automatic string statuses
mtw.my = mtw.my or {
name = "",
stats = "",
weapon = "",
offweapon = "",
rogue_weapon = "",
class = "",
area = "",
room = ""
}

--Boolean statuses
mtw.status = mtw.status or {
riding = false,
vampire = false,
waking = false,
writhing = false,
shielding = false,
clotting = false,
defending = false,
combat = false
}

--Vital stats
mtw.vitals = {
current = {health = 0, endurance = 0, magic = 0, guile = 0, faith = 0},
old = {health = 0, endurance = 0, magic = 0, guile = 0, faith = 0},
loss = {health = 0, endurance = 0, magic = 0, guile = 0, faith = 0},
max = {health = 0, endurance = 0, magic = 0, guile = 0, faith = 0},
percent = {health = 0, endurance = 0, magic = 0, guile = 0, faith = 0},
adrenaline = 0,
xp = 0,
cadence = 0,
bleeding = 0,
blood = 0
}


--Balance booleans
mtw.balance = {
balance = true,
equilibrium = true,
psi = true,
offhand = true,
roar = true,
overdrive = true,
focus = true,
flourish = true,
anachronize = true,
barrage = true,
canto = true,
requiem = true,
last_stand = true,
recover = true,
concentrate = true,
perfect = true,
desperate = true,
rage = true,
immunity = true,
}

mtw.waiting = {
balance = false,
offhand = false,
psi = false,
equilibrium = false,
focus = false,
wake = false,
stand = false,
writhe = false,
overdrive = false,
flourish = false,
ih = false,
slow = false,
sent = false,
clotting = false,
recover = false,
wield = false,
loot = false
}

--Balance reset timers
mtw.balance_timers = {
balance = {timer = createStopWatch(), cap = 0},
equilibrium = {timer = createStopWatch(), cap = 0},
offhand = {timer = createStopWatch(), cap = 22},
overdrive = {timer = createStopWatch(), cap = 5},
focus = {timer = createStopWatch(), cap = 5},
flourish = {timer = createStopWatch(), cap = 6},
anachronize = {timer = createStopWatch(), cap = 100},
barrage = {timer = createStopWatch(), cap = 60},
canto = {timer = createStopWatch(), cap = 15},
requiem = {timer = createStopWatch(), cap = 70},
last_stand = {timer = createStopWatch(), cap = 130},
recover = {timer = createStopWatch(), cap = 0},
concentrate = {timer = createStopWatch(), cap = 0},
perfect = {timer = createStopWatch(), cap = 305},
desperate = {timer = createStopWatch(), cap = 125},
rage = {timer = createStopWatch(), cap = 185},
immunity = {timer = createStopWatch(), cap = 125},
psi = {timer = createStopWatch(), cap = 18},
}

--Healing command reset tracking
mtw.last = {
focus = "none",
overdrive = "none",
stand = "none",
writhe = "none",
special = "none",
balance = "none",
equilibrium = "none",
balanceequilibrium = "none",
balancetake = "none",
equilibriumtake = "none",
needybalancetake = "none",
needyequilibriumtake = "none",
balanceequilibriumtake = "none"
}

--Important command checks
mtw.sent = {
def = false,
diag = false,
assess = false,
ih = false,
wp = false,
whohere = false,
qw = false,
prelude = false,
inv = false
}

--Conditional heal command data
mtw.reject = {
mage = "none",
psion = "none",
priest = "none",
lust = "none"
}

--Possible affliction checks
mtw.check = {
reckless = false,
bloodboil = false,
illusion = false
}


--Misc statuses
mtw.need_wield = false
mtw.need_offwield = false
mtw.need_heal = false
mtw.recent_defend = false
mtw.fleeing = false
mtw.opening = false
mtw.removing = false
mtw.slow_command = ""
mtw.heal_priority = 10000
mtw.recovering_balance = false
mtw.recovering_equilibrium = false

--landmarks

mtw.landmarks = {
--Krondor
kron = 567,
--Sar-Sargoth
ssg = 2044,
--Elvandar
elv = 5790,
--Silban Abbey
silb = 5868,
--Imp Cave
imps = 4718,
--Crypt in the Highlands
crypt = 4594,
--Thunderhell
th = 2343,
--Mac Mordain Cadal
mmc = 5954,
--Uru Gathering
uru = 5830,
--Beaver Dam
dam = 3458,
--Eggerson Outpost
egg = 4890,
--Sedia Tunnels
sed = 7117,
--Yarsog
yar = 5719,
--Frontier Valley
fval = 7027,
--Ig'tur Troll Camp
igt = 3151,
--Rut Horuk Troll Camp
rut = 3788,
--Dirge Swamp
swamp = 4008,
--Bandit Camp
bndt = 3669,
--Beach Between Carse and Jonril
beach = 1331,
--Veilgarden
veil = 202,
--Highcastle
high = 7400,
--Loriel (east)
loriele = 1002,
--Loriel (north)
lorieln = 1089,
--Hush
hush = 1570,
--Port Natal
pnatal = 1611,
--Caldara
caldara = 2371,
--Harlech
harlech = 2508,
}

