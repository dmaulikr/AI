function ret = validateInput(x)

s = size(x);

rows = s(1);
cols = s(2);

ret = cols == 1 && rows >= 2 && rows <= 5;

if(ret == 0)
	return;
endif

for i = (1:rows)
	if(!(x(i) == 0 || x(i) == 1))
		ret = 0;
		return;	
	endif
endfor

endfunction
