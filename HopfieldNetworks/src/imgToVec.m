##
 # It transforms a Black and White image in a vector. Remains
 # to check if the image is not compatible.
 #
 # imagePath: full path for the image location
 # Example:
 #        a = imgToVec("../img/a.png")
##

function [vecAns] = imgToVec(imagePath)
	filename = strcat(tolower(imagePath));
	
	matrixImage = imread(filename);
	
	#Checking if the image is in the correct format
	if(length(size(matrixImage)) == 3)
		error("Invalid format image...\n");
		return;
	endif

	vecAns = [];

	for i = 1:rows(matrixImage)
		for j = 1:columns(matrixImage)
			if(matrixImage(i,j) == 0)
				vecAns(length(vecAns) + 1) = -1;
			else
				vecAns(length(vecAns) + 1) = 1;
			endif
		endfor
	endfor

endfunction