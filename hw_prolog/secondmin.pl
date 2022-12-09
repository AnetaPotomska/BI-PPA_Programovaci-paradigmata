% secondmin.pl
% without_second_min(+Lst, -Res)
% without_second_min(list, acc) :- length(list) < 2, !.
without_second_min([], _) :- fail, !.
without_second_min([_], _) :- fail, !.
without_second_min([H | T], R) :- findSecondMin([H | T], SubRes),
                                findMin(SubRes, Sub),
                                deleteAll([H | T], Sub, R).

findSecondMin([H | T], R) :- findMin([H | T], SubRes),
                             deleteAll([H | T], SubRes, R).

% findMin(+Lst, -Res).
findMin([A], A) :- !.
findMin([H | T], H) :- findMin(T, Res), H < Res, !.
findMin([H | T], Res) :- findMin(T, Res), H >= Res.

% deleteAll(+Lst, +E, -Res).
deleteAll([], _, []).
deleteAll([H | T], H, Res) :- deleteAll(T, H, Res), !.
deleteAll([H | T], E, [H|Res]) :- H \= E, deleteAll(T, E, Res).
