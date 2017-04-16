meme( anglais, rouge ).
meme( chien, espagnol ).
meme( norvegien, 1 ).
meme( kiwi, jaune ).
meme( wasabi, serpent ).
meme( litchi, jus_orange ).
meme( ukrainien, the ).
meme( canadien, poire ).
meme( cafe, verte ).
meme( lait, 3 ).

voisin( celeri, renard ).
voisin( norvegien, bleu ).
voisin( kiwi, cheval ).
voisin( verte, ivoire ).

droite( verte, ivoire ).

gauche(X, Y) :-
  droite(Y, X).

position(1).
position(2).
position(3).
position(4).
position(5).

couleur(rouge).
couleur(jaune).
couleur(bleu).
couleur(verte).
couleur(ivoire).

nationalite(anglais).
nationalite(espagnol).
nationalite(norvegien).
nationalite(ukrainien).
nationalite(canadien).

animal(chien).
animal(renard).
animal(serpent).
animal(cheval).
animal(zebre).

breuvage(jus_orange).
breuvage(the).
breuvage(cafe).
breuvage(lait).
breuvage(eau).

met(kiwi).
met(celeri).
met(wasabi).
met(litchi).
met(poire).

maison(Couleur, Nationalite, Animal, Breuvage, Met) :-
  couleur(Couleur),
  nationalite(Nationalite),
  animal(Animal),
  breuvage(Breuvage),
  met(Met).

valeurVersItems(X, X, _, _, _, _) :-
  couleur(X).

valeurVersItems(X, _, X, _, _, _) :-
  nationalite(X).

valeurVersItems(X, _, _, X, _, _) :-
  animal(X).

valeurVersItems(X, _, _, _, X, _) :-
  breuvage(X).

valeurVersItems(X, _, _, _, _, X) :-
  met(X).

tupleVersItems((X, Y), X, Y, _, _, _) :-
  couleur(X), nationalite(Y).

tupleVersItems((X, Y), X, _, Y, _, _) :-
  couleur(X), animal(Y).

tupleVersItems((X, Y), X, _, _, Y, _) :-
  couleur(X), breuvage(Y).

tupleVersItems((X, Y), X, _, _, _, Y) :-
  couleur(X), met(Y).

tupleVersItems((X, Y), _, X, Y, _, _) :-
  nationalite(X), animal(Y).

tupleVersItems((X, Y), _, X, _, Y, _) :-
  nationalite(X), breuvage(Y).

tupleVersItems((X, Y), _, X, _, _, Y) :-
  nationalite(X), met(Y).

tupleVersItems((X, Y), _, _, X, Y, _) :-
  animal(X), breuvage(Y).

tupleVersItems((X, Y), _, _, X, _, Y) :-
  animal(X), met(Y).

tupleVersItems((X, Y), _, _, _, X, Y) :-
  breuvage(X), met(Y).

tupleVersItems((Y, X), X, Y, _, _, _) :-
  couleur(X), nationalite(Y).

tupleVersItems((Y, X), X, _, Y, _, _) :-
  couleur(X), animal(Y).

tupleVersItems((Y, X), X, _, _, Y, _) :-
  couleur(X), breuvage(Y).

tupleVersItems((Y, X), X, _, _, _, Y) :-
  couleur(X), met(Y).

tupleVersItems((Y, X), _, X, Y, _, _) :-
  nationalite(X), animal(Y).

tupleVersItems((Y, X), _, X, _, Y, _) :-
  nationalite(X), breuvage(Y).

tupleVersItems((Y, X), _, X, _, _, Y) :-
  nationalite(X), met(Y).

tupleVersItems((Y, X), _, _, X, Y, _) :-
  animal(X), breuvage(Y).

tupleVersItems((Y, X), _, _, X, _, Y) :-
  animal(X), met(Y).

tupleVersItems((Y, X), _, _, _, X, Y) :-
  breuvage(X), met(Y).

verifierFaitsMaisons(Houses) :-
  length(Houses, 5),
  maisonsToutesDiff(Houses),
  verifierFaitsMemeMaison(Houses),
  verifierFaitsVoisin(Houses),
  verifierFaitsGauche(Houses),
  verifierFaitsDroite(Houses),
  verifierCouleurs(Houses),
  verifierNationalites(Houses),
  verifierAnimals(Houses),
  verifierBreuvages(Houses),
  verifierMets(Houses).

verifierFaitsVoisin(H) :-
  findall((X, Y), voisin(X, Y), VS),
  maplist(verifierFaitVoisin(H), VS).

verifierFaitsMemeMaison(H) :-
  findall((X, Y), meme(X, Y), XS),
  maplist(verifierFaitMemeMaison(H), XS).

