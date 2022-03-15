% vin1(numero, cru, millesime, degré)

vin1(100, "Chablis", 1974, 12).
vin1(110, "Mercurey", 1978, 13).
vin1(120, "Macon", 1977, 12).

% vin2(Numéro, cru, millésime, degré)

vin2(100, "Chablis", 1974, 12).
vin2(200, "Sancerre", 1979, 11).
vin2(210, "Pouilly", 1980, 12).
vin2(230, "Pouilly", 1981, 12).

% viticulteurs(Patronyme, Ville, Région)

viticulteurs("Nicolas", "Pouilly", "Bourgogne").
viticulteurs("Martin", "Bordeaux", "Bordelais").

% vin2(Numero, "Pouilly", Millesime, Degre).
% vin2(Numero, cru, millesime, 12).

% vin3 intersection de vin1 et vin2

vin3(N, C, M, D) :-
  vin1(N, C, M, D),
  vin2(N, C, M, D).

% vin4 union de vin1 et vin2

vin4(N, C, M, D) :-
  vin1(N,C,M,D).
vin4(N, C, M, D) :-
  vin2(N,C,M,D).

% \+(vin2(X, Y, 1978, Z))

% vin5 = vin1 \ vin2

vin5(N, C, M, D) :-
  vin1(N, C, M, D),
  \+ vin2(N, C, M, D).

% vignoble = vin5 * viticulteurs

vignoble(A, B, C, D, E, F, G) :-
  vin5(A, B, C, D),
  viticulteurs(E, F, G).

% vin 6 = projection de vin5 cru millésime

vin6(C, M) :-
  vin5(_, C, M, _).

vin7(N, C, M, D) :-
  vin4(N, C, M, D),
  M > 1975,
  M < 1980.

vin8(N,C,M,D,P,V,R) :-
  vin4(N, C, M, D),
  viticulteurs(P, V, R),
  V = C.


vin9("Macon", 1977, 12).
vin9("Macon", 1979, 14).
vin9("Macon", 1980, 12).
vin9("Saumur", 1977, 12).
vin9("Saumur", 1979, 14).
vin9("Chablis", 1977, 12).

type(1977, 12).
type(1979, 14).

projvin9(C) :- vin9(C, _, _).
pcvin9type(C, M, D) :- projvin9(C), type(M,D).
pcvin9typemvin9(C, M, D) :- pcvin9type(C, M, D), \+ vin9(C, M, D).


cru(C) :-
  projvin9(C),
  \+ pcvin9typemvin9(C, _, _).