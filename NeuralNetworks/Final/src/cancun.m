function [err_samples8 err_test] = cancun()
	ft = 'tanh';
	global activationFunction = ft;

	filename = 'weights/best_weights_tanh.mat';
	load(filename);

	samples8 = load('patterns/samples8.txt');

	g = getGAndGprima(ft){1};

	error = 0;
	for i = 1:rows(samples8)
		in = samples8(i,1:2);
		S = denormalizeOutput(samples8(i,3));
		o = denormalizeOutput(evalNet(in, w, g));
		error += 0.5*((S - o)^2);
	endfor

	printf("Error del conjunto conocido:\t %g\n", error/rows(samples8));

	test = load('patterns/Samples_8_G.txt');
	error = 0;
	for i = 1:rows(test)
		in = test(i,1:2);
		S = denormalizeOutput(test(i,3));
		o = denormalizeOutput(evalNet(in, w, g));
		error += 0.5*((S - o)^2);
	endfor

	printf("Error del conjunto dado:\t %g\n", error/rows(test));

endfunction
