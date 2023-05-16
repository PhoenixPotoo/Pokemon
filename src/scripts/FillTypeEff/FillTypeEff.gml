// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FillTypeEff(){
	nor = global.types.normal
	fir = global.types.fire
	wat = global.types.water
	gra = global.types.grass
	ele = global.types.electric
	ice = global.types.ice
	fig = global.types.fighting
	poi = global.types.poison
	gro = global.types.ground
	fly = global.types.flying
	psy = global.types.psychic
	bug = global.types.bug
	roc = global.types.rock
	gho = global.types.ghost
	dra = global.types.dragon
	dar = global.types.dark
	ste = global.types.steel
	fai = global.types.fairy
	
	nor.sEffectiveAgainst = []
	nor.nEffectiveAgainst = [roc,  ste]
	nor.immuneTo = [gho]
	
	fir.sEffectiveAgainst = [ gra,  ice,  bug,  ste]
	fir.nEffectiveAgainst = [ fir,  wat,  roc,  dra]
	fir.immuneTo = []
	
	wat.sEffectiveAgainst = [ fir,  gro,  roc]
	wat.nEffectiveAgainst = [ wat,  gra,  dra]
	wat.immuneTo = []

	ele.sEffectiveAgainst = [ wat,  fly]
	ele.nEffectiveAgainst = [ gra,  ele,  dra]
	ele.immuneTo = []

	gra.sEffectiveAgainst = [ wat,  gro,  roc]
	gra.nEffectiveAgainst = [ fir,  gra,  poi,  fly,  bug,  dra,  ste]
	gra.immuneTo = []

	ice.sEffectiveAgainst = [ gra,  gro,  fly,  dra]
	ice.nEffectiveAgainst = [ fir,  wat,  ice,  ste]
	ice.immuneTo = []

	fig.sEffectiveAgainst = [ nor,  ice,  roc,  dar,  ste]
	fig.nEffectiveAgainst = [ poi,  fly,  psy, bug, fai]
	fig.immuneTo = []

	poi.sEffectiveAgainst = [gra, fai]
	poi.nEffectiveAgainst = [poi, gro, roc, gho]
	poi.immuneTo = []

	gro.sEffectiveAgainst = [fir, ele, poi, roc, ste]
	gro.nEffectiveAgainst = [gra, bug]
	gro.immuneTo = [ele]

	fly.sEffectiveAgainst = [gra, fig, bug]
	fly.nEffectiveAgainst = [ele, roc, ste]
	fly.immuneTo = [gro]

	psy.sEffectiveAgainst = [fig, poi]
	psy.nEffectiveAgainst = [psy, ste]
	psy.immuneTo = []

	bug.sEffectiveAgainst = [gra, psy, dar]
	bug.nEffectiveAgainst = [fir, fig, poi, fly, gho, ste, fai]
	bug.immuneTo = []

	roc.sEffectiveAgainst = [fir, ice, fly, bug]
	roc.nEffectiveAgainst = [fig, gro, ste]
	roc.immuneTo = []

	gho.sEffectiveAgainst = [psy, gho]
	gho.nEffectiveAgainst = [dar]
	gho.immuneTo = [nor, fig]

	dra.sEffectiveAgainst = [dra]
	dra.nEffectiveAgainst = [ste]
	dra.immuneTo = [fai]

	dar.sEffectiveAgainst = [psy, gho]
	dar.nEffectiveAgainst = [fig, dar, fai]
	dar.immuneTo = [psy]

	ste.sEffectiveAgainst = [ice, roc, fai]
	ste.nEffectiveAgainst = [fig, dra, dar]
	ste.immuneTo = []
	
	fai.sEffectiveAgainst = [fig, dra, dar]
	fai.nEffectiveAgainst = []
	fai.immuneTo = [dra]
	
	
}

