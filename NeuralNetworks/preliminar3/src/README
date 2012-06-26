Entrega Preliminar N°2
-------------------------------------------------------------------------------
Dependencias:

Para correr de manera satisfactoria el trabajo debe contar con:
	- Octave 3.2.4+

-------------------------------------------------------------------------------
Ejecución:

Aclaración:
El trabajo se entrega con las redes neuronales ya entrenadas y listas para uti-
lizar.

Los métodos se ejecutan dentro del ambiente de Octave, dentro del path "src".

La función "main" es la que ejecuta los diferentes métodos. El formato para su
ejecución es:

octave> main('sMethod', in', 'f')

sMethod:
- AND
- OR

in: debe ser un vector de octave de 0 o 1, de longitud entre 2 y 5.

f:
- step
- sigmoid
- lineal

Ejemplos:
octave> main('AND',[0,1]','step")
octave> main('OR',[1,1,0,0,1]','step")

-------------------------------------------------------------------------------
Entrenamiento:

Para entrenar la red el trabajo cuenta con la función "training".

Por ejemplo:
octave> training('AND', 'all', 'lineal', 5, 0.05)

Mediante este se obtienen los pesos para la red, utilizando como conjunto de 
entrenamiento "src/trainingSets/AND/all", se corren 5 épocas con un
learningRate de 0.05

Ésta función guarda los pesos obtenidos, de forma que sean los utilizados por
la función main.


