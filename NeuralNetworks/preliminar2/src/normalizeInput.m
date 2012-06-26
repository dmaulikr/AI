function ret = normalizeInput(x, value)

ret(1) = -1;

for i = (1 : size(x)(1))
	if(x(i) == 0)
		ret(i+1) = -1;
	else
		ret(i+1) = x(i);
	endif
endfor

if(size(x)(1) < 5)
	for i = (size(x)(1) + 1 : 5)
		ret(i+1) = value;
	endfor	
endif

ret = ret';

endfunction
