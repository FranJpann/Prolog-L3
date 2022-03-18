:- include('LISTE').

% sorte Matrice

% symboles de constante et fonction 
%  matrice_vide : Matrice(E)
%  matrice : Liste(Liste(E)) -> Matrice(E)

% symboles de predicat
%  premiere_ligne : Liste(E) x Matrice(E) x Matrice(E) 
%  listes_de_meme_longueur : Liste(E) x Liste(E_)
%  premiere_colonne : Liste(E) x Matrice(E) x Matrice(E)
%  premiere_colonne_ : Liste(E) x Liste(Liste(E)) x Liste(Liste(E))
%  en_liste : Liste(E) x Liste(Liste(E))
%  derniere_ligne : Matrice(E) x Liste(E) x Matrice(E)
%  derniere_ligne_ : Liste(Liste(E)) x Liste(E) x Liste(Liste(E))
%  derniere_colonne : Matrice(E) x Liste(E) x Matrice(E).
%  derniere_colonne_ : Liset(Liste(E)) x Liste(E) x Liste(Liste(E)).
%  ieme_ligne_jeme_colonne : Matrice(E) x Nat x Nat x E.

% definition
premiere_ligne([X|L],matrice_vide,matrice([[X|L]])).
premiere_ligne([X|L],matrice([L_|M]),matrice([[X|L],L_|M])) :-
	listes_de_meme_longueur([X|L],L_).

listes_de_meme_longueur([],[]).
listes_de_meme_longueur([_|L],[_|L_]) :-
   listes_de_meme_longueur(L,L_).


premiere_colonne([X|C],matrice_vide,matrice([[X]|MC])) :-
   en_liste([X|C],[[X]|MC]).

premiere_colonne([X|C],matrice([[Y|L]|LL]),matrice([[X,Y|L]|CLL])) :-
   premiere_colonne_(C,LL,CLL).

premiere_colonne_([],[],[]).
premiere_colonne_([X|C],[L|M],[[X|L]|CM]) :-
   L= [_|_],
   premiere_colonne_(C,M,CM).

en_liste([],[]).
en_liste([X|L],[[X]|LL]) :-
   en_liste(L,LL).


derniere_ligne(matrice_vide,[X|L],matrice([[X|L]])).
derniere_ligne(matrice(M),L,matrice(ML)) :-
   M = [_|_],
   derniere_ligne_(M,L,ML).
derniere_ligne_([],L,[L]).
derniere_ligne_([L_|M],L,[L_|ML]) :-
   derniere_ligne_(M,L,ML).


derniere_colonne(matrice_vide,C,MC) :-
   premiere_colonne(C,matrice_vide,MC).
derniere_colonne(matrice(M),C,matrice(MC)) :-
   derniere_colonne_(M,C,MC).
derniere_colonne_([],[],[]).
derniere_colonne_([L|M],[X|C],[L_X|C_M]) :-
   L = [_|_],
   conc(L,[X],L_X),
   derniere_colonne_(M,C,C_M).
