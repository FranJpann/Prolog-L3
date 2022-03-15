%abvide
%ab(Racine, sad, sag)

est_vide(abvide).

ab(1, abvide, abvide).

racine(ab(R, _, _), R).
sous_arbreg(ab(_, G, _), G).
sous_arbred(ab(_,_,D), D).

ajout(X, abvide, ab(X, abvide, abvide)).
ajout(X, ab(R,G,D), ab(R,G,D)) :- X=R.
ajout(X, ab(R,G,D), ab(R, Gnew, D)) :- X < R, ajout(X, G, Gnew).
ajout(X, ab(R, G, D), ab(R, G, Dnew)) :- X > R, ajout(X, D, Dnew).

ajoutliste([], A, A).
ajoutliste([X|L], A, Res) :-
	ajout(X, A, A_),
	ajoutliste(L, A_, Res).

arbre(A) :- ajoutliste([6, 2, 8, 1, 7], abvide, A).

appartient(X, ab(X, _, _)).
appartient(X, ab(R, G, _)) :- X < R, appartient(X, G).
appartient(X, ab(R, _, D)) :- X > R, appartient(X, D).

nbnoeuds(abvide, 0).
nbnoeuds(ab(_, G, D), N) :-
	nbnoeuds(G, NG),
	nbnoeuds(D, ND),
	N is NG + ND + 1.

hauteur(abvide, 0).
hauteur(ab(_, G, D), H) :-
	hauteur(G, HG),
	hauteur(D, HD),
	H is max(HG, HD) + 1.

profondeur(ab(X, _, _), X, 0).
profondeur(ab(R, G, _), X, P) :-
	X < R, profondeur(G, X, PG), P is PG+1.
profondeur(ab(R, _, D), X, P) :-
	X > R, profondeur(D, X, PD), P is PD+1.

prefixe(abvide, []).
prefixe(ab(X, G, D), L) :-
	prefixe(G, LG),
	prefixe(D, LD),
	append([X], LG, L_),
	append(L_, LD, L).
	
infixe(abvide, []).
infixe(ab(X, G, D), L) :-
	infixe(G, LG),
	infixe(D, LD),
	append(LG, [X], L_),
	append(L_, LD, L).

postfixe(abvide, []).
postfixe(ab(X, G, D), L) :-
	postfixe(G, LG),
	postfixe(D, LD),
	append(LG, LD, L_),
	append(L_, [X], L).

plus_grand(ab(X, _, abvide), N) :- N = X.
plus_grand(ab(_, _, D), N) :- plus_grand(D, N).

supprimer(A, X, Res).