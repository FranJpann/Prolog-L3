% RUBIK'S CUBE

:-['MATRICE'].

rotation_matrice(matrice_vide, matrice_vide).
rotation_matrice(M, R) :-
    premiere_ligne(L, SM, M),
    rotation_matrice(SM, SR),
    reverse(L, C),
    premiere_colonne(C, SR, R).

rubikscube(
    matrice([[j1,j2,j3], [j4,j5, j6], [j7,j8, j9]]),
    matrice([[o1,o2,o3], [o4,o5,o6], [o7,o8,o9]]),
    matrice([[v1,v2,v3], [v4,v5,v6], [v7,v8,v9]]),
    matrice([[b1,b2,b3], [b4,b5,b6], [b7,b8, b9]]),
    matrice([[m1,m2,m3], [m4,m5,m6], [m7, m8,m9]]),
    matrice([[r1,r2,r3], [r4,r5,r6], [r7,r8,r9]])
).

rotation_couronne(cube(J, O, V, B, M, R), cube(J_, M_, O_, V_, B_, R)) :-
    rotation_matrice(J, J_),
    derniere_ligne(O__, LO, O),
    derniere_colonne(V__, CV, V),
    premiere_ligne(LB, B__, B),
    premiere_colonne(CM, M__, M),
    reverse(LO, RO), reverse(LB, RB),
    derniere_ligne(O__, CM, O_),
    derniere_colonne(V__, RO,V_),
    premiere_ligne(CV , B__, B_),
    premiere_colonne(RB, M__, M_).

ieme_bande(I, cube(_J, O, V, B, M, _R), Bande ):-
    ieme_bande_rec(I, O, V, B, M, Bande).
ieme_bande_rec(1, O, V, B, M, bande(LO, CV, LB, CM)) :-
    derniere_ligne(_, LO, O),
    derniere_colonne(_, CV, V),
    premiere_ligne(LB, _, B),
    premiere_colonne(CM, _, M).
ieme_bande(N, O, V, B, M, Bande):-
    N > 1, N_ is N - 1,
    derniere_ligne(O_,_, O), derniere_colonne(V_, _, V),
    premiere_ligne(_, B_, B), premiere_colonne(_, M_, M),
    ieme_bande_rec(N_, O_, V_, B_, M_, Bande).

r_b(I, cube(_J, O, V, B, M, _R), cube(J, O_, V_, B_, M_, R)):-
    r_b_rec(I, O, V, B, M, O_, V_, B_, M_).
r_b_rec(N, O, V, B, M, O_, V_, B_, M_) :-
    N>1, N_ is N-1,
    derniere_ligne(O__, LO, O), derniere_colonne(V__, CV, V),
    premiere_ligne(LB, B__, B), premiere_colonne(CM, M__, M),
    r_b_rec(N_, O__, V__, B__, M__, O3, V3, B3, M3),
    derniere_ligne(O3, LO, O), derniere_colonne(V3, CV, V),
    premiere_ligne(LB, B3, B), premiere_colonne(CM, M3, M).
r_b_rec(1, O, V, B, M, O_, V_, B_, M_) :-
    derniere_ligne(O__, LO, O),
    derniere_colonne(V__, CV, V),
    premiere_ligne(LB, B__, B),
    premiere_colonne(CM, M__, M),
    reverse(LO, RO), reverse(LB, RB),
    derniere_ligne(O__, CM, O_),
    derniere_colonne(V__, RO,V_),
    premiere_ligne(CV , B__, B_),
    premiere_colonne(RB, M__, M_).