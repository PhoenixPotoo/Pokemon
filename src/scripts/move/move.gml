function move(dir){
	var components = global.components[dir]; 
	var dx = components[0];
	var dy = components[1];

	if (state == states.idle){ //tile_map is holding tm for collisons
		if !(tilemap_get(collision_tile_map, x_pos + dx, y_pos + dy)){
			x_from = x_pos;
			y_from = y_pos;
	
			y_to = y_pos + dy;
			x_to = x_pos + dx;
	
			x_pos = x_to;
			y_pos = y_to;
			
			if(x_to == 12  and y_to == 18 and room_get_name(room) == "LittlerootTown"){
				room_goto(rooms.PokeLab)
				instance_create_layer(192, 304, "People", objPlayer)
			}
			if(x_to == 12  and y_to == 20 and room_get_name(room) == "PokeLab"){
				room_goto(rooms.LittlerootTown)
			}
			state = states.walking;
		}
		sprite_index = sprite[dir] //dir is the enum so this works
	
	}
	
}