/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 2CE751A8
/// @DnDArgument : "code" "///// @description Insert description here$(13_10)//// You can write your code in this editor$(13_10)instance_deactivate_all(true);$(13_10)$(13_10)units = [];$(13_10)turn = 0;$(13_10)unitTurnOrder = [];$(13_10)unitRenderOrder = [];$(13_10)$(13_10)//enemy array$(13_10)for(var i = 0; i < array_length(enemies); i++)$(13_10){$(13_10)	enemyUnits[i] = instance_create_depth(x+170, y+50, depth-10, objBattleUnitEnemy, enemies[i])$(13_10)	array_push(units, enemyUnits[i])$(13_10)}$(13_10)$(13_10)//our party$(13_10)for(var i = 0; i < 1; i++)$(13_10){$(13_10)	partyUnits[i] = $(13_10)	instance_create_depth(x+20, y+80, depth-10, objBattleUnitPC, global.playerParty[i]);$(13_10)	array_push(units, global.playerParty[i]);$(13_10)}$(13_10)////shuffle$(13_10)//unitTurnOrder = array_shuffle(units);$(13_10)$(13_10)////render order$(13_10)//RefreshRenderOrder = function()$(13_10)//{$(13_10)//	unitRenderOrder = [];$(13_10)//	array_copy(unitRenderOrder, 0, units, 0, array_length(units));$(13_10)//	array_sort(unitRenderOrder, true)$(13_10)//}$(13_10)//RefreshRenderOrder();$(13_10)$(13_10)//for(var i = 0; i < array_length(units); i++)$(13_10)//{$(13_10)//show_message(unitRenderOrder[i].name)$(13_10)//}$(13_10)$(13_10)"
///// @description Insert description here
//// You can write your code in this editor
instance_deactivate_all(true);

units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

//enemy array
for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+170, y+50, depth-10, objBattleUnitEnemy, enemies[i])
	array_push(units, enemyUnits[i])
}

//our party
for(var i = 0; i < 1; i++)
{
	partyUnits[i] = 
	instance_create_depth(x+20, y+80, depth-10, objBattleUnitPC, global.playerParty[i]);
	array_push(units, global.playerParty[i]);
}
////shuffle
//unitTurnOrder = array_shuffle(units);

////render order
//RefreshRenderOrder = function()
//{
//	unitRenderOrder = [];
//	array_copy(unitRenderOrder, 0, units, 0, array_length(units));
//	array_sort(unitRenderOrder, true)
//}
//RefreshRenderOrder();

//for(var i = 0; i < array_length(units); i++)
//{
//show_message(unitRenderOrder[i].name)
//}