function [selected selPos] = elitismSelection(population, fitnessVec, k)

	selected = {};

	[aux indices] = sort(fitnessVec);

	selPos = [];

	lenPop = length(population);

	for i=1:k
		selected{i} = population{indices((lenPop + 1) - i)};
		selPos(length(selPos) + 1) = indices((lenPop + 1) - i);
	endfor

endfunction