verifierFaitsGauche(H) :-
  findall((X, Y), gauche(X, Y), XS),
  maplist(verifierFaitGauche(H), XS).

verifierFaitsDroite(H) :-
  findall((X, Y), droite(X, Y), XS),
  maplist(verifierFaitDroite(H), XS).

verifierCouleurs(H) :-
    findall((X), couleur(X), XS),
    maplist(verifierCouleur(H), XS).

verifierNationalites(H) :-
  findall((X), nationalite(X), XS),
  maplist(verifierNationalite(H), XS).

verifierAnimals(H) :-
  findall((X), animal(X), XS),
  maplist(verifierAnimal(H), XS).

verifierBreuvages(H) :-
  findall((X), breuvage(X), XS),
  maplist(verifierBreuvage(H), XS).

verifierMets(H) :-
  findall((X), met(X), XS),
  maplist(verifierMet(H), XS).

verifierFaitVoisin(H, (X, Y)) :-
  position(X),
  valeurVersItem(Y, C, N, A, B, M),
  PY is X+1,
  nth1(PY, H, maison(C, N, A, B, M)).

verifierFaitVoisin(H, (Y, X)) :-
  position(X),
  valeurVersItem(Y, C, N, A, B, M),
  PY is X+1,
  nth1(PY, H, maison(C, N, A, B, M)).

verifierFaitVoisin(H, (X, Y)) :-
  valeurVersItems(X, CX, NX, AX, BX, MX),
  valeurVersItems(Y, CY, NY, AY, BY, MY),
  append(_, [maison(CX, NX, AX, BX, MX), maison(CY, NY, AY, BY, MY) | _], H).

verifierFaitVoisin(H, (Y, X)) :-
  valeurVersItems(X, CX, NX, AX, BX, MX),
  valeurVersItems(Y, CY, NY, AY, BY, MY),
  append(_, [maison(CX, NX, AX, BX, MX), maison(CY, NY, AY, BY, MY) | _], H).

verifierFaitMemeMaison(H, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(X, H, maison(C, N, A, B, M)).

verifierFaitMemeMaison(H, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(X, H, maison(C, N, A, B, M)).

verifierFaitMemeMaison(H, T) :-
  tupleVersItems(T, C, N, A, B, M),
  member(maison(C, N, A, B, M), H).

verifierFaitGauche(H, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, H, maison(C, N, A, B, M)),
  X < PY.

verifierFaitGauche(H, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, H, maison(C, N, A, B, M)),
  X < PY.

verifierFaitGauche(H, (X, Y)) :-
  valeurVersItems(X, C1, N1, A1, B1, M1),
  valeurVersItems(Y, C2, N2, A2, B2, M2),
  nth1(PX, H, maison(C1, N1, A1, B1, M1)),
  nth1(PY, H, maison(C2, N2, A2, B2, M2)),
  PX < PY.

verifierFaitDroite(H, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, H, maison(C, N, A, B, M)),
  X > PY.

verifierFaitDroite(H, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, H, maison(C, N, A, B, M)),
  X > PY.

verifierFaitDroite(H, (X, Y)) :-
  valeurVersItems(X, C1, N1, A1, B1, M1),
  valeurVersItems(Y, C2, N2, A2, B2, M2),
  nth1(PX, H, maison(C1, N1, A1, B1, M1)),
  nth1(PY, H, maison(C2, N2, A2, B2, M2)),
  PX > PY.

verifierCouleur(H, X) :-
  member(maison(X, _, _, _, _), H).

verifierNationalite(H, X) :-
  member(maison(_, X, _, _, _), H).

verifierAnimal(H, X) :-
  member(maison(_, _, X, _, _), H).

verifierBreuvage(H, X) :-
  member(maison(_, _, _, X, _), H).

verifierMet(H, X) :-
  member(maison(_, _, _, _, X), H).

maisonsToutesDiff([maison(C1, N1, A1, B1, M1), maison(C2, N2, A2, B2, M2), maison(C3, N3, A3, B3, M3), maison(C4, N4, A4, B4, M4), maison(C5, N5, A5, B5, M5)]) :-
  tousDiff([C1, C2, C3, C4, C5]),
  tousDiff([N1, N2, N3, N4, N5]),
  tousDiff([A1, A2, A3, A4, A5]),
  tousDiff([B1, B2, B3, B4, B5]),
  tousDiff([M1, M2, M3, M4, M5]).

tousDiff([]).
tousDiff(XS) :-
   list_to_set(XS, SS),
   length(XS, L1),
   length(SS, L2),
   L1 = L2.

question( Position, Couleur, Nationalite, Animal, Breuvage, Mets ) :-
  verifierFaitsMaisons(Houses),
  nth1(Position, Houses, maison(Couleur, Nationalite, Animal, Breuvage, Mets)).
