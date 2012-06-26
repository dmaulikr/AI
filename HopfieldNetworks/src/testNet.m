patterns = {'line1.png','line2.png'};

%testStability(patterns);

imgDir = 'img/original/';
printf("Creando red...");
net = createNet(patterns);
printf("Red creada\n");
patternName = 'line4.png';

originalImg = invert(imgToVec(strcat(imgDir, patternName)));
%testImg = dirtyPattenr(originalImg, 70);

printf("Evaluando...\n");
ret = evaluate(net, originalImg);

imshow(vecToImg(ret, 64));