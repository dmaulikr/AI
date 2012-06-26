function ret = denormalizeOutput(output)
	global activationFunction;
	if(strcmp(activationFunction, "tanh"))
		ret = output ./ 10;
	else
		ret = output./20 + 0.5;
	endif
endfunction