##
 # name: full path of the directory were the image file would be created.
 #
 # vecImg: vector created by imageToVec function.
 #
 # width: the width of the original image, this is use for transforming the vector into a matrix.
 # At the end the image wolud be of width X width.
 #
 # Example:
 #         v = vecToImg(a,64)
##

function matrixImage = vecToImg(vecImg, width)
	
	matrixImage = [];

	r=1;

	for i = 1:length(vecImg)
		if(vecImg(i) == -1)
			matrixImage(r, mod(i,width) + 1) = 0;
		else
			matrixImage(r, mod(i,width) + 1) = 1;
		endif

		if(mod(i,width) == 0)
			r++;
		endif
	endfor

endfunction