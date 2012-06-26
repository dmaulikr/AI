function ret = normalizeInput(input) 
	global activationFunction;
	if(strcmp(activationFunction, "tanh"))
		ret = input;
	else
		ret = input ./ 0.67;
	endif
endfunction