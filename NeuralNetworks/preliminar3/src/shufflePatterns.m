function ret = shufflePatterns(p)
	
	ret = p;
	
	for i = 1:rows(p)
		ri = floor(rand * rows(p)) + 1;
		
		auxRow = ret(i,:);
		ret(i,:) = ret(ri,:);
		ret(ri,:) = auxRow;
	endfor

endfunction