sMethod = 'SIMETRY';
sTrainingSet = 'all';

layer2sizes = [2];
etas = [0.5 0.25];

colors = {'r', 'g', 'b'};

ft = 'sigmoid';
err = 0.01;
l1 = 5;
max_epochs = 20000;
print_error = true;

for k=1:length(layer2sizes)
	clf;
	xlabel('Epocas');
	ylabel('Error');
	l2 = layer2sizes(k);
	netSize = [l1 l2 1];
	w = createNet(netSize);
	printf("Capas: %d\n", l2)
	hold on;
	for i=1:length(etas)
		eta = etas(i);
		printf("Eta: %f\n", eta)
		[ret_epoch ret_errors] = training(sMethod, netSize, sTrainingSet, ft, err, eta, max_epochs, print_error, w);
		plot(ret_errors, [colors{i},';', 'eta=',num2str(eta), ';']);
		title_text = sprintf("Error cuadratico de %s con capa oculta de %g", tolower(sMethod), l2);
		filename = sprintf("results/cuadError%s_l%d.png", tolower(sMethod), l2);
		resultsfilename = sprintf("results/epochs%s_etaN%d_l%d.mat", tolower(sMethod), i, l2);
		save(resultsfilename, "ret_epoch");
	endfor
	title(title_text);
	print(filename);
	hold off;
endfor
