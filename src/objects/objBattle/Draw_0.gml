/// @description Insert description here
// You can write your code in this editor
draw_sprite(battleBackground, 0, x, y);

//var _unitWithCurrentTurn = instance_id_get(unitTurnOrder[turn]);
//for(var i = 0; i < array_length(unitRenderOrder); i++){
//	show_message(unitRenderOrder[i].name)
//	with(unitRenderOrder[i])
//	{
//		draw_self();
//	}
//}

draw_sprite_stretched(sprTextMenu, 0, x, y+144, 480, 130);
draw_sprite_stretched(sprEnemyInfoMenu, 0, x+5, y+20, 100, 20);
draw_sprite_stretched(sprPartyInfoMenu, 0, x+140, y+100, 100, 30);

#macro X_ENEMY_NAME 10
#macro Y_ENEMY_NAME 24

#macro X_ENEMY_LV 80
#macro Y_PARTY_NAME 105
#macro X_PARTY_NAME 153
#macro X_PARTY_LV 220
#macro Y_PARTY_HP 120
#macro X_PARTY_HP 210
#macro Y_BATTLE_TEXT 160
#macro X_BATTLE_TEXT 13

pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?./ 0123456789", true, 0)
draw_set_font(pixelFont)
writeText(x+X_ENEMY_NAME, y+Y_ENEMY_NAME, enemyUnits[0].name)
writeText(x+X_PARTY_NAME, y+Y_PARTY_NAME, global.playerParty[0].name)
enemyLvl = "Lv" + string(enemyUnits[0].lvl)
writeText(x+X_ENEMY_LV, y+Y_ENEMY_NAME, enemyLvl)
partyLvl = "Lv" + string(global.playerParty[0].lvl)
writeText(x+X_PARTY_LV, y+Y_PARTY_NAME, partyLvl)
//partyHP = global.playerParty[0].baseHP
//writeText(x+X_PARTY_HP, y+Y_PARTY_HP, )




