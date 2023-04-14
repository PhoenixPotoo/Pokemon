function move(dir){
	var components = global.components[dir]; 
	var dx = components[0];
	var dy = components[1];

	if (state == states.idle){ //tile_map is holding tm for collisons
		if(x_pos == 12 and y_pos + dy == 18 and room_get_name(room) == "LittlerootTown"){
			room_goto(rooms.PokeLab)
			x_from = x_pos;
			y_from = y_pos;
	
			y_to = y_pos + dy;
			x_to = x_pos + dx;
	
			x_pos = x_to;
			y_pos = y_to;
			sprite_index = sprite[dir] //dir is the enum so this works
		}
		else if((x_to == 12 or x_to == 11) and y_pos + dy == 20 and room_get_name(room) == "PokeLab"){
			x_pos = 12
			y_pos = 19
			room_goto(rooms.LittlerootTown)
			x_to = 12
			y_to = 20
		}
		else{
			if !(tilemap_get(collision_tile_map, x_pos + dx, y_pos + dy)){
				x_from = x_pos;
				y_from = y_pos;
	
				y_to = y_pos + dy;
				x_to = x_pos + dx;
	
				x_pos = x_to;
				y_pos = y_to;
				sprite_index = sprite[dir] //dir is the enum so this works
			}
		}
		state = states.walking;
		}
		
	
	}
	
