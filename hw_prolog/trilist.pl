% trilist.pl
trilist([]) :- !.
trilist(L) :- my_length(L, Sub), M is mod(Sub, 3), M \= 0, fail.
trilist(L) :- my_length(L, Sub), M = Sub / 3,
              my_take(M, L, Res1),
              my_drop(M, L, Sub1),
              my_take(M, Sub1, Res2),
              my_drop(M, Sub1, Res3),
              Res1 = Res2, Res2 = Res3.

% my_drop(+El, +L, -Res).
my_drop(0, L, L) :- !.
my_drop(N, [_ | T], L) :- M is N - 1, my_drop(M, T, L).

% my_take(+El, +L, -Res).
my_take(0, _, []) :- !.
my_take(N, [H | T], [H | L]) :- M is N - 1, my_take(M, T, L).

% my_length(+Lst, -Res).
my_length([], 0).
my_length([_|T], Res) :- my_length(T, R1), Res is 1 + R1.

