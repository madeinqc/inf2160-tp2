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

memeMaison(X, Y) :-
  meme(X, Y); meme(Y, X).
memeMaison(X, Y) :-
  droite(X, Z),
  droite(Y, Z).
memeMaison(X, Y) :-
  X \= Y,
  memeMaison(X, Z),
  memeMaison(Y, Z).

voisin( celeri, renard ).
voisin( norvegien, bleu ).
voisin( kiwi, cheval ).
voisin( verte, ivoire ).
voisin(X, Y) :-
	\+ memeMaison(X, 1),
	\+ memeMaison(Y, 1),
	\+ memeMaison(X, 5),
	\+ memeMaison(Y, 5),
	gauche(X, Y); gauche(Y, X).
voisin(X, Y) :-
	memeMaison(X, 1),
  gauche(X, Y).
voisin(X, Y) :-
	memeMaison(Y, 1),
	gauche(Y, X).
voisin(X, Y) :-
	memeMaison(X, 5),
  gauche(Y, X).
voisin(X, Y) :-
	memeMaison(Y, 5),
	gauche(X, Y).

droite( verte, ivoire ).

gauche(1, 2).
gauche(2, 3).
gauche(3, 4).
gauche(4, 5).
gauche(X, Y) :- droite(Y, X).

numero(1).
numero(2).
numero(3).
numero(4).
numero(5).
couleur(rouge).
couleur(jaune).
couleur(bleu).
couleur(verte).
couleur(ivoire).
nationalite(anglais).
nationalite(espagnol).
nationalite(norvegien).
nationalite(ukranien).
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

person(Numero, Couleur, Nationalite, Animal, Breuvage, Met) :-
  numero(Numero),
  couleur(Couleur),
  nationalite(Nationalite),
  animal(Animal),
  breuvage(Breuvage),
  met(Met).

question( Position, Couleur, Nationalite, Animal, Boisson, Mets ) :-
	person(Position, Couleur, Nationalite, Animal, Boisson, Mets),
	person(P2, C2, N2, A2, B2, M2),
	person(P3, C3, N3, A3, B3, M3),
	person(P4, C4, N4, A4, B4, M4),
	person(P5, C5, N5, A5, B5, M5),
	length([Position, P2, P3, P4, P5], LLP), list_to_set([Position, P2, P3, P4, P5], SP), length(SP, SLP), LLP = SLP,
	length([Couleur, C2, C3, C4, C5], LLC), list_to_set([Couleur, C2, C3, C4, C5], SC), length(SC, SLC), LLC = SLC,
	length([Nationalite, N2, N3, N4, N5], LLN), list_to_set([Nationalite, N2, N3, N4, N5], SN), length(SN, SLN), LLN = SLN,
	length([Animal, A2, A3, A4, A5], LLA), list_to_set([Animal, A2, A3, A4, A5], SA), length(SA, SLA), LLA = SLA,
	length([Boisson, B2, B3, B4, B5], LLB), list_to_set([Boisson, B2, B3, B4, B5], SB), length(SB, SLB), LLB = SLB,
	length([Mets, M2, M3, M4, M5], LLM), list_to_set([Mets, M2, M3, M4, M5], SM), length(SM, SLM), LLM = SLM.
