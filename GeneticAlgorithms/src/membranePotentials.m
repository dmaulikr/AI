function hs= membranePotentials(input, net, g)

	input = normalizeInput(input);
	hs{1} = input;

	for i=1:length(net)
		input = [input -1];
		layer = net{i};
		hs{i+1} = [input * layer];
		input = g(input * layer);
	endfor

endfunction