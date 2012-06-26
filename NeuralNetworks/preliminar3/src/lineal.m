function ret = lineal(x)

	ret = x/5;
	if(ret > 1)
		ret = 1;
	elseif(ret < -1)
		ret = -1;
	endif