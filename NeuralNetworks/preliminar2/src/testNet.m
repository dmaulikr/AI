function [success fail] = testNet(sMethod, f)

filename = strcat(tolower(sMethod), 'Weights', f);
w = load(filename);
trainingSet = load(strcat('./trainingSets/', sMethod, '/all'));

if(strcmp('AND',sMethod))
	nValue = 1;
elseif(strcmp('OR',sMethod))
	nValue = -1;
endif

success = 0;
fail = 0;

for i = (1:size(trainingSet)(1))
	x = normalizeInput(trainingSet(i,1:5)', nValue);
	s = trainingSet(i,6);
	o = simplePerceptron5(x,w,f);

	#printf("Input: ");
	#disp(x');
	#printf("Output: '%d'", o);
	#printf(" Expected: '%d'\n\n", s); 

	if(sign(s) != sign(o))
		fail++;
		disp(x');
	else
		success++;
	endif

endfor

printf("Success: '%d'\n", success);
printf("Fail: '%d'\n", fail);

endfunction
