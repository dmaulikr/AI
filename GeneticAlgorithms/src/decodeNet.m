function ret = decodeNet(v, layerSizes)

	ret = {};
	k = 1;

	for i = 1:length(layerSizes)-1
		ret{i} = zeros(layerSizes(i)+1, layerSizes(i+1));
		for c = 1:columns(ret{i})
			for r = 1:rows(ret{i})
				ret{i}(r,c) = v(k);
				k++;
			endfor
		endfor
	endfor

endfunction