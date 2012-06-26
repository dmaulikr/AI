function training(sMethod, sTrainingSet, f, err, eta)

	path = strcat('./trainingSets/', sMethod, '/', sTrainingSet);
	
	trainingSet = load(path);

	if(strcmp('AND', sMethod))
		nValue = 1;
	elseif(strcmp('OR', sMethod))
		nValue = -1;
	endif

	w = trainNet(trainingSet, nValue, f, err, eta);
	
	filename = strcat(tolower(sMethod),'Weights', f, '.mat');
	dlmwrite(filename, w);
	
endfunction
