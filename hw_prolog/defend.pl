% defend.pl
% odebírání tokenů v řadě, z konce i ze začátku
% nechce skončit na failu
% can_x_defend(+List).
can_x_defend(B) :- can_x_defend2(B, x). 
can_x_defend2([], _) :- !, fail.
can_x_defend2(B, _) :- not(member(x, B)), !. % neexistuje žádný token x
can_x_defend2(B, _) :- not(member(o, B)), member(x, B), fail, !. % nejsou žádné o na desce a zůstal tam x, fail
can_x_defend2(B, x) :- deleteRow(B, x, Res), can_x_defend2(Res, o).
can_x_defend2(B, o) :- deleteRow(B, o, Res), can_x_defend2(Res, x).

% my_reverse(+Lst, -Res).
my_reverse(Lst, Res) :- my_reverse_aux(Lst, [], Res).
my_reverse_aux([], Acc, Acc).
my_reverse_aux([H|T], Acc, Res) :- my_reverse_aux(T, [H|Acc], Res).

% deleteRow(+List, +Elem, -Res) 
deleteRow([], _, []).
deleteRow([H | T], E, Res) :- H \= E, Res = [H | T], !.
deleteRow([H | T], H, Res) :- deleteRow(T, H, Res).
