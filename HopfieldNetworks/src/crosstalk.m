function ret = crosstalk(patterns, v)

	ret = zeros(1, columns(patterns));
	for i=1:columns(patterns)
		for u=1:rows(patterns)
			if(u != v)
				ret(i) += patterns(u,i) .* patterns(u,:) * patterns(v,:)';
			endif
		endfor
		ret(i) = (1/columns(patterns)) * ret(i);
	endfor
endfunction