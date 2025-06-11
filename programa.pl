% Resolviendo vomistar

departamento(maria, ventas).
departamento(juan, ventas).
departamento(roque, ventas).
departamento(nora, compras).
departamento(pedro, compras).
departamento(felipe, administracion).
departamento(hugo, administracion).
departamento(ana, administracion).

puesto(maria, empleado).
puesto(nora, empleado).
puesto(felipe, empleado).
puesto(hugo, empleado).
puesto(juan, cadete).
puesto(pedro, cadete).
puesto(ana, cadete).
puesto(roque, pasante).

% Es un predicado completamente inversible (porque puedo hacer consultas existenciales con ambas variables)
% Es una relación simétrica (porque si se cumple para A y B entonces también para B y A)
% Es una relación reflexiva (porque se cumple para A y A) 
% Es una relación transitiva (ya saben por qué)
trabajanMismoDepto(Persona1, Persona2):-
    departamento(Persona1, Depto),
    departamento(Persona2, Depto).

% puedeDarleOrdenes(maria,pedro). -> No, que deduzca el programa

puedeDarleOrdenes(Jefe, Subordinado):-
    puesto(Jefe, PuestoJefe),
    puesto(Subordinado, PuestoSubordinado),
    superiorA(PuestoJefe,PuestoSubordinado),
    trabajanMismoDepto(Subordinado, Jefe).

superiorA(empleado, cadete).
superiorA(empleado, pasante).

seLlevanBien(Persona1, Persona2) :-
    trabajanMismoDepto(Persona1,Persona2),
    not(puedeDarleOrdenes(Persona1,Persona2)),
    not(puedeDarleOrdenes(Persona2,Persona1)).

:-begin_tests(puedeDarleOrdenes).
% Son 3 clases de equivalencia. El nombre de la clase de equivalencia es el nombre del test:
test(mismoDeptoYEsPuestoSuperiorPuedeDarOrdenes):-
    puedeDarleOrdenes(maria,roque). % representan la clase de equivalencia
test(mismoDeptoYEsPuestoNoEsSuperiorNoPuedeDarOrdenes, fail):-
    puedeDarleOrdenes(roque, maria).
test(distintoDeptoAunqueSeaSuperiorNoPuedeDarOrdenes, fail):-
    puedeDarleOrdenes(hugo,juan).
:-end_tests(puedeDarleOrdenes).



estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

% Usar este para saber si son limítrofes ya que es una relación simétrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

puedenAtacarse(Jugador1, Jugador2):-
    ocupa(Pais1, Jugador1, _),
    ocupa(Pais2, Jugador2, _),
    sonLimitrofes(Pais1, Pais2).

estaTodoBien(Jugador1, Jugador2):-
    jugador(Jugador1),
    jugador(Jugador2),
    not(puedenAtacarse(Jugador1, Jugador2)).

estaTodoBien(Jugador1, Jugador2):-
    sonAliados(Jugador1, Jugador2).

sonAliados(Jugador1, Jugador2):- alianza(Jugador1, Jugador2).
sonAliados(Jugador1, Jugador2):- alianza(Jugador2, Jugador1).

ocupaContinente(Jugador, Continente):-
    jugador(Jugador),
    continente(Continente),
    forall(estaEn(Continente, Pais), ocupa(Pais, Jugador, _)).

continente(Continente):-
    estaEn(Continente, _).

elQueTieneMasEjercitos(Jugador):-
    ocupa(_, Jugador, NumeroGroso),
    forall(ocupa(_,_,CantEjercitos), NumeroGroso >= CantEjercitos).


