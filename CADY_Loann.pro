% vin1 ([(Numéro, Cru, Millésime, Degré), ...])
% vin2 ([(Numéro, Cru, Millésime, Degré), ...])
% viticulteurs ([ (Patronyme, Ville, Région), ...])

vin1([(100, "Chablis", 1974, 12),
	(110, "Mercurey", 1978, 13),
	(120, "Macon", 1977, 12)
]).

vin2([(100, "Chablis", 1974, 12),
	  (110, "Sancerre", 1979, 11),
	  (210, "Pouilly", 1980, 12),
	  (230, "Pouilly", 1981, 12)
]).

viticulteurs([("Nicolas", "Pouilly", "Bourgogne"),
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
	\+(member(X, L2)),
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
joint([(N, C, M, D)|L1], [(X1, Y1), (X2, Y2)], [(A, B, C, D, X1, Y1)|Res]) :-
	