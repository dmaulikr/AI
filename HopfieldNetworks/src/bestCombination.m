function best = bestCombination()

	[allPatterns namesMap] = getAllPatterns();

	sets = {};

	indexes = 1:rows(allPatterns);

	best = {};

	% Se comienza con conjuntos de 5 patrones porque ya se ha encontrado
	% un conjunto estable con 5 patrones.
	for k = 8:rows(allPatterns)
		found = false;
		% Todas las combinaciones de k patterns
		comb = nchoosek(indexes,k);
		for i = 1:rows(comb)
			set = {};
			for j = 1:columns(comb)
				set = {set{} namesMap{comb(i,j)}};
			endfor
			if(testStability(set, false))
				best = set;
				found = true;
				printf("Nuevo best de tamaño %d\n", k);
				disp(set);
			else
				printf("no estable\n");
			endif
			fflush(stdout);
		endfor
		
		% Si no encuentra de tamaño k, menos va a encontrar de k+1
		if(!found)
			break;
		endif;
			
	endfor



endfunction