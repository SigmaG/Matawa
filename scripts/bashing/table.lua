--MTW: bashing areas list

mtw_struct.set_metatable_custom("areas")

mtw.default.areas = {
["generic"] = {level = "", krondor = "none", targets = {"an ethereal mana wyrm", "a monstrous pumpkin", "a huge pumpkin", "a big pumpkin", "a mature pumpkin", "a medium pumpkin", "a small pumpkin", "a little pumpkin", "a tiny pumpkin",  "a time%-displaced glamredhel archer", "a time%-displaced glamredhel warrior"}, items = {"a mote of glowing%, blue mana"}},
["MoteHunt"] = {level = "Magicians", krondor = "none", targets = {"an ethereal mana wyrm"}, items = {"a mote of glowing%, blue mana"}},
["pumpkins"] = {level = "LOL", krondor = "none", targets = {"a monstrous pumpkin", "a huge pumpkin", "a big pumpkin", "a mature pumpkin", "a medium pumpkin", "a small pumpkin", "a little pumpkin", "a tiny pumpkin"}},
["Krondor"] = {level = "Ratting", krondor = "none", prime = {"urban", "estate"}, env = {"garden", "ruins"}, targets = {"a black rat","a rat", "an old rat", "a baby rat", "a young rat"}},
["Sewers of Krondor"] = {level = "Ratting", krondor = "none", prime = {"urban"}, targets = {"a black rat","a rat", "an old rat", "a baby rat", "a young rat"}},
["Elvandar"] = {level = "Ratting", krondor = "extremely far to the northwest", prime = {"forest", "estate"}, env = {"fresh water"}, targets = {"a giant red weevil", "a lumbering red weevil", "a fat green weevil", "a large wood weevil", "a hulking green weevil"}},
["Sar-Sargoth"] = {level = "Ratting", krondor = "extremely far to the north", prime = {"urban", "estate"}, env = {"fresh water", "constructed underground"}, targets = {"a black rat","a rat", "an old rat", "a baby rat", "a young rat"}},
["the Outpost of Eggerson"] = {level = "0-20", krondor = "distantly to the north", prime = {"ruins"}, env = {"fresh water"}, targets = {"a male renegade Keshian", "a renegade Keshian woman", "a female Roldem renegade", "a Roldem renegade", "a mercenary valeman", "a valewoman mercenary", "a female Quegan renegade", "a renegade Quegan male", "a dove"}},
["the Frontier Valley"] = {level = "0-20", krondor = "extremely far to the north", prime = {"valley", "village"}, env = {"forest", "fresh water", "hills", "constructed underground"}, targets = {"a temple guard of Prandur", "a temple guard of Guis%-Wan", "a guard bearing the symbol of Lims%-Kragma", "a male villager", "a female villager", "a small child", "a restless ghost", "a spectral warrior", "a goblin servant", "a goblin priest", "a moredhel spellweaver"}},
["the Sedia Tunnels"] = {level = "0-20", krondor = "extremely far to the north", prime = {"mines"}, env = {"ruins", "natural underground", "constructed underground", "canyon", "fresh water", "forest"}, targets = {"a large black scorpion", "a large red scorpion", "a giant worker ant", "a giant soldier ant", "a dwarven miner", "a dwarven warrior", "a small goblin"}},
["a Beaver Dam"] = {level = "10-30", krondor = "extremely far to the north", targets = {"a muskrat", "a black spider", "a beaver"}},
["the Dirge Swamp"] = {level = "10-30", krondor = "extremely far to the northwest", prime = {"swamp"}, targets = {"a green and red dragonfly", "a large mosquito"}},
["the Yabon River"] = {level = "10-30", krondor = "distantly to the northwest", prime = {"river"}, env = {"fresh water", "grasslands"}, targets = {"a Grey Warrior", "Nomatsu%, Strike Leader of the Kotai", "Hobnob", "a scrawny goblin", "a brook trout", "a bearded pike"}},
["the Free Cities Lake"] = {level = "??", krondor = "distantly to the northwest", prime = {"fresh water"}, env = {"beach"}, targets = {"a water elemental"}},
["Sailor's Grief"] = {level = "??", krondor = "extremely far to the northwest", prime = {"hills"}, env = {"path", "beach", "ocean"}, targets = {}},
["the Six Sisters"] = {level = "??", krondor = "extremely far to the northwest", prime = {"ocean"}, env = {"beach"}, targets = {}},
["Lake Moraelin"] = {level = "??", krondor = "extremely far to the northwest", targets = {}},
["the Grey Towers"] = {level = "30-60", krondor = "extremely far to the northwest", prime = {"mountain"}, env = {"hills", "forest", "path", "fresh water", "canyon", "natural underground", "village"}, targets = {"a goblin shaman", "an enraged goblin warrior", "a savage goblin", "Gortznik%, Chieftain of the Ktzerk", "a bandit sentry", "the bandit quartermaster", "a grizzled bandit", "a seasoned mountain raider", "a giant black bat", "a grey wolf", "a huge black bear", "a spotted bobcat", "a vulture", "a mountain sheep", "a green%-banded rattlesnake", "a speckled hawk", "a bighorn ram"}},
["the Ithilian Defile"] = {level = "90+", krondor = "extremely far to the north", prime = {"canyon"}, env = {"valley", "constructed underground", "ruins", "fresh water"}, targets = {"a snake%-like figure", "the Pantathian Serpent%-Priest", "a bighorn ram", "a ferocious coyote"}},
["the Calastius Mountains"] = {level = "??", krondor = "very far to the east", prime = {"mountains"}, env = {"path", "fresh water", "ruins", "natural underground", "constructed underground", "village"}, targets = {"a grey wolf", "a silver marmot", "a bighorn ram", "a speckled hawk", "a mountain sheep", "a menacing brigand"}},
["the Inclindel Gap"] = {level = "??", krondor = "extremely far to the north", prime = {"mountains"}, targets = {"a snowy mountain owl", "an eagle", "a tree shrew", "a huge black bear", "a wandering pilgrim", "Daas'Rika"}},
["the western Teeth of the World"] = {level = "??", krondor = "extremely far to the north", prime = {"mountains"}, env = {"natural underground", "urban"}, targets = {"a mountain sheep", "a vulture", "a rough%-legged buzzard", "a huge black bear"}},
["the Teeth of the World"] = {level = "??", krondor = "extremely far to the north", prime = {"mountains"}, targets = {"a huge wyvern", "a hatchling wyvern"}},
["the Southwestern Plains"] = {level = "??", krondor = "extremely far to the northwest", targets = {"a lively sparrow", "a small rabbit", "a large hare", "a wiry vixen"}},
["the Free-Cities Wilderness"] = {level = "??", krondor = "distantly to the west", targets = {"a tiny field mouse", "a lively sparrow", "a large hare"}},
["Central Hills"] = {level = "Low", krondor = "distantly to the north", prime = {"hills"}, env = {"urban", "fresh water"}, targets = {"a Yabonese Highwayman", "a small rabbit"}},
["the Vale of Isbandia"] = {level = "Low", krondor = "extremely far to the north", targets = {"a wandering pilgrim", "a fierce snow leopard", "a magnificent horned brown elk", "a sleek arctic fox", "a tiny field mouse", "a small rabbit", "a large hare", "a speckled hawk"}},
["the Straits of Darkness"] = {level = "??", krondor = "distantly to the west", prime = {"beach", "ocean"}, env = {"ruins", "path", "constructed underground"}, targets = {"a large sandcrawler", "a seagull", "a ravenous shark"}},
["countryside south of Krondor"] = {level = "none", krondor = "directly southwest", prime = {"farmlands", "river"}, env = {"village", "natural underground"}, targets = {}},
["farmland surrounding Krondor"] = {level = "??", krondor = "far to the east", prime = {"farmland"}, env = {"urban"}, targets = {}},
["the Duchy of Crydee"] = {level = "0-20", krondor = "extremely far to the northwest", prime = {"grasslands", "farmlands"}, env = {"forest", "road", "urban"}, targets = {"a striped locust", "a large hare", "a young fawn", "a small rabbit", "a lively sparrow"}},
["farmlands surrounding Natal"] = {level = "??", krondor = "extremely far to the north", targets = {"a small blackbird", "a lively sparrow", "a pig"}},
["Yabon Forest"] = {level = "30-60", krondor = "extremely far to the northwest", prime = {"forest"}, env = {"natural underground"}, targets = {"a Grey Warrior", "a powerful stag", "a small forest bear", "a delicate doe", "a sturdy quail", "a small rabbit"}},
["Edder Forest"] = {level = "??", krondor = "extremely far to the north", prime = {"forest"}, env = {"natural underground", "river"}, targets = {"a mutant dragon", "a shaggy grizzly bear", "a delicate doe", "a small forest bear", "a dire wolf", "a brook trout", "a yellow perch", "a wood squirrel", "a small blackbird", "an edder lark"}},
["the Green Heart Forest"] = {level = "Questing", krondor = "extremely far to the northwest", prime = {"forest"}, targets = {"a goblin", "a small goblin", "a forest troll", "a young fawn", "a tawny owl", "a small forest bear", "a powerful stag", "a lively sparrow", "a tiny field mouse", "a wiry vixen", "a wiry fox", "a magnificent lion", "a tree shrew", "a delicate doe", "a plump wood fowl", "a delicate butterfly", "a white%-tailed deer", "a short%-tusked boar", "a small rabbit"}},
["Elvandar Forest"] = {level = "Questing", krondor = "extremely far to the northwest", prime = {"forest"}, env = {"river", "natural underground"}, targets = {"a water salamander", "a yellow perch", "a plump wood fowl", "a horned beetle", "a large mosquito", "a hairy brown and white spider", "a small forest bear", "a large snail", "a powerful stag", "a tree shrew", "a brightly%-colored pheasant", "a gwali youth", "a gwali", "a delicate doe", "a delicate butterfly", "a wiry fox", "a speckled hawk", "a young fawn"}},
["the goblin village of Skreech"] = {level = "??", krondor = "extremely far to the northwest", prime = {"village"}, env = {"natural underground"}, targets = {"a goblin pikeman", "a goblin mercenary", "a goblin archer", "a goblin guard", "a little goblin girl", "Pikemaster Toryk", "a goblin shaman", "Skreech, the goblin chief"}},
["Smuggler's Cove"] = {level = "20-40", krondor = "very far to the west", prime = {"reef", "natural underground"}, env = {"beach", "ocean", "urban", "fresh water"}, targets = {"a smuggler", "a scallywag sailor", "a Quegan mariner", "a seagull", "a large sandcrawler", "a large clam"}, items = {"a cargo crate"}},
["an Imp Cave"] = {level = "20-40", krondor = "very far to the west", prime = {"natural underground"}, targets = {"a seductive succubus","an imp rascal", "a scavenger imp", "a giant glow%-worm", "a glow%-worm"}},
["Ig'tur Trollcamp"] = {level = "30-50", krondor = "extremely far to the north", prime = {"village"}, env = {"garden", "natural underground"}, targets = {"a lumbering cave troll", "a matronly cave troll"}},
["Rut Horuk Trollcamp"] = {level = "30-50", krondor = "extremely far to the north", prime = {"village"}, env = {"natural underground"}, targets = {"a hulking troll guard", "a grey mountain troll", "a brutish mountain troll", "Gul%'Thor%, Lord of Rut Horuk", "Mok%'Thul", "Apprentice Ogmol"}},
["the Isbandia Lake"] = {level = "30-50", krondor = "extremely far to the north", targets = {"a brook trout", "a large salmon"}},
["the Barony of Yarsog"] = {level = "40-60", krondor = "extremely far to the north", targets = {"a female soldier"}},
["the Abbey of Silban"] = {level = "40-60", krondor = "extremely far to the northwest", prime = {"urban"}, env = {"path", "garden", "fresh water", "constructed underground"}, targets = {"a black widow spider", "a dust spinner"}},
["a Lions Den"] = {level = "40-60", krondor = "extremely far to the north", prime = {"natural underground"}, env = {"hills", "river"}, targets = {"a sleek lioness", "a young male lion", "a small lion cub"}},
["the road between Zun and Ylith"] = {level = "50-60", krondor = "distantly to the northwest", prime = {"road"}, env = {"forest"}, targets = {"a white%-tailed deer", "an enormous Vilevenom spider", "a blighted tree", "a scrawny timber wolf"}},
["countryside east of Krondor"] = {level = "40-70", krondor = "northeast", prime = {"plains"}, env = {"urban", "road", "path", "farmlands", "fresh water", "village", "forest", "grasslands", "river", "hills", "natural underground"}, targets = {"a male bandit", "a female bandit"}},
["Dass'Rika Abbey"] = {level = "Questing", krondor = "directly southwest", targets = {}},
["Bandit Camp"] = {level = "50-70", krondor = "far to the north", prime = {"forest", "ruins"}, env = {"road", "garden", "constructed underground", "plains"}, targets = {"a male bandit", "a female bandit", "a bandit guard", "a guard dog", "a bandit scout", "a plump wood fowl"}, items = {"a mote of glowing%, blue mana"}},
["the Far Coast beaches"] = {level = "25-35", krondor = "extremely far to the northwest", prime = {"ocean", "beach"}, env = {"natural underground", "reef"}, targets = {"a snapping turtle", "an undead sailor"}},
["beaches between Carse and Jonril"] = {level = "40-60", krondor = "extremely far to the northwest", prime = {"ocean", "beach"}, targets = {"a ravenous shark"}},
["the Lake of the Sky"] = {level = "25-50", krondor = "extremely far to the north", prime = {"fresh water", "beach"}, targets = {"a snapper crocodile", "a red%-billed sandpiper", "a water salamander", "a white%-breasted gull"}},
["the Eagles' Reaches"] = {level = "20-40", krondor = "extremely far to the northwest", prime = {"mountains"}, env = {"natural underground"}, targets = {"a large eagle", "a red crested eagle", "a silver crested eagle", "a cougar", "a baby eagle", "a brown crested eagle"}, items = {"a brown feather", "a silver feather", "a red eagle tail feather", "an eagle talon"}},
["the Great Star Lake"] = {level = "40-60", krondor = "very far to the south", prime = {"fresh water"}, targets = {"a water elemental"}},
["the Hadati Hills"] = {level = "30-50", krondor = "extremely far to the north", prime = {"hills"}, env = {"road", "mountains", "natural underground", "river", "fresh water", "forest", "urban", "path", "village", "beach"}, targets = {"a humanoid wraith", "a huge black wyvern", "an ancient wyvern", "a Moredhel assassin", "a Moredhel ranger", "a lively sparrow", "a highland fox", "a grizzly bear", "a speckled hawk", "a highland viper", "a northern black otter", "a silver%-fin fish", "a rock wyrm"}, items = {"a mote of glowing%, blue mana"}},
["a crypt in the Highlands"] = {level = "40-80", krondor = "extremely far to the north", prime = {"natural underground", "constructed underground"}, targets = {"an undead chieftain", "a revenant retainer", "a death cult priest", "a Hadati ghost", "the ghost of a Hadati Elder", "the ghost of a Hadati Lord", "a risen magician"}, items = {"a necromancer%'s keystone", "an ancient rotting kilt", "a mote of glowing%, blue mana"}},
["the road between Zun and LaMut"] = {level = "??", krondor = "distantly to the north", prime = {"road"}, env = {"urban", "mines", "fresh water"}, targets = {"a dessicated draugr", "a putrid corpsehound"}},
["the Tower of Artifice"] = {level = "40-70", krondor = "distantly to the north", targets = {"a sphere of glowing, blue mana", "a lifelike stone sentinel", "an apprentice artificer"}},
["Semal Reach"] = {level = "40-70", krondor = "extremely far to the north", prime = {"swamp", "jungle", "volcanic"}, env = {"mountains", "valley", "natural underground", "constructed underground", "river", "fresh water", "ruins", "urban"}, targets = {"a mottled wyvern", "a sleek jaguar", "a solid earth elemental", "a fiery elemental of flame", "a vicious crocodile", "an anaconda", "a large%, frilled dragon%-lizard", "a rock wyrm", "a small dust devil", "a Keshian dog soldier", "a giant shield beetle", "a huge black bear", "a colorful viper", "a large mountain goat"}},
["the Abbey at Sarth"] = {level = "60-100", krondor = "very far to the northwest", prime = {"village"}, targets = {"an Ishapian monk", "a warrior monk", "a librarian of Sarth"}},
["the Thunderhell Plains"] = {level = "60-100", krondor = "extremely far to the north", targets = {"a tufted eared lynx", "a polar bear", "a female polar bear", "a bearded seal", "a large salmon", "a bison", "an antlered caribou", "a caribou"}},
["Mac Mordain Cadal"] = {level = "60-100", krondor = "extremely far to the northwest", targets = {"a Moredhel warrior", "a Moredhel berserker", "a muscular, brutish goblin", "a Moredhel sentry", "a vicious goblin", "a rock elemental", "a risen skeleton", "a crawling torso", "a kobold magician", "a kobold miner", "a crazed miner", "Aeilleme%, the vengeful"}, items = {"a lump of iron ore", "a lump of gold ore", "a mote of glowing%, blue mana", "a pottery fragment", "a dirty pouch", "a strange device", "an elemental gemstone"}},
["the Tayr-Dorin Ruins"] = {level = "70-80", krondor = "extremely far to the northwest", prime = {"ruins"}, env = {"swamp", "constructed underground"}, targets = {"a crystalline spider", "a humanoid toad warrior", "a giant venomous toad", "a giant cavern spider"}, items = {"a half%-digested corpse", "a stone fragment", "an ancient dragon bone"}},
["Withered Grove"] = {level = "70-100+", krondor = "extremely far to the west", prime = {"forest"}, env = {"forest", "temple"}, targets = {"an ancient Lich", "a necromancer cultist", "a necromancer adept", "an undead warlock", "a risen villager", "a scorched cadaver", "a large wood rat"}, items = {"a pheasant's tibia", "the lower jaw of a bear", "a rotted deer skull", "a seed of corruption", "the lich's medallion"}},
["Uru Gathering"] = {level = "80-100", krondor = "distantly to the north", prime = {"hills"}, env = {"constructed underground", "mountains", "natural underground", "fresh water"}, targets = {"a giant brute", "a sleek cougar", "a ferocious grizzly bear", "a giant soldier", "Graag, a giant guard", "Hungar, the giant hoardmaster", "Grubans, a large giant", "Pone, the giant lieutenant", "Flork, the giant chieftain", "a giantess dancer", "a male giant", "a female giant"}, items = {"a mote of glowing%, blue mana"}},
["the Fifth Circle of Hell"] = {level = "Demons", krondor = "unscryable", targets = {"a powerful battle demon", "a seductive succubus", "a shadowy darkhound", "an imp"}},
["the Dimwood"] = {level = "80-90", krondor = "extremely far to the north", targets = {"a vicious carcajou", "a renegade bandit", "a swarthy bandit defector", "a massive feral wolf", "an enormous%, rabid wolf", "a cacophonous crow", "a large razorback boar", "a feral goblin", "a hulking woods goblin"}},
["the City of Carse"] = {level = "85-100", krondor = "extremely far to the northwest", targets = {"a tattooed Katargan priestess", "a blood%-splattered Katargan priest", "a lanky Katargan waif"}, items = {"a brief note"}},
["the South Krondorian Highway"] = {level = "90+", krondor = "very far to the south", prime = {"road"}, env = {"plains", "farmlands", "village"}, targets = {"a Keshian archer", "a Keshian warrior"}, items = {"a scrap of map .*"}},
["the Vale of Dreams"] = {level = "90+", krondor = "very far to the southwest", prime = {"farmlands"}, env = {"road", "beach", "village", "garden", "fresh water"}, targets = {"a Keshian archer", "a Keshian warrior"}, items = {"a mote of glowing%, blue mana", "a scrap of map .*"}},
["the edge of the Jal-Pur"] = {level = "90+", krondor = "very far to the southwest", prime = {"desert", "grasslands"}, env = {"natural underground"}, targets = {"a Keshian archer", "a Keshian warrior", "a rider of the Jal%-Pur"}, items = {"a scrap of map .*"}},
["a Keshian encampment"] = {level = "90+", krondor = "very far to the southwest", targets = {"a Keshian archer", "a Keshian warrior", "a rider of the Jal%-Pur", "a Keshian footsoldier", "a Keshian dog soldier", "a Keshian bodyguard", "Yuli Ikbar%-Hassim, the Quartermaster"}, items = {"a scrap of map .*"}},
["Shamata"] = {level = "Questing", krondor = "very far to the southwest", prime = {"urban"}, env = {"sewers", "garden"}, targets = {}},
["Stardock Isle"] = {level = "??", krondor = "very far to the south", prime = {"path"}, targets = {}},
["the Academy of Stardock"] = {level = "Questing", krondor = "very far to the south", prime = {"urban"}, env = {"garden", "fresh water"}, targets = {}},
["Stardock Town"] = {level = "??", krondor = "very far to the south", prime = {"village", "path"}, env = {"fresh water"}, targets = {}},
["the town of Sarth"] = {level = "??", krondor = "very far to the northwest", prime = {"urban"}, env = {"road", "natural underground"}, targets = {}},
["Loriel"] = {level = "??", krondor = "distantly to the north", prime = {"urban"}, targets = {}},
["the village of Zun"] = {level = "??", krondor = "distantly to the north", prime = {"urban"}, env = {"garden"}, targets = {}},
["Ravensburg"] = {level = "Questing", krondor = "east", prime = {"urban"}, env = {"road", "farmlands"}, targets = {}},
["Hawk's Hollow"] = {level = "??", krondor = "distantly to the north", prime = {"urban"}, targets = {"a simple guardsman", "a simple townsman", "a simple townswoman", "a servant", "a beggar girl"}},
["Margrave's Port"] = {level = "??", krondor = "distantly to the west", targets = {}},
["Questor's View"] = {level = "??", krondor = "distantly to the northwest", prime = {"village"}, targets = {}},
["the City of Ylith"] = {level = "??", krondor = "distantly to the northwest", prime = {"urban"}, env = {"fresh water", "garden"}, targets = {}},
["Port Natal"] = {level = "??", krondor = "distantly to the northwest", prime = {"urban"}, targets = {}},
["Free City of Natal"] = {level = "??", krondor = "distantly to the northwest", targets = {}},
["the town of Lan"] = {level = "??", krondor = "distantly to the west", targets = {"a seagull"}},
["Bordon"] = {level = "??", krondor = "distantly to the northwest", targets = {"a seagull"}},
["the town of Tulan"] = {level = "??", krondor = "extremely far to the northwest", targets = {"a lively sparrow", "a small blackbird", "a large sandcrawler", "a seagull"}},
["Jonril"] = {level = "??", krondor = "extremely far to the northwest", targets = {}},
["the town of Walinor"] = {level = "??", krondor = "extremely far to the northwest", prime = {"urban"}, targets = {}},
["the town of Crydee"] = {level = "??", krondor = "extremely far to the northwest", prime = {"urban"}, env = {"garden", "fresh water", "constructed underground"}, targets = {}},
["Harlech"] = {level = "??", krondor = "extremely far to the north", prime = {"village"}, targets = {"a Moredhel protector", "a Moredhel villager", "a Moredhel woman"}},
["Ardanian Ice Caves"] = {level = "??", krondor = "extremely far to the north", targets = {}},
["the City of Yabon"] = {level = "??", krondor = "extremely far to the north", prime = {"urban"}, env = {"garden"}, targets = {}},
["the City of LaMut"] = {level = "??", krondor = "extremely far to the north", targets = {}},
["Wyke"] = {level = "??", env = {"constructed underground"}, krondor = "extremely far to the north", targets = {}},
["the ruins of Armengar"] = {level = "??", krondor = "extremely far to the north", prime = {"ruins"}, env = {"constructed underground"}, targets = {"a grizzly bear", "a carrion crow", "a flea", "a blowfly", "a vulture", "a bandit guard", "Moltor, the slaver"}},
["Caern"] = {level = "??", krondor = "extremely far to the north", targets = {}},
["the town of Tyr-sog"] = {level = "??", krondor = "extremely far to the north", prime = {"urban"}, targets = {}},
["the Plains of Isbandia"] = {level = "??", krondor = "extremely far to the north", targets = {"a wandering pilgrim", "a rough%-legged buzzard", "a snowy%-white arctic fox", "a small rabbit", "a bighorn ram", "a stocky, white%-striped badger", "a brown bear", "a red stag", "a red doe", "a young fawn", "a jackrabbit", "a small blackbird", "a speckled hawk", "a yellow perch", "a magnificent horned brown elk", "a fierce snow leopard", "a massive northern hawk"}},
["Yabon Highway"] = {level = "??", krondor = "extremely far to the north", prime = {"road"}, env = {"urban"}, targets = {"a Yabonese Highwayman"}},
["Free Cities Highway"] = {level = "??", krondor = "distantly to the northwest", targets = {}},
["Far Coast Road"] = {level = "??", krondor = "distantly to the west", targets = {}},
["the Royal Krondorian Highway"] = {level = "??", krondor = "very far to the northwest", prime = {"road"}, targets = {"a time%-displaced glamredhel archer", "a time%-displaced glamredhel warrior"}},
["the Northern Krondor Highway"] = {level = "??", krondor = "distantly to the north", prime = {"road"}, targets = {}},
["Western Free-Cities Highway"] = {level = "??", krondor = "distantly to the northwest", targets = {}},
["the Southern Far Coast Highway"] = {level = "??", krondor = "extremely far to the northwest", targets = {}},
["the Crydee Highway"] = {level = "??", krondor = "extremely far to the northwest", targets = {}},
["Cutter's Gap"] = {level = "??", krondor = "extremely far to the north", prime = {"mountains"}, targets = {}},
["a track through the High Wold"] = {level = "??", krondor = "extremely far to the north", prime = {"path"}, env = {"mountains"}, targets = {}},
["the Ruins of Veilgarden"] = {level = "Siege", krondor = "extremely far to the northwest", prime = {"ruins", "forest"}, targets = {}},
["Highcastle"] = {level = "Siege", krondor = "extremely far to the north", targets = {"a moredhel ranger", "a scrappy goblin warrior", "an armored Krondorian soldier", "a rogue of Krondor"}},
["Sunspear"] = {level = "Siege", krondor = "very far to the southwest", prime = {"urban"}, env = {"mines"}, targets = {}},
["temple of Ka-hooli"] = {level = "none", krondor = "directly southwest", prime = {"temple"}, targets = {}},
["temple of Ruthia"] = {level = "none", krondor = "extremely far to the northwest", targets = {}},
["temple of Prandur"] = {level = "none", krondor = "extremely far to the north", prime = {"temple"}, targets = {}},
["the Temple of Lims-Kragma"] = {level = "none", krondor = "extremely far to the north", prime = {"temple"}, targets = {}},
["the Black Cathedral"] = {level = "none", krondor = "distantly to the north", prime = {"temple"}, env = {"garden"}, targets = {}},
["an Enchanted Glade"] = {level = "100", krondor = "extremely far to the north", targets = {"a porky piglet", "a swarm of tubby bumblebees", "a downy baby bluebird", "a frolicking red%-squirrel", "a tenderfooted doe", "aa big%-eyed baby fawn", "a fluffy white sheep"}},
}

