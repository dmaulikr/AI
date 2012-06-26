function ret = createNet(layerSizes)

	ret = {};
	#Parametro para achicar los random
	lambda_1 = 0.5;
	lambda_2 = 0;
	for i=1:length(layerSizes)-1
		% Se fija la semilla para sacar conclusiones
		rand("seed", i);
		ret{i} = (rand(layerSizes(i)+1, layerSizes(i+1))*lambda_1)-lambda_2;
	endfor

endfunction
