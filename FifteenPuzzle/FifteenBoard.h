//
//  FifteenBoard.h
//  FifteenPuzzle
//
//  Created by Skylar Hiebert on 2/3/12.
//  Copyright (c) 2012 skylarhiebert.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FifteenBoard : NSObject

@property int *boardModel;

-(id)init; 
-(void)scramble:(int)n; 
-(int)getTileAtRow:(int)row Column:(int)col; 
-(void)getRow:(int*)row Column:(int*)col ForTile:(int)tile; 
-(BOOL)isSolved; 
-(BOOL)canSlideTileUpAtRow:(int)row Column:(int)col; 
-(BOOL)canSlideTileDownAtRow:(int)row Column:(int)col;
-(BOOL)canSlideTileLeftAtRow:(int)row Column:(int)col; 
-(BOOL)canSlideTileRightAtRow:(int)row Column:(int)col; 
-(void)slideTileAtRow:(int)row Column:(int)col;

@end
