:- dynamic(meme/2).
:- dynamic(voisin/2).
:- dynamic(droite/2).
:- dynamic(gauche/2).

% Enumeration des valeurs possibles
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

% Permet de convertir une valeur vers une variable où le "type" est assuré.
% Ceci nous permet de savoir le "type" d'une variable donnée.
% Exemple: valeurVersItems(kiwi, C, N, A, B, M) retournera kiwi dans M
%          car c'est un met, tout en gardant les autres variables libres.
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

% Même fonctionnement que valeurVersItems, mais appliqué à un tuple.
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

% Construction de la liste des 5 maisons basé sur les faits. À noter que la position
% d'une maison est représenté par son index dans la liste, où l'index commence à 1.
obtenirMaisonsSelonFaits(Maisons) :-
  length(Maisons, 5),
  verifierFaitsMemeMaison(Maisons),
  verifierFaitsVoisin(Maisons),
  verifierFaitsGauche(Maisons),
  verifierFaitsDroite(Maisons),
  verifierCouleurs(Maisons),
  verifierNationalites(Maisons),
  verifierAnimals(Maisons),
  verifierBreuvages(Maisons),
  verifierMets(Maisons).

% Vérifications de tous les faits de type meme, voisin, gauche et droite ainsi
% qu'une validation pour s'assurer que toutes les valeurs possibles sont utilisées.
verifierFaitsMemeMaison(Maisons) :-
  findall((X, Y), meme(X, Y), XS),
  maplist(verifierFaitMemeMaison(Maisons), XS).

verifierFaitsVoisin(Maisons) :-
  findall((X, Y), voisin(X, Y), VS),
  maplist(verifierFaitVoisin(Maisons), VS).

verifierFaitsGauche(Maisons) :-
  findall((X, Y), gauche(X, Y), XS),
  maplist(verifierFaitGauche(Maisons), XS).

verifierFaitsDroite(Maisons) :-
  findall((X, Y), droite(X, Y), XS),
  maplist(verifierFaitDroite(Maisons), XS).

verifierCouleurs(Maisons) :-
  findall((X), couleur(X), XS),
  maplist(verifierCouleur(Maisons), XS).

verifierNationalites(Maisons) :-
  findall((X), nationalite(X), XS),
  maplist(verifierNationalite(Maisons), XS).

verifierAnimals(Maisons) :-
  findall((X), animal(X), XS),
  maplist(verifierAnimal(Maisons), XS).

verifierBreuvages(Maisons) :-
  findall((X), breuvage(X), XS),
  maplist(verifierBreuvage(Maisons), XS).

verifierMets(Maisons) :-
  findall((X), met(X), XS),
  maplist(verifierMet(Maisons), XS).

% Applique chacun des faits en respect à la liste de maison.

verifierFaitVoisin(Maisons, (X, Y)) :-
  position(X),
  valeurVersItem(Y, C, N, A, B, M),
  PY is X+1,
  nth1(PY, Maisons, maison(C, N, A, B, M)).

verifierFaitVoisin(Maisons, (Y, X)) :-
  position(X),
  valeurVersItem(Y, C, N, A, B, M),
  PY is X+1,
  nth1(PY, Maisons, maison(C, N, A, B, M)).

verifierFaitVoisin(Maisons, (X, Y)) :-
  valeurVersItems(X, CX, NX, AX, BX, MX),
  valeurVersItems(Y, CY, NY, AY, BY, MY),
  append(_, [maison(CX, NX, AX, BX, MX), maison(CY, NY, AY, BY, MY) | _], Maisons).

verifierFaitVoisin(Maisons, (Y, X)) :-
  valeurVersItems(X, CX, NX, AX, BX, MX),
  valeurVersItems(Y, CY, NY, AY, BY, MY),
  append(_, [maison(CX, NX, AX, BX, MX), maison(CY, NY, AY, BY, MY) | _], Maisons).

verifierFaitMemeMaison(Maisons, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(X, Maisons, maison(C, N, A, B, M)).

verifierFaitMemeMaison(Maisons, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(X, Maisons, maison(C, N, A, B, M)).

verifierFaitMemeMaison(Maisons, T) :-
  tupleVersItems(T, C, N, A, B, M),
  member(maison(C, N, A, B, M), Maisons).

verifierFaitGauche(Maisons, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, Maisons, maison(C, N, A, B, M)),
  X < PY.

verifierFaitGauche(Maisons, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, Maisons, maison(C, N, A, B, M)),
  X < PY.

verifierFaitGauche(Maisons, (X, Y)) :-
  valeurVersItems(X, C1, N1, A1, B1, M1),
  valeurVersItems(Y, C2, N2, A2, B2, M2),
  nth1(PX, Maisons, maison(C1, N1, A1, B1, M1)),
  nth1(PY, Maisons, maison(C2, N2, A2, B2, M2)),
  PX < PY.

verifierFaitDroite(Maisons, (X, Y)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, Maisons, maison(C, N, A, B, M)),
  X > PY.

verifierFaitDroite(Maisons, (Y, X)) :-
  position(X),
  valeurVersItems(Y, C, N, A, B, M),
  nth1(PY, Maisons, maison(C, N, A, B, M)),
  X > PY.

verifierFaitDroite(Maisons, (X, Y)) :-
  valeurVersItems(X, C1, N1, A1, B1, M1),
  valeurVersItems(Y, C2, N2, A2, B2, M2),
  nth1(PX, Maisons, maison(C1, N1, A1, B1, M1)),
  nth1(PY, Maisons, maison(C2, N2, A2, B2, M2)),
  PX > PY.

verifierCouleur(Maisons, X) :-
  member(maison(X, _, _, _, _), Maisons).

verifierNationalite(Maisons, X) :-
  member(maison(_, X, _, _, _), Maisons).

verifierAnimal(Maisons, X) :-
  member(maison(_, _, X, _, _), Maisons).

verifierBreuvage(Maisons, X) :-
  member(maison(_, _, _, X, _), Maisons).

verifierMet(Maisons, X) :-
  member(maison(_, _, _, _, X), Maisons).

question( Position, Couleur, Nationalite, Animal, Breuvage, Mets ) :-
  obtenirMaisonsSelonFaits(Maisons),
  nth1(Position, Maisons, maison(Couleur, Nationalite, Animal, Breuvage, Mets)).
