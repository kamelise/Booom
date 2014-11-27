//
//  GameVC.h
//  Booom
//
//  Created by Samka on 28.05.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "GameSettings.h"
#import "Game.h"

@interface GameViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) GameSettings *gameSettings;
@property (strong, nonatomic) Game *game;

@property (weak, nonatomic) IBOutlet UILabel *numberTeams;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *wordsNumber;
@property (weak, nonatomic) IBOutlet UILabel *roundDuration;
@property (weak, nonatomic) IBOutlet UILabel *teamNames;
@property (weak, nonatomic) IBOutlet UITableView *teamDetails;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;

@end
