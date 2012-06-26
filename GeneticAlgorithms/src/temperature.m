function T = temperature(generation)
	
	Tinitial = 100;
	T = Tinitial / (1 + log(generation));

endfunction