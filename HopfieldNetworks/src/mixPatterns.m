function retPat = mixPatterns(patterns)

	savePatterns = false;

	selectedPatterns = [];
	for i = 1:length(patterns)
		selectedPatterns = vertcat(selectedPatterns, imgToVec(strcat('img/original/', patterns(i){1})));
	endfor

	numResults = 2^length(patterns);

	retPat = zeros(numResults, length(selectedPatterns(1,:)));

	for j=1:numResults
		indexes = dec2bin(j, length(patterns)) - '0';
		indexes = indexes - 0.5;
		indexes = indexes * 2;
		
		for i=1:length(patterns)
			retPat(j,:) += selectedPatterns(i,:) * indexes(i);
		endfor

	endfor

	retPat = sign(retPat);

	if(savePatterns)
		for i=1:numResults
			imwrite(vecToImg(retPat(i,:), 64), strcat('img/mixes/', num2str(i), '.png'));
		endfor
	endif

endfunction