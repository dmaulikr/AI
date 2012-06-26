function w = geneticTraining()
	
	patterns = load('patterns/samples8.txt');

	ft = 'tanh';
	architecture = [2 4 2 1];
	populationSize = 20;
	% Probabilidad de mutacion
	pm = 0.001;
	% Probabilidad de crossover
	pc = 0.6;
	% Probabilidad de backpropagation
	pb = 0.1;
	% Gap generacional
	G=0.85;

	epochs = 1;
	generations=100;
	maxFitness=2000;
	fitnessTolerance=10e-5;
	structureTeamSize=5;

	% Stop conditions:
	% 1: Max generations.
	% 2: Optimal solution.
	% 3: Structure.
	% 4: Content.
	stopCondition=1;

	% SelectionTypes:
	% 1: Elitist
	% 2: Roulette
	% 3: Universal
	% 4: Boltzman
	% 5: Elitist + Roulette
	% 6: Elitist + Boltzman
	parentsSelection=1;
	substitutionSelection=1;

	g_gp = getGAndGprima(ft);

	population = createPopulation(populationSize, architecture);
	indLength = length(population{1});
	selectionSize = round(G*populationSize);
	finished = false;
	iter = 1;

	previousDreamTeam = {};
	dreamTeam = {};

	bestInd = [];

	plotFlag = true;

	do
		iter++;
		fitnessVec = [];

		previousBestFitness = 0;
		bestFitness = 0;
		bestError = 0;

		previousBestFitness = bestFitness;
		previousDreamTeam = dreamTeam;

		for i=1:populationSize
			[fitnessVec(i) auxErr] = fitness(population{i}, patterns, g_gp{1}, architecture);
			if(bestFitness < fitnessVec(i))
				bestError = auxErr;
				bestInd = population{i};
			endif
		endfor

		if(plotFlag)
			error = 0;
			outputs = [];
			for i = 1:rows(patterns)
				in = patterns(i,1:2);
				S = denormalizeOutput(patterns(i,3));
				o = denormalizeOutput(evalNet(in, decodeNet(bestInd, architecture), g_gp{1}));
				error += 0.5*((S - o)^2);
				outputs(length(outputs)+1,:) = [in S o];
			endfor

			plot3(outputs(:,1), outputs(:,2), outputs(:,3), "o3");
			hold on;
			plot3(outputs(:,1), outputs(:,2), outputs(:,4), "o1");
			hold off;
			drawnow;
		endif

		if(stopCondition == 3)
			dreamTeam = elitismSelection(population, fitnessVec, structureTeamSize);
		endif

		globalFitness = sum(fitnessVec)/populationSize;

		printf("GlobalFitness: %g, BestNet: Error: %g\n", globalFitness, bestError);
		fflush(stdout);

		if(parentsSelection == 1)
			selection = elitismSelection(population, fitnessVec, selectionSize);
		elseif(parentsSelection == 2)
			selection = rouletteSelection(population, fitnessVec, selectionSize);
		elseif(parentsSelection == 3)
			selection = universalSelection(population, fitnessVec, selectionSize);
		elseif(parentsSelection == 4)
			selection = boltzmanSelection(population, fitnessVec, selectionSize, iter);
		elseif(parentsSelection == 5)
			selection = mixEliteRoulette(population, fitnessVec, selectionSize, round(selectionSize/2));
		else
			selection = mixEliteBoltzman(population, fitnessVec, selectionSize, round(selectionSize/2), iter);
		endif
			
		children = {};

		for i=1:2:selectionSize
			if(i == selectionSize)
				children{i} = selection{i};
			elseif(rand() < pc)
				[sonLeft sonRight] = onePointCrossOver(selection{i}, selection{i+1});
				children{i} = sonLeft;
				children{i+1} = sonRight;
			else
				children{i} = selection{i};
				children{i+1} = selection{i+1};
			endif
		endfor

		for i=1:selectionSize
			if(rand() < pb)
				children{i} = backpropagation(children{i}, patterns, epochs, g_gp{1}, g_gp{2}, architecture);
			endif
			if(rand() < pm)
				% children{i} = nonUniformMutator(children{i}, pm, 0.1, iter, 2);
				children{i} = classicMutator(children{i}, pm);
			endif
		endfor


		all = {population{:} children{:}};

		allFitnessVec = [];
		for i=1:length(all)
			allFitnessVec(i) = fitness(all{i}, patterns, g_gp{1}, architecture);
		endfor

		if(substitutionSelection == 1)
			population = elitismSelection(all, allFitnessVec, populationSize);
		elseif(substitutionSelection == 2)
			population = rouletteSelection(all, allFitnessVec, populationSize);
		elseif(substitutionSelection == 3)
			population = universalSelection(all, allFitnessVec, populationSize);
		elseif(substitutionSelection == 4)
			population = boltzmanSelection(all, allFitnessVec, populationSize, iter);
		elseif(substitutionSelection == 5)
			population = mixEliteRoulette(all, allFitnessVec, populationSize, round(populationSize/2));
		else
			population = mixEliteBoltzman(all, allFitnessVec, populationSize, round(populationSize/2), iter);
		endif

		if(stopCondition == 1) 
			if(iter > generations)
				finished = true;
			endif
		elseif(stopCondition == 2)
			if(globalFitness > maxFitness)
				finished = true;
			endif
		elseif(stopCondition == 3) 
			if(iter > 2 && isequal(dreamTeam, previousDreamTeam))
				finished = true;
			endif
		else
			if(iter > 2 && abs(previousBestFitness - bestFitness) < fitnessTolerance)
				finished = true;
			endif
		endif

	until(finished)

	save("BestPopulation.mat", "population");

endfunction
