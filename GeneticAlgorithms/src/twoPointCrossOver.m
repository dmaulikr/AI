##
# For this implementation I assume that this is the father array FFFF
# and this is the MMMM. The @leftSon has father mixed with mother and 
# @rightSon mother mixed with fahter:
#
# >$ twoPointCrossOver(father, mother, 3,4)
#
# @leftSon = FFSS
# @rightSon = SSFF
#
##

function [leftSon rightSon] = twoPointCrossOver(father, mother, pointA, pointB)
	leftSon = [];
	rightSon = [];
		if(pointA > 0 && pointA <= length(father) && pointB >= pointA && pointB <= length(father))
			if( pointA > 1 )
				leftSon = [father(1 : pointA - 1)];
				rightSon = [mother(1 : pointA - 1)];
			endif

			leftSon = [leftSon mother(pointA : pointB)];
			rightSon = [rightSon father(pointA : pointB)];

			if( pointB < length(father) )
				leftSon = [leftSon father(pointB + 1:length(father))];
				rightSon = [rightSon mother(pointB + 1:length(mother))];
			endif
		endif
endfunction