function ret = mixedSelection(population, fitnessVec, k, ke)

	[eliteSelected eliteNotSelected] = elitismSelection(population, fitnessVec, ke);

	[rouletteSelected rouletteNotSelected] = rouletteSelection(eliteNotSelected, fitnessVec, k-ke);	

	ret = {eliteSelected{:} rouletteSelection{:}};

endfunction