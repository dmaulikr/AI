function ret = boltzmanSelection(population, fitnessVec, k, generation)

	p = [];
	q = [];

	globalFitness = sum(fitnessVec);


	meanAux = zeros(size(fitnessVec));

	for i=1:generation
		meanAux = meanAux .+ exp(fitnessVec/temperature(i));
	endfor

	meanAux /= generation;

	expVal = exp(-fitnessVec / temperature(generation)) ./meanAux;

	p = expVal / sum(expVal);
	q = cumsum(p);

	% No va más!

	selection = {};

	for i = 1:k
		r = rand();
		[maxAcum index] = max(r <= q(1:end) & r > [0 q(1:end-1)]);
		selection{length(selection) + 1} = population{index};
	endfor

	ret = selection;

endfunction