%15. [S] Magiškasis kvadratas.
%Į kvadratą N×N (N duotas) sudėliokite skirtingus skaičius nuo 1 iki duotojo N×N taip, kad jis taptų magiškuoju: eilučių, stulpelių, bei abiejų įstrižainių skaičių sumos sutaptų.

%Generavimui reikalingos konstantos (magiškasis skaičius ir laipsnio kvadratas).
constants(Order, MagicConstant, Square):-
    MagicConstant is (Order*(Order**2 + 1))/2,
    Square is Order**2.

%Pradinio sąrašo sukūrimas ([1, 2, 3, ... , n**2])
apv([],APV,APV).
apv([P|G],TARP, APV):-
    apv(G,[P|TARP],APV).
apversti(PRAD,APV):-
    apv(PRAD,[],APV).
generate_list(0, []).
generate_list(Order, [Order|List]):-
    NOrder is Order - 1,
	generate_list(NOrder, List), !.
initial_list(Order, List):-
    generate_list(Order, RList),
	apversti(RList, List).

%Visi sąrašo kėliniai
permute([], []).
permute([X|Rest], L) :-
    permute(Rest, L1),
    select(X, L, L1).

%Patikra

%Eilutės
check_rows(_, 0, MagicConstant, [], Sum):-
    Sum == MagicConstant.
check_rows(InitialOrder, 0, MagicConstant, Ats, Sum):-
    Sum == MagicConstant,
    check_rows(InitialOrder, InitialOrder, MagicConstant, Ats, 0).
check_rows(InitialOrder, Order, MagicConstant, [H|T], Sum):-
    NOrder is Order - 1,
    NSum is Sum + H,
    check_rows(InitialOrder, NOrder, MagicConstant, T, NSum).
check_rows(Order, MagicConstant, Ats):-
    check_rows(Order, Order, MagicConstant, Ats, 0), !.

%Pagrindinė įstrižainė
check_diagonal(_, Order, MagicConstant, [], Sum):-
    Order > 0,
    Sum == MagicConstant.
check_diagonal(InitialOrder, 0, MagicConstant, [H|T], Sum):-
    NSum is Sum + H,
	check_diagonal(InitialOrder, InitialOrder, MagicConstant, [H|T], NSum).
check_diagonal(InitialOrder, Order, MagicConstant, [_|T], Sum):-
    NOrder is Order - 1,
	check_diagonal(InitialOrder, NOrder, MagicConstant, T, Sum).
check_diagonal(Order, MagicConstant, Ats):-
    NOrder is Order + 1,
	check_diagonal(NOrder, 0, MagicConstant, Ats, 0), !.

%Šalutinė įstrižainė
check_antidiagonal(_, _, MagicConstant, [_], Sum):-
    Sum == MagicConstant.
check_antidiagonal(InitialOrder, InitialOrder, MagicConstant, [H|T], Sum):-
    NSum is Sum + H,
	check_antidiagonal(InitialOrder, 0, MagicConstant, [H|T], NSum).
check_antidiagonal(InitialOrder, Order, MagicConstant, [_|T], Sum):-
    Order < InitialOrder,
    NOrder is Order + 1,
	check_antidiagonal(InitialOrder, NOrder, MagicConstant, T, Sum).
check_antidiagonal(Order, MagicConstant, Ats):-
    NOrder is Order - 1,
	check_antidiagonal(NOrder, 0, MagicConstant, Ats, 0), !.

%Stulpeliai
%Vieno stulpelio patikra
check_columns(_, _, MagicConstant, [], Sum):-
    Sum == MagicConstant.
check_columns(InitialOrder, 0, MagicConstant, [H|T], Sum):-
    NSum is Sum + H,
	check_columns(InitialOrder, InitialOrder, MagicConstant, [H|T], NSum).
check_columns(InitialOrder, Order, MagicConstant, [_|T], Sum):-
    NOrder is Order - 1,
	check_columns(InitialOrder, NOrder, MagicConstant, T, Sum).
%Perėjimas per stulpelius
check_columns(_, _, _, _, _, 0).
check_columns(InitialOrder, Order, MagicConstant, Ats, Sum, Column):-
    NColumn is Column - 1,
    check_columns(InitialOrder, NColumn, MagicConstant, Ats, 0),
	check_columns(InitialOrder, Order, MagicConstant, Ats, Sum, NColumn).
check_columns(Order, MagicConstant, Ats):-
    check_columns(Order, Order, MagicConstant, Ats, 0, Order), !.

%Bendras patikrinimas
check_if_magic(Order, MagicConstant, Ats):-
    check_rows(Order, MagicConstant, Ats),
	check_diagonal(Order, MagicConstant, Ats),
	check_antidiagonal(Order, MagicConstant, Ats),
    check_columns(Order, MagicConstant, Ats).
	
%Išvedimas

%Išskirsto sąrašą į n sąrašų
part([], _, []).
part(L, N, [DL|DLTail]):-
    length(DL, N),
    append(DL, LTail, L),
	part(LTail, N, DLTail).

%Išveda kiekvieną sąrašą naujoje eilutėje.
print_matrix([]).
print_matrix([H|T]):-
    write(H),
	nl,
	print_matrix(T).

magic_square(Order, X):-
    constants(Order, MagicConstant, Square),
    initial_list(Square, List),
	permute(List, Ats),
	check_if_magic(Order, MagicConstant, Ats),
	part(Ats, Order, X),
	print_matrix(X).

%check_if_magic(4, 34,[8,11,14,1,13,2,7,12,3,16,9,6,10,5,4,15]). - true.
%check_if_magic(4, 34,[8,11,14,1,13,2,7,12,3,16,9,6,10,5,15,4]). - false.