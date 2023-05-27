/// @description Insert description here
// You can write your code in this editor
pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.! ", true, 1)
draw_set_font(pixelFont)
text = string(mouse_x) + " " + string(mouse_y)
draw_text(x+10, y+10, "fish")