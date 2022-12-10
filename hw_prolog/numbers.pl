% numbers.pl
% numbers(+Lst, +Target).
numbers(L, R) :- member(R, L), !. 
numbers(L, R) :- not(member(R, L)), fail.
numbers([H], R) :- fail.
numbers(L, R) :- 
    get_pair(L, X, Y),
    M is X + Y,
    deleteOne(X, L, Tmp),
    deleteOne(Y, Tmp, Res),
    numbers([M | Res], R).
numbers(L, R) :- 
    get_pair(L, X, Y),
    M is X - Y,
    deleteOne(X, L, Tmp),
    deleteOne(Y, Tmp, Res),
    numbers([M | Res], R).
numbers(L, R) :- 
    get_pair(L, X, Y),
    M is X * Y,
    deleteOne(X, L, Tmp),
    deleteOne(Y, Tmp, Res),
    numbers([M | Res], R).
numbers(L, R) :- 
    get_pair(L, X, Y),
    Y \= 0,
    P is mod(X, Y), 
    P = 0, 
    M is X / Y,
    deleteOne(X, L, Tmp),
    deleteOne(Y, Tmp, Res),
    numbers([M | Res], R).

% get_pair(+L, -X, -Y).
get_pair(L, X, Y) :- append([_, [X], _, [Y], _], L).

% deleteOne(+E, +L, -R).
deleteOne(_E, [], []).
deleteOne(E, [E|T], T).
deleteOne(E, [H|T], [H|Res]) :- E \= H, deleteOne(E, T, Res).
