function retPat = mixPatterns2(patterns)

       retPat = [];

       selectedPatterns = [];
       for i = 1:length(patterns)
               selectedPatterns = vertcat(selectedPatterns, imgToVec(strcat('img/original/', patterns(i){1})));
       endfor

       for i=1:length(selectedPatterns(1,)
               randImg = ceil(rand()*length(patterns));
               retPat(i) = selectedPatterns(randImg,(i);
       endfor

endfunction