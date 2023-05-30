/// @description Insert description here
// You can write your code in this editor
draw_self()
pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?./ 0123456789", true, 0)
draw_set_font(pixelFont)
writeBigText(x, y, moves[2].name)
