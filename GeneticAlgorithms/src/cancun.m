function [err_samples8 err_test] = cancun()
	ft = 'tanh';
	global activationFunction = ft;

	filename = 'weights/BestPopulation.mat';
	load(filename);


	samples8 = load('patterns/samples8.txt');
	
	g_gp = getGAndGprima(ft);
	
	architecture = [2 1];

	v = [];
	bestFitness = 0;
	fitnessVec = [];

	for i=1:length(population)
		[fitnessVec(i) auxErr] = fitness(population{i}, samples8, g_gp{1}, architecture);
		if(bestFitness < fitnessVec(i))
			v = population{i};
		endif
	endfor

	printf("auxError: %g\n", auxErr);

	w = decodeNet(v, architecture);

	
	outputs = [];

	error = 0;
	for i = 1:rows(samples8)
		in = samples8(i,1:2);
		S = denormalizeOutput(samples8(i,3));
		o = denormalizeOutput(evalNet(in, w, g_gp{1}));
		error += 0.5*((S - o)^2);
		outputs(length(outputs)+1,:) = [in S o];
	endfor

	comp = outputs(:,3:4);
	comp = sortrows(comp, 1);
	plot(comp(:,1), comp(:,2), '*r');
	hold on
	plot(comp(:,1), comp(:,1));
	hold off;

	plot3(outputs(:,1), outputs(:,2), outputs(:,3), "o3");
	hold on;
	plot3(outputs(:,1), outputs(:,2), outputs(:,4), "o1");
	hold off;

	printf("Error del conjunto conocido:\t %g\n", error/rows(samples8));

	test = load('patterns/Samples_8_G.txt');
	error = 0;
	for i = 1:rows(test)
		in = test(i,1:2);
		S = denormalizeOutput(test(i,3));
		o = denormalizeOutput(evalNet(in, w, g_gp{1}));
		error += 0.5*((S - o)^2);
	endfor

	printf("Error del conjunto dado:\t %g\n", error/rows(test));

endfunction
