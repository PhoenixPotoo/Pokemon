#macro X_ENEMY_NAME 10
#macro Y_ENEMY_NAME 24
#macro X_ENEMY_LV 80
#macro Y_PARTY_NAME 105
#macro X_PARTY_NAME 153
#macro X_PARTY_LV 220
#macro Y_PARTY_HP 119
#macro X_PARTY_HP 210
#macro X_PARTY_HP_BAR 192
#macro Y_PARTY_HP_BAR 114
#macro Y_ENEMY_HP_BAR 33
#macro X_ENEMY_HP_BAR 50
#macro Y_BATTLE_TEXT 160
#macro X_BATTLE_TEXT 13


draw_sprite(battleBackground, 0, x, y);
hpPartyPosition = (partyUnits[0].hP <= 0) ? 0 : ceil(((partyUnits[0].hP / partyUnits[0].maxHP) * 32) - 1)
draw_sprite_stretched(sprHealthBar, hpPartyPosition, x+X_PARTY_HP_BAR, y+Y_PARTY_HP_BAR, 39, 2);

hpEnemyPosition = (enemyUnits[0].hP <= 0) ? 0 : ceil(((enemyUnits[0].hP / enemyUnits[0].maxHP) * 32) - 1)
draw_sprite_stretched(sprHealthBar, hpEnemyPosition, x+X_ENEMY_HP_BAR, y+Y_ENEMY_HP_BAR, 39, 2);

//draw_sprite_stretched(sprMoveSetMenu, 0, x, y+144, 240, 66);
draw_sprite_stretched(sprEnemyInfoMenu, 0, x+5, y+20, 100, 20);
draw_sprite_stretched(sprPartyInfoMenu, 0, x+140, y+100, 100, 30);


pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?./ 0123456789", true, 0)
draw_set_font(pixelFont)
writeText(x+X_ENEMY_NAME, y+Y_ENEMY_NAME, enemyUnits[0].name)
writeText(x+X_PARTY_NAME, y+Y_PARTY_NAME, partyUnits[0].name)
enemyLvl = "Lv" + string(enemyUnits[0].lvl)
writeText(x+X_ENEMY_LV, y+Y_ENEMY_NAME, enemyLvl)
partyLvl = "Lv" + string(partyUnits[0].lvl)
writeText(x+X_PARTY_LV, y+Y_PARTY_NAME, partyLvl)
partyHP = string(ceil(partyUnits[0].hP)) + "/" + string(partyUnits[0].maxHP)
writeText(x+X_PARTY_HP, y+Y_PARTY_HP, partyHP)






