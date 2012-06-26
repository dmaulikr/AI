function [vecAns] = main(imagePath)
	filename = strcat(tolower(imagePath));
	
	printf("Loding Image ...\n");
	matrixImage = loadimage(filename);
	
	printf("Checking if the image is squared...\n");
	# TODO: Needs to chek if is AxA.

	printf("Building Vector from matrix...\n");
	vecAns = [];
	for i=1:size(matrixImage)(1)
		vecAns = [vecAns matrixImage(i,:)];
	endfor
	printf("Vector builded...\n");
endfunction
