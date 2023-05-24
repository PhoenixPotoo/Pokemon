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
global.pokemonStats = 
{
	zigzagoon:
	{
		name: "Zigzagoon",
		baseHP: 38,
		baseAtk: 30,
		baseDef: 41,
		baseSpAtk: 30,
		baseSpDef: 41,
		baseSpd: 60,
		spr:
		{
			frontSprite: sprFront263,
			backSprite: sprBack263
		},
		type: [global.types.normal],
		pokedexNum: 263,
	},
	treecko:
	{
		name: "Treecko",
		baseHP: 40,
		baseAtk: 45,
		baseDef: 35,
		baseSpAtk: 65,
		baseSpDef: 55,
		baseSpd: 70,
		spr:
		{
			frontSprite: sprFront252,
			backSprite: sprBack252
		},
		type: [global.types.grass],
		pokedexNum: 252,
	},
	mudkip:
	{
		name: "Mudkip",
		baseHP: 50,
		baseAtk: 70,
		baseDef: 50,
		baseSpAtk: 50,
		baseSpDef: 50,
		baseSpd: 40,
		spr:
		{
			frontSprite: sprFront258,
			backSprite: sprBack258
		},
		type: [global.types.water],
		pokedexNum: 258,
	},
	torchic:
	{
		name: "Torchic",
		baseHP: 45,
		baseAtk: 60,
		baseDef: 40,
		baseSpAtk: 70,
		baseSpDef: 50,
		baseSpd: 45,
		spr:
		{
			frontSprite: sprFront255,
			backSprite: sprBack255
		},
		type: [global.types.fire],
		pokedexNum: 255,
	},
	wurmple:
	{
		name: "Wurmple",
		baseHP: 45,
		baseAtk: 45,
		baseDef: 35,
		baseSpAtk: 20,
		baseSpDef: 30,
		baseSpd: 20,
		spr:
		{
			frontSprite: sprFront265,
			backSprite: sprBack265
		},
		type: [global.types.bug],
		pokedexNum: 265,
	},
	slakoth:
	{
		name: "Slakoth",
		baseHP: 60,
		baseAtk: 60,
		baseDef: 60,
		baseSpAtk: 35,
		baseSpDef: 35,
		baseSpd: 30,
		spr:
		{
			frontSprite: sprFront287,
			backSprite: sprBack287
		},
		type: [global.types.normal],
		pokedexNum: 287,
	},
	shroomish:
	{
		name: "Shroomish",
		baseHP: 60,
		baseAtk: 40,
		baseDef: 60,
		baseSpAtk: 40,
		baseSpDef: 60,
		baseSpd: 35,
		spr:
		{
			frontSprite: sprFront285,
			backSprite: sprBack285
		},
		type: [global.types.grass],
		pokedexNum: 285,
	},
	taillow:
	{
		name: "Taillow",
		baseHP: 40,
		baseAtk: 55,
		baseDef: 30,
		baseSpAtk: 30,
		baseSpDef: 30,
		baseSpd: 85,
		spr:
		{
			frontSprite: sprFront276,
			backSprite: sprBack276
		},
		type: [global.types.normal, global.types.flying],
		pokedexNum: 276,
	},
	silcoon:
	{
		name: "Silcoon",
		baseHP: 50,
		baseAtk: 35,
		baseDef: 55,
		baseSpAtk: 25,
		baseSpDef: 25,
		baseSpd: 15,
		spr:
		{
			frontSprite: sprFront266,
			backSprite: sprBack266
		},
		type: [global.types.bug],
		pokedexNum: 266,
	},
	cascoon:
	{
		name: "Cascoon",
		baseHP: 50,
		baseAtk: 35,
		baseDef: 55,
		baseSpAtk: 25,
		baseSpDef: 25,
		baseSpd: 15,
		spr:
		{
			frontSprite: sprFront268,
			backSprite: sprBack268
		},
		type: [global.types.bug],
		pokedexNum: 268,
	}
}

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
		tackle:
			{
			name: "Tackle",
			pow: 50,	
			type: global.types.normal,
			pp: 35,
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

global.playerParty = 
[
	global.pokemonStats.mudkip,
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