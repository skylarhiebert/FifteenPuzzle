//
//  FifteenPuzzleViewController.h
//  FifteenPuzzle
//
//  Created by Skylar Hiebert on 2/3/12.
//  Copyright (c) 2012 skylarhiebert.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FifteenBoard;

#define NUM_SHUFFLES 150

@interface FifteenPuzzleViewController : UIViewController

@property(weak,nonatomic) IBOutlet UIView *boardView;
@property(strong,nonatomic) FifteenBoard *board;

-(IBAction)scrambleTiles:(id)sender;
-(IBAction)tileSelected:(UIButton*)sender;
-(void)arrangeBoardView;

@end
