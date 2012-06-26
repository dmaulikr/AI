function ret = removeSpurious(net, Sf, pattern)

	epsilon = 0.2;
	N = length(Sf);

	do
		net = -(epsilon/N) .*Sf' * Sf + net;
		printf("Corrije!\n");
		fflush(stdout);
	until(!isequal(Sf, evaluate(net, pattern)));

	ret = net;

endfunction