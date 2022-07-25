print_Lista( [],0 ).
print_Lista( [Head|T],L ) :- write(Head),write(" "),print_Lista( T,P ), L is P + 1.


is_empty_field([0|_], 0). 
is_empty_field([Head|Tail], Index) :-
NowyIndex is Index - 1,
is_empty_field(Tail, NowyIndex).





get_empty([Val|Tail],CurrId, Index) :- Index is CurrId, Val < 2. 
get_empty([_|Tail], CurrId, Index) :-
get_empty(Tail, CurrId + 1,Index).


check_pionek([Val|Tail],CurrId, StartId, Index) :- Val \= 0, CurrId > StartId,Index > CurrId. 
check_pionek([_|Tail], CurrId,StartId, Index) :-
check_pionek(Tail, CurrId + 1,StartId,Index).


get_non_empty([Val|Tail],CurrId, Index) :- Val \= 0, Index is CurrId. 
get_non_empty([_|Tail], CurrId, Index) :-
get_non_empty(Tail, CurrId + 1,Index).

min_jeden([Head|Tail], 0, [New_Head|Tail])  :- New_Head is Head-1.
min_jeden([Head|Tail], Index, NowaLista) :-
NowyIndex  is Index - 1,
NowaLista = [Head|MalaLista],
min_jeden(Tail, NowyIndex, MalaLista).

add_jeden([Head|Tail], 0, [New_Head|Tail]) :- New_Head is Head+1.
add_jeden([Head|Tail], Index, NowaLista) :-
NowyIndex  is Index - 1,
NowaLista = [Head|MalaLista],
add_jeden(Tail, NowyIndex, MalaLista).


move_pionek(Lista, Src, Dst,FinList) :-
min_jeden(Lista, Src, FirstL),
add_jeden(FirstL, Dst, FinList).


get_moves(List, FinList,Length) :-
   get_non_empty(List, 0, X1),
   get_empty(List, 0, Y1),
   X1 < Y1,
   Y1 - X1 >= 1,
   Y1 - X1 =< 3,  
   move_pionek(List, X1, Y1, FinList).

game_process(List, Length) :-
   get_moves(List,ListaPo,Length),
   write("["),   
   print_Lista(ListaPo, Length),
   write("]"),
   get_moves(ListaPo, NowaLista,Length),
   write("["),   
   print_Lista(NowaLista, Length),
   write("]"),
   game_process(NowaLista, Length).
game_process(List, Length) :-  
   write("["),   
   print_Lista(List, Length),
   write("]"),
   get_moves(List,ListaPo,Length),
   write("["),   
   print_Lista(ListaPo, Length),
   write("]"),
   write("\n").

   


