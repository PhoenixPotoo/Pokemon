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
draw_sprite_stretched(sprEnemyInfoMenu, 0, x+5, y+10, 100, 24);
draw_sprite_stretched(sprPartyInfoMenu, 0, x+140, y+114, 100, 30);



pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.! ", true, 1)
draw_set_font(pixelFont)
draw_text(x+100, y+100, "fish")

