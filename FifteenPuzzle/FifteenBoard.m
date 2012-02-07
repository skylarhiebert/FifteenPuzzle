//
//  FifteenboardModel.m
//  FifteenPuzzle
//
//  Created by Skylar Hiebert on 2/3/12.
//  Copyright (c) 2012 skylarhiebert.com. All rights reserved.
//

#import "FifteenBoard.h"
#include <stdlib.h>

@implementation FifteenBoard

@synthesize boardModel;

#define EMPTY_TILE 16

-(id)init {
    boardModel = (int *) malloc(sizeof(int) * 16);
    for (int i = 0; i < 16; i++) {
        boardModel[i] = i+1;
    }
    return self;
}

-(void)scramble:(int)n {
    //NSLog(@"scramble:%d", n);
    arc4random_stir();
    for (int i = 0; i < n; i++) {
        const int rand = arc4random() % 4;
        int eRow, eCol;
        [self getRow:&eRow Column:&eCol ForTile:EMPTY_TILE];
        switch (rand) {
            case 0:
                if (eRow < 3 && [self canSlideTileUpAtRow:eRow + 1 Column:eCol]) {
                    [self slideTileAtRow:eRow + 1 Column:eCol];
                }    
                break;
            case 1:
                if (eRow > 0 && [self canSlideTileDownAtRow:eRow - 1 Column:eCol]) {
                    [self slideTileAtRow:eRow - 1 Column:eCol];
                }  
                break;
            case 2:
                if (eCol < 3 && [self canSlideTileLeftAtRow:eRow Column:eCol + 1]) {
                    [self slideTileAtRow:eRow Column:eCol + 1];
                }  
                break;
            case 3:
                if (eCol > 0 && [self canSlideTileRightAtRow:eRow Column:eCol - 1]) {
                    [self slideTileAtRow:eRow Column:eCol - 1];
                }  
                break;
            default:
                break;
        }
    }    
}

-(int)getTileAtRow:(int)row Column:(int)col { 
    //NSLog(@"getTileAtRow:%d Column:%d", row, col);
    return boardModel[row*4 + col];
}

-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile {
    for (int i = 0; i < 16; i++) {
        if (boardModel[i] == tile) {
            *row = i/4;
            *col = i%4;
            return;
        }
    }
}

-(BOOL)isSolved {
    for (int i = 0; i < 16; i++) {
        if (boardModel[i] != i+1) {
            return FALSE;
        }
    }
    return TRUE;
}

-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col {
    //NSLog(@"canSlideTileUpAtRow:%d Column:%d", row, col);
    if (row > 0 && row <= 3 && boardModel[(row - 1) * 4 + col] == EMPTY_TILE) {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col {
    //NSLog(@"canSlideTileDownAtRow:%d Column:%d", row, col);
    if (row < 3 && boardModel[(row + 1) * 4 + col] == EMPTY_TILE) {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col {
    //NSLog(@"canSlideTileLeftAtRow:%d Column:%d", row, col);
    if (col > 0 && col <= 3 && boardModel[row * 4 + (col - 1)] == EMPTY_TILE) {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col {
    //NSLog(@"canSlideTileRightAtRow:%d Column:%d", row, col);
    if (col < 3 && boardModel[row * 4 + (col + 1)] == EMPTY_TILE) {
        return TRUE;
    }
    return FALSE;
}

-(void)slideTileAtRow:(int)row Column:(int)col {
    //NSLog(@"slideTileAtRow:%d Column:%d", row, col);
    const int tile = boardModel[row*4 + col];
    int eRow, eCol;
    [self getRow:&eRow Column:&eCol ForTile:EMPTY_TILE];
    boardModel[row*4 + col] = EMPTY_TILE;
    boardModel[eRow*4 + eCol] = tile;
}

@end
