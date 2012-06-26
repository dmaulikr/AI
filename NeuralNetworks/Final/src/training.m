function [ret_epochs ret_errors] = training(netSize, sTrainingSet, ft, eta, min_err, max_epochs, print_errors, w, plott)

	inputLength = netSize(1);
	path = strcat('./patterns/', sTrainingSet, '.txt');

	trainingSet = load(path);

	g_gp = getGAndGprima(ft);

	w_new = w;

	[w epochs errors] = trainNet(trainingSet, netSize, g_gp{1}, g_gp{2}, eta, min_err, max_epochs, print_errors, w_new);
	w_new = createNet(netSize);

	ret_epochs = epochs;
	ret_errors = errors;

	filename = strcat('weights/best_weights.mat');
	save(filename, "w");

endfunction
