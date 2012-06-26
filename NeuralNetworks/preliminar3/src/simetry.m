function ret = simetry(input, ft)

	g_gp = getGAndGprima(ft);
	inputLength = length(input);
	filename = strcat('weights/simetryWeights', ft, '_', num2str(inputLength), '.mat');
	load(filename);

	ret = evalNet(input, w, g_gp{1});

endfunction