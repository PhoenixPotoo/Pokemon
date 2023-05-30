///// @description Insert description here
//// You can write your code in this editor
instance_deactivate_all(true);

units = [];
turn = 0;
isYourTurn = true;


turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTarget = noone;

//enemy array
for(var i = 0; i < array_length(enemies); i++)
{
	enemyUnits[i] = instance_create_depth(x+170, y+50, depth-10, objBattleUnitEnemy, enemies[i])
	array_push(units, enemyUnits[i])
}

//our party
for(var i = 0; i < 1; i++)
{
	//global.playerParty[i].lvl = 2
	calcPartyPM(global.playerParty[i])
	partyUnits[i] = 
	instance_create_depth(x+20, y+80, depth-10, objBattleUnitPC, global.playerParty[i]);
	array_push(units, global.playerParty[i]);
}

instance_create_depth(x, y+144, -10, objMenu)

function BattleStateSelectAction()
{
	var _unit = isYourTurn ? partyUnits[0] : enemyUnits[0];
	var _target = isYourTurn ? enemyUnits[0] : partyUnits[0] ;

	if(!instance_exists(_unit) || _unit.hP <=0)
	{
		battleState = BattleStateVictoryCheck;
		exit;
	}
	if(isYourTurn)
	{
		objMenu.sprite_index = sprMoveSetMenu
	}
	else
	{
		move = irandom_range(0, (array_length(_unit.move) - 1)) //rng
		BeginAction(_unit.id, _unit.move[move], _target.id);
	}
}

function BeginAction(_user, _action, _target)
{
	currentUser = _user;
	currentAction = _action;
	currentTarget = _target;
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with(_user)
	{
		acting = true;
		if (!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
		{
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}	
	}
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	if(currentUser.acting)
	{
		if(currentUser.image_index >= currentUser.image_number - 1)
		{
			with(currentUser)
			{
				//sprite_index = sprites.idle; too lazy
				image_index = 0;
				acting = false;
			}
			currentAction.func(currentUser, currentAction, currentTarget);
			show_message(currentUser.name + ": "+ string(currentUser.hP) + "   " + currentTarget.name + ": " + string(currentTarget.hP))
		}
	}
	else
	{
		battleWaitTimeRemaining--;
		if(battleWaitTimeRemaining == 0 )
		{
			battleState = BattleStateVictoryCheck;
		}
	}
}

function BattleStateVictoryCheck()
{
	battleState = BattleStateTurnProgression;
}

function BattleStateTurnProgression()
{
	isYourTurn = not isYourTurn
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;