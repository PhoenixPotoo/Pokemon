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
		else if (encounter >= 30 and encounter <= 55) 
		{
		    return global.pokemonStats.wurmple;
		} 
		else 
		{
		    return global.pokemonStats.wurmple;
		}
	}
}