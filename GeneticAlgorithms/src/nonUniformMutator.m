function ret = nonUniformMutator(individual, pm, c, gen, n)

	pot = gen/n;
	newPm = pm * c^pot;

	ret = classicMutator(individual, newPm);

endfunction