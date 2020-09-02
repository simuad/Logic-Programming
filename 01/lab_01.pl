asmuo(kotryna, moteris, 35, šokti).
asmuo(hubertas, vyras, 40, limonadas).
asmuo(monika, moteris, 29, piešti).
asmuo(aleksas, vyras, 33, megzti).
asmuo(justinas, vyras, 6, limonadas).
asmuo(gerda, moteris, 1, smuikas).
asmuo(akvilė, moteris, 3, limonadas).
asmuo(egidijus, vyras, 4, futbolas).
asmuo(nojus, vyras, 5, smuikas).
asmuo(rusnė, moteris, 1, dainuoti).
asmuo(marius, vyras, 6, limonadas).
asmuo(titas, vyras, 2, limonadas).
mama(janė, kotryna).
mama(janė, hubertas).
mama(janė, monika).
mama(janė, aleksas).
mama(kotryna, justinas).
mama(kotryna, gerda).
mama(kotryna, akvilė).
mama(violeta, egidijus).
mama(violeta, nojus).
mama(monika, rusnė).
mama(monika, marius).
mama(barbora, titas).
pora(leonas, janė).
pora(motiejus, kotryna).
pora(hubertas, violeta).
pora(monika, kastytis).
pora(aleksas, barbora).

%2. vienas_is_tevu(TevasMama, Vaikas) - Pirmasis asmuo (TevasMama) yra antrojo (Vaikas) vienas iš tėvų (tėtis ar mama);
vienas_is_tevu(TevasMama, Vaikas):-mama(TevasMama, Vaikas).
vienas_is_tevu(TevasMama, Vaikas):-pora(TevasMama, Zmona), mama(Zmona, Vaikas).
%?- vienas_is_tevu(janė, kotryna). - true
%?- vienas_is_tevu(leonas, justinas). - false

%28. turi_vaiku(TevasMama) - Asmuo TevasMama turi vaikų;
turi_vaiku(TevasMama):-mama(TevasMama, _).
turi_vaiku(TevasMama):-pora(TevasMama, Zmona), mama(Zmona, _).
%?- turi_vaiku(hubertas). - true
%?- turi_vaiku(gerda). - false

%35. tmbml(Berniukas1, Berniukas2, Berniukas3) - „Trys maži berniukai - Berniukas1, Berniukas2 ir Berniukas3 - mėgsta limonadą“ (kas yra „maži“, nuspręskite patys);
mbml(Asmuo):-asmuo(Asmuo, vyras, Amzius, limonadas), Amzius < 7.
tmbml(Berniukas1, Berniukas2, Berniukas3):-mbml(Berniukas1), mbml(Berniukas2), mbml(Berniukas3).
%?- tmbml(justinas, marius, titas). - true
%?- tmbml(justinas, akvilė, titas). - false
%?- tmbml(hubertas, justinas, titas). - false

%37. vunderkindas(Kudikis) - Asmuo Kudikis „dar kūdikis, o jau groja (mėgsta groti) smuiku“;
vunderkindas(Kudikis):-asmuo(Kudikis, _, Amzius, smuikas), Amzius =< 1.
%?- vunderkindas(gerda). - true
%?- vunderkindas(nojus). - false