function ret = mixEliteBoltz(population, fitnessVec, k, ke, generation)

	eliteSelected = elitismSelection(population, fitnessVec, ke);

	boltzSelected  = boltzmanSelection(population, fitnessVec, k-ke, generation);	

	ret = {eliteSelected{:} boltzSelected{:}};

endfunction