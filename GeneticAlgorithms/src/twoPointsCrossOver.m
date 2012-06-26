function [leftSon rightSon] = twoPointsCrossOver(father, mother)

	flen = length(father);

	[father mother] = onePointCrossOver(father, mother);
	[leftSon rightSon] = onePointCrossOver(father, mother);

endfunction