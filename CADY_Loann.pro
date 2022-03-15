% vin1 ([(Numéro, Cru, Millésime, Degré), ...])
% vin2 ([(Numéro, Cru, Millésime, Degré), ...])
% viticulteurs ([ (Patronyme, Ville, Région), ...])

vin1([
	(100, "Chablis", 1974, 12),
	(110, "Mercurey", 1978, 13),
	(120, "Macon", 1977, 12)
]).

vin2([
	(100, "Chablis", 1974, 12),
	(200, "Sancerre", 1979, 11),
	(210, "Pouilly", 1980, 12),
	(230, "Pouilly", 1981, 12)
]).

viticulteurs([
	("Nicolas", "Pouilly", "Bourgogne"),
	("Martin", "Bordeaux", "Bordelais")
]).

% vin3 = intersection de vin1 et vin2

inter([], _,  []).
inter([X|Y], L2, [X|Res]) :- 
	member(X, L2),
	inter(Y, L2, Res).
inter([_|Y], L2, Res) :-
	inter(Y, L2, Res).

vin3(L) :- vin1(L1), vin2(L2), inter(L1, L2, L).

% vin4 = union de vin1 et vin2

union([],[],[]).
union([],L2, L2).
union([X|Y], L2 , [X|Res]) :-
    \+(member(X, L2)),
	union(Y, L2, Res).
union([_|Y], L2, Res) :-
	union(Y, L2, Res).

vin4(L) :- vin1(L1), vin2(L2), union(L1, L2, L).

% vin5 = vin1 \ vin2

diff([], _, []).
diff([X|Y], L2, [X|Res]) :-
	\+ member(X, L2),
	diff(Y, L2, Res).
diff([_|Y], L2, Res) :-
	diff(Y, L2, Res).

vin5(L) :- vin1(L1), vin2(L2), diff(L1, L2, L).

% vignoble = vin5 x viticulteurs

produit([], _, []).
produit([(A, B, C, D)|L1], [(X1), (X2)], [(A, B, C, D, X1), (A, B, C, D, X2)|Res]) :-
	produit(L1, [(X1), (X2)], Res).

vignoble(L) :- vin5(L1), viticulteurs(L2), produit(L1, L2, L).

% vin6 = projection de vin5 sur cru, millésime

proj([], []).
proj([(_, C, M, _)|L1], [(C, M)|Res]) :-
	proj(L1, Res).

vin6(L) :- vin5(L1), proj(L1, L).

% vin7 = restriction de vin4 aux Millésimes compris strict entre 1975 et 1980

restr([], []).
restr([(N, C, M, D)|L1], [(N, C, M, D)|Res]) :-
	M > 1975,
	M < 1980,
	restr(L1, Res).
restr([_|L1], Res) :-
	restr(L1, Res).

vin7(L) :- vin4(L1), restr(L1, L).

% vin8 = jointure vin4 et viticulteur sur Ville = Cru

joint([], _, []).
joint([(A, B, C, D)|L1], [(X1, Y1, Z1), (X2, Y2, Z2)], [(A, B, C, D, X1, Y1, Z1)|Res]) :-
	B = Y1,
	joint(L1, [(X1, Y1, Z1), (X2, Y2, Z2)], Res).
joint([(A, B, C, D)|L1], [(X1, Y1, Z1), (X2, Y2, Z2)], [(A, B, C, D, X2, Y2, Z2)|Res]) :-
	B = Y2,
	joint(L1, [(X1, Y1, Z1), (X2, Y2, Z2)], Res).
joint([_|L1], L2, Res) :-
	joint(L1, L2, Res).

vin8(L) :- vin4(L1), viticulteurs(L2), joint(L1, L2, L).

% vin9([(Cru, Millésime, Degré), ...])
% type([(Millésime, Degré), ...])

vin9([
	("Macon", 1977, 12),
	("Macon", 1979, 14),
	("Macon", 1980, 12),
	("Saumur", 1977, 12),
	("Saumur", 1979, 14),
	("Chablis", 1977, 12)
]).

type([
	(1977, 12),
	(1979, 14)
]).

% cru([(Cru), ...]) = vin9 / type (projvin9 \ projvin9_type_moinsvin9_projcru)

% Sous relations :
% projvin9 = projection vin9 sur le cru (En enlevant les doublons)
% projvin9_type = projvin9 x type
% projvin9_type_moinsvin9 = projvin9_type \ vin9
% projvin9_type_moinsvin9_projcru = projection projvin9_type_moinsvin9 sur le cru

projvin9([], []).
projvin9([(C, _, _)|L], [C|Res]) :-
	\+ member((C, _, _) , L),
	projvin9(L, Res).
projvin9([_|L], Res) :-
	projvin9(L, Res).
projvin9(L) :- vin9(L1), projvin9(L1, L).

projvin9_type([], _, []).
projvin9_type([(C)|L1], [(X1), (X2)], [(C, X1), (C, X2)|Res]) :-
	projvin9_type(L1, [(X1), (X2)], Res).
projvin9_type(L) :- projvin9(L1), type(L2), projvin9_type(L1, L2, L).

projvin9_type_moinsvin9([], _, []).
projvin9_type_moinsvin9([X|L1], L2, [X|Res]) :-
	\+ member(X, L2),
	projvin9_type_moinsvin9(L1, L2, Res).
projvin9_type_moinsvin9([_|L1], L2, Res) :-
	projvin9_type_moinsvin9(L1, L2, Res).
projvin9_type_moinsvin9(L) :- projvin9_type(L1), vin9(L2), projvin9_type_moinsvin9(L1, L2, L).

projvin9_type_moinsvin9_projcru([], []).
projvin9_type_moinsvin9_projcru([(C, _, _)|L], [C|Res]) :-
	projvin9_type_moinsvin9_projcru(L, Res).
projvin9_type_moinsvin9_projcru(L) :- projvin9_type_moinsvin9(L1), projvin9_type_moinsvin9_projcru(L1, L).


cru([], _, []).
cru([C|L1], L2, [C|Res]) :-
	\+ member(C, L2),
	cru(L1, L2, Res).
cru([_|L1], L2, Res) :-
	cru(L1, L2, Res).
cru(L) :- projvin9(L1), projvin9_type_moinsvin9_projcru(L2), cru(L1, L2, L).