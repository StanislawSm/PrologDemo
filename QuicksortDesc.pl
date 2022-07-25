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

