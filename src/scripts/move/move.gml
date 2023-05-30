function Move(dir){
	var components = global.components[dir]; 
	var dx = components[0];
	var dy = components[1];
	collision_tile_layer = layer_get_id("Collisions");
	collision_tile_map = layer_tilemap_get_id(collision_tile_layer);
	grass_tile_layer = layer_get_id("Grass");
	grass_tile_map = layer_tilemap_get_id(grass_tile_layer);

	switch(state)
	{
		case states.idle:
			// get to battling
			if(tilemap_get(grass_tile_map, x_pos, y_pos)){
				randomize()
				encounter = irandom_range(1, 10) //rng
				if (encounter == 1 and !justEncountered){
					justEncountered = true
					state = states.battling
					NewEncounter([calcPM()], sprBattleBG)
				}
			}
			//movement/doors
			if !(tilemap_get(collision_tile_map, x_pos + dx, y_pos + dy)) and state != states.battling{
				justEncountered = false
				x_from = x_pos;
				y_from = y_pos;
	
				y_to = y_pos + dy;
				x_to = x_pos + dx;
	
				x_pos = x_to;
				y_pos = y_to;
			
				//from town to poke lab
				if(x_to == 12 and y_to == 18 and room_get_name(room) == "LittlerootTown"){
					targetX = 192
					targetY = 304
					room_goto(rooms.PokeLab)
				}
			
				//from town to route 1
				if(y_to == -1 and room_get_name(room) == "LittlerootTown"){
					targetY = 688
					if (x_to == 15){targetX = 256}
					if (x_to == 16){targetX = 272}
					room_goto(rooms.PetalburgWoods)
				}
			
				//from route 1 back to town
				if(y_to == 44 and room_get_name(room) == "PetalburgWoods"){
					targetY = 0
					if (x_to == 17){targetX = 256}
					if (x_to == 16){targetX = 240}
					room_goto(rooms.LittlerootTown)
				}
			
				//from poke lab back to town
				if((x_to == 12 or x_to == 11) and y_to == 20 and room_get_name(room) == "PokeLab"){
					targetX = 192
					targetY = 304
					room_goto(rooms.LittlerootTown)
				}
				state = states.walking;
		
			}
			sprite_index = sprite[dir] //dir is the enum so this works
			break;
		case states.battling:
			show_message("encountered!!!")
			show_message("you won cool ong fr ")
			state = states.idle
			break;
	}
	
}