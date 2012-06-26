function [trainingSet testSet] = getTrainingAndTestSet(threshold, patterns, percentagePreferred, percentageOthers)

	% Indices de patterns que tienen el z > threshold %
	indexes = find(abs(patterns(:,3)) > threshold);

	% Puntos de preferencia %
	preferred = patterns(indexes,:);
	
	% Los otros puntos %
	others = patterns;
	others(indexes,:) = [];

	pref_size = round(length(preferred)*percentagePreferred);
	others_size = round(length(others)*percentageOthers);

	trainingSet = vertcat(preferred(1:pref_size,:), others(1:others_size,:));
	testSet = vertcat(preferred(pref_size+1:length(preferred),:), others(others_size+1:length(others),:));

endfunction