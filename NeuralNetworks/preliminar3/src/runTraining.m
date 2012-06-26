sMethod = 'PARITY';

l1 = 3;
l2 = 3;

netSize = [l1 l2 1];

sTrainingSet = 'all';

ft = 'sigmoid';

err = 0.01;
eta = 0.5;

max_epochs = 3000;

print_errors = true;

w = createNet(netSize);

[ret_epochs ret_errors] = training(sMethod, netSize, sTrainingSet, ft, err, eta, max_epochs, print_errors, w);

plot(ret_errors);