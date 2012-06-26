function ret = backpropagation(ind, patterns, max_epochs, g, g_prima, architecture)

epochs = 0;

w = decodeNet(ind, architecture);
inputLenght = architecture(1);
eta = 0.5;
finished = false;

do

	trainingSet = shufflePatterns(patterns);

	qtyPatterns = rows(patterns);

	epochs++;

	for i = 1:qtyPatterns

		mu = patterns(i,1:inputLenght);
		S_mu = denormalizeOutput(patterns(i,inputLenght+1));
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
		endfor
		w_tmenos1 = w;

		if(epochs > max_epochs)
			finished = true;
		endif

	endfor

until(finished)	

ret = encodeNet(w);

endfunction