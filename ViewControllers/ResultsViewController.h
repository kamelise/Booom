//
//  ResultsVC.h
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "Game.h"

@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Game *game;

@property (weak, nonatomic) IBOutlet UILabel *finalResult;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UIButton *nextRoundButton;
- (IBAction)nextButtonDidClicked:(id)sender;
@end
