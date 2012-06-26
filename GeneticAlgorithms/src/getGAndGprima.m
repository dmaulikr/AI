function ret = getGAndGprima(ft)

ret = {};

% DEFAULT: tanh
if(nargin == 0)
	ft = 'tanh';
endif

if(strcmp(ft, 'tanh'))
	ret{1} = inline("tanh(x)");
	ret{2} = inline("sech(x).^2");
elseif(strcmp(ft, 'exp'))
	ret{1} = inline("1./(1+exp(-1*x))");
	ret{2} = inline("1");
endif

endfunction