function ret = createHopfieldNet(patterns)

	ret = (1/columns(patterns))*(patterns'*patterns);

	ret = ret - diag(ones(rows(ret),1)).*ret;
	
endfunction