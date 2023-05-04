/// @description Insert description here
// You can write your code in this editor
if(!instance_exists(objDataCarrier)){
	instance_create_depth(0, 0, 0, objDataCarrier)
	objDataCarrier.playerSprite = sprMayUp
	
	objDataCarrier.playerX = targetX //make this a universal variable to change at move line 22
	objDataCarrier.playerY = targetY
	
	objDataCarrier.playerX_pos = floor(objDataCarrier.playerX / tile_width);
	objDataCarrier.playerY_pos = floor(objDataCarrier.playerY / tile_height);
	
}
