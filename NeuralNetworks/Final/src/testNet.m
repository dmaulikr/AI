function ret = testNet(ft)

	g_gp = getGAndGprima(ft);

	k = 1;
	range = 8;
	step = 0.5;
	for i=-range:step:range
		for j=-range:step:range	
			input(k,:) = [i j];
			k++;
		endfor
	endfor

	filename = strcat('weights/weights_test1.mat');
	load(filename);

	inputLength = length(input);
	for i=1:inputLength
		ret(i) = evalNet(input(i,:), w, g_gp{1});
	endfor

	plot3(input(:,1), input(:,2), ret', "*b");
	hold on;

%	path = strcat('./patterns/samples8.txt');
%	trainingSet = load(path);
%	plot3(trainingSet(:,1), trainingSet(:,2), trainingSet(:,3), "*r");

endfunction