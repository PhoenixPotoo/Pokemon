if(state == states.walking){
	calcMove()
}

var collision_tile_layer = layer_get_id("Collisions");
collision_tile_map = layer_tilemap_get_id(collision_tile_layer);
var grass_tile_layer = layer_get_id("Grass");
grass_tile_map = layer_tilemap_get_id(grass_tile_layer);