mtw.default.areas["Fort Dannis"] = {level = "Group", krondor = "extremely far to the northwest", prime = {"mountain", "ruins"}, env = {"hills"}}
local mt = {
 __index = function(t,k)
  if k == "targets" then
   local c = gmcp.Char.Status.city:gsub(" %(.*%)", "")
   if c == "Elvandar" then
    return {"a goblin conscript", "a troll mercenary", "a wily goblin fighter", "a Moredhel warrior", "a Moredhel battlemaster", "a savage troll warrior", "a vicious goblin warrior", "a veteran Krondorian warrior", "a Tsurani swordsman", "a Krondorian skirmisher", "a well%-armored Krondorian soldier",  "a captain of Krondor", "a Tsurani berserker", "a stout dwarven warrior"}
   elseif c == "Krondor" then
    return {"a warrior of Elvandar", "a master warrior of Elvandar", "an Eledhel ranger", "an Eledhel scout",  "an Eledhel commander", "an Eledhel scoutmaster", "a scarred Eledhel veteran", "a goblin conscript", "a troll mercenary", "a wily goblin fighter", "a Moredhel warrior", "a savage troll warrior", "a vicious goblin warrior", "a Moredhel battlemaster"}
   elseif c == "Sar-Sargoth" then
    return {"a veteran Krondorian warrior", "a Tsurani swordsman", "a Krondorian skirmisher", "a well%-armored Krondorian soldier",  "a captain of Krondor", "a Tsurani berserker", "a stout dwarven warrior", "a warrior of Elvandar", "a master warrior of Elvandar", "an Eledhel ranger", "an Eledhel scout",  "an Eledhel commander", "an Eledhel scoutmaster", "a scarred Eledhel veteran"}
   else
    return {"a veteran Krondorian warrior", "a Tsurani swordsman", "a Krondorian skirmisher", "a well%-armored Krondorian soldier",  "a captain of Krondor", "a Tsurani berserker", "a stout dwarven warrior", "a warrior of Elvandar", "a master warrior of Elvandar", "an Eledhel ranger", "an Eledhel scout",  "an Eledhel commander", "an Eledhel scoutmaster", "a scarred Eledhel veteran", "a goblin conscript", "a troll mercenary", "a wily goblin fighter", "a Moredhel warrior", "a savage troll warrior", "a vicious goblin warrior", "a Moredhel battlemaster"}
   end
  else
   return nil 
  end
 end
}
setmetatable(mtw.default.areas["Fort Dannis"], mt)

