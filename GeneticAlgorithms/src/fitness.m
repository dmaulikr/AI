function [ret Err] = fitness(w_vec, patterns, g, arch);
	
	w = decodeNet(w_vec, arch);

	Err = 0;

	for i = 1:rows(patterns)
		in = patterns(i,1:2);
		S = denormalizeOutput(patterns(i,3));
		o = denormalizeOutput(evalNet(in, w, g));
		Err += 0.5*((S - o)^2);
	endfor

	Err = Err / rows(patterns);

	ret = 1/Err;

endfunction