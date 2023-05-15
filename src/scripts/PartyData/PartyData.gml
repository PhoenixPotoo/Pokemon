// starting up me party

global.playerParty = 
[
	{},
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
		frontSprite: sprFront263,
		backSprite: sprBack263,
		type: "",
		pokedexNum: 263,
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

global.types = 
{
	normal:
	{
		sEffectiveAgainst: [],
		nEffectiveAgainst: [ roc,  ste],
		immuneTo: []
	},
	
	fir:
	{
		sEffectiveAgainst: [ gra,  ice,  bug,  ste],
		nEffectiveAgainst: [ fir,  wat,  roc,  dra],
		immuneTo: []
	},
	
	wat:
	{
		sEffectiveAgainst: [ fir,  gro,  roc],
		nEffectiveAgainst: [ wat,  gra,  dra],
		immuneTo: []
	},
	
	ele:
	{
		sEffectiveAgainst: [ wat,  fly],
		nEffectiveAgainst: [ gra,  ele,  dra],
		immuneTo: []
	},
	
	gra:
	{
		sEffectiveAgainst: [ wat,  gro,  roc],
		nEffectiveAgainst: [ fir,  gra,  poi,  fly,  bug,  dra,  ste],
		immuneTo: []
	},
	
	ice:
	{
		sEffectiveAgainst: [ gra,  gro,  fly,  dra],
		nEffectiveAgainst: [ fir.  wat,  ice,  ste],
		immuneTo: []
	},
	
	fig:
	{
		sEffectiveAgainst: [ nor,  ice,  roc,  dar,  ste],
		nEffectiveAgainst: [ poi,  fly,  psy, ],
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