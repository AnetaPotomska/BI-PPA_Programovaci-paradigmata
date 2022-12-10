% numbers.pl
% numbers(+Lst, +Target).
numbers(L, R) :- member(R, L), !. 
numbers(L, R) :- not(member(R, L)), fail.
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H + S, 
                          numbers([M | T], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H - S, 
                          numbers([M | T], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H * S, 
                          numbers([M | T], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          P is mod(H, S), P = 0, 
                          M is H/S,
                          numbers([M | T], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H + S, 
                          numbers([T | M], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H - S, 
                          numbers([T | M], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          M is H * S, 
                          numbers([T | M], R).
numbers([H, S | T], R) :- H \= [], S \= [],
                          P is mod(H, S), P = 0, 
                          M is H/S,
                          numbers([T | M], R).

my_last([H], H) :- !.
my_last([_|T], Res) :- my_last(T, Res).
