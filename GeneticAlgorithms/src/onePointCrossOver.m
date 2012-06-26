function [sonLeft sonRight] = onePointCrossOver(father, mother)

	flen = length(father);
	point = round(rand() * (flen - 1)) + 1;
	try
		sonLeft = [father(1:point) mother(point+1:flen)];
		sonRight = [mother(1:point) father(point+1:flen)];
	catch
		[sonLeft sonRight] = onePointCrossOver(father, mother);
	end_try_catch

endfunction