function selection = rouletteSelection(population, fitnessVec, k)

	p = [];
	q = [];

	globalFitness = sum(fitnessVec);

	acum = 0;

	p = fitnessVec ./ globalFitness;
	q = cumsum(p);

	% No va más!

	selection = {};

	for i = 1:k
		r = rand();
		[maxAcum index] = max(r <= q(1:end) & r > [0 q(1:end-1)]);
		selection{length(selection) + 1} = population{index};
	endfor

endfunction