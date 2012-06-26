function  ret = binarizeImage(imagePath, threshold, save, name)

	im = imread(imagePath);
	for i = 1:rows(im)
		for j = 1:columns(im)
			if(im(i,j,1) >= threshold)
				ret(i,j) = 1;
			else
				ret(i,j) = 0;
			endif
		endfor
	endfor

	if(save)
		imwrite(ret, name);
	else
		imshow(ret);
	endif

endfunction