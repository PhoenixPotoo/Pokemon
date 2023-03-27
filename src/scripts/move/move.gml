function move(){
	if (state == states.idle){
		x_from = x_pos;
		y_from = y_pos;
	
		y_to = y_pos;
		x_to = x_pos + 1;
	
		x_pos = x_to;
		y_pos = y_to;
	
		state = states.walking;
	}
}