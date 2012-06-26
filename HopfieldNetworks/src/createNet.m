function [net selectedPatterns] = createNet(patterns)

	% Variables ---------------------------------------------------------------
	showPatterns = false;
	saveNet = false;
	% -------------------------------------------------------------------------

	% Se seleccionan los patrones elegidos
	selectedPatterns = [];
	for i = 1:length(patterns)
		selectedPatterns = vertcat(selectedPatterns, imgToVec(strcat('img/original/', patterns(i){1})));
	endfor

	% Se crea la matriz de pesos y se la guarda.
	net = createHopfieldNet(selectedPatterns);

	if(saveNet)
		save('weights/net.mat', 'net');
	endif

	% Se muestran los patrones elegidos si se lo desea
	if(showPatterns)
		for i = 1:length(patterns)
			imshow(vecToImg(selectedPatterns(i,:), 64));
			sleep(0.5);
		endfor
	endif

endfunction