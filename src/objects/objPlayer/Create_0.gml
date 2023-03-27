/// @description making variables + state machine my favorite :DDD


enum states{
	idle,
	walking
}

state = states.idle;

x_pos = x div tile_width;
y_pos = y div tile_height;

x_from = x_pos;
y_from = y_pos;

x_to = x_pos;
y_to = y_pos;

walk_anim_length = 0.5;
walk_anim_time = 0;

