function [success fail] = testParity(inputLength, ft)
	path = strcat('./patterns/PARITY/all_', num2str(inputLength));
	testSet = load(path);

	success = 0;
	fail = 0;

	for i = 1 : length(testSet)
		mu = testSet(i,1:inputLength);
		S_mu = testSet(i,inputLength+1);
		if(parity(mu, ft) == S_mu)
			success++;
		else
			disp(mu);
			fail++;
		endif
	endfor

endfunction