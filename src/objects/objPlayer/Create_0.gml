/// @description making variables + state machine my favorite :DDD


enum states{
	idle,
	walking,
	goingToLT,
	goingToPW,
	goingToP
}

state = states.idle;

x_pos = floor(x / tile_width);
y_pos = floor(y / tile_height);

x_from = x_pos;
y_from = y_pos;

x_to = x_pos;
y_to = y_pos;

walk_anim_length = 0.4;
walk_anim_time = 0;

image_speed = 0;
frames = [1, 0, 1, 2, 1]
walk_anim_frames = 5;
sprite[directions.right] = sprMayRight;
sprite[directions.left] = sprMayLeft;
sprite[directions.down] = sprMayDown;
sprite[directions.up] = sprMayUp;



image_index = 1