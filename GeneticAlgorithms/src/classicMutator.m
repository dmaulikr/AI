function ret = classicMutator(individual, pm)

	pNormalized = pm / 100;

	for i=1:length(individual)
		if(rand() < pNormalized)
			individual(i) = individual(i) * 1.1;
		endif
	endfor

	ret = individual;

endfunction