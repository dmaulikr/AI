function [sonLeft sonRight] = anularCrossOver(father, mother, pointA, l)
	if(pointA > 0 && l <= (length(father) / 2))
		twoPointCrossOver(father, mother, pointA, pointA + l);
	endif
endfunction