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

% removes the head of a list
removeHead([_|Tail], Tail). 


% checks if a list has the same elements
checkEachElement(X,[X]).
checkEachElement(X,[H|T]) :- H =:= X, checkEachElement(X,T).


checkState([X|Xs],Final):-
   member(-1, [X|Xs]),Final = false.
   
checkState([X|Xs],Final):-
   checkEachElement(0,[X|Xs]), Final = true.
 
checkState([X|Xs],Final):-
   czy_graficzny([X|Xs],Final).
   

% e.g List [6,3,3,3,3,2,2,2,2,1,1]
% We first check if our first element > 0. So is (6>0)
% Odejmij subs by 1 all elements from 0 to pos (including) (0 to 6) [5,2,2,2,2,1,1,2,2,1,1]
% remove our head from list so now we have [2,2,2,2,1,1,2,2,1,1]
% we sort our list to get [2,2,2,2,2,2,1,1,1,1]
% we checkstate of our list, where if list has only 0 values it is a ciag graficzny
% if it has -1 as an element that means its not a ciag graficzny
% Otherwise we repeat the czy_graficzny function with current list [2,2,2,2,2,2,1,1,1,1]
czy_graficzny([X|Xs],Final) :-
   Pos is X, X > 0, !,
   odejmij([X|Xs],Pos,WynikOdej),
   removeHead(WynikOdej,WynikRem),
   quicksort(WynikRem,WynikSort),
   checkState(WynikSort,Final).
   
   

czy_graficzny([],[]).