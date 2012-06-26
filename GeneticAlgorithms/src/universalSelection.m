function ret = universalSelection(population, fitnessVec, k)

	p = [];
	q = [];

	globalFitness = sum(fitnessVec);

	p = fitnessVec ./ globalFitness;
	q = cumsum(p);

	% No va más!

	selection = {};

	r = rand();
	for i = 1:k
		ri = (r + i - 1)/k;
		[maxAcum index] = max(r <= q(1:end) & r > [0 q(1:end-1)]);
		selection{length(selection) + 1} = population{index};
	endfor

	ret = selection;

endfunction