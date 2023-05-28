// starting up me party
global.types = 
{
	normal:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	fire:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	water:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	electric:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	grass:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	ice:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	fighting:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	poison:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	ground:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	flying:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	psychic:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	bug:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	rock:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	ghost:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	dragon:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	dark:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	steel:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	},
	
	fairy:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [],
		immuneTo: []
	}
	
}
FillTypeEff()
global.moves = 
{
	attacking: 
	{
		tackle:
			{
			name: "Tackle",
			pow: 50,	
			type: global.types.normal,
			pp: 35,
			isSpecial: false 
			},
		pound:
			{
			name: "Pound",
			pow: 40,
			type: global.types.normal,
			pp: 35,
			isSpecial: false 
			},
		poisonSting:
			{
			name: "Poison Sting",
			pow: 15,	
			type: global.types.poison,
			pp: 35,
			isSpecial: false
			},
		peck:
			{
			name: "Peck",
			pow: 35,
			type: global.types.flying,
			pp: 35,
			isSpecial: false
			},
		mudSlap:
			{
			name: "Mud Slap",
			pow: 20,	
			type: global.types.ground,
			pp: 10,
			isSpecial: false 
			},
		waterGun:
			{
			name: "Water Gun",
			pow: 40,	
			type: global.types.water,
			pp: 25,
			isSpecial: false 
			},
		scratch:
			{
			name: "Scratch",
			pow: 40,	
			type: global.types.normal,
			pp: 35,
			isSpecial: false 
			},
		ember:
			{
			name: "Ember",
			pow: 50,	
			type: global.types.normal,
			pp: 35,
			isSpecial: false 
			},
		quickAttack:
			{
			name: "Quick Attack",
			pow: 40,
			type: global.types.normal,
			pp: 30,
			isSpecial: false
			}
	},
	statChange:
		{
		tailWhip:
			{	
			name: "Tail Whip",
			stat: "def",
			stage: -1,
			pp: 30,
			isItForSelf: false 
			},
		leer:
			{	
			name: "Leer",
			stat: "def",
			stage: -1,
			pp: 30,
			isItForSelf: false 
			},
		growl:
			{	
			name: "Growl",
			stat: "atk",
			stage: -1,
			pp: 40,
			isItForSelf: false
			},
		stringShot:
			{	
			name: "String Shot",
			stat: "spd",
			stage: -2,
			pp: 40,
			isItForSelf: false
			},
		harden:
			{	
			name: "Harden",
			stat: "def",
			stage: 1,
			pp: 30,
			isItForSelf: true
			},	
		}
}

nor = global.types.normal
fir = global.types.fire
wat = global.types.water
gra = global.types.grass
ele = global.types.electric
ice = global.types.ice
fig = global.types.fighting
poi = global.types.poison
gro = global.types.ground
fly = global.types.flying
psy = global.types.psychic
bug = global.types.bug
roc = global.types.rock
gho = global.types.ghost
dra = global.types.dragon
dar = global.types.dark
ste = global.types.steel
fai = global.types.fairy

tackle = global.moves.attacking.tackle
pound = global.moves.attacking.pound
poisonSting = global.moves.attacking.poisonSting
peck = global.moves.attacking.peck
mudSlap = global.moves.attacking.mudSlap
waterGun = global.moves.attacking.waterGun
scratch = global.moves.attacking.scratch
ember = global.moves.attacking.ember
quickAttack = global.moves.attacking.quickAttack

leer = global.moves.statChange.leer
tailWhip = global.moves.statChange.tailWhip
growl = global.moves.statChange.growl
stringShot = global.moves.statChange.stringShot
harden = global.moves.statChange.harden

