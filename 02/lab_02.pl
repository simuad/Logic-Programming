%2. Duomenų bazėje saugomi duomenys apie studentus faktais: studentas(Vardas, Kursas); yraVyresnis(StudentoVardas1, StudentoVardas2). Sąryšis „būti vyresniu“ yra tranzityvus, todėl į faktų aibę neįtraukiami tie faktai, kurie seka iš tranzityvumo sąryšio. Apibrėžkite predikatą:
%2.5 „studentas A yra vyresnis už žemesnio kurso studentą B“.
studentas(daiva, 1).
studentas(mykolas, 1).
studentas(darius, 1).
studentas(petras, 2).
studentas(ernesta, 2).
studentas(greta, 2).
studentas(marius, 3).
studentas(kamile, 3).
studentas(zigmas, 3).
studentas(jonas, 4).
studentas(karolina, 4).
studentas(elze, 4).
yraVyresnis(zigmas, karolina).
yraVyresnis(karolina, elze).
yraVyresnis(elze, kamile).
yraVyresnis(kamile, darius).
yraVyresnis(darius, jonas).
yraVyresnis(jonas, ernesta).
yraVyresnis(ernesta, marius).
yraVyresnis(marius, petras).
yraVyresnis(petras, greta).
yraVyresnis(greta, mykolas).
yraVyresnis(mykolas, daiva).
aukstesnio_kurso(Studentas1, Studentas2):-studentas(Studentas1, St1_kursas), studentas(Studentas2, St2_kursas), St1_kursas > St2_kursas.
vyresnis_uz_zemesnio(Studentas1, Studentas2):-vyresnis_uz_zemesnio(Studentas1, Studentas2, Studentas1), !.
vyresnis_uz_zemesnio(Studentas1, Studentas2, PradinisStudentas):-yraVyresnis(Studentas1, Studentas2), aukstesnio_kurso(PradinisStudentas, Studentas2).
vyresnis_uz_zemesnio(Studentas1, Studentas2, PradinisStudentas):-yraVyresnis(Studentas1, TarpinisStudentas), vyresnis_uz_zemesnio(TarpinisStudentas, Studentas2, PradinisStudentas).
%?- vyresnis_uz_zemesnio(zigmas, darius). - true. (Vyresnis ir aukštesnio kurso)
%?- vyresnis_uz_zemesnio(zigmas, kamile). - false. (Vyresnis ir to pačio kurso)
%?- vyresnis_uz_zemesnio(zigmas, jonas). - false. (Vyresnis ir žemesnio kurso)
%?- vyresnis_uz_zemesnio(greta, darius). - false. (Jaunesnė ir aukštesnio kurso)
%?- vyresnis_uz_zemesnio(greta, ernesta). - false. (Jaunesnė ir to pačio kurso)
%?- vyresnis_uz_zemesnio(greta, zigmas). - false. (Jaunesnė ir žemesnio kurso)
%5. Apibrėžkite predikatą realizuojantį nurodytą sveikaskaitę operaciją naudojant tik sudėties ir atimties operacijas:
%5.3 dalybos liekana (mod).
%Case 1: Skaicius1 >= 0, Skaicius2 > 0
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 >= 0, Skaicius2 > 0, Skaicius1 < Skaicius2, Liekana is Skaicius1, !.
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 >= 0, Skaicius2 > 0, Skaicius1 >= Skaicius2, mod(Skaicius1 - Skaicius2, Skaicius2, Liekana), !.
%Case 2: Skaicius1 > 0, Skaicius2 < 0
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 > 0, Skaicius2 < 0, Skaicius1 =< 0, Liekana is Skaicius1, !.
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 > 0, Skaicius2 < 0, mod(Skaicius1 + Skaicius2, Skaicius2, Liekana), !.
%Case 3: Skaicius1 < 0, Skaicius2 > 0
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 < 0, Skaicius2 > 0, Skaicius1 >= 0, Liekana is Skaicius1, !.
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 < 0, Skaicius2 > 0, mod(Skaicius1 + Skaicius2, Skaicius2, Liekana), !.
%Case 4: Skaicius1 =< 0, Skaicius2 < 0
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 =< 0, Skaicius2 < 0, Skaicius1 > Skaicius2, Liekana is Skaicius1, !.
mod(Skaicius1, Skaicius2, Liekana):-Skaicius1 =< 0, Skaicius2 < 0, Skaicius1 =< Skaicius2, mod(Skaicius1 - Skaicius2, Skaicius2, Liekana), !.
%?- mod(16, 0, X). - false.
%?- mod(-16, 0, X). - false.
%?- mod(16, 3, X). - X = 1.
%?- mod(16, -3, X). - X = -2.
%?- mod(-16, 3, X). - X = 2.
%?- mod(-16, -3, X). - X = -1.