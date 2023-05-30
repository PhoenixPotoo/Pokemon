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

function calcPM()
{
	gendPM = variable_clone(GenNewWildPM())
	lvl = irandom_range(5, 6)
	gendPM.lvl = lvl
	//hp, atk, def, spAtk, spDef, spd
	gendPM.hP = calcHPStat(gendPM.baseHP, lvl)
	gendPM.maxHP = calcHPStat(gendPM.baseHP, lvl)
	gendPM.atk = calcStat(gendPM.baseAtk, lvl)
	gendPM.def = calcStat(gendPM.baseDef, lvl)
	gendPM.spAtk = calcStat(gendPM.baseSpAtk, lvl)
	gendPM.spDef = calcStat(gendPM.baseSpDef, lvl)
	gendPM.spd = calcStat(gendPM.baseSpd, lvl)
	gendPM.defStage = 0;
	gendPM.atkStage = 0;
	gendPM.spdStage = 0;
	
	return gendPM
}

function calcPartyPM(pokemon)
{
	gendPM = pokemon
	lvl = pokemon.lvl

	//hp, atk, def, spAtk, spDef, spd
	gendPM.hP = calcHPStat(gendPM.baseHP, lvl)
	gendPM.maxHP = calcHPStat(gendPM.baseHP, lvl)
	gendPM.atk = calcStat(gendPM.baseAtk, lvl)
	gendPM.def = calcStat(gendPM.baseDef, lvl)
	gendPM.spAtk = calcStat(gendPM.baseSpAtk, lvl)
	gendPM.spDef = calcStat(gendPM.baseSpDef, lvl)
	gendPM.spd = calcStat(gendPM.baseSpd, lvl)
	gendPM.defStage = 0;
	gendPM.atkStage = 0;
	gendPM.spdStage = 0;
	
	return gendPM
}

function calcStat(baseStat, lvl){
	return ceil((((2*baseStat + 5) * lvl)/100) + 5)
}

function calcHPStat(baseStat, lvl){
	return ceil((((2*baseStat + 5) * lvl)/100) + lvl + 10)
}