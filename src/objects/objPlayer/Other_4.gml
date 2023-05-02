/// @description Insert description here
// You can write your code in this editor
if(instance_exists(objDataCarrier)){
	sprite_index = objDataCarrier.playerSprite
	instance_destroy(objDataCarrier)
}