/// @description Insert description here
// You can write your code in this editor
//instance_deactivate_all(true);

units = []

//enemy array
for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+170, y+95, depth-10, objBattleUnit, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//our party
for(var i = 0; i < array_length(global.playerParty); i++)
{
	partyUnits[i] = instance_create_depth(0, 143, depth-10, objBattleUnit, global.playerParty[i]);
	array_push(units, global.playerParty[i]);
}