mtw.default.areas["Hush"] = {level = "Group", krondor = "distantly to the northwest", prime = {"urban"}}
local mt2 = {
 __index = function (t,k)
  if k == "targets" then
   local c = gmcp.Char.Status.city:gsub(" %(.*%)", "")
   if c == "Krondor" then
    return {"a Goblin Bloodraider", "a Black Slayer of the Northlands", "a Spellweaver Adept", "a Warder of the Queen%'s Guard", "an Elite Natalese Archer", "a High Ranger of the Free Cities"}
   elseif c == "Sar-Sargoth" then
    return {"a Royal Lancer of the West", "a Knight%-Captain of Krondor", "a Spellweaver Adept", "a Warder of the Queen%'s Guard", "an Elite Natalese Archer", "a High Ranger of the Free Cities"}
   elseif c == "Elvandar" then
    return {"a Goblin Bloodraider", "a Black Slayer of the Northlands", "a Royal Lancer of the West", "a Knight%-Captain of Krondor", "an Elite Natalese Archer", "a High Ranger of the Free Cities"}
   else
    return {"a Goblin Bloodraider", "a Black Slayer of the Northlands", "a Royal Lancer of the West", "a Knight%-Captain of Krondor", "a Spellweaver Adept", "a Warder of the Queen%'s Guard"}
   end
  else
   return nil
  end
 end
}
setmetatable(mtw.default.areas["Hush"], mt2)