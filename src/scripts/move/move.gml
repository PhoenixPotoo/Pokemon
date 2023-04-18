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
				state = states.goingToP
				room_goto(rooms.PokeLab)
			}
			if(x_to == 12  and y_to == 20 and room_get_name(room) == "PokeLab"){
				state = states.goingToLT
				room_goto(rooms.LittlerootTown)
			}
			if(x_to == 16 and y_to < 0 and room_get_name(room) == "LittlerootTown"){
				state = states.goingToPW
				room_goto(rooms.PetalburgWoods)
				x = 272
				y = 688
				x_from = 17
				y_from = 43
				x_pos = 17
				y_pos = 43
				x_to = 17
				y_to = 43
			}
			if(x_to == 15 and y_to < 0 and room_get_name(room) == "LittlerootTown"){
				room_goto(rooms.PetalburgWoods)
				x = 272
				y = 688
				x_from = 16
				y_from = 43
				x_pos = 16
				y_pos = 43
				x_to = 16
				y_to = 43
			}
			switch(state){
				case states.goingToLT:
				break;
				case states.goingToP:
				break;
				case states.goingToPW:
				break;
				case states.idle:
			}
			state = states.walking;
		}
		sprite_index = sprite[dir] //dir is the enum so this works
	
	}
	
}