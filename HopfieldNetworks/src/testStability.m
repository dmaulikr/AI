function ret = testStability(patterns, print)

	stablePatterns = 0;

	[net selectedPatterns] = createNet(patterns);

	for i=1:rows(selectedPatterns)
		if(isempty(find(crosstalk(selectedPatterns,i) >= 1)))
			stablePatterns++;
			if(print)
				printf("%s: ESTABLE\n", patterns(i){1});
			endif
		else
			if(print)
				printf("%s: NO ESTABLE\n", patterns(i){1});
			endif
		endif
	endfor

	ret = (stablePatterns == length(patterns));

endfunction