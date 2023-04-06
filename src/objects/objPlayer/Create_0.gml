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

walk_anim_length = 0.4;
walk_anim_time = 0;

image_speed = 0;
frames = [1, 0, 1, 2, 1]
walk_anim_frames = 5;
sprite[directions.right] = sprMayRight;
sprite[directions.left] = sprMayLeft;
sprite[directions.down] = sprMayDown;
sprite[directions.up] = sprMayUp;

var tile_layer = layer_get_id("Collisions");
tile_map = layer_tilemap_get_id(tile_layer);

image_index = 1