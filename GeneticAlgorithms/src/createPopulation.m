function ret = createPopulation(size, layerSizes)

	ret = {};

	for i = 1:size
		ret{length(ret) + 1} = encodeNet(createNet(layerSizes));
	endfor

endfunction