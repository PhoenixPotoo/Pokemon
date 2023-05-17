///// @description Insert description here
//// You can write your code in this editor
//instance_deactivate_all(true);

//units = []

////enemy array
//for(var i = 0; i < array_length(enemies); i++)
//{
//	enemyUnits[i] = instance_create_depth(x+170, y+95, depth-10, objBattleUnit, {
//		name: "Zigzagoon",
//		baseHP: 38,
//		baseAtk: 30,
//		baseDef: 41,
//		baseSpAtk: 30,
//		baseSpDef: 41,
//		baseSpd: 60,
//		spr:
//		{
//			frontSprite: sprFront263,
//			backSprite: sprBack263
//		},
//		type: global.types.normal,
//		pokedexNum: 263,
//	});
//	array_push(units, enemyUnits[i]);
//}

////our party
//for(var i = 0; i < array_length(global.playerParty); i++)
//{
//	partyUnits[i] = instance_create_depth(x, y+143, depth-10, objBattleUnit, global.playerParty[i]);
//	array_push(units, global.playerParty[i]);
//}

instance_deactivate_all(true)

units = [];
show_message("fosh");
 instance_create_depth(x+170, y+95, depth-10, objBattleUnit, global.pokemonStats.zigzagoon)
