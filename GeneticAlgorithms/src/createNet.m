function ret = createNet(layerSizes)

	ret = {};
	#Parametro para achicar los random
	lambda_1 = 1;
	lambda_2 = 1;
	for i=1:length(layerSizes)-1
		ret{i} = (rand(layerSizes(i)+1, layerSizes(i+1))*lambda_1)-lambda_2;
	endfor

endfunction
