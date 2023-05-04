/// @description Insert description here
// You can write your code in this editor
if(instance_exists(objDataCarrier)){
	sprite_index = objDataCarrier.playerSprite
	x = objDataCarrier.playerX
	y = objDataCarrier.playerY
	
	x_pos = objDataCarrier.playerX_pos;
	y_pos = objDataCarrier.playerY_pos;

	x_from = x_pos;
	y_from = y_pos;

	x_to = x_pos;
	y_to = y_pos;
	instance_destroy(objDataCarrier)
}