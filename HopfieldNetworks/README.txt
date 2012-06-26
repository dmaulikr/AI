En la carpeta src se encuentran todos las funciones de octave.

- Para crear una red, con los patrones que se guardan en "img/original"

net = createNet({"a.png","f.png","h.png"});


- Para evaluar la red con el patrón "sonic.png":

result = evaluate(net, imgToVec("img/original/sonic.png"));

- Para probar la estabilidad de un conjunto de patrones:

testStability({"a.png","h.png"});
