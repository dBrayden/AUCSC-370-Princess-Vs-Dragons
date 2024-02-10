/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/cFiles/file.h to edit this template
 */

/* 
 * File:   predefine.h
 * Author: brayd
 *
 * Created on September 27, 2022, 11:21 AM
 */

#ifndef PREDEFINE_H
#define PREDEFINE_H

/**
 * 
 */
void gameStart();

/**
 * initialized the board and sets each spot to the empty board icon
 * @param size The size of the wanted board
 */
void createBoard(int size);

/**
 * prints the board with the dragons and princess on the board
 * @param size size of the board
 */
void printBoard(int size);

/**
 * Asks the user how they want to move the princess then runs the corresponding
 * move function
 */
void playerMove();
/**
 * moves the princess left
 */
void moveL();
/**
 * moves the princess up
 */
void moveU();
/**
 * moves the princess right
 */
void moveR();
/**
 * moves the princess down
 */
void moveD();

/**
 *  Generates the spaces and the adds the dragons to said spaces on the board
 * @param size
 */
void generateDragonSpaces(int size);

/**
 * used to see if a number is already in the array.
 * 
 * @param numberArray array that contains the spaces the dragons will occupy.
 * @param arraySize
 * @param numToFind Number being checked if it's a duplicate or not.
 * @return inArray If inArray = 1 there is a duplicate, if 0 no duplicate.
 */
int inArray(int numberArray[], int arraySize, int numToFind);

#ifdef __cplusplus
extern "C" {
#endif




#ifdef __cplusplus
}
#endif

#endif /* PREDEFINE_H */

