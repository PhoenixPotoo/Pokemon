///// @description Insert description here
//// You can write your code in this editor
instance_deactivate_all(true);

units = [];

//enemy array
for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+170, y+95, depth-10, objBattleUnitEnemy, enemies[i])
	array_push(units, enemyUnits[i])
}

//our party
for(var i = 0; i < 1; i++)
{
	partyUnits[i] = 
	instance_create_depth(x, y+155, depth-10, objBattleUnitPC, global.playerParty[i]);
	array_push(units, global.playerParty[i]);
}

//instance_deactivate_all(true)

//units = [];
//show_message("fosh");
// instance_create_depth(x+170, y+95, depth-10, objBattleUnit, enemies[0])
