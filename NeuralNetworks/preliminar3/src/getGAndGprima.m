function ret = getGAndGprima(ft)

ret = {};

if(nargin == 0)
	ft = 'step';
endif

if(strcmp(ft, 'sigmoid'))
	ret{1} = inline("tanh(1*x)");
	ret{2} = inline("1*(sech(x).^2)");
elseif(strcmp(ft, 'lineal'))
	ret{1} = inline("x/4");
	ret{2} = inline("1/4");
endif

endfunction