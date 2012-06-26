% Limpia variables globales anteriores
clear all;

sTrainingSet = 'samples8';

netSize = [2 36 12 6 1];

ft = 'tanh';

%  Se setea el nombre de la función de activación como variable global
global activationFunction = ft;

min_err = 0.01;
eta = 0.5;

max_epochs = 5000;

print_errors = true;

w = createNet(netSize);

[ret_epochs ret_errors] = training(netSize, sTrainingSet, ft, eta, min_err, max_epochs, print_errors, w);


plot(ret_errors);