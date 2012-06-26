function listImages()

	files = dir("img/original");
	filenames = {files.name};

	index = 1;
	for i = 1:length(filenames)
		if(!(strcmp(filenames(i), ".") || strcmp(filenames(i), "..")))
			printf("%d. %s\n", index++, filenames(i){1});
		endif
	endfor

endfunction