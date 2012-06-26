function ret = evaluate(net, imgVec)

	% Variables ---------------------------------------------------------------
	showStates = true;
	roundsPerPrint = 2000;
	calculateEnergy = false;
	roundsPerEnergy = 200;
	% -------------------------------------------------------------------------

	input = imgVec;

	% Matriz de estados, la fila i corresponse al estado S(i).
	S_prev = input;
	S_curr = S_prev;	

	finished = false;

	eqQty = 0;
	rounds = 0;

	positions = randperm(length(imgVec));
	currentPosition = 1;

	H = [];

	do

		if(currentPosition == length(positions))
			currentPosition = 1;
			positions = randperm(length(imgVec));
		endif

		S_prev = S_curr;

		% Se obtiene la posición a actualizar
		up = positions(currentPosition++);

		% Se realiza la actulaización
		S_curr(up) = sign(net(up,:)*S_prev');

		% Chequea si el estado es igual al anterior
		if(isequal(S_curr, S_prev))
			eqQty++;
		else
			eqQty = 0;
		endif

		if(calculateEnergy && mod(rounds, roundsPerEnergy) == 0)
			H(length(H) + 1) = -0.5 * sum(sum((S_curr'*S_curr).*net));
		endif

		% Si los estados han sido los mismos en todas las
		% posiciones se termina
		if(eqQty == length(imgVec))
			finished = true;
		endif

		% Se imprime si se lo desea cada roundsPerPrint veces.
		if(showStates && mod(rounds,roundsPerPrint) == 0)
			imshow(vecToImg(S_curr, 64));
			drawnow();
		endif

		rounds++;
	
	until(finished)

	ret = S_curr;

	if(calculateEnergy)
		plot(H);
		% print("H","img/results/energy_noise_50.png","-dpng");
	endif

endfunction
