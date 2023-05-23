// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GenNewWildPM()
{
	
	if(room_get_name(room) == "PetalburgWoods")
	{
		randomize()
		encounter = irandom_range(1, 100)
		if (encounter <= 30) 
		{
			return global.pokemonStats.zigzagoon;
		} 
		else if (encounter > 30 and encounter <= 55) 
		{
		    return global.pokemonStats.wurmple;
		}
		else if (encounter > 55 and encounter <= 60) 
		{
		    return global.pokemonStats.slakoth;
		}
		else if (encounter > 60 and encounter <= 75) 
		{
		    return global.pokemonStats.shroomish;
		}
		else if (encounter > 75 and encounter <= 80) 
		{
		    return global.pokemonStats.taillow;
		}
		else if (encounter > 80 and encounter <= 90) 
		{
		    return global.pokemonStats.silcoon;
		}
		else if (encounter > 90 and encounter <= 100) 
		{
		    return global.pokemonStats.cascoon;
		}
		else 
		{
		    return global.pokemonStats.shroomish;
		}
	}
}