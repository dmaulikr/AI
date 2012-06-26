function ret = noise(pattern, prob)

ret = pattern;
uno = 0;
cero = 0;

for i=1:length(pattern)

	r = rand();
	if(r*100 < prob)
		if(rand() > 0.5)
			ret(i) = -1;
		else
			ret(i) = 1;
		endif
	endif
endfor

endfunction