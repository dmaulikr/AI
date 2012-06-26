function [ret_epochs ret_errors] = training(sMethod, netSize, sTrainingSet, ft, err, eta, max_epochs, print_errors, w, plott)

	inputLength = netSize(1);
	path = strcat('./patterns/', sMethod, '/', sTrainingSet, '_', num2str(inputLength));
	
	trainingSet = load(path);

	g_gp = getGAndGprima(ft);

	w_new = w;

	do
		[w epochs errors] = trainNet(trainingSet, netSize, g_gp{1}, g_gp{2}, err, eta, max_epochs, print_errors, w_new);
		w_new = createNet(netSize);
	until(epochs < max_epochs)

	ret_epochs = epochs;
	ret_errors = errors;


	filename = strcat('weights/', tolower(sMethod),'Weights', ft, '_', num2str(inputLength), '.mat');
	save(filename, "w");
	
endfunction
