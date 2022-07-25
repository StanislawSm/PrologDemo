:- lib(ic).

quicksort([X|Xs],Ys) :-
  partition(Xs,X,Left,Right),
  quicksort(Left,Ls),
  quicksort(Right,Rs),
  appendOwn(Ls,[X|Rs],Ys).
quicksort([],[]).


 % If X > Y, X is saved on the left side of the array, meaning Left
 % If X =< Y, X is saved on the right side of the array, meaning Right
partition([X|Xs],Y,[X|Ls],Rs) :-    
   X > Y, partition(Xs,Y,Ls,Rs).       
partition([X|Xs],Y,Ls,[X|Rs]) :-
   X =< Y, partition(Xs,Y,Ls,Rs).
partition([],Y,[],[]).


appendOwn([],Ys,Ys).
appendOwn([X|Xs],Ys,[X|Zs]) :- appendOwn(Xs,Ys,Zs).


% subtracts all elements from 0 to Position by 1

odejmij(Lista, Position, Result) :-
odejmij(Lista, [], Position, Result).

odejmij([Head|Tail], Acc, Position, Result):-
    Position > 0, !, 
    Head1 is Head - 1, % subtracts the head each time
    append(Acc,[Head1],Acc1),
    Position1 is Position -1,
    odejmij(Tail, Acc1, Position1, Result).

odejmij([H|T], Acc, 0, Result):-
    H11 is H - 1,
    append(Acc,[H11],Acc1),
    append(Acc1,T,Acc2),
    odejmij([], Acc2, 0, Result).

odejmij([], Acc2, 0, Acc2).

removeHead([_|Tail], Tail). 

checkEachElement(X,[X]).
checkEachElement(X,[H|T]) :- H =:= X, checkEachElement(X,T).


checkState([X|Xs],Final):-
   member(-1, [X|Xs]),Final = false.
   
checkState([X|Xs],Final):-
   checkEachElement(0,[X|Xs]), Final = true.
 
checkState([X|Xs],Final):-
   czy_graficzny([X|Xs],Final).

czy_graficzny([], true).    
czy_graficzny([X|Xs],Final) :-
   Pos is X, X > 0, !,
   odejmij([X|Xs],Pos,WynikOdej),
   removeHead(WynikOdej,WynikRem),
   quicksort(WynikRem,WynikSort),
   checkState(WynikSort,Final).
   
%-------------------------------------------------------------------------
   
czy_bez0([], true).
czy_bez0(Lista, Z) :-
	not(member(0, Lista)), 
	Z = true ; Z = false.

list_sum([], 0).
list_sum([H|T], Sum) :-
   list_sum(T, Rest),
   Sum is H + Rest.


policz_kr(Lista, N) :-
	list_sum(Lista, TotalSum),
	N is TotalSum/2.

policz_wie([], 0).
policz_wie([H|T], Il) :-
    policz_wie(T, Il1),
    Il is (Il1 + 1).
	
	
czy_wyst_kr([], true).
czy_wyst_kr(Lista, K) :-
	policz_kr(Lista, N),
	policz_wie(Lista, W),
	N >= (W - 1),
	K = true; K = false.

and(true, true, true, Final) :-
	Final = true; Final = false. 

czy_spojny([], true).
czy_spojny(Lista, Final) :-
	czy_graficzny(Lista, G),
	czy_bez0(Lista, Z),
	czy_wyst_kr(Lista, K),
	and(G, Z, K, Final).
	