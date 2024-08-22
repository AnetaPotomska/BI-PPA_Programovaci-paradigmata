% secondmin.pl
% without_second_min(+Lst, -Res)
% without_second_min(list, acc) :- length(list) < 2, !.
without_second_min([], _) :- fail, !.
without_second_min([_], _) :- fail, !.
without_second_min([H | T], R) :- 
                                sort([H | T], [H1 | T1]),
                                deleteFirstE([H1 | T1], H1, [H2 | _]),
                                deleteAll([H | T], H2, R).

% deleteFirstE(+List, +Elem, -Res) 
deleteFirstE([], _, []).
deleteFirstE([H | T], E, Res) :- H \= E, Res = [H | T], !.
deleteFirstE([H | T], H, Res) :- deleteFirstE(T, H, Res).

% deleteAll(+Lst, +E, -Res).
deleteAll([], _, []).
deleteAll([H | T], H, Res) :- deleteAll(T, H, Res), !.
deleteAll([H | T], E, [H|Res]) :- H \= E, deleteAll(T, E, Res).
