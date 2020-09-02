%1. Paprasti predikatai su sveikųjų skaičių sąrašais:
%1.1. did(S) - teisingas, kai duoto sveikųjų skaičių sąrašo S elementai išdėstyti didėjimo tvarka.

did([_]).
did([Pirmas, Antras | Likes]):-(Pirmas =< Antras), did([Antras|Likes]), !.

%?- did([4, 18, 23, 100]). - true.
%?- did([4, 4, 18, 23, 100]). - true.
%?- did([4, 23, 18, 100]). - false.

%2. Paprasti nearitmetiniai predikatai:
%2.1. dubl_trigub(S,R) - sąrašas R gaunamas iš S, pastarojo teigiamus elementus pakartojant du kartus, o neteigiamus - tris kartus.

%kartoti(Skaicius, Rezultatas) - galima perduoti skaičių, nenurodant kiek kartų jį reikia pakartoti.
kartoti(Skaicius, Rezultatas):-kiekkartoti(Skaicius, _, Rezultatas).
%kiekkartoti([H|T], Y, Rezultatas) - perduoda skaičių į ciklą ir nurodo kiek kartų jį kartoti pagal ženklą.
kiekkartoti([H|T], Y, Rezultatas):-H > 0,
                                   Y is 2,
								   kartojimas([H|T], Y - 1, Rezultatas), !.
kiekkartoti([H|T], Y, Rezultatas):-H =< 0,
                                   Y is 3,
								   kartojimas([H|T], Y - 1, Rezultatas), !.
%kartojimas(Skaicius, Kartojimai, Rezultatas) - grąžina sąrašą, kur perduotas skaičius yra pakartotas perduotą skaičių kartų. 
kartojimas(Skaicius, Kartojimai, Rezultatas):- Kartojimai = 0, Rezultatas = Skaicius, !.
kartojimas([H|T], Kartojimai, Rezultatas):-Kartojimai \= 0,
                                           NKartojimai is Kartojimai-1,
						                   kartojimas([H|[H|T]], NKartojimai, Rezultatas).
apjungti([], A, A).
apjungti([E|A], B, [E|AB]):-apjungti(A, B, AB).
pakartotassarasas([], []).
pakartotassarasas([H|T], ApjungtasSarasas):-pakartotassarasas(T, Sarasas),
                                            kartoti([H], PakartotiSkaiciai),
							                apjungti(PakartotiSkaiciai, Sarasas, ApjungtasSarasas).
dubl_trigub(S, R):-pakartotassarasas(S, R).

%?- dubl_trigub([-3, 2, 0], R). - R = [-3, -3, -3, 2, 2, 0, 0, 0].

%3. Sudėtingesni predikatai:
%3.7. keisti(S,K,R) - duotas sąrašas S. Duotas sąrašas K, nusakantis keitinį ir susidedantis iš elementų pavidalo k(KeiciamasSimbolis, PakeistasSimbolis). R - rezultatas, gautas pritaikius sąrašui S keitinį K.

k(_, _).
keitinys(Simbolis, KeiciamasSimbolis, _, Gauta):-Simbolis \= KeiciamasSimbolis, Gauta = Simbolis.
keitinys(Simbolis, KeiciamasSimbolis, Keitimas, Gauta):-Simbolis == KeiciamasSimbolis, Gauta = Keitimas.
keitinys(Simbolis, KeiciamasSimbolis, _, _):-Simbolis \= KeiciamasSimbolis.
%keitinioargumentai(Keitinys, X, Y) - išgauname keitinio argumentus.
keitinioargumentai(Keitinys, X, Y):-k(X, Y) = Keitinys.
%keitimas([H|T], HSar, GautasSimbolis) - pereiname per keitinių sąrašą.
keitimas([], _, _).
keitimas([H|T], HSar, GautasSimbolis):-keitimas(T, HSar, GautasSimbolis),
		                               keitinioargumentai(H, KeiciamasSimbolis, PakeistasSimbolis),
			                           keitinys(HSar, KeiciamasSimbolis, PakeistasSimbolis, GautasSimbolis).
%pradinissarasas([HSar|TSar], Keitinys, [Pakeistas|Rezultatas]) - pereiname per pradinį sąrašą.
pradinissarasas([], _, []).
pradinissarasas([HSar|TSar], Keitinys, [Pakeistas|Rezultatas]):-pradinissarasas(TSar, Keitinys, Rezultatas),
                                                                keitimas(Keitinys, HSar, Pakeistas).
keisti(Sar, Keit, Ats):-pradinissarasas(Sar, Keit, Ats), !.

%?- keisti([a,c,b],[k(a,x),k(b,y)], R). - R = [x, c, y].
%?- keisti([a,w,c,x,e,y,g,z],[k(w,b),k(x,d),k(y,f),k(z,h)],R). - R = [a, b, c, d, e, f, g, h].

%4. Operacijos su natūraliaisiais skaičiais, išreikštais skaitmenų sąrašais:
%4.7. i_dvejet(Des,Dvej) - Des yra skaičius vaizduojami dešimtainių skaitmenų sąrašu. Dvej - tas pats skaičiaus, vaizduojamas dvejetainių skaitmenų sąrašu.

%listtodecimal(Sarasas, Rezultatas) - Skaičių sąrašą pakeičia į skaičių
listtodecimal([], X, X).
listtodecimal([H|T], SenaSuma, Rezultatas):-NaujaSuma is SenaSuma * 10 + H,
                                            listtodecimal(T, NaujaSuma, Rezultatas).
listtodecimal(Sarasas, Rezultatas):-listtodecimal(Sarasas, 0, Rezultatas).
i_dvejet(0, Sarasas, Sarasas).
i_dvejet(Skaicius, Sarasas, Rezultatas):-Skaicius > 0,
                                         SarNarys is Skaicius mod 2,
                                         NSkaicius is Skaicius // 2,
						                 i_dvejet(NSkaicius, [SarNarys|Sarasas], Rezultatas), !.
i_dvejet(Des,Dvej):-listtodecimal(Des, DesSkaicius), i_dvejet(DesSkaicius, [], Dvej).

%?- i_dvejet([1,3,9],Dvej). - Dvej = [1, 0, 0, 0, 1, 0, 1, 1].