function ret = evalNet(input, net, g)

	input = normalizeInput(input);

	for i=1:length(net) 	
		input = [input -1];
		layer = net{i};
		input = g(input * layer);
	endfor

	ret = normalizeOutput(input);
endfunction