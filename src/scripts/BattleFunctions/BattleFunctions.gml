function NewEncounter(_enemies, _bg){
	instance_create_depth
	(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-99999,
		objBattleHandler,
		{
			enemies: _enemies,
			battleBackground: _bg
			
		}
	);
}