function ret = trainNet(trainingSet, nValue, f, err, learningRate)

w = rand(6,1);

finish = false;
epochs = 0;
E_plot = [];

qtyPatterns = rows(trainingSet);

while(!finish)
	epochs++;

	for i = (1:qtyPatterns)

		mu = normalizeInput(trainingSet(i,1:5)', nValue);
		S_mu = trainingSet(i,6);
		o_mu = simplePerceptron5(mu, w, f);
		
		if(strcmp(f,'sigmoid'))
			B = 1; #Si cambias esto cambia sigmoid
			delta_w = learningRate*(S_mu - o_mu)*B*(1 - o_mu^2).*mu;
		else
			delta_w = learningRate*(S_mu - o_mu).*mu;
		endif
		w = w .+ delta_w;


	endfor

	E_W = 0;
	for i = (1:qtyPatterns)
		mu = normalizeInput(trainingSet(i,1:5)', nValue);
		S_mu = trainingSet(i,6);
		o_mu = simplePerceptron5(mu, w, f);

		E_W += (S_mu - o_mu)^2;
	endfor

	E_W = E_W / 2;

#	if(mod(epochs,100)==0)
#		E_W
#	endif

	E_plot(length(E_plot) + 1) = E_W;

	if(E_W < err)
		finish = true;
	endif

	trainingSet = shufflePatterns(trainingSet);

	fflush(stdout);
endwhile

#plot(E_plot);
#print -deps foo.eps
printf("Epocas: '%d'.\n", epochs);

ret = w;

endfunction
