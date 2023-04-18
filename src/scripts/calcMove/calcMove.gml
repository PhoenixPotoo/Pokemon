// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function calcMove(){
	walk_anim_time += 1 / room_speed;
	
	var t = walk_anim_time / walk_anim_length;
	
	if(t >= 1){
	walk_anim_time = 0;
	t = 1;
	state = states.idle;
	}
	
	var _x = lerp(x_from, x_to, t);
	var _y = lerp(y_from, y_to, t);

	x = _x * tile_width;
	y = _y * tile_width;
	
	image_index = frames[floor((walk_anim_frames - 1) * t)]
}