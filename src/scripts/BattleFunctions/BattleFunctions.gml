function NewEncounter(_enemies, _bg){
	show_message(_enemies)
	instance_create_depth
	(camera_get_view_x(view_camera[0]),
	camera_get_view_y(view_camera[0]),
	-9999,
	objBattle,
	{enemies: _enemies, battleBackground: _bg});
	
}