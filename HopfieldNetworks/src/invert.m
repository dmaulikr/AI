function ret = invert(pattern)

	for i=1:length(pattern)
		if(pattern(i) > 0)
			ret(i) = -1;
		else
			ret(i) = 1;		
		endif
	endfor

endfunction
