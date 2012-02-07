//
//  FifteenPuzzleViewController.m
//  FifteenPuzzle
//
//  Created by Skylar Hiebert on 2/3/12.
//  Copyright (c) 2012 skylarhiebert.com. All rights reserved.
//

#import "FifteenPuzzleViewController.h"
#import "FifteenBoard.h"

@implementation FifteenPuzzleViewController

@synthesize boardView;
@synthesize board;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.board = [[FifteenBoard alloc] init]; // create/init board
    [board scramble:NUM_SHUFFLES];            // scramble tiles
    [self arrangeBoardView];                  // sync view with model
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)scrambleTiles:(id)sender {
    [board scramble:NUM_SHUFFLES];
    [self arrangeBoardView];
}

-(IBAction)tileSelected:(UIButton*)sender {
    const int tag = [sender tag];
    int row, col;
    [board getRow:&row Column:&col ForTile:tag];  // (2)
    CGRect buttonFrame = sender.frame;
    if ([board canSlideTileUpAtRow:row Column:col]) {
        [board slideTileAtRow:row Column:col];  
        buttonFrame.origin.y = (row-1)*buttonFrame.size.height;
    } else if ([board canSlideTileDownAtRow:row Column:col]) {
        [board slideTileAtRow:row Column:col];  
        buttonFrame.origin.y = (row+1)*buttonFrame.size.height;
    } else if ([board canSlideTileLeftAtRow:row Column:col]) {
        [board slideTileAtRow:row Column:col];  
        buttonFrame.origin.x = (col-1)*buttonFrame.size.width;
    } else if ([board canSlideTileRightAtRow:row Column:col]) {
        [board slideTileAtRow:row Column:col];  
        buttonFrame.origin.x = (col+1)*buttonFrame.size.width;
    }
    [UIView animateWithDuration:0.5 animations:^{sender.frame = buttonFrame;}];
    
    if ([board isSolved]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations" 
                                                        message:@"You Solved the Puzzle" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
    }

}

-(void)arrangeBoardView {
    const CGRect boardBounds = boardView.bounds;
    const CGFloat tileWidth = boardBounds.size.width / 4;
    const CGFloat tileHeight = boardBounds.size.height / 4;
    for (int row = 0; row < 4; row++)
        for (int col = 0; col < 4; col++) {
            const int tile = [board getTileAtRow:row Column:col];
            if (tile > 0) {
                __weak UIButton *button = (UIButton *)[boardView viewWithTag:tile];
                button.frame = CGRectMake(col*tileWidth, row*tileHeight, tileWidth, tileHeight);
            } 
        }
}

@end

