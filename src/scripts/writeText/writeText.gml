// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function writeText(x, y, text){
draw_text_ext_transformed(x, y, string_upper(text), 0, 200, 0.8, 0.8, 0);
}
function writeBigText(x, y, text){
draw_text_ext_transformed(x, y, string_upper(text), 0, 200, 1.5, 1.5, 0);
}

global.currentFrame = 0
global.totalFrame = 10
global.currentLetter = 0
global.finished = false
function drawTextSeq(x, y, text)
{
	displayText = ""
	if(global.currentLetter <= string_length(text) && !global.finished) 
	{
    global.currentFrame = global.currentFrame + 1
	}
	else
	{
	global.finished = true
	}
    if (global.currentFrame >= global.totalFrame) 
	{
        global.currentFrame = 0;
        displayText += string_char_at(text, global.currentLetter);
        global.currentLetter++;
		pixelFont = font_add_sprite_ext(sprTextUpper, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!?./ 0123456789", true, 0)
		draw_set_font(pixelFont)
		draw_text_ext_transformed(x + 13, y + 160, string_upper("fish"), 0, 6, 0.8, 0.8, 0);
    }
}
