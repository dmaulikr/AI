function [allPatterns namesMap] = getAllPatterns()

	files = dir("img/original/*.png");
	filenames = {files.name};

	namesMap = {};
	allPatterns = [];

	for i = 1:length(filenames)
		namesMap{length(namesMap) + 1} = filenames(i){1};
		allPatterns = vertcat(allPatterns, imgToVec(strcat("img/original/", filenames(i){1})));
	endfor

endfunction