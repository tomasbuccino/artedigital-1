# artedigital-1
Final de Arte Digital 1

UPDATE VER3: Agregadas las funciones, booleans e ifs básicos. No sé si está bien la lógica. Falta probar. Código comentado. Necesito que los audios se reproduzcan en intervalos: problema, me parece que con los ifs a partir de los booleans se reproducen solo una vez y si los dejo sin nada se superponen y no respetan el intervalo. 

El original es ver2, el redone es una prueba que hice (halfway) con/para Alberti usando switch para procesar las secciones/casos.

| OBRA |----- SECTOR 1 -----|----- SECTOR 2 -----|----- SECTOR 3 -----|

Básicamente la obra consiste en un sensor de distancia, al que se le pasan 3 ranges de valores y estos 3 ranges corresponden a sectores de "acercamiento" a la obra

SECTOR 3: El sector 3 es la obra sin interacción, en idle, donde la obra "habla" consigo misma. Básicamente reproduce sonidos con un delay  de 3000 ms.

SECTOR 2: Cuando se entra en el range del sector 2, se emite un audio y arranca un Ani. Cuando termina el Ani, se emite otro audio indicando que se puede pasar al sector 1. si no se respeta el ani, hay otro feedback y el sector 1 se vuelve unresponsive.
Volver al sector 2 no tendría que retriggerear el ani si ya se pasó por esa instancia. Al idle se vuelve dejando la obra en realidad, porque el sensor pasa a detectar el range del sector 3. 

SECTOR 1: Básicamente lo mismo que el sector 3 pero con otros audios.

Quizás tendrían que estar las siguientes variables:

BOOLEAN IDLE: Si está en idle(sector3) o no.

BOOLEAN TRIGGERED: Si yá pasó por el sector 2, debería aparecer una vez terminado el ani. Cuando vuelve a idle se tendría que resetear el valor de triggered.

BOOLEAN ANICOMPLETE: Tendría que tener un boolean que detectara si se completó el ani o si se lo ignoró y en base a este boolean cambia el feedback.

Alberti dixit: Tiene que haber una variable, un estado, que indique que el sonido está corriendo, que pregunte todo el tiempo y cuando no, que corra otro o haga otra cosa.
