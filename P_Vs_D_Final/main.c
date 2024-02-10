

/* 
 * File:   main.c
 * Author: Brayden Dickau
 * ID: 1687165
 *
 * Simple game that creates a board populated by dragons and a princess. The
 * goal of the game is to get the princess to the edge of the board by moving
 * her left, right, up and down so she can swim away. Be careful of the dragons 
 * as meeting one will lead to death. The dragons, however are blind and will 
 * not move from their location.
 * 
 * Created on September 24, 2022, 4:17 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "predefine.h"

int boardSize = -1;
int gameBoard[10][10];

int princessX;
int princessY;

int gameRunning = 1;
int emptySpaces;
int eaten = 0; //boolean 1 == true 0 == false

int main() {
    
    //Initial game start
    gameStart();
    
    createBoard(boardSize); 
    
    generateDragonSpaces(boardSize);
    
    printBoard(boardSize);    
    
    //main game loop
    while(gameRunning == 1){
    
        playerMove();
    
        printBoard(boardSize);
    }
    
    if(eaten == 0){
    printf("The Princess Has Escaped\n");
    printf("You Win!\n");
    }
    else{
        printf("Sorry, the princess has been eaten!\nGame Over");
    }

    return (EXIT_SUCCESS);
}
/**
 * prints the starting text and then asks and scan for the users requested board
 * size. Will loop until a correct board size between 4 and 10 is given.
 */
void gameStart(){
    
    int potentialSize;
    
    printf("Welcome to Princess vs Dragons ");
    printf("\n");
    printf("Enter a Board Size Between Four and Ten: ");
    fflush(stdout);
    
    scanf("%d", &potentialSize);
    
    // Restricts board size to between 4 and 10
    if(potentialSize <= 10 && potentialSize >= 4){
           boardSize = potentialSize;
        }
    fflush(stdout);
    
    //Until a correct board size is inputted, keeps asking the user.
    while(boardSize == -1){
        if(potentialSize <= 10 && potentialSize >= 4){
            boardSize = potentialSize;
        }
    
        else{
            printf("Incorrect Size. Please Try Again: ");
            fflush(stdin);
            fflush(stdout);
            scanf("%d", &potentialSize);    
        }
    }
    fflush(stdin);
    fflush(stdout);
    printf("\n");
}
/**
 * 
 * @param size size of the board
 */
void createBoard(int size){
    
    //sets each space in the 2d array to 0 to create a blank board for printing
    for (int i = 0; i < size; i++ ){  
        for(int j = 0; j < size; j++){
                gameBoard[i][j] = 0;
        }
    }
    
    //finds the middle of the board and places the princess there in the array
    princessX = size/2;
    princessY = size/2;
    
    gameBoard[princessX][princessY] = 1;
    
    emptySpaces = (boardSize*boardSize)-1;  
}//createBoard
/**
 * goes through the 2d gameBoard array and prints out the board based on what
 * the array contains 
 * 0 = " ------ "
 * 1 = "Princess"
 * 2 = " Dragon "
 * 3 = " Yum Yum "
 * @param size board size
 */
void printBoard(int size){
    
    for (int k = 0; k < size; k++ ){
        
        for(int l = 0; l < size; l++){
            
            //depending on the number in the array, prints corresponding words
            if(gameBoard[k][l] == 0){printf(" ------ ");}//if
            if(gameBoard[k][l] == 1){printf("Princess");}//if
            if(gameBoard[k][l] == 2){printf(" Dragon ");}//if
            if(gameBoard[k][l] == 3){printf(" Yum Yum ");}//if
            printf(" ");  
        }//for
        printf("\n");
    }//for
    
}//printBoard

void playerMove(){

    char movement;
   
    printf("Enter Movement: ");
    fflush(stdout);
    scanf("%c", &movement);
    fflush(stdin);
    fflush(stdout);
    
    //handles the user input, if correct runs the corresponding move function.
    if( movement == 'l' || movement == 'L'){ moveL(); return;}
    if( movement == 'u' || movement == 'U'){ moveU(); return;}
    if( movement == 'r' || movement == 'R'){ moveR(); return;}
    if( movement == 'd' || movement == 'D'){ moveD(); return; }
    //ends main game loop, wont be in final code
//    if( movement == 'e' || movement == 'E'){
//        gameRunning = 0;                      
//    }
    /*if no correct input, tells the user and then the game loop reprints the
     * board and asks the user again 
     */
    else{
        printf("incorrect Input, Try Again: \n");
    
    }
    
}//playerMove

void moveL(){
    //checks if princess will step on a empty spot, if so moves princess there
    if(princessX > 0 && gameBoard[princessY][princessX-1] == 0){
        
        gameBoard[princessY][princessX] = 0;
        princessX--;
        gameBoard[princessY][princessX] = 1;
        return;
    }
    //checks if princess will step on a dragon, if so assigns "yum yum" to that spot
    if(princessX > 0 && gameBoard[princessY][princessX-1] == 2){
          
        gameBoard[princessY][princessX] = 0;
        princessX--;
        gameBoard[princessY][princessX] = 3;
        eaten = 1;
        gameRunning = 0;
        return;    
    }
    //Last case, the princess moved off the board and the game is won.
    else{
        gameBoard[princessY][princessX] = 0;       
        gameRunning = 0;
    }    
}//moveL

