//
//  RoundVC.h
//  Booom
//
//  Created by Samka on 17.06.14.
//  Copyright (c) 2014 kamelise. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "Game.h"

@interface RoundViewController : UIViewController

@property (strong,nonatomic) Game *game;

@property (weak, nonatomic) IBOutlet UILabel *roundNumber;
@property (weak, nonatomic) IBOutlet UILabel *wordsLeftNumber;
@property (weak, nonatomic) IBOutlet UILabel *currentTeam;

@end
