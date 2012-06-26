function ret = mixEliteRoulette(population, fitnessVec, k, ke)

	eliteSelected = elitismSelection(population, fitnessVec, ke);

	rouletteSelected = rouletteSelection(population, fitnessVec, k-ke);	

	ret = {eliteSelected{:} rouletteSelected{:}};

endfunction