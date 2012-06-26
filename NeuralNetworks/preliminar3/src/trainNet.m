function [ret_w ret_epochs ret_errors] = trainNet(trainingSet, netSize, g, g_prima, err, eta, max_epochs, print_errors, w)

if(nargin < 9)
	error("Invalid parameters: trainNet.");
endif

deltas = {};
qtyPatterns = rows(trainingSet);

epochs = 0;
cuadraticErrors = []; 

% Parametros eta adaptativo
maxerrors = 10;
Ew = [];
b = 0.1;
a = 0.01;
consecutives = 0;
mindif = 1e-7;

inputLenght = netSize(1);

do

	epochs++;

	for i = 1:qtyPatterns

		mu = trainingSet(i,1:inputLenght);
		S_mu = trainingSet(i,inputLenght+1);
		hs = membranePotentials(mu, w, g);
		V = {};
		for j = 1:length(hs)
			V(j) = g(hs{j});
		endfor
		o_mu = V{length(V)};
		#printf("Calculada: %d, Esperada: %d\n", o_mu, S_mu);

		#Se calcula el delta de la capa de salida (por ahora para una sola salida)
		deltas{length(w)} = g_prima(hs{length(hs)})*(S_mu - o_mu);

		% Se calculan los deltas para las capas ocultas
	 	% DANGER: ZONA DE PELIGRO
		for j = length(deltas) - 1 : -1 : 1
			% Se saca la última fila correspondiente a los pesos del bias.
			imp_w = (1:rows(w{j+1}) - 1);
			deltas{j} = g_prima(hs{j+1}).*(w{j+1}(imp_w, :)*deltas{j+1}')';
		endfor

		% Se realiza la correción de pesos
		for j = 1:length(w)
			% Se coloca el -1 para corregir el peso del "bias".
			delta_w = eta * ([V{j} -1]' * deltas{j});
			w{j} = w{j} + delta_w;
		endfor
	endfor

	currentError = 0;

	for i = 1:qtyPatterns
		mu = trainingSet(i,1:inputLenght);
		S_mu = trainingSet(i,inputLenght+1);
		o_mu = evalNet(mu, w, g);
		currentError += (S_mu - o_mu)^2;
	endfor

	currentError = currentError / qtyPatterns;

	if(print_errors && mod(epochs,100) == 0)
		printf("currentError = %10.6g \t eta = %#10.4g \t epochs = %d\n", currentError, eta, epochs);
	endif

	fflush(stdout);

	cuadraticErrors(epochs) = currentError;

	#Se mezclan los patrones
	trainingSet = shufflePatterns(trainingSet);

	if(epochs == max_epochs)
		break;
	endif

	if ( epochs >= 2 )
		deltaEw = cuadraticErrors(epochs) - cuadraticErrors(epochs-1);
		
		if ( abs(deltaEw) >= mindif )
			if ( deltaEw > 0 )
				eta -= b*eta;
				consecutives = 0;
			else
				if ( consecutives+1 >= maxerrors )
					eta += a;
					consecutives = 0;
				else
					consecutives++;
				endif
			endif
		endif
		
	endif

until(currentError < err)

ret_w = w;
ret_epochs = epochs;
ret_errors = cuadraticErrors;

endfunction