void moveU(){
    //checks if princess will step on a empty spot, if so moves princess there
    if(princessY > 0 && gameBoard[princessY-1][princessX] == 0){
        
        gameBoard[princessY][princessX] = 0;
        princessY--;
        gameBoard[princessY][princessX] = 1;
        return;
    }//if
    //checks if princess will step on a dragon, if so assigns "yum yum" to that spot
    if(princessX > 0 && gameBoard[princessY-1][princessX] == 2){
               
        gameBoard[princessY][princessX] = 0;
        princessY--;
        gameBoard[princessY][princessX] = 3; 
        eaten = 1;
        gameRunning = 0;
        return;
    }//if
    //Last case, the princess moved off the board and the game is won.
    else{
        gameBoard[princessY][princessX] = 0;
        gameRunning = 0;
    }//else   
}// moveU

void moveR(){
    //checks if princess will step on a empty spot, if so moves princess there
    if(princessX < boardSize-1 && gameBoard[princessY][princessX+1] == 0){
        
        gameBoard[princessY][princessX] = 0;
        princessX++;
        gameBoard[princessY][princessX] = 1; 
        return;
    }//if
    //checks if princess will step on a dragon, if so assigns "yum yum" to that spot
    if(princessX < boardSize-1 && gameBoard[princessY][princessX+1] == 2){
       
        gameBoard[princessY][princessX] = 0;
        princessX++;
        gameBoard[princessY][princessX] = 3;
        eaten = 1;
        gameRunning = 0;
        return; 
    }//if
    //Last case, the princess moved off the board and the game is won.
    else{
        gameBoard[princessY][princessX] = 0; 
        gameRunning = 0;
    } //else  
}//MoveR

void moveD(){
    //checks if princess will step on a empty spot, if so moves princess there
    if(princessY < boardSize-1 && gameBoard[princessY+1][princessX] == 0){
        
        gameBoard[princessY][princessX] = 0;
        princessY++;
        gameBoard[princessY][princessX] = 1;
        return;
    }//if
    //checks if princess will step on a dragon, if so assigns "yum yum" to that spot
    if(princessX < boardSize-1 && gameBoard[princessY+1][princessX] == 2){
        
        gameBoard[princessY][princessX] = 0;
        princessY++;
        gameBoard[princessY][princessX] = 3;
        eaten = 1;
        gameRunning = 0;
        return;  
    }//if
    //Last case, the princess moved off the board and the game is won.
    else{
        gameBoard[princessY][princessX] = 0;
        gameRunning = 0;
    }//else   
}//moveD

/**
 * 
 * @param size 
 */
void generateDragonSpaces(int size){
    
    int arrayCounter = 0;
    int dragonSpaces[emptySpaces/4];  
    srand(time(NULL));
    int randomNum;
    
    //generates the random spaces for the dragons
    for (int m = 0; m < emptySpaces/4; m++){
        
        randomNum = rand() % emptySpaces + 1;      
         
        dragonSpaces[m] = randomNum;
        //checks for duplicates
        for(int r = 0; r < emptySpaces/4; r++ ){
        if(inArray(dragonSpaces, emptySpaces/4, randomNum) == 1){ 
            
            randomNum = rand() % emptySpaces + 1;
            
        }//if
        }//for
        dragonSpaces[m] = randomNum; 
                  
    }//for
    //converts dragon space number into index numbers for the gameBoard array.
    for(int p = 0; p < emptySpaces/4; p++){   
        dragonSpaces[p] = dragonSpaces[p] -1;    
    }
    /**converts the dragon numbers to x,y coordinate system. Then add to  the 
     * gameBoard. This is done by using a 2d array for loop for going through it
     * and counting the number of spaces in the array. when the current spaces
     * number is in the dragonSpaces array, sets that spot to a dragon on the 
     * board. 
     */
    for (int m = 0; m < size; m++ ){  
        for(int n = 0; n < size; n++){
            if(inArray(dragonSpaces, emptySpaces/4, arrayCounter) == 1){
                
                //makes sure dragon cannot be placed on the princess.
                if(gameBoard[m][n] == 1){gameBoard[m+1][n] = 2;}//if
                
                else{gameBoard[m][n] = 2;}//else   
            }//if
            arrayCounter++;           
        }//for
    }//for
}//generateDragonSpaces

/**
 * Goes through the array to check if number given is already in array
 * @param numberArray
 * @param arraySize
 * @param numToFind
 * @return 
 */
int inArray(int numberArray[], int arraySize, int numToFind){
    
    int inArray = 0;
    for(int o = 0; o < arraySize; o++){
      
      if(numberArray[o] == numToFind){
          inArray = 1;
      }     
    } 
    return inArray;
}//inArray