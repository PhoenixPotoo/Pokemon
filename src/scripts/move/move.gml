function move(dir){
	var components = global.components[dir]; 
	var dx = components[0];
	var dy = components[1];
	
	if (state == states.idle){
		if !(tilemap_get(tile_map, x_pos + dx, y_pos + dy)){
			x_from = x_pos;
			y_from = y_pos;
	
			y_to = y_pos + dy;
			x_to = x_pos + dx;
	
			x_pos = x_to;
			y_pos = y_to;
	
			state = states.walking;
		}
		sprite_index = sprite[dir]
	}
	
	if(x_pos + dx == 12  and y_pos + dy == 18){
		room_goto(rooms.PokeLab)
	}
}