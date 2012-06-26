function [ret_w ret_epochs ret_errors] = trainNet(patterns, netSize, g, g_prima, eta, min_error, max_epochs, print_errors, w)

if(nargin < 8)
	error("Invalid parameters: trainNet.");
endif

deltas = {};

epochs = 0;
cuadraticErrors = []; 

% Estrategias
adaptativeEta = true;
momentum = true;
epochs_per_print = 10;
plotType = 2;

% Conjuntos de entrenamiento y testeo
threshold = 3;
preferredPercentage = 0.95;
othersPercentage = 0.70;


% Parametros eta adaptativo
maxerrors = 10;
Ew = [];
b = 0.01;
a = 0.1;
consecutives = 0;
mindif = 1e-5;

% Parametros momentum
b_momentum = 0.2;

inputLenght = netSize(1);

finished = false;
epochs_stop_condition = 10;

% Se obtienen los conjuntos de prueba y entrenamiento
[trainingSet testSet] = getTrainingAndTestSet(threshold, patterns, preferredPercentage, othersPercentage);

printf("Conjunto de entrenamiento: %g (%d puntos)\n", length(trainingSet)/length(patterns), length(trainingSet));
printf("Conjunto de prueba: %g (%d puntos)\n\n", length(testSet)/length(patterns), length(testSet));

do

	% Se mezcla el conjunto de entrenamiento
	trainingSet = shufflePatterns(trainingSet);

	qtyPatterns = rows(trainingSet);
	qtyTests = rows(testSet);

	epochs++;

	for i = 1:qtyPatterns

		mu = trainingSet(i,1:inputLenght);
		S_mu = denormalizeOutput(trainingSet(i,inputLenght+1));
		hs = membranePotentials(mu, w, g);
		V = {};
		for j = 1:length(hs)
			V(j) = g(hs{j});
		endfor
		o_mu = V{length(V)};

		% Se calcula el delta de la capa de salida
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
			if(momentum & i > 1)
				w{j} +=  b_momentum*(w{j} - w_tmenos1{j});
			endif
		endfor
		w_tmenos1 = w;

	endfor


	outputs = [];
	trainingError = 0;
	for i = 1:qtyPatterns
		mu = trainingSet(i,1:inputLenght);
		S_mu = denormalizeOutput(trainingSet(i,inputLenght+1));
		o_mu = denormalizeOutput(evalNet(mu, w, g));
		outputs(i,:) = [mu S_mu o_mu];
		trainingError += (S_mu - o_mu)^2;
	endfor
	trainingError = trainingError / 2;

	testError = 0;
	for i = 1:qtyTests
		mu = testSet(i,1:inputLenght);
		S_mu = denormalizeOutput(testSet(i,inputLenght+1));
		o_mu = denormalizeOutput(evalNet(mu, w, g));
		outputs(length(outputs)+1,:) = [mu S_mu o_mu];
		testError += (S_mu - o_mu)^2;
	endfor
	testError = testError / 2;

	if(print_errors && mod(epochs,epochs_per_print) == 0)
		printf("trainingError = %#6.6g  testError = %#6.6g eta = %#5.4g epochs = %d \n", 
			trainingError, testError, eta, epochs);
		if(plotType == 1)
			plot3(outputs(:,1), outputs(:,2), outputs(:,3), "o3");
			hold on;
			plot3(outputs(:,1), outputs(:,2), outputs(:,4), "o1");
			hold off;
		elseif(plotType == 2)
			comp = outputs(:,3:4);
			comp = sortrows(comp, 1);
			plot(comp(:,1), comp(:,2), '*r');
			hold on
			plot(comp(:,1), comp(:,1));
			hold off;
		endif

		drawnow;
	endif

	fflush(stdout);

	cuadraticErrors(epochs,1) = trainingError;
	cuadraticErrors(epochs,2) = testError;

	if(adaptativeEta) 
		if ( epochs >= 2 )
			deltaEw = cuadraticErrors(epochs,1) - cuadraticErrors(epochs-1,1);
			
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
	endif

	if(cuadraticErrors(epochs,1) < min_error || epochs > max_epochs)
		finished = true;
	endif

until(finished)

printf("\nEntrenamiento finalizado: {trainingError: %g, testError: %g} \n", trainingError, testError);

plot3(outputs(:,1), outputs(:,2), outputs(:,3), "o3");
hold on;
plot3(outputs(:,1), outputs(:,2), outputs(:,4), "o1");
print("results_plot1.png", "-dpng");
hold off;

comp = outputs(:,3:4);
comp = sortrows(comp, 1);
plot(comp(:,1), comp(:,2), '*r');
hold on
plot(comp(:,1), comp(:,1));
print("results_plot2.png", "-dpng");
hold off;

ret_w = w;
ret_epochs = epochs;
ret_errors = cuadraticErrors;

endfunction
