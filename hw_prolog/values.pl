% values.pl
% values_in(+-Values, +Universe)
values_in([], _) :- ! .
values_in([H], L) :- member(H, L), ! .
values_in([H | T], L) :- member(H, L), values_in(T, L).