global.pokemonStats = 
{
	zigzagoon:
	{
		name: "Zigzagoon",
		baseHP: 38,
		maxHP: 38,
		baseAtk: 30,
		baseDef: 41,
		baseSpAtk: 30,
		baseSpDef: 41,
		baseSpd: 60,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront263,
			backSprite: sprBack263
		},
		type: [nor],
		pokedexNum: 263,
		moves: [tackle, growl, tailWhip]
	},
	treecko:
	{
		name: "Treecko",
		baseHP: 40,
		maxHP: 40,
		baseAtk: 45,
		baseDef: 35,
		baseSpAtk: 65,
		baseSpDef: 55,
		baseSpd: 70,
		lvl: 1,

		spr:
		{
			frontSprite: sprFront252,
			backSprite: sprBack252
		},
		type: [gra],
		pokedexNum: 252,
		moves: [pound, leer, quickAttack]
	},
	mudkip:
	{
		name: "Mudkip",
		baseHP: 50,
		maxHP: 50,
		baseAtk: 70,
		baseDef: 50,
		baseSpAtk: 50,
		baseSpDef: 50,
		baseSpd: 40,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront258,
			backSprite: sprBack258
		},
		type: [wat],
		pokedexNum: 258,
		moves: [tackle, growl, mudSlap]
	},
	torchic:
	{
		name: "Torchic",
		baseHP: 45,
		maxHP: 45,
		baseAtk: 60,
		baseDef: 40,
		baseSpAtk: 70,
		baseSpDef: 50,
		baseSpd: 45,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront255,
			backSprite: sprBack255
		},
		type: [fir],
		pokedexNum: 255,
		moves: [scratch, growl, ember]
	},
	wurmple:
	{
		name: "Wurmple",
		baseHP: 45,
		maxHP: 45,
		baseAtk: 45,
		baseDef: 35,
		baseSpAtk: 20,
		baseSpDef: 30,
		baseSpd: 20,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront265,
			backSprite: sprBack265
		},
		type: [bug],
		pokedexNum: 265,
		moves: [tackle, stringShot, poisonSting]
	},
	slakoth:
	{
		name: "Slakoth",
		baseHP: 60,
		maxHP: 60,
		baseAtk: 60,
		baseDef: 60,
		baseSpAtk: 35,
		baseSpDef: 35,
		baseSpd: 30,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront287,
			backSprite: sprBack287
		},
		type: [nor],
		pokedexNum: 287,
		moves: [scratch]
	},
	shroomish:
	{
		name: "Shroomish",
		baseHP: 60,
		maxHP: 46,
		baseAtk: 40,
		baseDef: 60,
		baseSpAtk: 40,
		baseSpDef: 60,
		baseSpd: 35,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront285,
			backSprite: sprBack285
		},
		type: [gra],
		pokedexNum: 285,
		moves: [tackle]
	},
	taillow:
	{
		name: "Taillow",
		baseHP: 40,
		maxHP: 40,
		baseAtk: 55,
		baseDef: 30,
		baseSpAtk: 30,
		baseSpDef: 30,
		baseSpd: 85,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront276,
			backSprite: sprBack276
		},
		type: [nor, fly],
		pokedexNum: 276,
		moves: [peck, growl, quickAttack]
	},
	silcoon:
	{
		name: "Silcoon",
		baseHP: 50,
		maxHP: 50,
		baseAtk: 35,
		baseDef: 55,
		baseSpAtk: 25,
		baseSpDef: 25,
		baseSpd: 15,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront266,
			backSprite: sprBack266
		},
		type: [bug],
		pokedexNum: 266,
		moves: [harden]
	},
	cascoon:
	{
		name: "Cascoon",
		baseHP: 50,
		maxHP: 50,
		baseAtk: 35,
		baseDef: 55,
		baseSpAtk: 25,
		baseSpDef: 25,
		baseSpd: 15,
		lvl: 1,
		spr:
		{
			frontSprite: sprFront268,
			backSprite: sprBack268
		},
		type: [bug],
		pokedexNum: 268,
		moves: [harden]
	}
}

slotOnePM = variable_clone(global.pokemonStats.mudkip)
global.playerParty = 
[
	slotOnePM,
	{},
	{},
	{},
	{},
	{}

]

global.enemyParty = 
[
	{},
	{},
	{},
	{},
	{},
	{}
]

global.petalburgWoodsWildPool = [global.pokemonStats.zigzagoon]