:- dynamic(faitsMaisons/6).

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

memeSansOrdre(X, Y) :-
  meme(X, Y);
  meme(Y, X).

memeTest(X, Y) :-
  memeSansOrdre(X, Y),
  (
    maison(X, Y, _, _, _, _);
    maison(X, _, Y, _, _, _);
    maison(X, _, _, Y, _, _);
    maison(X, _, _, _, Y, _);
    maison(X, _, _, _, _, Y);
    maison(_, X, Y, _, _, _);
    maison(_, X, _, Y, _, _);
    maison(_, X, _, _, Y, _);
    maison(_, X, _, _, _, Y);
    maison(_, _, X, Y, _, _);
    maison(_, _, X, _, Y, _);
    maison(_, _, X, _, _, Y);
    maison(_, _, _, X, Y, _);
    maison(_, _, _, X, _, Y);
    maison(_, _, _, _, X, Y);
    maison(Y, X, _, _, _, _);
    maison(Y, _, X, _, _, _);
    maison(Y, _, _, X, _, _);
    maison(Y, _, _, _, X, _);
    maison(Y, _, _, _, _, X);
    maison(_, Y, X, _, _, _);
    maison(_, Y, _, X, _, _);
    maison(_, Y, _, _, X, _);
    maison(_, Y, _, _, _, X);
    maison(_, _, Y, X, _, _);
    maison(_, _, Y, _, X, _);
    maison(_, _, Y, _, _, X);
    maison(_, _, _, Y, X, _);
    maison(_, _, _, Y, _, X);
    maison(_, _, _, _, Y, X)
  ).

memeMaison(X, Y) :-
  memeSansOrdre(X, Y).
memeMaison(X, Y) :-
  memeSansOrdre(X, Z),
  X \= Z,
  Z \= Y,
  memeSansOrdre(Z, Y).
memeMaison(X, Y) :-
  voisinSansOrdre(X, Z),
  position(Y),
  Y1 is Y + 1,
  Y2 is Y - 1,
  (memeSansOrdre(Z, Y1);memeSansOrdre(Z, Y2)).

voisin( celeri, renard ).
voisin( norvegien, bleu ).
voisin( kiwi, cheval ).
voisin( verte, ivoire ).
voisinSansOrdre(X, Y) :-
  voisin(X, Y);
  voisin(Y, X).

droite( verte, ivoire ).
droite(X, Y) :-
  droite(X, Z),
  droite(Z, Y).

gauche(1, 2).
gauche(2, 3).
gauche(3, 4).
gauche(4, 5).
gauche(X, Y) :-
  gauche(X, Z),
  gauche(Z, Y).

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

maison(Position, Couleur, Nationalite, Animal, Breuvage, Met) :-
  position(Position),
  couleur(Couleur),
  nationalite(Nationalite),
  animal(Animal),
  breuvage(Breuvage),
  met(Met).

rue([maison(1, CA, NA, AA, BA, MA),
     maison(2, CB, NB, AB, BB, MB),
     maison(3, CC, NC, AC, BC, MC),
     maison(4, CD, ND, AD, BD, MD),
     maison(5, CE, NE, AE, BE, ME)
    ]) :-
  tousDiff([CA, CB, CC, CD, CE]),
  tousDiff([NA, NB, NC, ND, NE]),
  tousDiff([AA, AB, AC, AD, AE]),
  tousDiff([BA, BB, BC, BD, BE]),
  tousDiff([MA, MB, MC, MD, ME]).

testFM(Houses) :-
  member(maison(1, _, norvegien, _, _, _), Houses).

creerFaitsMaisons :-
  findall((X, Y), meme(X, Y), XS),
  maplist(creerFaitMaisonSansOrdre, XS),
  findall((X, Y), voisin(X, Y), VS).

creerFaitMaisonSansOrdre((X, Y)) :-
  (creerFaitMaison((X, Y)), !);
  (creerFaitMaison((Y, X)), !).

creerFaitMaison((X, Y)) :-
  position(X),
  couleur(Y),
  assert(faitsMaisons(X, Y, _, _, _, _)).

creerFaitMaison((X, Y)) :-
  position(X),
  nationalite(Y),
  assert(faitsMaisons(X, _, Y, _, _, _)).

creerFaitMaison((X, Y)) :-
  position(X),
  animal(Y),
  assert(faitsMaisons(X, _, _, Y, _, _)).

creerFaitMaison((X, Y)) :-
  position(X),
  breuvage(Y),
  assert(faitsMaisons(X, _, _, _, Y, _)).

creerFaitMaison((X, Y)) :-
  position(X),
  met(Y),
  assert(faitsMaisons(X, _, _, _, _, Y)).

creerFaitMaison((X, Y)) :-
  couleur(X),
  nationalite(Y),
  assert(faitsMaisons(_, X, Y, _, _, _)).

creerFaitMaison((X, Y)) :-
  couleur(X),
  animal(Y),
  assert(faitsMaisons(_, X, _, Y, _, _)).

creerFaitMaison((X, Y)) :-
  couleur(X),
  breuvage(Y),
  assert(faitsMaisons(_, X, _, _, Y, _)).

creerFaitMaison((X, Y)) :-
  couleur(X),
  met(Y),
  assert(faitsMaisons(_, X, _, _, _, Y)).

creerFaitMaison((X, Y)) :-
  nationalite(X),
  animal(Y),
  assert(faitsMaisons(_, _, X, Y, _, _)).

creerFaitMaison((X, Y)) :-
  nationalite(X),
  breuvage(Y),
  assert(faitsMaisons(_, _, X, _, Y, _)).

creerFaitMaison((X, Y)) :-
  nationalite(X),
  met(Y),
  assert(faitsMaisons(_, _, X, _, _, Y)).

creerFaitMaison((X, Y)) :-
  animal(X),
  breuvage(Y),
  assert(faitsMaisons(_, _, _, X, Y, _)).

creerFaitMaison((X, Y)) :-
  animal(X),
  met(Y),
  assert(faitsMaisons(_, _, _, X, _, Y)).

creerFaitMaison((X, Y)) :-
  breuvage(X),
  met(Y),
  assert(faitsMaisons(_, _, _, _, X, Y)).

question( Position, Couleur, Nationalite, Animal, Breuvage, Mets ) :-
	maison(Position, Couleur, Nationalite, Animal, Breuvage, Mets),
  memeMaison(Position, Couleur),
  memeMaison(Position, Nationalite),
  memeMaison(Position, Animal),
  memeMaison(Position, Breuvage),
  memeMaison(Position, Mets).

tousDiff([]).
tousDiff(XS) :-
   list_to_set(XS, SS),
   length(XS, L1),
   length(SS, L2),
   L1 = L2.
