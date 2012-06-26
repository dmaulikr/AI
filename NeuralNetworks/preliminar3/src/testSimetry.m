function [success fail] = testSimetry(inputLength, ft)
	path = strcat('./patterns/SIMETRY/all_', num2str(inputLength));
	testSet = load(path);

	success = 0;
	fail = 0;

	for i = 1 : length(testSet)
		mu = testSet(i,1:inputLength);
		S_mu = testSet(i,inputLength+1);
		if(simetry(mu, ft) == S_mu)
			success++;
		else
			fail++;
		endif
	endfor

endfunction