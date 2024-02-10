




%----------------------------------------%
%
% Function to start the game enter
% startGame(). to play


startGame():- getBoardSize().


%----------------------------------%
% Asks the user for an input between
% 4 and 10, loops if the input is
% less than 4 or greater than 10
%
%

getBoardSize():- write("Enter a size between 4 and 10 by
typing the number followed by a period: "), read(Size),
    getBoardSizeHelper(Size).


getBoardSizeHelper(Size):- Size >= 4, Size =< 10,%converts size to board size
    NewSize is Size * Size,
    calcPrincessSpot(NewSize, Size).
% runs if statement above is false
getBoardSizeHelper(_):- write("Incorrect Size, Try Again"),
    getBoardSize().


%---------------------------%
% calcPrincessSpot(Size, Width).
%
% Takes the Size and Width of
% the board and calculates where
% the princess should be on creation
% and after for movement.
%
% On even boards the index for movement
% and board creation is different so
% the princess's correct index is also
% passed
%
% Size: The length of the board
% Width: the width of the board
%


calcPrincessSpot(Size, Width):- Width == 4,
    createBoard2(_, 0, Size, Width, 5, 2, 10).
calcPrincessSpot(Size, Width):- Width == 5,
    createBoard2(_, 0, Size, Width, 12, 2, 12).
calcPrincessSpot(Size, Width):- Width == 6,
    createBoard2(_, 0, Size, Width, 14, 3, 21).
calcPrincessSpot(Size, Width):- Width == 7,
    createBoard2(_, 0, Size, Width, 24, 3, 24).
calcPrincessSpot(Size, Width):- Width == 8,
    createBoard2(_, 0, Size, Width, 27, 4, 36).
calcPrincessSpot(Size, Width):- Width == 9,
    createBoard2(_, 0, Size, Width, 40,4, 40).
calcPrincessSpot(Size, Width):- Width == 10,
    createBoard2(_, 0, Size, Width, 44,5, 55).



%------------------------------%
%
% createBoard2(Board, Index, Size, Width, PrincessSpot, PrinCol,
% CorrectPrincessSpot).
%
% creates the board for the game
% from bottom right to top left
% on a 2d grid. places the princess
% at the given index and empty spaces
% for all other indecies. When the index
% is equal to the size, starts the gameLoop.
%
%
% Board: the game board as a list
% Index: current spot on the board
% Size: length of the board list
% Width: the width of the board when prinited 2d
% PrincessSpot: where the princess it
% PrinCol: what column the princess is at
% CorrectPrincessSpot: index of the princess for movement
%
%
%






createBoard2(_, Index, Size,Width, PrincessSpot, PrinCol, CorrectPrincessSpot) :-
    Index == 0,
    createBoard2(["--------"], 1, Size,Width, PrincessSpot, PrinCol, CorrectPrincessSpot).

createBoard2(Board, Index, Size,Width, _, PrinCol,CorrectPrincessSpot ) :-
    Index == Size,
    gameLoop(Board, 2, Size, Width, CorrectPrincessSpot, PrinCol).

createBoard2(Board, Index, Size, Width, PrincessSpot, PrinCol, CorrectPrincessSpot) :-
    Index <  Size,
    Index \== PrincessSpot,
    NewIndex is Index + 1,
    createBoard2(["--------"|Board], NewIndex, Size,
                 Width, PrincessSpot, PrinCol, CorrectPrincessSpot).


createBoard2(Board, Index, Size, Width, PrincessSpot, PrinCol, CorrectPrincessSpot ) :-
    Index < Size,
    Index == PrincessSpot,
    NewIndex is Index + 1,
    createBoard2(["princess"|Board], NewIndex, Size,
                 Width,  PrincessSpot, PrinCol ,CorrectPrincessSpot ).





%----------------------------------%
%
% printBoard2(Board, Size, Width, Index, CurCol).
%
% prints out the 1D board in a 2D way. Does so by
% going through each item and writing them to the console,
% and when the CurCol is equal to the width writes a newLine.
%
%
% Board: the gameboard
% Size: length of the board
% Width: width of the board
% Index: current index
% CurCol: current column


printBoard2([], _,_, _, _):-nl.
printBoard2([First|Rest], Size, Width, Index, CurCol):- write(First),
    write(" "),
    CurCol \== Width,
    NewIndex is Index + 1,
    NextCol is CurCol + 1,
    printBoard2(Rest, Size, Width, NewIndex,NextCol).

printBoard2([_|Rest], Size, Width, _, CurCol):-
    nl,
    printBoard2(Rest, Size, Width, CurCol, 1).






%---------------------------%
% elementAtIndexIs(Board, Index, CurrentIndex, Item).
%
% Goes through a list, the board, and checks if the
% element at a givin index is equal to a element givin.
% Used to check if there is a empty space or a dragon
% on princess movement.
%
%
% Board: the gameboard
% Index: spot in the board being looked at
% CurrentIndex: current index the function is on
% Item: the item that the function is comparing
% with the item at the givin index
%
%



elementAtIndexIs([First|_], Index, CurrentIndex, Item):- Index == CurrentIndex,
    First == Item.
elementAtIndexIs([_|Rest], Index, CurrentIndex, Item):- CurrentIndex < Index,
    NewCur is CurrentIndex + 1,
    elementAtIndexIs(Rest, Index, NewCur, Item).



%-------------------------------------%
%
% move(Movement, PrincessSpot, Size, Width, Board, PrinCol).
%
% Based on the movement givin, Moves the princess on the
% board, accepts R,D,L,U and r,d,l,u. any other inputs
% it makes the user try again.
%
%
% Movement: where the user whats to move
% Board: the game board as a list
% Size: length of the board list
% Width: the width of the board when prinited 2d
% PrincessSpot: where the princess it
% PrinCol: what column the princess is at



move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 82, write("Moved Right "),
    nl,
    moveRight(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 114, write("Moved Right "),
    nl,
    moveRight(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 68, write("Moved Down"),
    nl,
    moveDown(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 100, write("Moved Down"),
    nl,
    moveDown(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 76, write("Moved Left"),
    nl,
    moveLeft(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 108, write("Moved Left"),
    nl,
    moveLeft(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 85, write("Moved Up"),
    nl,
    moveUp(1, Board, PrincessSpot, Size, Width, PrinCol).
move(Movement, PrincessSpot, Size, Width, Board, PrinCol):-
    Movement == 117, write("Moved Up"),
    nl,
    moveUp(1, Board, PrincessSpot, Size, Width, PrinCol).

%--------------------------Moves the princess on the board



%-----------------------------------------%
%
% moveRight(State, Board, PrincessSpot, Size, Width, PrinCol).
%
% Moves the princess right on the board in two stages
%
%
% moves the princess right on the board by
% first setting the princesses spot to empty
% then checking the spot + 1 index in the board
% list if its a dragon calls the gameLoop with state == 4, ending
% the game. else it places the princess at the new index if the princess
% is not at the edge before moving. If PrinCol == Width before moving,
% the princess leaves the board and the game is won.
%
%
% State: step of the movement 1 = remove princess from board. 2 = place
% place new item at nex index or end game.
% Board: the game board as a list
% Size: length of the board list Width: the width of the board when
% prinited 2d PrincessSpot: where the princess it PrinCol: what column
% the princess is at




moveRight(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1,
    TempWidth is Width - 1,
    PrinCol == TempWidth,
     changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    printBoard2(NewBoard, Size, Width, 0, 1),nl,
    write("The Princess has escaped!").



moveRight(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    NewPrincess is PrincessSpot + 1,

    NewCol is PrinCol + 1,

   moveRight(2, NewBoard, NewPrincess, Size, Width, NewCol).


moveRight(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    elementAtIndexIs(Board, PrincessSpot, 0, " Dragon "),
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, " YumYum "),
    gameLoop(NewBoard, 4, Size, Width, PrincessSpot, PrinCol).


moveRight(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "Princess"),
    gameLoop(NewBoard, 3, Size, Width, PrincessSpot, PrinCol).





%-----------------------------------------%
%
% moveDown(State, Board, PrincessSpot, Size, Width, PrinCol).
%
% Moves the princess Down on the board in two stages
%
%
% moves the princess Down on the board by
% first setting the princesses spot to empty
% then checking the spot + Width index in the board
% list if its a dragon calls the gameLoop with state == 4, ending
% the game. else it places the princess at the new index if the princess
% is not at the edge before moving. If PrincessSpot is greater than
% Size - Width before moving, the princess leaves the board and the game is won.
%
%
% State: step of the movement 1 = remove princess from board. 2 = place
% place new item at nex index or end game. Board: the game board as a
% list
% Size: length of the board list Width: the width of the board when
% prinited 2d PrincessSpot: where the princess it PrinCol: what column
% the princess is at



moveDown(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1, TempSize is Size - Width,
    PrincessSpot < TempSize,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    NewPrincess is PrincessSpot + Width,
    moveDown(2, NewBoard, NewPrincess, Size, Width, PrinCol).

moveDown(State, Board, PrincessSpot, Size, Width, _):- State == 1,
    TempSize is Size - Width,
    PrincessSpot >= TempSize,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    printBoard2(NewBoard, Size, Width, 0, 1),nl,
    write("The Princess has escaped!").



moveDown(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    elementAtIndexIs(Board, PrincessSpot, 0, " Dragon "),
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, " YumYum "),
    gameLoop(NewBoard, 4, Size, Width, PrincessSpot, PrinCol).


moveDown(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "Princess"),
    gameLoop(NewBoard, 3, Size, Width, PrincessSpot, PrinCol).



%-----------------------------------------%
%
% moveLeft(State, Board, PrincessSpot, Size, Width, PrinCol).
%
% Moves the princess left on the board in two stages
%
%
% moves the princess right on the board by
% first setting the princesses spot to empty
% then checking the spot - 1 index in the board
% list if its a dragon calls the gameLoop with state == 4, ending
% the game. else it places the princess at the new index if the princess
% is not at the edge before moving. If PrinCol == 0 before moving,
% the princess leaves the board and the game is won.
%
% State: step of the movement 1 = remove princess from board. 2 = place
% place new item at nex index or end game.
% Board: the game board as a list
% Size: length of the board list Width: the width of the board when
% prinited 2d PrincessSpot: where the princess it PrinCol: what column
% the princess is at



moveLeft(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1,
    TempCol is PrinCol,
    TempCol == 0,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    printBoard2(NewBoard, Size, Width, 0, 1),nl,
    write("The Princess has escaped!").



moveLeft(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    NewPrincess is PrincessSpot - 1,
    NewCol is PrinCol - 1,
    moveLeft(2, NewBoard, NewPrincess, Size, Width, NewCol).



moveLeft(State, Board, PrincessSpot, Size, Width, _):- State == 2,
    elementAtIndexIs(Board, PrincessSpot, 0, " Dragon "),
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, " YumYum "),
    gameLoop(NewBoard, 4, Size, Width, PrincessSpot, _).


moveLeft(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "Princess"),
    gameLoop(NewBoard, 3, Size, Width, PrincessSpot, PrinCol).




%-----------------------------------------%
%
% moveUp(State, Board, PrincessSpot, Size, Width, PrinCol).
%
% Moves the princess up on the board in two stages
%
%
% moves the princess up on the board by
% first setting the princesses spot to empty
% then checking the spot + Width index in the board
% list if its a dragon calls the gameLoop with state == 4, ending
% the game. else it places the princess at the new index if the princess
% is not at the edge before moving. If PrincessSpot is less than
% Width before moving, the princess leaves the board and the game is won.
%
% State: step of the movement 1 = remove princess from board. 2 = place
% place new item at nex index or end game.
% Board: the game board as a
% list Size: length of the board list Width: the width of the board when
% prinited 2d PrincessSpot: where the princess it PrinCol: what column
% the princess is at



moveUp(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 1,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    NewPrincess is PrincessSpot - Width,
    moveUp(2, NewBoard, NewPrincess, Size, Width, PrinCol).

moveUp(State, Board, PrincessSpot, Size, Width, _):- State == 1,

    PrincessSpot < Width,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "--------"),
    printBoard2(NewBoard, Size, Width, 0, 1),nl,
    write("The Princess has escaped!").




moveUp(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    elementAtIndexIs(Board, PrincessSpot, 0, " Dragon "),
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, " YumYum "),
    gameLoop(NewBoard, 4, Size, Width, PrincessSpot, PrinCol).


moveUp(State, Board, PrincessSpot, Size, Width, PrinCol):- State == 2,
    changeBoardAtIndex(Board, NewBoard, PrincessSpot, "Princess"),
    gameLoop(NewBoard, 3, Size, Width, PrincessSpot, PrinCol).






%-----------------------------------------------%
%
% Main game loop, keeps track of the state of the
% game and prints out the board and asks for user
% input to move the princess on the board, also
% ends the game if the princess is eaten
%
%
%
%
% Board: the game board as a list
% State:
%        2 = generate dragons
%        3 = movment loop
%        4 = game lost
%
% Size: length of the board list
% Width: the width of the board when prinited 2d
% PrincessSpot: where the princess it
% PrinCol: what column the princess is at




gameLoop(Board, State, Size, Width, PrincessSpot, PrinCol):- State == 1,
   % printBoard2(Board, Size, Width, 0, 1),%prints the board without dragons
    gameLoop(Board, 2, Size, Width, PrincessSpot, PrinCol).

gameLoop(Board, State, Size, Width, PrincessSpot, PrinCol):- State == 2,
        genDragonSpots(Size, Width, PrincessSpot, 0, _, Board, PrinCol).

gameLoop(Board, State, Size, Width, PrincessSpot, PrinCol):- State == 3,
    nl,
    printBoard2(Board, Size, Width, 0, 1),
    %write("Please Enter how you would like to move: "),
    nl,
    write("Please Enter how you would like to move: "),
    %printBoard2(Board, Size, Width, 0, 1),
    testInput(PrincessSpot, Board, Size, Width, PrinCol).

gameLoop(Board, State, Size, Width, _, _):- State == 4,
    printBoard2(Board, Size, Width, 0, 1),
    nl,
    write("Game Has Ended, The princess has been eaten").



%---------------------------------%
%
% genDragonSpots(Size, Width, PrincessSpot, Index, ListOfDragons,
%                GameBoard, PrinCol).
%
% generates the list of dragons, if
% the list is empty, loops until
% a list of dragons that isn't
% empty is generated
%
%
% Size: length of the board
% Width: width of the board
% PrincessSpot: index of the princess
% Index: current index on
% ListOfDragons: list containing indecies that contian dragons on the
% board
% GameBoard: the board for the game
% PrinCol: column the princess is on
%
%
%
%


genDragonSpots(Size, Width, PrincessSpot,  Index, _, GameBoard, PrinCol):-
    genDragonSpotsHelper(Size, Width, PrincessSpot, Index, [], GameBoard , PrinCol).
genDragonSpots(Size, Width, PrincessSpot, Index, ListOfDragons, GameBoard, PrinCol):-
    genDragonSpots(Size, Width, PrincessSpot, Index, ListOfDragons, GameBoard, PrinCol).





%----------------------------------------------%
%
% genDragonSpotsHelper(Size, Width, PrincessSpot, Index, ListOfDragons,
%                GameBoard, PrinCol).
%
% goes through each index of the board and generates
% a number between 1 and 4. If that generated number is
% equal to 1, adds that index number to the ListOfDragons.
%
%
%
%
%
% Size: length of the board
% Width: width of the board
% PrincessSpot: index of the princess
% Index: current index on
% ListOfDragons: list containing indecies that contian dragons on the
% board
% GameBoard: the board for the game
% PrinCol: column the princess is on
%



genDragonSpotsHelper(Size, Width, PrincessSpot, Index, ListOfDragons, GameBoard, PrinCol):-
    Index ==  Size,%at end of the board
    populateBoard(GameBoard, ListOfDragons, PrincessSpot, Size, Width , PrinCol).


genDragonSpotsHelper(Size, Width, PrincessSpot, Index, _, GameBoard, PrinCol):-
    Index == 0, random(1,5,X),
    X \== 1,
    NewIndex is Index + 1,
    genDragonSpotsHelper(Size, Width, PrincessSpot, NewIndex, [], GameBoard, PrinCol).

genDragonSpotsHelper(Size, Width, PrincessSpot, Index, _, GameBoard, PrinCol):-
    Index == 0, random(1,5,X),
    X == 1,
    NewIndex is Index + 1,
    genDragonSpotsHelper(Size, Width, PrincessSpot, NewIndex, [Index], GameBoard, PrinCol).

genDragonSpotsHelper(Size, Width, PrincessSpot, Index, ListOfDragons, GameBoard, PrinCol):-
    Index < Size, random(1,5,X),
    X == 1,
    NewIndex is Index + 1,
    genDragonSpotsHelper(Size, Width, PrincessSpot, NewIndex, [Index|ListOfDragons],
                         GameBoard, PrinCol).
genDragonSpotsHelper(Size, Width, PrincessSpot, Index, ListOfDragons, GameBoard, PrinCol):-
    Index < Size, random(1,5,X),
    X \== 1,
    NewIndex is Index + 1,
    genDragonSpotsHelper(Size, Width, PrincessSpot, NewIndex, ListOfDragons,
                         GameBoard, PrinCol).


%-------------------------------------------%
%
% populateBoard(Board, ListOfDragons,
%               PrincessSpot, Size, Width, PrinCol).
%
%  Adds the dragons to the gameboard, skips the dragon
%  if its index was at the princessSpot.
%
%
%
%
% Size: length of the board
% Width: width of the board
% PrincessSpot: index of the princess
% ListOfDragons: list containing indecies that contian dragons on the
% board
% GameBoard: the board for the game
% PrinCol: column the princess is on



populateBoard(Board, [], PrincessSpot , Size, Width, PrinCol ):-
    gameLoop(Board, 3, Size, Width, PrincessSpot, PrinCol).%goes to print the board

populateBoard(Board, [First|Rest], PrincessSpot, Size, Width, PrinCol):-
    First == PrincessSpot,
    populateBoard(Board, Rest, PrincessSpot, Size, Width, PrinCol).


populateBoard(Board, [First|Rest], PrincessSpot, Size, Width, PrinCol):-  First \== PrincessSpot,
    changeBoardAtIndex(Board, NewBoard, First, " Dragon "),
    populateBoard(NewBoard, Rest, PrincessSpot, Size, Width, PrinCol).





% changeBoardAtIndex(Board, Board, Index, Item).
% By: Class of AUCSC370 2022
%
% changes the element at the index on the board to the givin
% Item
%
% Board: the game board
% NewBoard: the board after the item is added
% Index: where the item is being changed
% Item: the item that the spot is changing to
%
%
changeBoardAtIndex([_| Rest], [Item | Rest], 0, Item).
changeBoardAtIndex([First | Rest], [First | RestOfAnswer], Index, Item) :- Index > 0,
    NewIndex is Index - 1,
    changeBoardAtIndex(Rest, RestOfAnswer, NewIndex, Item).



%------------------------------------------------%
% testInput(PrincessIndex, Board, Size, Width, PrinCol).
% takes the user input and only processes the first
% character of the input. Then flushes out the input stream
%
%
% PrincessIndex: where the princess is on the board
% Board: the game board
% Size: length of the board
% Width: width of the board
% PrinCol: column the princess is on
%
%
%
% myFlush(Move, Char, Index PrincessIndex, Board, Size, Width, PrinCol).
%
%  flushes the input and calls the move function.
%
%
%  Move: the user input
%  Char: first character of the input
%  Index: Current index
%  PrincessIndex: where the princess is on the board
%  Board: the game board
%  Size: length of the board
%  Width: width of the board
%  PrinCol: column the princess is on




testInput(PrincessIndex, Board, Size, Width, PrinCol):- get0(Move),
    myFlush(Move, _,0,PrincessIndex, Board, Size, Width, PrinCol).

myFlush(10, Char, _ ,PrincessIndex, Board, Size, Width, PrinCol):-
    move(Char, PrincessIndex,Size ,Width, Board, PrinCol).
myFlush(Move, _, Index,PrincessIndex, Board, Size, Width, PrinCol):-
    Move \== 10, Index== 0, get0(Word),
    myFlush(Word, Move, 1,PrincessIndex, Board, Size, Width, PrinCol).
myFlush(Move, Char, Index,PrincessIndex, Board, Size, Width, PrinCol):-
    Move \== 10, get0(Word),
    myFlush(Word, Char, Index,PrincessIndex, Board, Size, Width, PrinCol).







