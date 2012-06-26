function ret = normalizeOutput(output) 
	global activationFunction;
	if(strcmp(activationFunction, "tanh"))
		ret = output * 10;
	else
		ret = (output - 0.5)*20;
	endif
endfunction