function ret = encodeNet(w)

	ret = [];

	for i = 1:length(w)
		for c = 1:columns(w{i})
			for r = 1:rows(w{i})
				ret(length(ret) + 1) = w{i}(r,c);
			endfor
		endfor
	endfor

endfunction