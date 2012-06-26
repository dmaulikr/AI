function [leftSon rightSon] = uniformCrossOver(father, mother, p)
	leftSon = [];
	rightSon = [];
	for i=1:length(father)
		randomValue = rand();
		if(randomValue < p)
			#mustchange
			leftSon(i) = mother(i);
			rightSon(i) = father(i);
		else
			#mustnot
			leftSon(i) = father(i);
			rightSon(i) = mother(i);

		endif
	endfor
	leftSon
	rightSon
endfunction