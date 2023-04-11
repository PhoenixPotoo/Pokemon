gml_pragma("global", "MACRO()");
#macro tile_width 16
#macro tile_height 16

enum directions{
	right,
	left,
	up,
	down
}

enum rooms{
	LittlerootTown,
	PokeLab,
	PetalburgWoods
}

global.components = [];
global.components[directions.right] = [1, 0];
global.components[directions.left] = [-1, 0];
global.components[directions.down] = [0, 1];
global.components[directions.up] = [0, -1];



