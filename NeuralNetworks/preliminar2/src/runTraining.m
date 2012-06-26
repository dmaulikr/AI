sMethod = 'AND';
sTrainingSet = 'all';
f = {'step', 'sigmoid', 'lineal'};
err = 0.01;

etas = [0.01 0.03 0.05];

for j=1:length(f)
	printf("Funcion: %s\n", f{j})
	for i=1:length(etas)
		training(sMethod, sTrainingSet, f{j}, err, etas(i));
	endfor
endfor