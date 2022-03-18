% sorte : Liste
% symboles de constante et fonction
%  [_|_] : E x Liste(E) -> Liste(E)
%  [] : Liste(E)
% symboles de predicat
%  'liste_?' : _
%  suppression : Liste(E) x E x Liste(E)
%  renverse : Liste(E) x Liste(E)
%  renverse_ : Liste(E) x Liste(E) x Liste(E)
%  conc : Liste(E) x Liste(E) x Liste(E)
%  supprime_element : E x Liste(E) x Liste(E)
%  membre : E x Liste(E)
%  ieme : Nat x Liste(E) x E.

% definition
'liste_?'([]).
'liste_?'([_X|L]) :- 
   'liste_?'(L).

suppression([X|L],X,L).
suppression([Y|L],X,[Y|L_]) :- 
   suppression(L,X,L_).

renverse(L,R) :- renverse_(L,[],R).

renverse_([],Acc,Acc).
renverse_([X|L],Acc,R) :-
   renverse_(L,[X|Acc],R).


conc([],L2,L2). 
conc([X|L1],L2,[X|L3]) :- 
   conc(L1,L2,L3).

supprime_element(_,[],[]).
supprime_element(X,[X|L],L_) :-
   supprime_element(X,L,L_).
supprime_element(X,[Y|L],[Y|L_]) :-
   \+(X=Y),
   supprime_element(X,L,L_).


membre(X,[X|_L]).
membre(X,[_Y|L]) :- 
   membre(X,L).

ieme(zero, [X | _], X).
ieme(s(N), [_ | L], X) :-
   ieme(N, L, X).