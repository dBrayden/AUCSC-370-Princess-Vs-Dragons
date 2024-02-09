(#%require (only racket/base random))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Name: Brayden Dickau ID: 1687165
;;
;; Simple game that creates a board populated by dragons and a princess. The
;; goal of the game is to get the princess to the edge of the board by moving
;; her left, right, up and down so she can swim away. Be careful of the dragons 
;; as meeting one will lead to death. The dragons, however are blind and will 
;; not move from their location.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; prompts the user for a board input then starts the
;; gameloop
;;

(define (startGame)
  (display "Enter the board size between 4 and 10: ")
  (gameLoop (makeBoardHelper (readLine 0))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; modified Rosanna Heise readLine function added state to track what type
;; of input is being evaluated. 0 = size input 1 = princess movement
;;

(define (readLine state)
(readLoop (read-char (current-input-port)) '() state))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Used to branch to different functions to handle board size and princess
;; movement inputs
;;


(define (inputHelper input state)
  (cond
    ((null? input) (readLine state));;fixes bug after multi char wrong input for princess move
    ((eq? state 1) (car input))
    ((eq? (length input) 2) (twoLongInput input 0))
    ((eq? (length input) 1) (inputConvert input))
    (#t (display "Invalid input, try again: ") (readLine state))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; converts the given input from ASCII to int and checks if its
;; a valid board size 4-10 if not calls the readLine function
;; so the user can attempt to put in a valid input
;;

(define (inputConvert input)
  (cond
  ((eq? (>= (- (char->integer (car input)) 48) 4) (<= (- (char->integer (car input)) 48) 10))  (- (char->integer (car input)) 48))
  (#t (display "Invalid input, try again: ") (readLine 0))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Only used when the input for the board size is longer than or equal to
;; two. First checks if the first item in the inputted list is 1. adds one
;; to count then checks the next item in the list. If it's 0 then runs the
;; function again with count being two. This done to be able to take 10 as
;; a number, and also rejects all other inputs greater than 10 and calls
;; the user to try again.

(define (twoLongInput input count)
  (cond
    ((eq? count 2) 10)
   ((null? input) (display "invalid size, try again: ") (readLine 0))
   ((eq? (- (char->integer (car input)) 48) 1) (twoLongInput (cdr input) 1))
   ((eq? (- (char->integer (car input)) 48) 0) (twoLongInput input 2))
   
   (#t (display "invalid size, try again: ") (readLine)))) 
    
;;;;;;;;;;;;;;;;;By: Rosanna Heise;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; readLoop(currentCharacter line) --> line (as String)
;;
;; This recursive method reads a character at a time from the
;; current input port (assuming Scheme's "Interaction Window")
;; until it finds the newline (i.e. enter). It builds the characters
;; into a string which is returned at the end. Newline is not part
;; of the string, but is eliminated from the input
;;
;;
;; I chnaged this function slightly by changing the (list->string line)
;; to call the inputHelper to sort out the input to see if the input
;; is between 4-10 and is a number

(define (readLoop curChar line state)
(cond
((char=? #\newline curChar) (inputHelper line state))
(#t (readLoop (read-char (current-input-port))
(append line (list curChar)) state))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; First prints the gameBoard given as an input then
;; asks the user to enter a movement to move the
;; princess
;; Not recursive but the function calls lead back to
;; this function until an endgame state is reached
;;

(define (gameLoop gameBoard)
  (printBoard1 gameBoard (length gameBoard) 1 0)
  (display "Enter Movement: ") (movePrincess (readLine 1) gameBoard))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; prints the given board list into a 2d board in the
;; console 
    
(define (printBoard1 board size index rowCount)
  (cond
    ((null? (cdr board)) (display (printItem (car board)))(newline))
    ((= rowCount (sqrt size)) (newline) (printBoard1 board size index 0));;if a row has been printed prtint new line
    (#t (display (printItem (car board))) (display " ") (printBoard1 (cdr board) size (+ index 1) (+ rowCount 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; depending on the placeholder inputted as the element
;; from the gameboard displays its full represenation
;; into the console

(define (printItem element)
  (cond
    ((eq? #\e element) "--------")
    ((eq? #\p element) "princess")
    ((eq? #\d element) " Dragon ")
    ((eq? #\y element) " YumYum ")
    (#t "emp")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; swaps element at specified spot with item then returns the rebuilt list
;; used to move the princess around the board
;; uses two dummy lists to go through. it goes through the gameBoard list
;; by having left start as '() and right being the inputted list
;; one by one it checks if the current spot is the one being replaced
;; if so appends the item to the left list and then the cdr of the right
;; list. if this isnt the spot, shifts one element from right to left and
;; recursivly does this until the correct spot is found
;;

(define (swapElement item left right spot index)
  (cond
    ((null? right) left);; at end of list returns the completed list in left
    ((= spot index) (swapElement item (append left (list item)) (cdr right) spot (+ index 1)))
    (#t (swapElement item (append left (list (car right))) (cdr right) spot (+ index 1)))))
(define (swapHelper board item)
  (swapElement item (car board) (cdr board) 4 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; creates a board with the length of the size given, populates each spot with the empty tag #\e
;; or a 25% chance for a spot to be a dragon with the placeholder #\d. For the given princess spot
;; puts the placeholder #\p. returns a list that represents the gameBoard.
;;

(define (makeBoard size currentSpot princessSpot)
  (cond
    ((eq? size 0) '())
    ((eq? currentSpot princessSpot) (cons #\p (makeBoard (- size 1) (+ currentSpot 1) princessSpot)))
    ((eq? (random 4) 1) (cons #\d (makeBoard (- size 1) (+ currentSpot 1) princessSpot)))
    (#t (cons #\e (makeBoard (- size 1) (+ currentSpot 1) princessSpot)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Takes the size inputted by the user and calls the makeBoard function
;; with the added inputs needed by makeBoard that represent the length
;; of the board and the princesses spot.
;;

(define (makeBoardHelper size)
  (makeBoard (* size size) 1 (calcPrincess1 (* size size))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Based on the size inputted returns the spot for 
;; princess at the intitial board creation. Either
;; the middle of the board for odd sized boards,
;; or the top right of the four middle spots on
;; even boards.

(define (calcPrincess1 size)
  (cond
    ((eq? size 16) 7)
    ((eq? size 25) 13)
    ((eq? size 36) 16)
    ((eq? size 49) 25)
    ((eq? size 64) 29)
    ((eq? size 81) 41)
    ((eq? size 100) 46)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Takes in the user input and checks if it is a valid input or
;; not. Based on what the input is, either calls the respective
;; move function or recursivly calls itself until a correct input
;; is given

(define (movePrincess input board)
  (cond
    ((eq? input #\r) (Display "moved right")(newline) (moveR board 1 1 1))
    ((eq? input #\R) (Display "moved right")(newline) (moveR board 1 1 1))
    ((eq? input #\d) (Display "moved Down")(newline) (moveD board 1 1 1))
    ((eq? input #\D) (Display "moved Down")(newline) (moveD board 1 1 1))
    ((eq? input #\l) (Display "moved Left")(newline) (moveL board 1 1 102));;princess starting spot > 101 so works for boards 4-10
    ((eq? input #\L) (Display "moved Left")(newline) (moveL board 1 1 102))
    ;; temp princess spot > than last col on first row for on all boards. accounts for invalid princess placement when moving
    ((eq? input #\u) (Display "moved up")(newline) (moveU board 1 1 11))
    ((eq? input #\U) (Display "moved up")(newline) (moveU board 1 1 11))
    ;;stops the user from inputting multiple moves as one input ex: rrrr -> moves right 4 times
    ((eq? input #\newline) (movePrincess (read-char (current-input-port)) board))
    (#t (display "Incorrect input, try again: ") (movePrincess (read-char (current-input-port)) board))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moves the princess right on the board by
;; first setting the princesses spot to empty
;; then checking the spot + 1 index in the board
;; list if its a dragon calls the endGame function
;; with endState at 2 else it places the princess
;; at the new index if the princess is not at the
;; edge before moving. if so calls the endGame with
;; the endGame state at 1
;;

(define (moveR board shift step princessIndex)
  (cond

    ;;checks if princess is on last colum of board before moving, if so does not place princess again and then ends game
    ((eq? (modulo princessIndex (sqrt (length board))) 0) (endGame board 1)) 
    ((eq? step 1)
     (moveR (swapElement #\e '() board (getIndex #\p board 1) 1) (getIndex #\p board 1) 2 (getIndex #\p board 1)))
    ((eq? (checkDragon board (+ shift 1)) #t)
     ;;sets dragon spot that princess went to to yumyum placeholder
     (endGame (swapElement #\y '() board (+ shift 1) 1) 2))
    ((eq? step 2) (gameLoop (swapElement #\p '() board (+ shift 1) 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moves the princess down on the board by
;; first setting the princesses spot to empty
;; then checking the spot index + Sqrt(length board)
;; in the board list if its a dragon calls the endGame
;; function with endState at 2 else it places the princess
;; at the new index if the princess is not at the
;; edge before moving. if so calls the endGame with
;; the endGame state at 1
;;
(define (moveD board shift step princessIndex)
  (cond
    
    ((eq? (> princessIndex (* (sqrt (length board)) (- (sqrt (length board)) 1))) #t) (endGame board 1));;checks if princess is on last row of board befor moving, if so does not place princess again and then ends game
    ((eq? step 1)
     (moveD (swapElement #\e '() board (getIndex #\p board 1) 1) (getIndex #\p board 1) 2 (getIndex #\p board 1)))
    ((eq? (checkDragon board (+ shift (sqrt (length board)))) #t)
     ;;sets dragon spot that princess went to to yumyum placeholder
     (endGame (swapElement #\y '() board (+ shift (sqrt (length board))) 1) 2))
    ((eq? step 2) (gameLoop (swapElement #\p '() board (+ shift (sqrt (length board))) 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moves the princess left on the board by
;; first setting the princesses spot to empty
;; then checking the spot - 1 index in the board
;; list if its a dragon calls the endGame function
;; with endState at 2 else it places the princess
;; at the new index if the princess is not at the
;; edge before moving. if so calls the endGame with
;; the endGame state at 1
;;

(define (moveL board shift step princessIndex)
  (cond
    
    ((eq? (modulo (- princessIndex 1) (sqrt (length board)))0) (endGame board 1)) 
    ((eq? step 1)
     (moveL (swapElement #\e '() board (getIndex #\p board 1) 1) (getIndex #\p board 1) 2 (getIndex #\p board 1)))
    ((eq? (checkDragon board (- shift 1)) #t)
     ;;sets dragon spot that princess went to to yumyum placeholder
     (endGame (swapElement #\y '() board (- shift 1) 1) 2))
    ((eq? step 2) (gameLoop (swapElement #\p '() board (- shift 1) 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moves the princess up on the board by
;; first setting the princesses spot to empty
;; then checking the spot index - Sqrt(length board)
;; in the board list if its a dragon calls the endGame
;; function with endState at 2 else it places the princess
;; at the new index if the princess is not at the
;; edge before moving. if so calls the endGame with
;; the endGame state at 1
;;
(define (moveU board shift step princessIndex)
  (cond
    
    ((eq? (>= princessIndex 0) (<= princessIndex (sqrt (length board)))) (endGame board 1))
    ((eq? step 1)
     (moveU (swapElement #\e '() board (getIndex #\p board 1) 1) (getIndex #\p board 1) 2 (getIndex #\p board 1)))
    ((eq? (checkDragon board (- shift (sqrt (length board)))) #t)
     ;;sets dragon spot that princess went to to yumyum placeholder
     (endGame (swapElement #\y '() board (- shift (sqrt (length board))) 1) 2))
    ((eq? step 2) (gameLoop (swapElement #\p '() board (- shift (sqrt (length board))) 1)))))



;;checks the board spot the princess to move to has a dragon or not
;;

(define (checkDragon board nextSpot)
  (cond
    ((eq? (getItem board '() nextSpot 0) #\d) #t)
    (#t #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; takes an item and list as input and will return
;; the item at the inputted index
;; 
;; This is used to check what is in the space that
;; the princess is going to be moved to

(define (getItem aList item index currentIndex)
  (cond
    ((eq? index currentIndex) item)
    (#t (getItem (cdr aList) (car aList) index (+ currentIndex 1)))))

;;gets first index of an Item in a list
;;Returns index
;;
;;Used to find the princesses spot
(define (getIndex item aList index )
  (cond
    ((eq? item (car aList)) index)
    (#t (getIndex item (cdr aList) (+ index 1)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; prints the endgame message and is called to end the gameLoop
;; endState = 1 prints the victory message, any other endState
;; means the princess was eaten

(define (endGame board endState)
  (printBoard1 board (length board) 1 0)
  (display "The Game Has Ended")(newline)
  (cond
    ((eq? endState 1) (display "The Princess Has Escaped!"))
    (#t (display "You Lose, The Princess Was Eaten..."))
  ))