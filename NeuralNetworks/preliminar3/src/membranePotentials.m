function hs= membranePotentials(input, net, f)

	hs{1} = input;

	for i=1:length(net)
		input = [input -1];
		layer = net{i};
		hs{i+1} = [input * layer];
		input = feval(f, input * layer);
	endfor

endfunction