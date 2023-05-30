function NewEncounter(_enemies, _bg){
	instance_create_depth
	(camera_get_view_x(view_camera[0]),
	camera_get_view_y(view_camera[0]),
	-9999,
	objBattle,
	{enemies: _enemies, battleBackground: _bg});
	
}


function doDmg(_user, _action, _target)
{
	var dmg = ((((2*_user.lvl)/5) + 2) * _action.pow * (_user.atk / _target.def)) / 50
	_target.hP -= dmg
	show_message(_target.name)
	if(_target.hP < 0) 
	{
		_target.hP = 0
	}
}

function doStatChange(_user, _action, _target)
{	
	if(_action.isItForSelf)
	{
		switch(_action.stat)
		{
			case "def":
			{	
				_user.defStage += _action.stage
				multi = calcStageMultiplier(_user.defStage);
				_user.def = calcStat(_user.baseDef, _user.lvl) * multi
				break;
			}
			case "atk":
			{	
				_user.atkStage += _action.stage
				multi = calcStageMultiplier(_user.atkStage);
				_user.atk = calcStat(_user.baseAtk, _user.lvl) * multi
				break;
			}
			case "spd":
			{	
				_user.spdStage += _action.stage
				multi = calcStageMultiplier(_user.spdStage);
				_user.spd = calcStat(_user.baseSpd, _user.lvl) * multi
				break;
			}
		}
	}
	else
	{
		switch(_action.stat)
		{
			case "def":
			{	
				_target.defStage += _action.stage
				multi = calcStageMultiplier(_target.defStage);
				_target.def = calcStat(_target.baseDef, _target.lvl) * multi
				break;
			}
			case "atk":
			{	
				_target.atkStage += _action.stage
				multi = calcStageMultiplier(_target.atkStage);
				_target.atk = calcStat(_target.baseAtk, _target.lvl) * multi
				break;
			}
			case "spd":
			{	
				_target.spdStage += _action.stage
				multi = calcStageMultiplier(_target.spdStage);
				_target.spd = calcStat(_target.baseSpd, _target.lvl) * multi
				break;
			}
		
		}
	}
	
}

function calcStageMultiplier(stage)
{
	switch(stage)
	{
		case -6: return 1/4
		case -5: return 2/7
		case -4: return 1/3
		case -3: return 2/5
		case -2: return 1/2
		case -1: return 2/3
		case 0: return 1
		case 1: return 3/2
		case 2: return 2
		case 3: return 5/2
		case 4: return 3
		case 5: return 7/2
		case 6: return 4
		default:
		{
			if(stage > 6)
			{
				stage = 6
				return 1/4
			}
			if(stage < -6)
			{
				stage = -6
				return 4
			}
		}
	}
}